package com.ext.constants;

import lombok.Getter;
import org.apache.commons.lang3.StringUtils;

import java.util.Arrays;

public enum PlatformConfigEnum {
    DEFAULT_HEAD_IMG("默认头像"),
    ;

    @Getter
    String desc;

    PlatformConfigEnum(String desc) {
        this.desc = desc;
    }

    public static String getDescByName(String name) {
        if (StringUtils.isBlank(name))
            return "";
        return Arrays.stream(PlatformConfigEnum.values()).filter(e -> e.name().equals(name)).findFirst().get().getDesc();
    }
}
