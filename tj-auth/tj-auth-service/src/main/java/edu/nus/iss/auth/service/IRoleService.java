package edu.nus.iss.auth.service;

import com.baomidou.mybatisplus.extension.service.IService;
import edu.nus.iss.auth.domain.po.Role;

import java.util.List;

/**
 * <p>
 * 角色表 服务类
 * </p>
 *

 */
public interface IRoleService extends IService<Role> {

    boolean exists(Long roleId);
    boolean exists(List<Long> roleIds);

    void deleteRole(Long id);
}
