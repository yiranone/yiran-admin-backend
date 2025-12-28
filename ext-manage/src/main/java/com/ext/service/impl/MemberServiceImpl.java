package com.ext.service.impl;

import com.ext.dao.*;
import com.ext.entity.*;
import com.ext.service.MemberService;
import com.ext.util.ShareCodeUtil;
import com.ext.dto.MemberDTO;
import com.querydsl.core.Tuple;
import com.querydsl.core.types.Predicate;
import com.querydsl.jpa.impl.JPAQuery;
import lombok.extern.slf4j.Slf4j;
import one.yiran.common.domain.PageModel;
import one.yiran.common.domain.PageRequest;
import one.yiran.common.exception.BusinessException;
import one.yiran.dashboard.common.constants.SystemConstants;
import one.yiran.dashboard.entity.*;
import one.yiran.dashboard.service.SysChannelService;
import one.yiran.dashboard.util.MemberCacheUtil;
import one.yiran.db.common.service.CrudBaseServiceImpl;
import one.yiran.db.common.util.PageRequestUtil;
import one.yiran.db.common.util.PredicateBuilder;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.*;

@Slf4j
@Service
public class MemberServiceImpl extends CrudBaseServiceImpl<Long, Member> implements MemberService {

    @Autowired
    private MemberDao memberDao;
    @Autowired
    private SysChannelService sysChannelService;

    @Override
    public Member selectByAddress(Long channelId, String address) {
        Assert.notNull(channelId, "channelId不能为空");
        Assert.hasLength(address, "phone不能为空");
        return super.selectOne(QMember.member.channelId.eq(channelId)
                .and(QMember.member.loginAddress.eq(address)));
    }

    @Override
    public PageModel<MemberDTO> selectPageDetail(PageRequest pageRequest, MemberDTO search) {
        QMember qMember = QMember.member;
        QSysChannel qSysChannel = QSysChannel.sysChannel;

        Predicate[] pres = PredicateBuilder.builder()
                .addEqualOrNullExpression(qMember.isDelete, Boolean.FALSE)
                .addEntityByAnnotation(search, qMember)
                .toArray();

        JPAQuery<Tuple> q = queryFactory.select(qMember, qSysChannel).from(qMember)
                .leftJoin(qSysChannel).on(qSysChannel.channelId.eq(qMember.channelId))
                .where(pres);

        PageRequestUtil.injectQuery(pageRequest, q, qMember, qSysChannel);

        List<Tuple> ts = q.fetch();
        List<MemberDTO> memberVOS = new ArrayList<>();
        for (Tuple r : ts) {
            Member member = r.get(qMember);
            SysChannel sysChannel = r.get(qSysChannel);
            MemberDTO vo = MemberDTO.from(member, sysChannel);
            memberVOS.add(vo);
        }
        long count = q.fetchCount();
        return PageModel.instance(count, memberVOS);
    }

    @Override
    @Transactional
    public Member registerMember(Member member) {
        Member db = this.selectByAddress(member.getChannelId(), member.getLoginAddress());
        if (db == null) {
            throw BusinessException.build("Login address '" + member.getLoginAddress() + "' has been registered");
        }
        member.setStatus(SystemConstants.STATUS_ENABLE);
        member.setRegisterTime(new Date());
        member = this.insert(member);

        member.setMemberCode(ShareCodeUtil.generateCode(member.getId()));
        return memberDao.saveAndFlush(member);
    }

    @Override
    @Transactional
    public void updateMember(Member t) {
        Member db = memberDao.lockById(t.getId());
        db.setStatus(t.getStatus());
        db.setUpdateBy(t.getUpdateBy());
        db.setRemark(t.getRemark());
        this.attemptModifyLoginAddress(db, t.getLoginAddress());
        if (SystemConstants.STATUS_DISABLE.equals(t.getStatus())) {//冻结，直接退出登录
            SysChannel channel = sysChannelService.selectByPId(db.getChannelId());
            MemberCacheUtil.removeAllSessionInfo(channel.getChannelCode(), db.getId());
        }
        this.update(db);
    }

    private void attemptModifyLoginAddress(Member db, String loginAddress) {
        if (StringUtils.isEmpty(loginAddress)) {
            throw BusinessException.build("The login address cannot be empty");
        }
        if (!StringUtils.equals(loginAddress, db.getLoginAddress())) {
            Member checkUser = this.selectByAddress(db.getChannelId(), loginAddress);
            if (checkUser != null && !checkUser.getId().equals(db.getId())) {
                throw BusinessException.build("Login address '" + loginAddress + "' has been registered");
            }
            db.setLoginAddress(loginAddress);
        }
    }

}
