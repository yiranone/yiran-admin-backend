package one.yiran.dashboard.factory;

import eu.bitwalker.useragentutils.UserAgent;
import one.yiran.dashboard.common.constants.SystemConstants;
import one.yiran.dashboard.common.constants.UserConstants;
import one.yiran.dashboard.common.model.UserSession;
import one.yiran.dashboard.common.util.TraceUtil;
import one.yiran.dashboard.entity.*;
import one.yiran.dashboard.service.*;
import one.yiran.dashboard.common.util.IpUtil;
import one.yiran.dashboard.util.LogUtil;
import one.yiran.dashboard.common.util.ServletUtil;
import one.yiran.dashboard.common.util.SpringUtil;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Date;
import java.util.TimerTask;


public class AsyncFactory {
    private static final Logger sys_user_admin_logger = LoggerFactory.getLogger("sys-admin");
    private static final Logger sys_user_member_logger = LoggerFactory.getLogger("sys-member");

    public static TimerTask recordOperateInfo(final SysOperateLog sysOperateLog) {
        final String traceId = TraceUtil.getTraceId();
        return new TimerTask() {
            @Override
            public void run() {
                TraceUtil.setTraceId(traceId);
                sysOperateLog.setJsonResult(StringUtils.substring(sysOperateLog.getJsonResult(),0,2048));
                sysOperateLog.setOperateLocation(IpUtil.getRealAddressByIP(sysOperateLog.getOperateIp()));
                sysOperateLog.setCreateTime(new Date());
                SpringUtil.getBean(SysOperLogService.class).insert(sysOperateLog);
            }
        };
    }

    public static TimerTask recordUserLoginInfo(final Long channelId, final Long categoryId, final String username, final String status, final String message, final Object... args) {
        return recordLoginInfo(UserConstants.SESSION_TYPE_USER,channelId,categoryId,username, status, message, args);
    }

    public static TimerTask recordMemberLoginInfo(final Long channelId, final Long categoryId,final String username, final String status, final String message, final Object... args) {
        return recordLoginInfo(UserConstants.SESSION_TYPE_MEMBER,channelId,categoryId,username, status, message, args);
    }

    //登陆用户打印到控制台 并记录到数据库
    public static TimerTask recordLoginInfo(final String category, final Long channelId, final Long categoryId, final String username, final String status, final String message, final Object... args) {
        final UserAgent userAgent = UserAgent.parseUserAgentString(ServletUtil.getRequest().getHeader("User-Agent"));
        final String ip = IpUtil.getIpAddr(ServletUtil.getRequest());
        final String traceId = TraceUtil.getTraceId();
        return new TimerTask() {
            @Override
            public void run() {
                TraceUtil.setTraceId(traceId);
                if(username == null)
                    return;
                String ipString = IpUtil.getRealAddressByIP(ip);
                StringBuilder s = new StringBuilder();
                s.append(LogUtil.getBlock(ip));
                s.append(ipString);
                s.append(LogUtil.getBlock(username));
                s.append(LogUtil.getBlock(status));
                s.append(LogUtil.getBlock(message));
                // 打印信息到日志
                if(StringUtils.equals(category, UserConstants.SESSION_TYPE_USER))
                    sys_user_admin_logger.info(s.toString(), args);
                else
                    sys_user_member_logger.info(s.toString(), args);
                // 获取客户端操作系统
                String os = userAgent.getOperatingSystem().getName();
                // 获取客户端浏览器
                String browser = userAgent.getBrowser().getName();
                // 封装对象
                SysLoginInfo logininfor = new SysLoginInfo();
                logininfor.setCreateBy(StringUtils.substring(username,0,32));
                logininfor.setCreateTime(new Date());
                logininfor.setChannelId(channelId);
                logininfor.setLoginName(StringUtils.substring(username,0,32));
                logininfor.setIpAddr(StringUtils.substring(ip,0,32));
                logininfor.setLoginLocation(StringUtils.substring(ipString,0,32));
                logininfor.setBrowser(StringUtils.substring(browser,0,32));
                logininfor.setOs(StringUtils.substring(os,0,32));
                logininfor.setMsg(StringUtils.substring(message,0,1024));
                logininfor.setLoginTime(new Date());
                logininfor.setCategoryId(categoryId); //userid or memberid
                logininfor.setCategory(category);
                // 日志状态
                if (SystemConstants.SUCCESS.equals(status) || SystemConstants.LOGOUT.equals(status) || SystemConstants.REGISTER.equals(status)) {
                    logininfor.setStatus(SystemConstants.SUCCESS);
                } else if (SystemConstants.FAIL.equals(status)) {
                    logininfor.setStatus(SystemConstants.FAIL);
                }
                // 插入数据
                SpringUtil.getBean(SysLoginInfoService.class).insert(logininfor);
            }
        };
    }

    //记录在线用户信息表
    public static TimerTask recordOnlineInfo(UserSession session) {
        final String traceId = TraceUtil.getTraceId();
        final UserAgent userAgent = UserAgent.parseUserAgentString(ServletUtil.getRequest().getHeader("User-Agent"));
        final String ip = IpUtil.getIpAddr(ServletUtil.getRequest());
        return new TimerTask() {
            @Override
            public void run() {
                TraceUtil.setTraceId(traceId);
                String ipString = IpUtil.getRealAddressByIP(ip);
                // 获取客户端操作系统
                String os = userAgent.getOperatingSystem().getName();
                // 获取客户端浏览器
                String browser = userAgent.getBrowser().getName();
                String deptName = "";
                String channelName = "";
                if (session.getDeptId() != null) {
                    SysDept dept = SpringUtil.getBean(SysDeptService.class).selectByPId(session.getDeptId());
                    deptName = dept.getDeptName();
                }
                if (session.getChannelId() != null) {
                    SysChannel channel = SpringUtil.getBean(SysChannelService.class).selectByPId(session.getChannelId());
                    if(channel != null)
                        channelName = channel.getChannelName();
                }
                // 封装对象
                SysUserOnline sysUserOnline = new SysUserOnline();
                sysUserOnline.setBrowser(browser);
                sysUserOnline.setOs(os);
                sysUserOnline.setIpAddr(ip);
                sysUserOnline.setLoginLocation(ipString);
                sysUserOnline.setLoginName(session.getLoginName());
                sysUserOnline.setSessionId(session.getToken());
                sysUserOnline.setExpireTime(session.getTokenExpires());
                sysUserOnline.setStartTimestamp(new Date());
                sysUserOnline.setLastAccessTime(new Date());
                sysUserOnline.setDeptName(deptName);
                sysUserOnline.setChannelName(channelName);
                // 插入数据
                SpringUtil.getBean(SysUserOnlineService.class).saveOnline(sysUserOnline);
            }
        };
    }
}
