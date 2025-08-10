package edu.nus.iss.exam.domain.vo;

import com.google.common.collect.Lists;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.List;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class QuestionVO {

    private Long id;

    private String name;

    private String type;

    private List<String> options;

    private List<String> answers = Lists.newArrayList();
}
