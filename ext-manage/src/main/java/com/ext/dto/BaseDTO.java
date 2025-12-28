package com.ext.dto;

import lombok.Data;
import one.yiran.common.util.DateUtil;
import one.yiran.dashboard.common.annotation.Excel;
import one.yiran.db.common.annotation.Search;
import one.yiran.db.common.domain.TimedBasedEntity;
import org.springframework.beans.BeanUtils;

@Data
public class BaseDTO {
    private Long id;
    @Search
    private Long channelId;
    protected String channelCode;
    private String channelName;
    @Excel(name = "创建时间")
    protected String createTime;
    private String createBy;
    protected String updateTime;
    private String updateBy;
    private Boolean isDelete;
    private String remark;

    protected static void copy(TimedBasedEntity db, BaseDTO dto) {
        BeanUtils.copyProperties(db, dto);

        dto.setCreateBy(db.getCreateBy());
        dto.setCreateTime(DateUtil.dateTime(db.getCreateTime()));
        dto.setUpdateBy(db.getUpdateBy());
        dto.setUpdateTime(DateUtil.dateTime(db.getUpdateTime()));
    }
}
