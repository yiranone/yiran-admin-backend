package com.ext.service;

import com.ext.entity.Member;
import com.ext.dto.MemberDTO;
import one.yiran.common.domain.PageModel;
import one.yiran.common.domain.PageRequest;
import one.yiran.db.common.service.CrudBaseService;

public interface MemberService extends CrudBaseService<Long, Member> {

    Member registerMember(Member member);

    Member selectByAddress(Long channelId, String address);

    PageModel<MemberDTO> selectPageDetail(PageRequest pageRequest, MemberDTO search);

    void updateMember(Member member);

}
