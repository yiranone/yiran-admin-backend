package com.ext.controller.admin;

import com.ext.constants.BizPermissionConstants;
import com.ext.dto.QuestionDTO;
import com.ext.entity.Question;
import com.ext.service.QuestionService;
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
@RequestMapping("/biz/question")
public class AdminQuestionController {
    private static final String MODULE_NAME = "常见问题";

    @Autowired
    private QuestionService questionService;

    @Autowired
    private SysChannelService sysChannelService;

    @RequirePermission(BizPermissionConstants.Question.VIEW)
    @RequestMapping("/list")
    public PageModel<QuestionDTO> list(@ApiObject(createIfNull = true) QuestionDTO search, HttpServletRequest request) {
        PageRequest pageRequest = PageRequestUtil.fromRequest(request);
        Long channelId = ChannelCheckUtils.getChannelIdIfNotAdmin();
        if (channelId != null) {
            search.setChannelId(channelId);
        }
        return questionService.selectPageDetail(pageRequest, search);
    }

    @Log(title = MODULE_NAME, businessType = BusinessType.ADD)
    @RequirePermission(BizPermissionConstants.Question.ADD)
    @PostMapping("/add")
    public void add(@ApiObject(validate = true) QuestionDTO dto) {
        Long channelId = SessionContextHelper.getChannelIdWithCheck();
        if (dto.getChannelId() == null) dto.setChannelId(channelId);
        ChannelCheckUtils.checkHasPermission(dto.getChannelId());

        Question db = new Question();
        BeanUtils.copyProperties(dto, db);
        db.setChannelId(dto.getChannelId());
        db.setIsDelete(false);
        db.setCreateBy(SessionContextHelper.getCurrentLoginName());
        db.setUpdateBy(SessionContextHelper.getCurrentLoginName());
        questionService.insert(db);
    }

    @Log(title = MODULE_NAME, businessType = BusinessType.EDIT)
    @RequirePermission(BizPermissionConstants.Question.EDIT)
    @PostMapping("edit")
    public void edit(@ApiObject(validate = true) QuestionDTO dto) {
        if (dto == null) {
            throw BusinessException.build("The request cannot be empty");
        }
        if (dto.getId() == null) {
            throw BusinessException.build("The ID cannot be empty");
        }
        Question db = questionService.selectByPId(dto.getId());
        if (db == null) {
            throw BusinessException.build("Data does not exist");
        }
        ChannelCheckUtils.checkHasPermission(db.getChannelId());

        db = QuestionDTO.dtoToDb(dto, db);
        db.setRemark(dto.getRemark());
        db.setUpdateBy(SessionContextHelper.getCurrentLoginName());
        questionService.update(db);
    }

    @Log(title = MODULE_NAME, businessType = BusinessType.DELETE)
    @RequirePermission(BizPermissionConstants.Question.DELETE)
    @PostMapping("/delete")
    public void delete(@ApiParam(required = true) Long[] ids) {
        for (Long id : ids) {
            Question db = questionService.selectByPId(id);
            if (db == null) throw BusinessException.build("Data does not exist");
            ChannelCheckUtils.checkHasPermission(db.getChannelId());
        }
        questionService.removeByPIds(ids);
    }

    @RequirePermission(BizPermissionConstants.Question.VIEW)
    @PostMapping("/detail")
    public QuestionDTO detail(@ApiParam(required = true) Long id) {
        Question db = questionService.selectByPId(id);
        if (db == null) throw BusinessException.build("Data does not exist");
        if (db.getChannelId() != null) ChannelCheckUtils.checkHasPermission(db.getChannelId());
        SysChannel channel = sysChannelService.selectByPId(db.getChannelId());
        return QuestionDTO.from(db, channel);
    }
}
