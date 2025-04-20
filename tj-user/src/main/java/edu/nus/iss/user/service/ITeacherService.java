package edu.nus.iss.user.service;

import edu.nus.iss.common.domain.dto.PageDTO;
import edu.nus.iss.user.domain.query.UserPageQuery;
import edu.nus.iss.user.domain.vo.TeacherPageVO;

/**
 * <p>
 * 教师详情表 服务类
 * </p>
 *
 * 
 */
public interface ITeacherService{
    PageDTO<TeacherPageVO> queryTeacherPage(UserPageQuery pageQuery);

}
