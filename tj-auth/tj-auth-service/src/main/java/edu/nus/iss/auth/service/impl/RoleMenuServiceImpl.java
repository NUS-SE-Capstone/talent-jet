package edu.nus.iss.auth.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import edu.nus.iss.auth.domain.po.RoleMenu;
import edu.nus.iss.auth.mapper.RoleMenuMapper;
import edu.nus.iss.auth.service.IRoleMenuService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 账户、角色关联表 服务实现类
 * </p>
 *

 */
@Service
public class RoleMenuServiceImpl extends ServiceImpl<RoleMenuMapper, RoleMenu> implements IRoleMenuService {

    @Override
    public void removeByRoleId(Long id) {
        remove(new LambdaQueryWrapper<RoleMenu>().eq(RoleMenu::getRoleId, id));
    }

    @Override
    public void deleteRoleMenus(Long roleId, List<Long> menuIds) {
        // delete from role_menus where role_id = ? and menu_id in (?,?);
        remove(
                new LambdaQueryWrapper<RoleMenu>()
                        .eq(RoleMenu::getRoleId, roleId)
                        .in(RoleMenu::getMenuId, menuIds)
        );
    }
}
