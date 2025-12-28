package com.ext.controller;

import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import one.yiran.dashboard.common.annotation.AjaxWrapper;
import one.yiran.dashboard.common.annotation.RequireMemberLogin;
import one.yiran.dashboard.common.constants.Global;
import one.yiran.dashboard.common.util.FileUploadUtil;
import one.yiran.dashboard.common.util.MimeTypeUtil;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@AjaxWrapper
@Controller
@RequestMapping("/ext/common")
public class CommonUploadController extends BaseController {

    @RequireMemberLogin
    @PostMapping("/upload")
    @ApiOperation(value = "文件上传", httpMethod = "POST")
    public Map uploadFile(MultipartFile file, HttpServletRequest request) throws Exception {
        String[] image = MimeTypeUtil.IMAGE_EXTENSION;
        String[] media = MimeTypeUtil.MEDIA_EXTENSION;
        String[] both = ArrayUtils.addAll(image, media);
        String fileRelatedPath = FileUploadUtil.upload(Global.getUploadPath(), file, both);
        String contextPath = request.getContextPath();
        String contextPathAvatar = fileRelatedPath;
        if (!StringUtils.startsWith(fileRelatedPath, "http")) {
            contextPathAvatar = contextPath + fileRelatedPath;
        }
        Map ajax = new HashMap();
        ajax.put("url", contextPathAvatar);
        return ajax;
    }

}
