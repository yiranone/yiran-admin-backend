package com.ext.service;

import com.ext.entity.Banner;
import com.ext.dto.BannerDTO;
import one.yiran.common.domain.PageModel;
import one.yiran.common.domain.PageRequest;
import one.yiran.db.common.service.CrudBaseService;

import java.util.List;

public interface BannerService extends CrudBaseService<Long, Banner> {

    PageModel<BannerDTO> selectPageDetail(PageRequest pageRequest, BannerDTO search);

    List<Banner> findAllByChannelId(Long channelId);
}
