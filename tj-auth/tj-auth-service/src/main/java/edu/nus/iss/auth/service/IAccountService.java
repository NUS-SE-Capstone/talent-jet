package edu.nus.iss.auth.service;

import edu.nus.iss.api.dto.user.LoginFormDTO;

/**
 * <p>
 * 账号表，平台内所有用户的账号、密码信息 服务类
 * </p>
 *

 */
public interface IAccountService{

    String login(LoginFormDTO loginFormDTO, boolean isStaff);

    void logout();

    String refreshToken(String refreshToken);
}
