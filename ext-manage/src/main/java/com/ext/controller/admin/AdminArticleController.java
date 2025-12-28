package com.ext.controller.admin;

import com.ext.constants.BizPermissionConstants;
import com.ext.entity.Article;
import com.ext.service.ArticleService;
import com.ext.dto.ArticleDTO;
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
@RequestMapping("/biz/article")
public class AdminArticleController {
    private static final String MODULE_NAME = "文章管理";

    @Autowired
    private ArticleService articleService;

    @Autowired
    private SysChannelService sysChannelService;

    @RequirePermission(BizPermissionConstants.Article.VIEW)
    @RequestMapping("/list")
    public PageModel<ArticleDTO> list(@ApiObject(createIfNull = true) ArticleDTO search, HttpServletRequest request) {
        PageRequest pageRequest = PageRequestUtil.fromRequest(request);
        Long channelId = ChannelCheckUtils.getChannelIdIfNotAdmin();
        if (channelId != null) {
            search.setChannelId(channelId);
        }
        return articleService.selectPageDetail(pageRequest, search);
    }

    @Log(title = MODULE_NAME, businessType = BusinessType.ADD)
    @RequirePermission(BizPermissionConstants.Article.ADD)
    @PostMapping("/add")
    public void add(@ApiObject(validate = true) ArticleDTO dto) {
        Long channelId = SessionContextHelper.getChannelIdWithCheck();
        if (dto.getChannelId() == null) dto.setChannelId(channelId);
        ChannelCheckUtils.checkHasPermission(dto.getChannelId());

        Article db = new Article();
        BeanUtils.copyProperties(dto, db);
        db.setChannelId(dto.getChannelId());
        db.setIsDelete(false);
        db.setCreateBy(SessionContextHelper.getCurrentLoginName());
        db.setUpdateBy(SessionContextHelper.getCurrentLoginName());
        articleService.insert(db);
    }

    @Log(title = MODULE_NAME, businessType = BusinessType.EDIT)
    @RequirePermission(BizPermissionConstants.Article.EDIT)
    @PostMapping("edit")
    public void edit(@ApiObject(validate = true) ArticleDTO dto) {
        if (dto == null) {
            throw BusinessException.build("The request cannot be empty");
        }
        if (dto.getId() == null) {
            throw BusinessException.build("The ID cannot be empty");
        }
        Article db = articleService.selectByPId(dto.getId());
        if (db == null) {
            throw BusinessException.build("Data does not exist");
        }
        ChannelCheckUtils.checkHasPermission(db.getChannelId());

        db = ArticleDTO.dtoToDb(dto, db);
        db.setRemark(dto.getRemark());
        db.setUpdateBy(SessionContextHelper.getCurrentLoginName());
        articleService.update(db);
    }

    @Log(title = MODULE_NAME, businessType = BusinessType.DELETE)
    @RequirePermission(BizPermissionConstants.Article.DELETE)
    @PostMapping("/delete")
    public void delete(@ApiParam(required = true) Long[] ids) {
        for (Long id : ids) {
            Article db = articleService.selectByPId(id);
            if (db == null) throw BusinessException.build("Data does not exist");
            ChannelCheckUtils.checkHasPermission(db.getChannelId());
        }
        articleService.removeByPIds(ids);
    }

    @RequirePermission(BizPermissionConstants.Article.VIEW)
    @PostMapping("/detail")
    public ArticleDTO detail(@ApiParam(required = true) Long id) {
        Article db = articleService.selectByPId(id);
        if (db == null) throw BusinessException.build("Data does not exist");
        if (db.getChannelId() != null) ChannelCheckUtils.checkHasPermission(db.getChannelId());
        SysChannel channel = sysChannelService.selectByPId(db.getChannelId());
        return ArticleDTO.from(db, channel);
    }
}
