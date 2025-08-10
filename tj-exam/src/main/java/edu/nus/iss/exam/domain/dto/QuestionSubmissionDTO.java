package edu.nus.iss.exam.domain.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class QuestionSubmissionDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long questionId;

    private String answer;

    private String questionType;
}
