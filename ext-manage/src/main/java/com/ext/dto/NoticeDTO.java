package com.ext.dto;

import com.ext.entity.Notice;
import lombok.Data;
import lombok.EqualsAndHashCode;
import one.yiran.dashboard.entity.SysChannel;
import org.springframework.beans.BeanUtils;

@Data
@EqualsAndHashCode(callSuper = true)
public class NoticeDTO extends BaseDTO {
    private String title;
    private String description;
    private String content;
    private String link;
    private Integer status;
    private Integer isTop;
    private Integer isPlay;

    public static NoticeDTO from(Notice db) {
        NoticeDTO dto = new NoticeDTO();
        NoticeDTO.copy(db, dto);
        return dto;
    }

    public static NoticeDTO from(Notice db, SysChannel channel) {
        NoticeDTO dto = from(db);
        dto.setChannelCode(channel.getChannelCode());
        dto.setChannelName(channel.getChannelName());
        return dto;
    }

    public static Notice dtoToDb(NoticeDTO dto, Notice db) {
        Notice data = new Notice();
        BeanUtils.copyProperties(dto, data);
        data.setCreateTime(db.getCreateTime());
        data.setCreateBy(db.getCreateBy());
        data.setChannelId(db.getChannelId());
        data.setIsDelete(db.getIsDelete());
        return data;
    }

}
