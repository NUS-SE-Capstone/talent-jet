package edu.nus.iss.auth.service.impl;

import edu.nus.iss.api.client.user.UserClient;
import edu.nus.iss.api.dto.user.LoginFormDTO;
import edu.nus.iss.auth.common.constants.JwtConstants;
import edu.nus.iss.auth.service.IAccountService;
import edu.nus.iss.auth.service.ILoginRecordService;
import edu.nus.iss.auth.util.JwtTool;
import edu.nus.iss.common.domain.dto.LoginUserDTO;
import edu.nus.iss.common.exceptions.BadRequestException;
import edu.nus.iss.common.utils.BooleanUtils;
import edu.nus.iss.common.utils.WebUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 账号表，平台内所有用户的账号、密码信息 服务实现类
 * </p>
 *

 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AccountServiceImpl implements IAccountService{
    private final JwtTool jwtTool;
    private final UserClient userClient;
    private final ILoginRecordService loginRecordService;

    @Override
    public String login(LoginFormDTO loginDTO, boolean isStaff) {
        // 1.查询并校验用户信息
        LoginUserDTO detail = userClient.queryUserDetail(loginDTO, isStaff);
        if (detail == null) {
            throw new BadRequestException("登录信息有误");
        }

        // 2.基于JWT生成登录token
        // 2.1.设置记住我标记
        detail.setRememberMe(loginDTO.getRememberMe());
        // 2.2.生成token
        String token = generateToken(detail);

        // 3.计入登录信息表
        loginRecordService.loginSuccess(loginDTO.getCellPhone(), detail.getUserId());
        // 4.返回结果
        return token;
    }

    private String generateToken(LoginUserDTO detail) {
        // 2.2.生成access-token
        String token = jwtTool.createToken(detail);
        // 2.3.生成refresh-token，将refresh-token的JTI 保存到Redis
        String refreshToken = jwtTool.createRefreshToken(detail);
        // 2.4.将refresh-token写入用户cookie，并设置HttpOnly为true
        int maxAge = BooleanUtils.isTrue(detail.getRememberMe()) ?
                (int) JwtConstants.JWT_REMEMBER_ME_TTL.toSeconds() : -1;
        WebUtils.cookieBuilder()
                .name(detail.getRoleId() == 2 ? JwtConstants.REFRESH_HEADER : JwtConstants.ADMIN_REFRESH_HEADER)
                .value(refreshToken)
                .maxAge(maxAge)
                .httpOnly(true)
                .build();
        return token;
    }

    @Override
    public void logout() {
        // 删除jti
        jwtTool.cleanJtiCache();
        // 删除cookie
        WebUtils.cookieBuilder()
                .name(JwtConstants.REFRESH_HEADER)
                .value("")
                .maxAge(0)
                .httpOnly(true)
                .build();
    }

    @Override
    public String refreshToken(String refreshToken) {
        // 1.校验refresh-token,校验JTI
        LoginUserDTO userDTO = jwtTool.parseRefreshToken(refreshToken);
        // 2.生成新的access-token、refresh-token
        return generateToken(userDTO);
    }
}
