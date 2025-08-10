package edu.nus.iss.exam.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.google.common.collect.Lists;
import edu.nus.iss.api.client.course.CatalogueClient;
import edu.nus.iss.api.client.course.CourseClient;
import edu.nus.iss.api.client.user.UserClient;
import edu.nus.iss.api.dto.course.CataSimpleInfoDTO;
import edu.nus.iss.api.dto.course.CourseFullInfoDTO;
import edu.nus.iss.api.dto.exam.QuestionBizDTO;
import edu.nus.iss.api.dto.exam.QuestionDTO;
import edu.nus.iss.api.dto.user.UserDTO;
import edu.nus.iss.common.constants.Constant;
import edu.nus.iss.common.domain.dto.PageDTO;
import edu.nus.iss.common.domain.query.PageQuery;
import edu.nus.iss.common.exceptions.BizIllegalException;
import edu.nus.iss.common.utils.CollUtils;
import edu.nus.iss.common.utils.UserContext;
import edu.nus.iss.exam.async.ExamAsyncTask;
import edu.nus.iss.exam.domain.dto.ExamSubmissionDTO;
import edu.nus.iss.exam.domain.dto.QuestionSubmissionDTO;
import edu.nus.iss.exam.domain.dto.SectionQuestionsDTO;
import edu.nus.iss.exam.domain.po.ExamDetail;
import edu.nus.iss.exam.domain.po.ExamRecord;
import edu.nus.iss.exam.domain.vo.*;
import edu.nus.iss.exam.mapper.ExamDetailMapper;
import edu.nus.iss.exam.mapper.ExamRecordMapper;
import edu.nus.iss.exam.service.IExamService;
import edu.nus.iss.exam.service.IQuestionBizService;
import edu.nus.iss.exam.service.IQuestionService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ExamServiceImpl extends ServiceImpl<ExamRecordMapper, ExamRecord> implements IExamService {
    @Autowired
    private IQuestionBizService questionBizService;
    @Autowired
    private IQuestionService questionService;
    @Autowired
    private ExamDetailMapper examDetailMapper;
    @Autowired
    private ExamAsyncTask examAsyncTask;
    @Autowired
    private CourseClient courseClient;
    @Autowired
    private CatalogueClient catalogueClient;
    @Autowired
    private UserClient userClient;

    @Override
    public SectionQuestionsVO getSectionQuestions(SectionQuestionsDTO sectionQuestionsDTO) {
        // 1. 根据章节id查询题目id
        List<Long> questionIds = questionBizService.queryQuestionIdsByBizId(sectionQuestionsDTO.getSectionId()).stream().map(QuestionBizDTO::getQuestionId).collect(Collectors.toList());
        // 2. 根据题目id查询题目
        List<QuestionDTO> sectionQuestions = questionService.queryQuestionByIds(questionIds);
        SectionQuestionsVO sectionQuestionsVO = new SectionQuestionsVO();
        // 3. 封装数据 { "id": examId, "questions":[] }
        sectionQuestionsVO.setId(IdWorker.getId());
        sectionQuestionsVO.setQuestions(new ArrayList<>());
        List<QuestionVO> questions = sectionQuestionsVO.getQuestions();
        for(QuestionDTO questionDTO:sectionQuestions){
            QuestionVO questionVO = new QuestionVO();
            BeanUtils.copyProperties(questionDTO,questionVO);
            questions.add(questionVO);
        }
        return sectionQuestionsVO;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void submitSectionExam(ExamSubmissionDTO examSubmissionDTO, String token) {
        // 1. 查询用户剩余token
        Long userId = UserContext.getUser();
        UserDTO userDTO = userClient.queryUserById(userId);
        if(userDTO.getToken()<=0){
            throw new BizIllegalException("Your token balance is insufficient for submission. Please try again after the next weekly update.");
        }
        Long examId = examSubmissionDTO.getId();
        // 2. 保存考试记录
        ExamRecord examRecord = ExamRecord.builder()
                .examId(examId)
                .userId(UserContext.getUser())
                .courseId(examSubmissionDTO.getExamInfo().getCourseId())
                .sectionId(examSubmissionDTO.getExamInfo().getSectionId())
                .type(examSubmissionDTO.getExamInfo().getType())
                .build();
        save(examRecord);

        // 3. 保存答题详情
        List<QuestionSubmissionDTO> examDetails = examSubmissionDTO.getExamDetails();
        for(QuestionSubmissionDTO questionSubmissionDTO:examDetails){
            ExamDetail examDetail = ExamDetail.builder()
                    .examId(examId)
                    .questionId(questionSubmissionDTO.getQuestionId())
                    .answer(questionSubmissionDTO.getAnswer())
                    .build();
            examDetailMapper.insert(examDetail);
        }
        // 4.异步计算分数 并 消耗token
        examAsyncTask.asyncCalculateScore(examId)
                .thenAccept(tokens ->{
                       try{
                           UserContext.setUser(userId);
                           userDTO.setToken(userDTO.getToken()-tokens);
                           userClient.updateUserById(userDTO);
                       } finally {
                           UserContext.removeUser();
                       }
                });
    }

    @Override
    public PageDTO<ExamPageVO> pageQuery(PageQuery pageQuery) {
        //1. 分页查询
        Page<ExamRecord> page=lambdaQuery()
                .page(pageQuery.toMpPage(Constant.DATA_FIELD_NAME_CREATE_TIME, false));


        // 2.判空
        List<ExamRecord> records = page.getRecords();
        if(CollUtils.isEmpty(records)){
            return PageDTO.empty(page);
        }

        // 3.封装数据
        List<ExamPageVO> list=new ArrayList<>(records.size());

        for(ExamRecord examRecord:records){
            CourseFullInfoDTO courseInfo = courseClient.getCourseInfoById(examRecord.getCourseId(), false, false);
            List<CataSimpleInfoDTO> cataSimpleInfoDTOS = catalogueClient.batchQueryCatalogue(Lists.newArrayList(examRecord.getSectionId()));
            CataSimpleInfoDTO cataSimpleInfoDTO = null;
            if(!CollUtils.isEmpty(cataSimpleInfoDTOS)){
                cataSimpleInfoDTO = cataSimpleInfoDTOS.get(0);
            }

            ExamPageVO examPageVO = ExamPageVO.builder()
                    .id(examRecord.getExamId())
                    .courseName(courseInfo.getName())
                    .sectionName(cataSimpleInfoDTO != null? cataSimpleInfoDTO.getName():"Course Exam")
                    .commitTime(examRecord.getCreateTime())
                    .score(examRecord.getScore())
                    .type(examRecord.getType())
                    .build();
            list.add(examPageVO);
        }
        return PageDTO.of(page,list);
    }

    @Override
    public List<ExamDetailVO> getExamDetails(Long id) {
        //1. 根据id获取 ExamDetail
        QueryWrapper<ExamDetail> qw=new QueryWrapper<>();
        qw.eq("exam_id",id);
        List<ExamDetail> examDetails = examDetailMapper.selectList(qw);

        //2.封装数据
        List<ExamDetailVO> result = Lists.newArrayList();
        for(ExamDetail examDetail:examDetails){
            QuestionDetailVO questionDetailVO = questionService.queryQuestionDetailById(examDetail.getQuestionId());

            ExamDetailVO examDetailVO = ExamDetailVO.builder()
                    .id(examDetail.getExamId())
                    .correct(examDetail.getCorrect())
                    .yourScore(examDetail.getScore())
                    .score(Double.valueOf(questionDetailVO.getScore()))
                    .question(questionDetailVO)
                    .answer(examDetail.getAnswer())
                    .comment(examDetail.getComment())
                    .totalTokens(examDetail.getTotalTokens())
                    .build();
            result.add(examDetailVO);
        }
        return result;
    }
}
