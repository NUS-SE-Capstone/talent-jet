package edu.nus.iss.exam.constants;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AiScoreResult {

    private Integer code;

    private Double score;

    private String explanation;

    private Integer totalTokens;
}
