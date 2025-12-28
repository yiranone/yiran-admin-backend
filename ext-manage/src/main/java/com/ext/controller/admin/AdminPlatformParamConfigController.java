package com.ext.controller.admin;

import com.ext.constants.BizPermissionConstants;
import com.ext.entity.PlatformParamConfig;
import com.ext.service.PlatformParamConfigService;
import com.ext.dto.PlatformParamConfigDTO;
import one.yiran.common.domain.PageModel;
import one.yiran.common.domain.PageRequest;
import one.yiran.common.exception.BusinessException;
import one.yiran.dashboard.common.annotation.AjaxWrapper;
import one.yiran.dashboard.common.annotation.ApiObject;
import one.yiran.dashboard.common.annotation.ApiParam;
import one.yiran.dashboard.common.annotation.Log;
import one.yiran.dashboard.common.annotation.RequirePermission;
import one.yiran.dashboard.common.constants.BusinessType;
import one.yiran.dashboard.common.expection.user.UserNotFoundException;
import one.yiran.dashboard.common.util.WrapUtil;
import one.yiran.dashboard.security.SessionContextHelper;
import one.yiran.dashboard.web.util.ChannelCheckUtils;
import one.yiran.db.common.util.PageRequestUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;


@AjaxWrapper
@Controller
@RequestMapping("/biz/platformParamConfig")
public class AdminPlatformParamConfigController {

    private static final String MODULE_NAME = "平台参数管理";

    @Autowired
    private PlatformParamConfigService platformParamConfigService;

    @RequirePermission(BizPermissionConstants.PlatformParamConfig.VIEW)
    @RequestMapping("/list")
    public PageModel<PlatformParamConfigDTO> list(@ApiObject(createIfNull = true) PlatformParamConfigDTO search,
                                                  @ApiParam String key, HttpServletRequest request) {
        PageRequest pageRequest = PageRequestUtil.fromRequest(request);
        Long channelId = ChannelCheckUtils.getChannelIdIfNotAdmin();
        if (channelId != null) {
            search.setChannelId(channelId);
        }
        PageModel pe = platformParamConfigService.selectPageDetail(pageRequest, search);
        return pe;
    }

    @Log(title = MODULE_NAME, businessType = BusinessType.ADD)
    @RequirePermission(BizPermissionConstants.PlatformParamConfig.ADD)
    @PostMapping("/add")
    public PlatformParamConfig add(@ApiObject(validate = true) PlatformParamConfig config) {
        Long channelId = SessionContextHelper.getChannelIdWithCheck();
        if(config.getChannelId() == null)
            config.setChannelId(channelId);
        ChannelCheckUtils.checkHasPermission(config.getChannelId());
        return platformParamConfigService.saveOrUpdate(config);
    }

    @Log(title = MODULE_NAME, businessType = BusinessType.EDIT)
    @RequirePermission(BizPermissionConstants.PlatformParamConfig.EDIT)
    @PostMapping("edit")
    public PlatformParamConfig edit(@ApiObject(validate = true) PlatformParamConfig config) {
        if (config == null) {
            throw BusinessException.build("config Cannot be empty");
        }
        if (config.getId() == null) {
            throw BusinessException.build("The ID cannot be empty");
        }
        //修改
        PlatformParamConfig db = platformParamConfigService.selectByPId(config.getId());
        if (db == null) {
            throw BusinessException.build("Data does not exist");
        }
        ChannelCheckUtils.checkHasPermission(db.getChannelId());
        db.setConfigKey(config.getConfigKey());
        db.setConfigValue(config.getConfigValue());
        db.setDescription(config.getDescription());
        db = platformParamConfigService.saveOrUpdate(db);
        return db;
    }

    @Log(title = MODULE_NAME, businessType = BusinessType.DELETE)
    @RequirePermission(BizPermissionConstants.PlatformParamConfig.DELETE)
    @PostMapping("/remove")
    public Map<String, Object> remove(@ApiParam(required = true) Long[] ids) {
        for (Long id : ids) {
            PlatformParamConfig db = platformParamConfigService.selectByPId(id);
            if (db == null)
                throw new UserNotFoundException();
            ChannelCheckUtils.checkHasPermission(db.getChannelId());
        }
        return WrapUtil.wrap("deleteCount",platformParamConfigService.removeByPIds(ids));
    }

    @RequirePermission(BizPermissionConstants.PlatformParamConfig.VIEW)
    @PostMapping("/detail")
    public PlatformParamConfig detail(@ApiParam(required = true) Long id) {
        PlatformParamConfig db =  platformParamConfigService.selectByPId(id);
        if (db == null)
            throw new UserNotFoundException();
        if(db.getChannelId() != null)
            ChannelCheckUtils.checkHasPermission(db.getChannelId());
        return db;
    }

}
