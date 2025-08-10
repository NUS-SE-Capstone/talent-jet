package edu.nus.iss.exam.domain.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class SectionQuestionsVO {

    private Long id;

    private List<QuestionVO> questions;
}
