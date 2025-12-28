package com.ext.controller.admin;

import com.ext.constants.BizPermissionConstants;
import com.ext.entity.Banner;
import com.ext.service.BannerService;
import com.ext.dto.BannerDTO;
import one.yiran.common.domain.PageModel;
import one.yiran.common.domain.PageRequest;
import one.yiran.common.exception.BusinessException;
import one.yiran.dashboard.common.annotation.AjaxWrapper;
import one.yiran.dashboard.common.annotation.ApiObject;
import one.yiran.dashboard.common.annotation.ApiParam;
import one.yiran.dashboard.common.annotation.Log;
import one.yiran.dashboard.common.annotation.RequirePermission;
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
@RequestMapping("/biz/banner")
public class AdminBannerController {
    private static final String MODULE_NAME = "BANNER管理";

    @Autowired
    private BannerService bannerService;

    @Autowired
    private SysChannelService sysChannelService;

    @RequirePermission(BizPermissionConstants.Banner.VIEW)
    @RequestMapping("/list")
    public PageModel<BannerDTO> list(@ApiObject(createIfNull = true) BannerDTO search, HttpServletRequest request) {
        PageRequest pageRequest = PageRequestUtil.fromRequest(request);
        Long channelId = ChannelCheckUtils.getChannelIdIfNotAdmin();
        if (channelId != null) {
            search.setChannelId(channelId);
        }
        return bannerService.selectPageDetail(pageRequest, search);
    }

    @Log(title = MODULE_NAME, businessType = BusinessType.ADD)
    @RequirePermission(BizPermissionConstants.Banner.ADD)
    @PostMapping("/add")
    public void add(@ApiObject(validate = true) BannerDTO dto) {
        Long channelId = SessionContextHelper.getChannelIdWithCheck();
        if (dto.getChannelId() == null) dto.setChannelId(channelId);
        ChannelCheckUtils.checkHasPermission(dto.getChannelId());

        Banner db = new Banner();
        BeanUtils.copyProperties(dto, db);
        db.setChannelId(dto.getChannelId());
        db.setIsDelete(false);
        db.setCreateBy(SessionContextHelper.getCurrentLoginName());
        db.setUpdateBy(SessionContextHelper.getCurrentLoginName());
        bannerService.insert(db);
    }

    @Log(title = MODULE_NAME, businessType = BusinessType.EDIT)
    @RequirePermission(BizPermissionConstants.Banner.EDIT)
    @PostMapping("edit")
    public void edit(@ApiObject(validate = true) BannerDTO dto) {
        if (dto == null) {
            throw BusinessException.build("The request cannot be empty");
        }
        if (dto.getId() == null) {
            throw BusinessException.build("The ID cannot be empty");
        }
        Banner db = bannerService.selectByPId(dto.getId());
        if (db == null) {
            throw BusinessException.build("Data does not exist");
        }
        ChannelCheckUtils.checkHasPermission(db.getChannelId());

        db = BannerDTO.dtoToDb(dto, db);
        db.setRemark(dto.getRemark());
        db.setUpdateBy(SessionContextHelper.getCurrentLoginName());
        bannerService.update(db);
    }

    @Log(title = MODULE_NAME, businessType = BusinessType.DELETE)
    @RequirePermission(BizPermissionConstants.Banner.DELETE)
    @PostMapping("/delete")
    public void delete(@ApiParam(required = true) Long[] ids) {
        for (Long id : ids) {
            Banner db = bannerService.selectByPId(id);
            if (db == null) throw BusinessException.build("Data does not exist");
            ChannelCheckUtils.checkHasPermission(db.getChannelId());
        }
        bannerService.removeByPIds(ids);
    }

    @RequirePermission(BizPermissionConstants.Banner.VIEW)
    @PostMapping("/detail")
    public BannerDTO detail(@ApiParam(required = true) Long id) {
        Banner db = bannerService.selectByPId(id);
        if (db == null) throw BusinessException.build("Data does not exist");
        if (db.getChannelId() != null) ChannelCheckUtils.checkHasPermission(db.getChannelId());
        SysChannel channel = sysChannelService.selectByPId(db.getChannelId());
        return BannerDTO.from(db, channel);
    }
}
