package com.ext.controller;

import com.ext.entity.Banner;
import com.ext.service.BannerService;
import com.ext.dto.BannerDTO;
import one.yiran.common.domain.PageModel;
import one.yiran.common.domain.PageRequest;
import one.yiran.dashboard.common.annotation.AjaxWrapper;
import one.yiran.dashboard.common.annotation.ApiChannel;
import one.yiran.dashboard.common.annotation.ApiObject;
import one.yiran.dashboard.vo.ChannelVO;
import one.yiran.db.common.util.PageRequestUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@AjaxWrapper
@RequestMapping("/ext/banner")
public class BannerController {

    @Autowired
    private BannerService bannerService;

    @PostMapping(value = "/list")
    public PageModel<BannerDTO> list(@ApiChannel ChannelVO channelVO,
                                     @ApiObject(createIfNull = true) BannerDTO search,
                                     HttpServletRequest request) {
        PageRequest pageRequest = PageRequestUtil.fromRequest(request);
        pageRequest.setOrderDirection(Sort.Direction.ASC.name());
        pageRequest.setOrderByColumn("sort");
        search.setChannelId(channelVO.getChannelId());
        search.setStatus(1);
        return bannerService.selectPageDetail(pageRequest, search);
    }

    @GetMapping(value = "/detail/{bannerId}")
    @ResponseBody
    public Banner detail(@PathVariable("bannerId") String bannerId) {
        return bannerService.selectByPId(Long.valueOf(bannerId));
    }

}
