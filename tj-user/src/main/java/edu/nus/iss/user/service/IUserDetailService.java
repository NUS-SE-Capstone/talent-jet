package edu.nus.iss.user.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import edu.nus.iss.common.enums.UserType;
import edu.nus.iss.user.domain.po.UserDetail;
import edu.nus.iss.user.domain.query.UserPageQuery;

import java.util.List;

/**
 * <p>
 * 教师详情表 服务类
 * </p>
 *
 * 
 */
public interface IUserDetailService extends IService<UserDetail> {

    UserDetail queryById(Long userId);

    List<UserDetail> queryByIds(List<Long> ids);

    Page<UserDetail> queryUserDetailByPage(UserPageQuery pageQuery, UserType type);
}
