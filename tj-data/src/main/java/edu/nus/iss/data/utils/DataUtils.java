package edu.nus.iss.data.utils;

import edu.nus.iss.common.utils.DateUtils;
import lombok.extern.slf4j.Slf4j;

/**
 * @ClassName DataUtils
 * @Author wusongsong
 * @Date 2022/10/10 19:40
 * @Version
 **/
@Slf4j
public class DataUtils {

    public static int getVersion(int totalVersion) {
        return DateUtils.now().getDayOfMonth() % totalVersion;
    }
}
