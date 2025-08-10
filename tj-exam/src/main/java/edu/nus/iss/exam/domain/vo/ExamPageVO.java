package edu.nus.iss.exam.domain.vo;

import io.swagger.annotations.ApiModel;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@ApiModel(description = "Exam Record Page Data")
@Builder
public class ExamPageVO {
    private Long id;

    private String courseName;

    private String sectionName;

    private LocalDateTime commitTime;

    private Integer type;

    private Double score;

}
