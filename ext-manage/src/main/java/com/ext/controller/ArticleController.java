package com.ext.controller;

import com.ext.entity.Article;
import com.ext.service.ArticleService;
import com.ext.dto.ArticleDTO;
import one.yiran.dashboard.common.annotation.AjaxWrapper;
import one.yiran.dashboard.common.annotation.ApiChannel;
import one.yiran.dashboard.common.annotation.ApiParam;
import one.yiran.dashboard.vo.ChannelVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping("/ext/article")
public class ArticleController extends BaseController {

    @Autowired
    private ArticleService articleService;

    @AjaxWrapper
    @RequestMapping(value = "/detail")
    public ArticleDTO detail(@ApiChannel ChannelVO channelVO,
                             @ApiParam(required = true) String type) {
        Article db = articleService.findByChannelIdAndType(channelVO.getChannelId(), type);
        return ArticleDTO.from(db);
    }

    @RequestMapping(value = "/page")
    public void page(@ApiChannel ChannelVO channelVO,
                     @ApiParam(required = true) String type,
                     HttpServletResponse response) throws IOException {
        Article db = articleService.findByChannelIdAndType(channelVO.getChannelId(), type);
        String content = db.getContent();
        response.addHeader("content-type", "text/html");
        response.setCharacterEncoding("utf-8");
        response.getWriter().write(content);
        response.flushBuffer();
    }

}
