package com.ext.dto;

import com.ext.entity.PlatformParamConfig;
import lombok.Data;
import lombok.EqualsAndHashCode;
import one.yiran.dashboard.entity.SysChannel;
import org.springframework.beans.BeanUtils;

@Data
@EqualsAndHashCode(callSuper = true)
public class PlatformParamConfigDTO extends BaseDTO {
    private String configGroup;
    private String valueType;
    private String configKey;
    private String configName;
    private String configValue;
    private String description;

    public static PlatformParamConfigDTO from(PlatformParamConfig db) {
        PlatformParamConfigDTO dto = new PlatformParamConfigDTO();
        BaseDTO.copy(db, dto);
        return dto;
    }

    public static PlatformParamConfigDTO from(PlatformParamConfig db, SysChannel channel) {
        PlatformParamConfigDTO dto = from(db);
        if (channel != null) {
            dto.setChannelCode(channel.getChannelCode());
            dto.setChannelName(channel.getChannelName());
        }
        return dto;
    }

    public static PlatformParamConfig dtoToDb(PlatformParamConfigDTO dto, PlatformParamConfig db) {
        PlatformParamConfig data = new PlatformParamConfig();
        BeanUtils.copyProperties(dto, data);
        data.setCreateTime(db.getCreateTime());
        data.setCreateBy(db.getCreateBy());
        data.setChannelId(db.getChannelId());
        data.setIsDelete(db.getIsDelete());
        return data;
    }
}
