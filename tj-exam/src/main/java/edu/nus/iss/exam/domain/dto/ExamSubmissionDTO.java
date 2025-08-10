package edu.nus.iss.exam.domain.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.List;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class ExamSubmissionDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;

    private SectionQuestionsDTO examInfo;

    private List<QuestionSubmissionDTO> examDetails;
}
