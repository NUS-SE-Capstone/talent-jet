package edu.nus.iss.exam.domain.vo;

import edu.nus.iss.exam.domain.po.QuestionDetail;
import io.swagger.annotations.ApiModel;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@ApiModel(description = "Exam Record Page Data")
@Builder
public class ExamDetailVO {
    private Long id;

    private String answer;

    private Integer correct;

    private Double score;

    private Double yourScore;

    private String comment;

    private Integer totalTokens;

    private QuestionDetailVO question;
}
