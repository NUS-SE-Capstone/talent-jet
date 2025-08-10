package edu.nus.iss.learning.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import edu.nus.iss.learning.domain.po.PointsBoard;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * 学霸天梯榜 Mapper 接口
 * </p>
 *
 * @author 虎哥
 */
public interface PointsBoardMapper extends BaseMapper<PointsBoard> {

    void createPointsBoardTable(@Param("tableName") String tableName);
}
