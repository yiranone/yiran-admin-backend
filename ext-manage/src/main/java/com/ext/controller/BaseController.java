package com.ext.controller;

import one.yiran.common.exception.BusinessException;
import one.yiran.dashboard.common.model.MemberSession;
import one.yiran.dashboard.util.MemberCacheUtil;

import javax.servlet.http.HttpServletRequest;

public class BaseController {

    protected void checkField(Object field, String message) {
        if (field == null) {
            throw BusinessException.build(String.format("%s cannot be empty", message));
        }
    }

    protected Long getMemberId(HttpServletRequest request) {
        MemberSession session = MemberCacheUtil.getSessionInfo(request);
        return session.getMemberId();
    }

}