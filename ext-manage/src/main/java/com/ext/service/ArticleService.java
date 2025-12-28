package com.ext.service;

import com.ext.entity.Article;
import com.ext.dto.ArticleDTO;
import one.yiran.common.domain.PageModel;
import one.yiran.common.domain.PageRequest;
import one.yiran.db.common.service.CrudBaseService;

public interface ArticleService extends CrudBaseService<Long, Article> {

    PageModel<ArticleDTO> selectPageDetail(PageRequest pageRequest, ArticleDTO search);

    Article findByChannelIdAndType(Long channelId, String type);
}
