package edu.nus.iss.user.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import edu.nus.iss.common.exceptions.BadRequestException;
import edu.nus.iss.user.constants.UserErrorInfo;
import lombok.Getter;

@Getter
public enum UserStatus {
    FROZEN(0, "禁止使用"),
    NORMAL(1, "已激活"),
    ;
    @EnumValue
    int value;
    String desc;

    UserStatus(Integer value, String desc) {
        this.value = value;
        this.desc = desc;
    }

    public static UserStatus of(int value) {
        if (value == 0) {
            return FROZEN;
        }
        if (value == 1) {
            return NORMAL;
        }
        throw new BadRequestException(UserErrorInfo.Msg.INVALID_USER_STATUS);
    }
}