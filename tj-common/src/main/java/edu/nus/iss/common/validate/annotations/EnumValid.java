package edu.nus.iss.common.validate.annotations;

import edu.nus.iss.common.validate.EnumValidator;
import edu.nus.iss.common.validate.EnumValueValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

/**
 * 用于状态的枚举校验
 **/
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ ElementType.PARAMETER, ElementType.FIELD, ElementType.METHOD })
@Constraint(validatedBy = {EnumValidator.class, EnumValueValidator.class})
public @interface EnumValid {
    String message() default "不满足业务条件";

    int[] enumeration() default {};

    Class<?>[] groups() default { };

    Class<? extends Payload>[] payload() default { };
}
