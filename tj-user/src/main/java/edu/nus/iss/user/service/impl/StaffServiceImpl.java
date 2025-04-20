package edu.nus.iss.user.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import edu.nus.iss.api.cache.RoleCache;
import edu.nus.iss.common.domain.dto.PageDTO;
import edu.nus.iss.common.enums.UserType;
import edu.nus.iss.common.utils.BeanUtils;
import edu.nus.iss.user.domain.po.UserDetail;
import edu.nus.iss.user.domain.query.UserPageQuery;
import edu.nus.iss.user.domain.vo.StaffVO;
import edu.nus.iss.user.service.IStaffService;
import edu.nus.iss.user.service.IUserDetailService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 员工详情表 服务实现类
 * </p>
 *
 * 
 */
@Service
@RequiredArgsConstructor
public class StaffServiceImpl implements IStaffService {

    private final IUserDetailService detailService;
    private final RoleCache roleCache;
    @Override
    public PageDTO<StaffVO> queryStaffPage(UserPageQuery query) {
        // 1.搜索
        Page<UserDetail> p = detailService.queryUserDetailByPage(query, UserType.STAFF);
        // 2.处理vo
        return PageDTO.of(p, u -> {
            StaffVO v = BeanUtils.toBean(u, StaffVO.class);
            v.setRoleName(roleCache.getRoleName(u.getRoleId()));
            return v;
        });
    }
}
