package edu.nus.iss.learning.controller;

import edu.nus.iss.common.utils.BeanUtils;
import edu.nus.iss.common.utils.CollUtils;
import edu.nus.iss.learning.domain.po.PointsBoardSeason;
import edu.nus.iss.learning.domain.query.PointsBoardQuery;
import edu.nus.iss.learning.domain.vo.PointsBoardSeasonVO;
import edu.nus.iss.learning.domain.vo.PointsBoardVO;
import edu.nus.iss.learning.service.IPointsBoardSeasonService;
import edu.nus.iss.learning.service.IPointsBoardService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.List;

/**
 * <p>
 * 学霸天梯榜 控制器
 * </p>
 *
 * @author 虎哥
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/boards")
@Api(tags = "积分相关接口")
public class PointsBoardController {

    private final IPointsBoardService pointsBoardService;

    private final IPointsBoardSeasonService seasonService;

    @GetMapping
    @ApiOperation("分页查询指定赛季的积分排行榜")
    public PointsBoardVO queryPointsBoardBySeason(PointsBoardQuery query){
        return pointsBoardService.queryPointsBoardBySeason(query);
    }

    @ApiOperation("查询赛季信息列表")
    @GetMapping("/seasons/list")
    public List<PointsBoardSeasonVO> queryPointsBoardSeasons(){
        // 1.获取时间
        LocalDateTime now = LocalDateTime.now();

        // 2.查询赛季列表，必须是当前赛季之前的（开始时间小于等于当前时间）
        List<PointsBoardSeason> list =  seasonService.lambdaQuery()
                .le(PointsBoardSeason::getBeginTime, now).list();
        if (CollUtils.isEmpty(list)) {
            return CollUtils.emptyList();
        }
        // 3.返回VO
        return BeanUtils.copyToList(list, PointsBoardSeasonVO.class);
    }
}
