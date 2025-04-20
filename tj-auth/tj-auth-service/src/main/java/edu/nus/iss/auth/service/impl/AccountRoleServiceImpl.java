package edu.nus.iss.auth.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import edu.nus.iss.auth.domain.po.AccountRole;
import edu.nus.iss.auth.mapper.AccountRoleMapper;
import edu.nus.iss.auth.service.IAccountRoleService;
import org.springframework.stereotype.Service;


@Service
public class AccountRoleServiceImpl extends ServiceImpl<AccountRoleMapper, AccountRole> implements IAccountRoleService {

}
