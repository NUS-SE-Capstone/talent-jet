package edu.nus.iss.exam.domain.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("exam_record")
@NoArgsConstructor
@AllArgsConstructor(staticName = "of")
@Builder
public class ExamRecord implements Serializable {

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
     * 用户id
     */
    private Long userId;
    /**
     * 课程id
     */
    private Long courseId;
    /**
     * 章节id
     */
    private Long sectionId;
    /**
     * 创建时间
     */
    private LocalDateTime createTime;
    /**
     * 更新时间
     */
    private LocalDateTime updateTime;
    /**
     * 总分
     */
    private Double score;
    /**
     * 1: 练习 2: 考试
     */
    private Integer type;
    /**
     * token数量
     */
    private Integer totalTokens;
}
