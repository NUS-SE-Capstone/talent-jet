package edu.nus.iss.auth.service.impl;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import edu.nus.iss.auth.constants.AuthConstants;
import edu.nus.iss.auth.domain.po.AccountRole;
import edu.nus.iss.auth.domain.po.Menu;
import edu.nus.iss.auth.domain.po.RoleMenu;
import edu.nus.iss.auth.mapper.MenuMapper;
import edu.nus.iss.auth.service.IAccountRoleService;
import edu.nus.iss.auth.service.IMenuService;
import edu.nus.iss.auth.service.IRoleMenuService;
import edu.nus.iss.auth.service.IRoleService;
import edu.nus.iss.common.exceptions.CommonException;
import edu.nus.iss.common.utils.UserContext;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import static edu.nus.iss.auth.common.constants.AuthErrorInfo.Msg.MENU_NOT_FOUND;
import static edu.nus.iss.auth.common.constants.AuthErrorInfo.Msg.ROLE_NOT_FOUND;

/**
 * <p>
 * 权限表，包括菜单权限和访问路径权限 服务实现类
 * </p>
 *

 */
@Service
@RequiredArgsConstructor
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements IMenuService {

    private final IRoleMenuService roleMenuService;
    private final IRoleService roleService;
    private final IAccountRoleService accountRoleService;

    @Override
    public List<Menu> listMenuByUser() {
        // 1.获取用户信息
        Long userId = UserContext.getUser();
        // 2.查询角色
        List<AccountRole> accountRoles = accountRoleService.lambdaQuery().eq(AccountRole::getAccountId, userId).list();
        if (CollUtil.isEmpty(accountRoles)) {
            return Collections.emptyList();
        }
        List<Long> roleIds = accountRoles.stream().map(AccountRole::getRoleId).collect(Collectors.toList());
        // 3.查询菜单
        return getBaseMapper().listByRoles(roleIds);
    }

    @Override
    @Transactional
    public void saveMenu(Menu menu) {
        // 1.新增菜单
        save(menu);
        // 2.判断当前菜单是否有父菜单
        if(menu.getParentId() != 0) {
            // 有父菜单，需要判断父菜单hashChildren属性
            Menu parent = getById(menu.getParentId());
            if(!parent.getHasChildren()){
                // 更新父菜单的hasChildren属性
                parent.setHasChildren(true);
                parent.setUpdateTime(null);
                updateById(parent);
            }
        }
        // 3.与管理员关联
        RoleMenu roleMenu = new RoleMenu();
        roleMenu.setMenuId(menu.getId());
        roleMenu.setRoleId(AuthConstants.ADMIN_ROLE_ID);
        roleMenuService.save(roleMenu);
    }

    @Override
    @Transactional
    public void deleteMenu(Long id) {
        // 1.查询当前菜单
        Menu menu = getById(id);
        if (menu == null) {
            return;
        }
        // 2.判断当前菜单是否有子菜单
        List<Long> delIds;
        if (menu.getHasChildren()) {
            // 2.1.添加子菜单及父菜单
            delIds = lambdaQuery()
                    .eq(Menu::getParentId, id)
                    .list()
                    .stream()
                    .map(Menu::getId)
                    .collect(Collectors.toList());
            // 添加父菜单id
            delIds.add(id);
        }else {
            // 2.2.添加父菜单id
            delIds = Collections.singletonList(id);
        }
        // 3.删除菜单
        removeByIds(delIds);
        // 4.删除菜单与角色的关联数据
        roleMenuService.remove(new LambdaQueryWrapper<RoleMenu>().in(RoleMenu::getMenuId, delIds));
    }

    @Override
    public void bindRoleMenus(Long roleId, List<Long> menuIds) {
        // 1.判断角色是否存在
        boolean exists = roleService.exists(roleId);
        if (!exists) {
            throw new CommonException(ROLE_NOT_FOUND);
        }
        // 2.判断菜单是否存在
        Integer menuCount = lambdaQuery().in(Menu::getId, menuIds).count();
        if (menuCount != menuIds.size()) {
            throw new CommonException(MENU_NOT_FOUND);
        }
        // 3.绑定关系
        List<RoleMenu> roleMenus = new ArrayList<>(menuCount);
        for (Long menuId : menuIds) {
            roleMenus.add(new RoleMenu(roleId, menuId));
        }
        // 4.写入数据库
        roleMenuService.saveBatch(roleMenus);
    }

    @Override
    public void deleteRoleMenus(Long roleId, List<Long> menuIds) {
        roleMenuService.deleteRoleMenus(roleId, menuIds);
    }
}
