package com.ext.controller.admin;

import com.ext.constants.BizPermissionConstants;
import com.ext.dto.NoticeDTO;
import com.ext.entity.Notice;
import com.ext.service.NoticeService;
import one.yiran.common.domain.PageModel;
import one.yiran.common.domain.PageRequest;
import one.yiran.common.exception.BusinessException;
import one.yiran.dashboard.common.annotation.*;
import one.yiran.dashboard.common.constants.BusinessType;
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

@AjaxWrapper
@Controller
@RequestMapping("/biz/notice")
public class AdminNoticeController {
    private static final String MODULE_NAME = "消息管理";

    @Autowired
    private NoticeService noticeService;

    @Autowired
    private SysChannelService sysChannelService;

    @RequirePermission(BizPermissionConstants.Notice.VIEW)
    @RequestMapping("/list")
    public PageModel<NoticeDTO> list(@ApiObject(createIfNull = true) NoticeDTO search, HttpServletRequest request) {
        PageRequest pageRequest = PageRequestUtil.fromRequest(request);
        Long channelId = ChannelCheckUtils.getChannelIdIfNotAdmin();
        if (channelId != null) {
            search.setChannelId(channelId);
        }
        return noticeService.selectPageDetail(pageRequest, search);
    }

    @Log(title = MODULE_NAME, businessType = BusinessType.ADD)
    @RequirePermission(BizPermissionConstants.Notice.ADD)
    @PostMapping("/add")
    public void add(@ApiObject(validate = true) NoticeDTO dto) {
        Long channelId = SessionContextHelper.getChannelIdWithCheck();
        if (dto.getChannelId() == null) dto.setChannelId(channelId);
        ChannelCheckUtils.checkHasPermission(dto.getChannelId());

        Notice db = new Notice();
        BeanUtils.copyProperties(dto, db);
        db.setChannelId(dto.getChannelId());
        db.setIsDelete(false);
        db.setCreateBy(SessionContextHelper.getCurrentLoginName());
        db.setUpdateBy(SessionContextHelper.getCurrentLoginName());
        noticeService.insert(db);
    }

    @Log(title = MODULE_NAME, businessType = BusinessType.EDIT)
    @RequirePermission(BizPermissionConstants.Notice.EDIT)
    @PostMapping("edit")
    public void edit(@ApiObject(validate = true) NoticeDTO dto) {
        if (dto == null) {
            throw BusinessException.build("The request cannot be empty");
        }
        if (dto.getId() == null) {
            throw BusinessException.build("The ID cannot be empty");
        }
        Notice db = noticeService.selectByPId(dto.getId());
        if (db == null) {
            throw BusinessException.build("Data does not exist");
        }
        ChannelCheckUtils.checkHasPermission(db.getChannelId());

        db = NoticeDTO.dtoToDb(dto, db);
        db.setRemark(dto.getRemark());
        db.setUpdateBy(SessionContextHelper.getCurrentLoginName());
        noticeService.update(db);
    }

    @Log(title = MODULE_NAME, businessType = BusinessType.DELETE)
    @RequirePermission(BizPermissionConstants.Notice.DELETE)
    @PostMapping("/delete")
    public void delete(@ApiParam(required = true) Long[] ids) {
        for (Long id : ids) {
            Notice db = noticeService.selectByPId(id);
            if (db == null) throw BusinessException.build("Data does not exist");
            ChannelCheckUtils.checkHasPermission(db.getChannelId());
        }
        noticeService.removeByPIds(ids);
    }

    @RequirePermission(BizPermissionConstants.Notice.VIEW)
    @PostMapping("/detail")
    public NoticeDTO detail(@ApiParam(required = true) Long id) {
        Notice db = noticeService.selectByPId(id);
        if (db == null) throw BusinessException.build("Data does not exist");
        if (db.getChannelId() != null) ChannelCheckUtils.checkHasPermission(db.getChannelId());
        SysChannel channel = sysChannelService.selectByPId(db.getChannelId());
        return NoticeDTO.from(db, channel);
    }
}
