package com.ext.dto;

import com.ext.entity.Article;
import lombok.Data;
import lombok.EqualsAndHashCode;
import one.yiran.dashboard.entity.SysChannel;
import org.springframework.beans.BeanUtils;

@Data
@EqualsAndHashCode(callSuper = true)
public class ArticleDTO extends BaseDTO {
    private String title;
    private String content;
    private String type;

    public static ArticleDTO from(Article db) {
        ArticleDTO dto = new ArticleDTO();
        BaseDTO.copy(db, dto);
        return dto;
    }

    public static ArticleDTO from(Article db, SysChannel channel) {
        ArticleDTO dto = from(db);
        dto.setChannelCode(channel.getChannelCode());
        dto.setChannelName(channel.getChannelName());
        return dto;
    }

    public static Article dtoToDb(ArticleDTO dto, Article db) {
        Article data = new Article();
        BeanUtils.copyProperties(dto, data);
        data.setCreateTime(db.getCreateTime());
        data.setCreateBy(db.getCreateBy());
        data.setChannelId(db.getChannelId());
        data.setIsDelete(db.getIsDelete());
        return data;
    }
}
