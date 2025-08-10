package edu.nus.iss.exam.async;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import edu.nus.iss.exam.constants.AiScoreResult;
import edu.nus.iss.exam.constants.QuestionType;
import edu.nus.iss.exam.domain.po.ExamDetail;
import edu.nus.iss.exam.domain.po.ExamRecord;
import edu.nus.iss.exam.domain.vo.QuestionDetailVO;
import edu.nus.iss.exam.mapper.ExamDetailMapper;
import edu.nus.iss.exam.mapper.ExamRecordMapper;
import edu.nus.iss.exam.service.AiScoreService;
import edu.nus.iss.exam.service.IQuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.concurrent.CompletableFuture;

@Service
public class ExamAsyncTask {
    @Autowired
    private ExamRecordMapper examRecordMapper;
    @Autowired
    private ExamDetailMapper examDetailMapper;
    @Autowired
    private IQuestionService questionService;
    @Autowired
    private AiScoreService aiScoreService;

    @Async
    @Transactional(rollbackFor = Exception.class)
    public CompletableFuture<Integer> asyncCalculateScore(Long examId) {
        // 1. 查询所有答题详情
        QueryWrapper<ExamDetail> qw = new QueryWrapper<>();
        qw.eq("exam_id", examId);
        List<ExamDetail> examDetailList = examDetailMapper.selectList(qw);

        // 2. 计算每一题
        double totalScore = 0d;
        int totalTokens = 0;

        for (ExamDetail examDetail : examDetailList) {
            // 3. 查询题库标准答案
            QuestionDetailVO questionDetailVO = questionService.queryQuestionDetailById(examDetail.getQuestionId());

            // 4. 判断非主观题是否答对
            if (!questionDetailVO.getType().equals(QuestionType.SUBJECTIVE.getValue())) {
                if(questionDetailVO.getAnswer().equals(examDetail.getAnswer())){
                    examDetail.setCorrect(1);
                    examDetail.setScore(Double.valueOf(questionDetailVO.getScore()));
                }
                else {
                    examDetail.setCorrect(0);
                    examDetail.setScore(0d);
                }
            } else {
                // 5. 主观题打分
                AiScoreResult scoreResult = aiScoreService.score(questionDetailVO.getName(),
                        questionDetailVO.getAnswer(), examDetail.getAnswer(), Double.valueOf(questionDetailVO.getScore()));
                if(scoreResult.getCode().equals(200)){
                    examDetail.setScore(scoreResult.getScore());
                    examDetail.setComment(scoreResult.getExplanation());
                    examDetail.setTotalTokens(scoreResult.getTotalTokens());
                    totalTokens+=scoreResult.getTotalTokens();
                }
            }

            // 6. 更新详情表
            examDetailMapper.updateById(examDetail);
            // 7. 累加总分
            totalScore+=examDetail.getScore();
        }
        // 8. 更新记录表
        UpdateWrapper<ExamRecord> uw = new UpdateWrapper<>();
        uw.eq("exam_id", examId);
        uw.set("score", totalScore);
        uw.set("total_tokens", totalTokens);
        examRecordMapper.update(null, uw);
        return CompletableFuture.completedFuture(totalTokens);
    }

}
