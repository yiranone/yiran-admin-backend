package com.ext.dto;

import com.ext.entity.Question;
import lombok.Data;
import lombok.EqualsAndHashCode;
import one.yiran.dashboard.entity.SysChannel;
import org.springframework.beans.BeanUtils;

@Data
@EqualsAndHashCode(callSuper = true)
public class QuestionDTO extends BaseDTO {
    private String title;//标题
    private String content;//内容
    private Integer sortNo;

    public static QuestionDTO from(Question db) {
        QuestionDTO dto = new QuestionDTO();
        QuestionDTO.copy(db, dto);
        return dto;
    }

    public static QuestionDTO from(Question db, SysChannel channel) {
        QuestionDTO dto = from(db);
        dto.setChannelCode(channel.getChannelCode());
        dto.setChannelName(channel.getChannelName());
        return dto;
    }

    public static Question dtoToDb(QuestionDTO dto, Question db) {
        Question data = new Question();
        BeanUtils.copyProperties(dto, data);
        data.setCreateTime(db.getCreateTime());
        data.setCreateBy(db.getCreateBy());
        data.setChannelId(db.getChannelId());
        data.setIsDelete(db.getIsDelete());
        return data;
    }
}
