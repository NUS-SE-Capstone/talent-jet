package edu.nus.iss.exam.service;

import com.baomidou.mybatisplus.extension.service.IService;
import edu.nus.iss.common.domain.dto.PageDTO;
import edu.nus.iss.common.domain.query.PageQuery;
import edu.nus.iss.exam.domain.dto.ExamSubmissionDTO;
import edu.nus.iss.exam.domain.dto.SectionQuestionsDTO;
import edu.nus.iss.exam.domain.po.ExamRecord;
import edu.nus.iss.exam.domain.vo.ExamDetailVO;
import edu.nus.iss.exam.domain.vo.ExamPageVO;
import edu.nus.iss.exam.domain.vo.SectionQuestionsVO;

import java.util.List;

public interface IExamService extends IService<ExamRecord> {
    SectionQuestionsVO getSectionQuestions(SectionQuestionsDTO sectionQuestionsDTO);

    void submitSectionExam(ExamSubmissionDTO examSubmissionDTO, String token);

    PageDTO<ExamPageVO> pageQuery(PageQuery pageQuery);

    List<ExamDetailVO> getExamDetails(Long id);
}
