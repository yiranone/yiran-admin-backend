package com.ext.dto;

import com.ext.entity.Banner;
import lombok.Data;
import lombok.EqualsAndHashCode;
import one.yiran.dashboard.entity.SysChannel;
import one.yiran.db.common.annotation.Search;
import org.springframework.beans.BeanUtils;

@Data
@EqualsAndHashCode(callSuper = true)
public class BannerDTO extends BaseDTO {
    @Search(op = Search.Op.REGEX)
    private String bannerName;
    private String bannerLink;
    private Integer bannerType;
    private String imageUrl;
    private Integer position;
    private String content;
    @Search
    private Integer status;
    private Integer sort;

    public static BannerDTO from(Banner db) {
        BannerDTO dto = new BannerDTO();
        BaseDTO.copy(db, dto);
        return dto;
    }

    public static BannerDTO from(Banner db, SysChannel channel) {
        BannerDTO dto = from(db);
        dto.setChannelCode(channel.getChannelCode());
        dto.setChannelName(channel.getChannelName());
        return dto;
    }

    public static Banner dtoToDb(BannerDTO dto, Banner db) {
        Banner data = new Banner();
        BeanUtils.copyProperties(dto, data);
        data.setCreateTime(db.getCreateTime());
        data.setCreateBy(db.getCreateBy());
        data.setChannelId(db.getChannelId());
        data.setIsDelete(db.getIsDelete());
        return data;
    }
}
