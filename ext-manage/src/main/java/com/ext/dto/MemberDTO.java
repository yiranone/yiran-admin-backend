package com.ext.dto;

import com.ext.entity.Member;
import lombok.Data;
import lombok.EqualsAndHashCode;
import one.yiran.common.util.DateUtil;
import one.yiran.dashboard.entity.SysChannel;
import org.springframework.beans.BeanUtils;

@Data
@EqualsAndHashCode(callSuper = true)
public class MemberDTO extends BaseDTO {
    private String memberCode;
    private String loginAddress;
    private String status;
    private String registerTime;
    private String loginIp;
    private String loginTime;

    public static MemberDTO from(Member db) {
        MemberDTO dto = new MemberDTO();
        BaseDTO.copy(db, dto);

        dto.setRegisterTime(DateUtil.dateTime(db.getRegisterTime()));
        dto.setLoginTime(DateUtil.dateTime(db.getLoginTime()));
        return dto;
    }

    public static MemberDTO from(Member db, SysChannel sysChannel) {
        MemberDTO dto = from(db);
        dto.setChannelCode(sysChannel.getChannelCode());
        dto.setChannelName(sysChannel.getChannelName());
        return dto;
    }

    public static Member dtoToDb(MemberDTO dto, Member db) {
        Member data = new Member();
        BeanUtils.copyProperties(dto, data);

        data.setMemberCode(db.getMemberCode());
        data.setRegisterTime(db.getRegisterTime());
        data.setLoginIp(db.getLoginIp());
        data.setLoginTime(db.getLoginTime());

        data.setCreateTime(db.getCreateTime());
        data.setCreateBy(db.getCreateBy());
        data.setChannelId(db.getChannelId());
        data.setIsDelete(db.getIsDelete());
        return data;
    }
}
