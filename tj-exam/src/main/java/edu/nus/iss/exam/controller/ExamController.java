package edu.nus.iss.exam.controller;

import edu.nus.iss.common.domain.dto.PageDTO;
import edu.nus.iss.common.domain.query.PageQuery;
import edu.nus.iss.exam.domain.dto.ExamSubmissionDTO;
import edu.nus.iss.exam.domain.dto.SectionQuestionsDTO;
import edu.nus.iss.exam.domain.vo.ExamDetailVO;
import edu.nus.iss.exam.domain.vo.ExamPageVO;
import edu.nus.iss.exam.domain.vo.SectionQuestionsVO;
import edu.nus.iss.exam.service.IExamService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/exams")
@Api(tags = "Section Exercise")
@Slf4j
public class ExamController {
    @Autowired
    private IExamService examService;

    @PostMapping
    @ApiOperation("Query Section Questions")
    public SectionQuestionsVO getSectionQuestions(@RequestBody SectionQuestionsDTO sectionQuestionsDTO){
        return examService.getSectionQuestions(sectionQuestionsDTO);
    }

    @PostMapping("/details")
    @ApiOperation("Submit Section Exam")
    public void submitSectionExam(@RequestBody ExamSubmissionDTO examSubmissionDTO, HttpServletRequest request){
        String token = request.getHeader("Authorization");
        examService.submitSectionExam(examSubmissionDTO,token);
    }

    @GetMapping("/page")
    @ApiOperation("Page Query Exam Records")
    public PageDTO<ExamPageVO> pageQuery(PageQuery pageQuery){
        return examService.pageQuery(pageQuery);
    }
    @GetMapping("/{id}")
    public List<ExamDetailVO> getExamDetails(@PathVariable("id") Long id ){
        return examService.getExamDetails(id);
    }
}
