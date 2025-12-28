package com.ext.controller;

import com.ext.entity.Member;
import com.ext.service.MemberService;
import lombok.extern.slf4j.Slf4j;
import one.yiran.dashboard.common.constants.Global;
import one.yiran.dashboard.common.model.MemberSession;
import one.yiran.dashboard.util.MemberCacheUtil;
import one.yiran.dashboard.common.annotation.AjaxWrapper;
import one.yiran.dashboard.common.annotation.ApiChannel;
import one.yiran.dashboard.common.annotation.ApiParam;
import one.yiran.dashboard.common.constants.SystemConstants;
import one.yiran.dashboard.common.expection.user.UserBlockedException;
import one.yiran.dashboard.common.expection.user.UserDeleteException;
import one.yiran.dashboard.common.util.MessageUtil;
import one.yiran.dashboard.entity.SysChannel;
import one.yiran.dashboard.factory.AsyncFactory;
import one.yiran.dashboard.factory.AsyncManager;
import one.yiran.dashboard.security.SessionContextHelper;
import one.yiran.dashboard.service.SysChannelService;
import one.yiran.dashboard.vo.ChannelVO;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.security.SignatureException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@AjaxWrapper
@Controller
@RequestMapping("/ext/member")
public class MemberLoginController {

    @Autowired
    private MemberService memberService;
    @Autowired
    private SysChannelService channelService;

    @RequestMapping("/config")
    public Map<String, String> loginConfig(HttpServletRequest request) {
        Map<String, String> map = new HashMap<>();
        String hostName = request.getHeader("Host");
        log.info("客户端请求 Host:{}", hostName);
        String logo = null;
        String icon = null;
        String displayName = null;
        String registerNeedInviteCode = "N";
        String h5logo = "";
        String channel = "";
        if (StringUtils.isNotBlank(hostName)) {
            SysChannel sysChan = channelService.selectByH5DomainName(hostName);
            if (sysChan != null) {
                logo = sysChan.getLogo();
                displayName = sysChan.getDisplayName();
                icon = sysChan.getIcon();
                registerNeedInviteCode = sysChan.getRegisterNeedInviteCode();
                h5logo = sysChan.getH5logo();
                channel = sysChan.getChannelCode();
            }
        }
        map.put("logo", logo);
        map.put("icon", icon);
        map.put("displayName", displayName);
        map.put("registerNeedInviteCode", registerNeedInviteCode);
        map.put("h5logo", h5logo);
        map.put("channel", channel);
        return map;
    }

    @RequestMapping("/loginNonce")
    public String loginNonce(@ApiChannel ChannelVO channelVO, @ApiParam(required = true) String address, HttpServletRequest request) {
        String channelName = StringUtils.defaultString(channelVO.getChannelCode(), "SIGN");
        return channelName + "_" + address + "_" + System.currentTimeMillis();
    }

    @PostMapping("/loginBySign")
    public MemberSession loginBySign(@ApiChannel ChannelVO channelVO,
                                     @ApiParam(required = true) String address,
                                     HttpServletRequest request) throws SignatureException {

        log.info("用户使用的客户端 {}", request.getHeader("User-Agent"));
//        boolean success = Web3SignatureVerification.verifyStrictSignature(address, signedMessage, originalMessage, channelVO.getChannelCode());
//        if (!success) {
//            throw BusinessException.build("Login failed, signature abnormal");
//        }

        SysChannel channel = channelService.selectByPId(channelVO.getChannelId());
        Member m = memberService.selectByAddress(channelVO.getChannelId(), address);
        if (m == null) {
            log.info("{}首次登陆初始化账号", address);
            m = new Member();
            m.setChannelId(channel.getChannelId());
            m.setLoginAddress(address);
            m.setIsDelete(false);
            m.setCreateBy("sys");
            m.setUpdateBy("sys");
            m = memberService.registerMember(m);
        }
        log.info("用户登陆成功,memberId={},channelId={}", m.getId(), m.getChannelId());

        String username = m.getLoginAddress();
        if (Boolean.TRUE.equals(m.getIsDelete())) {
            AsyncManager.me().execute(AsyncFactory.recordMemberLoginInfo(m.getChannelId(), m.getId(), username, SystemConstants.LOGIN_FAIL, MessageUtil.message("user.password.delete")));
            throw new UserDeleteException();
        }

        if (SystemConstants.STATUS_DISABLE.equals(m.getStatus())) {
            AsyncManager.me().execute(AsyncFactory.recordMemberLoginInfo(m.getChannelId(), m.getId(), username, SystemConstants.LOGIN_FAIL, MessageUtil.message("user.blocked", m.getLoginAddress())));
            throw new UserBlockedException();
        }

        AsyncManager.me().execute(AsyncFactory.recordMemberLoginInfo(m.getChannelId(), m.getId(), "会员" + m.getId(), SystemConstants.LOGIN_SUCCESS, MessageUtil.message("user.login.success")));
        m.setLoginIp(SessionContextHelper.getIp());
        m.setLoginTime(new Date());
        memberService.update(m);

        String randomKey = channel.getChannelCode() + "_" + m.getId() + "_" + RandomStringUtils.randomAlphanumeric(38);

        MemberSession memberSession = new MemberSession();
        memberSession.setMemberId(m.getId());
        memberSession.setLoginAddress(m.getLoginAddress());
        memberSession.setChannelId(channel.getChannelId());
        memberSession.setChannelCode(channel.getChannelCode());
        memberSession.setChannelName(channel.getChannelName());
        memberSession.setIsLocked(SystemConstants.STATUS_DISABLE.equals(m.getStatus()));

        MemberCacheUtil.setSessionInfo(randomKey, memberSession);
        memberSession.setToken(randomKey);
        Calendar c = Calendar.getInstance();
        c.add(Calendar.MINUTE, Global.getSessionTimeout().intValue());
        memberSession.setTokenExpires(c.getTimeInMillis());

        return memberSession;
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        MemberSession memberSession = MemberCacheUtil.getSessionInfo(request);
        if (memberSession != null) {
            String phone = memberSession.getPhone();
            // 记录用户退出日志
            AsyncManager.me().execute(AsyncFactory.recordMemberLoginInfo(memberSession.getChannelId(), memberSession.getMemberId(), phone, SystemConstants.LOGOUT, MessageUtil.message("user.logout.success")));
            //设置数据库里面的用户状态为离线
            log.info("设置用户{}为离线状态 token={}", phone, memberSession.getToken());
            // 清理缓存
            MemberCacheUtil.removeSessionInfo(memberSession.getToken());
            return "会员退出登陆成功";
        }
        return "会员退出登陆异常";
    }
}
