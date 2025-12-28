package com.ext.controller.admin;

import com.ext.constants.BizPermissionConstants;
import com.ext.entity.Member;
import com.ext.service.*;
import com.ext.dto.MemberDTO;
import one.yiran.common.domain.PageModel;
import one.yiran.common.domain.PageRequest;
import one.yiran.common.exception.BusinessException;
import one.yiran.dashboard.common.annotation.*;
import one.yiran.dashboard.common.constants.BusinessType;
import one.yiran.dashboard.common.expection.user.UserNotFoundException;
import one.yiran.dashboard.common.util.ExcelUtil;
import one.yiran.dashboard.entity.SysChannel;
import one.yiran.dashboard.security.SessionContextHelper;
import one.yiran.dashboard.service.SysChannelService;
import one.yiran.dashboard.web.util.ChannelCheckUtils;
import one.yiran.db.common.util.PageRequestUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@AjaxWrapper
@Controller
@RequestMapping("/biz/member")
public class AdminMemberController {

    @Autowired
    private MemberService memberService;
    @Autowired
    private SysChannelService channelService;

    @RequirePermission(BizPermissionConstants.Member.VIEW)
    @RequestMapping("/list")
    public PageModel<MemberDTO> list(@ApiObject(createIfNull = true) MemberDTO search, HttpServletRequest request) {
        PageRequest pageRequest = PageRequestUtil.fromRequest(request);
        Long channelId = ChannelCheckUtils.getChannelIdIfNotAdmin();
        if (channelId != null) {
            search.setChannelId(channelId);
        }
        return memberService.selectPageDetail(pageRequest, search);
    }

    @Log(title = "会员管理", businessType = BusinessType.ADD)
    @RequirePermission(BizPermissionConstants.Member.ADD)
    @PostMapping("/add")
    public void add(@ApiObject(validate = true) MemberDTO dto) {
        Long channelId = SessionContextHelper.getChannelIdWithCheck();
        if (dto.getChannelId() == null) dto.setChannelId(channelId);
        ChannelCheckUtils.checkHasPermission(dto.getChannelId());

        Member db = new Member();
        BeanUtils.copyProperties(dto, db);
        db.setChannelId(dto.getChannelId());
        db.setIsDelete(false);
        db.setCreateBy(SessionContextHelper.getCurrentLoginName());
        db.setUpdateBy(SessionContextHelper.getCurrentLoginName());
        memberService.registerMember(db);
    }

    @Log(title = "会员管理", businessType = BusinessType.EDIT)
    @RequirePermission(BizPermissionConstants.Member.EDIT)
    @PostMapping("edit")
    public void edit(@ApiObject(validate = true) MemberDTO dto) {
        if (dto == null) {
            throw BusinessException.build("The request cannot be empty");
        }
        if (dto.getId() == null) {
            throw BusinessException.build("The ID cannot be empty");
        }
        //修改
        Member db = memberService.selectByPId(dto.getId());
        if (db == null) {
            throw BusinessException.build("Data does not exist");
        }
        ChannelCheckUtils.checkHasPermission(db.getChannelId());

        db = MemberDTO.dtoToDb(dto, db);
        db.setUpdateBy(SessionContextHelper.getCurrentLoginName());
        memberService.updateMember(db);
    }

    @Log(title = "用户管理", businessType = BusinessType.DELETE)
    @RequirePermission(BizPermissionConstants.Member.DELETE)
    @PostMapping("/remove")
    public void remove(@ApiParam(required = true) Long[] ids) {
        for (Long id : ids) {
            Member db = memberService.selectByPId(id);
            if (db == null)
                throw new UserNotFoundException();
            ChannelCheckUtils.checkHasPermission(db.getChannelId());
        }
        memberService.deleteByPIds(ids);
    }

    @RequirePermission(BizPermissionConstants.Member.VIEW)
    @PostMapping("/detail")
    public MemberDTO detail(@ApiParam(required = true) Long memberId) {
        Member db = memberService.selectByPId(memberId);
        if (db == null)
            throw new UserNotFoundException();
        ChannelCheckUtils.checkHasPermission(db.getChannelId());

        SysChannel channel = channelService.selectByPId(db.getChannelId());
        return MemberDTO.from(db, channel);
    }


    @Log(title = "用户导出", businessType = BusinessType.EXPORT)
    @RequirePermission(BizPermissionConstants.Member.VIEW)
    @PostMapping("/export")
    public void export(@ApiObject(createIfNull = true) MemberDTO search, HttpServletRequest request, HttpServletResponse response) {
        PageRequest pageRequest = PageRequestUtil.fromRequestIgnorePageSize(request);
        Long channelId = ChannelCheckUtils.getChannelIdIfNotAdmin();
        if (channelId != null) {
            search.setChannelId(channelId);
        }
        PageModel<MemberDTO> list = memberService.selectPageDetail(pageRequest, search);
        ExcelUtil<MemberDTO> util = new ExcelUtil<>(MemberDTO.class);
        util.exportExcel(response, list.getRows(), "用户列表");
    }

}
