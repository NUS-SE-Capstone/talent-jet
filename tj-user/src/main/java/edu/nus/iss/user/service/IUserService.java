package edu.nus.iss.user.service;

import com.baomidou.mybatisplus.extension.service.IService;
import edu.nus.iss.api.dto.user.LoginFormDTO;
import edu.nus.iss.api.dto.user.UserDTO;
import edu.nus.iss.common.domain.dto.LoginUserDTO;
import edu.nus.iss.user.domain.dto.UserFormDTO;
import edu.nus.iss.user.domain.po.User;
import edu.nus.iss.user.domain.vo.UserDetailVO;

/**
 * <p>
 * 学员用户表 服务类
 * </p>
 *
 * 
 */
public interface IUserService extends IService<User> {
    LoginUserDTO queryUserDetail(LoginFormDTO loginDTO, boolean isStaff);

    void resetPassword(Long userId);

    UserDetailVO myInfo();

    void addUserByPhone(User user, String code);

    void updatePasswordByPhone(String cellPhone, String code, String password);

    Long saveUser(UserDTO userDTO);

    void updateUser(UserDTO userDTO);

    void updateUserWithPassword(UserFormDTO userDTO);
}
