package edu.nus.iss.exam.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import edu.nus.iss.api.dto.IdAndNumDTO;
import edu.nus.iss.exam.domain.po.Question;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 题目 Mapper 接口
 * </p>
 *
 * @author 虎哥
 * @since 2022-09-02
 */
public interface QuestionMapper extends BaseMapper<Question> {

    List<IdAndNumDTO> countQuestionOfCreater(@Param("createrIds") List<Long> createrIds);

}
