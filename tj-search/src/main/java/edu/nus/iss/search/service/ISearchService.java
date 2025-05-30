package edu.nus.iss.search.service;

import edu.nus.iss.common.domain.dto.PageDTO;
import edu.nus.iss.search.domain.query.CoursePageQuery;
import edu.nus.iss.search.domain.vo.CourseVO;

import java.util.List;

public interface ISearchService {

    List<CourseVO> queryCourseByCateId(Long cateLv2Id);

    List<CourseVO> queryBestTopN();

    List<CourseVO> queryNewTopN();

    List<CourseVO> queryFreeTopN();

    PageDTO<CourseVO> queryCoursesForPortal(CoursePageQuery query);

    List<Long> queryCoursesIdByName(String keyword);
}
