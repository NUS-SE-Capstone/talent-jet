package edu.nus.iss.exam.domain.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;
import lombok.experimental.Accessors;

import java.io.Serializable;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("exam_detail")
@NoArgsConstructor
@AllArgsConstructor(staticName = "of")
@Builder
public class ExamDetail implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    /**
     * 考试id
     */
    private Long examId;
    /**
     * 题目id
     */
    private Long questionId;
    /**
     * 分数
     */
    private Double score;
    /**
     * 答案
     */
    private String answer;
    /**
     * 是否正确
     */
    private Integer correct;
    /**
     * ai打分评价
     */
    private String comment;
    /**
     * 主观题所使用的token数量
     */
    private Integer totalTokens;
}
