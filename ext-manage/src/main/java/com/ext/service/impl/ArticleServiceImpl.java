package com.ext.service.impl;

import com.ext.dao.ArticleDao;
import com.ext.entity.Article;
import com.ext.entity.QArticle;
import com.ext.service.ArticleService;
import com.ext.dto.ArticleDTO;
import com.querydsl.core.Tuple;
import com.querydsl.core.types.Predicate;
import com.querydsl.jpa.impl.JPAQuery;
import lombok.extern.slf4j.Slf4j;
import one.yiran.common.domain.PageModel;
import one.yiran.common.domain.PageRequest;
import one.yiran.dashboard.entity.QSysChannel;
import one.yiran.dashboard.entity.SysChannel;
import one.yiran.db.common.service.CrudBaseServiceImpl;
import one.yiran.db.common.util.PageRequestUtil;
import one.yiran.db.common.util.PredicateBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class ArticleServiceImpl extends CrudBaseServiceImpl<Long, Article> implements ArticleService {

    @Autowired
    private ArticleDao articleDao;

    @Override
    public PageModel<ArticleDTO> selectPageDetail(PageRequest pageRequest, ArticleDTO search) {
        QArticle qArticle = QArticle.article;
        QSysChannel qSysChannel = QSysChannel.sysChannel;

        Predicate[] pres = PredicateBuilder.builder()
                .addEqualOrNullExpression(qArticle.isDelete, Boolean.FALSE)
                .addEqualIfNotBlank(qArticle.channelId, search.getChannelId())
                .addEntityByAnnotation(search, qArticle)
                .toArray();

        JPAQuery<Tuple> q = queryFactory.select(qArticle, qSysChannel)
                .from(qArticle)
                .leftJoin(qSysChannel).on(qSysChannel.channelId.eq(qArticle.channelId))
                .where(pres);

        PageRequestUtil.injectQuery(pageRequest, q, qArticle, qSysChannel);

        List<Tuple> ts = q.fetch();
        List<ArticleDTO> dtoList = new ArrayList<>();
        for (Tuple r : ts) {
            Article db = r.get(qArticle);
            SysChannel channel = r.get(qSysChannel);
            ArticleDTO dto = ArticleDTO.from(db, channel);
            dtoList.add(dto);
        }
        long count = q.fetchCount();
        return PageModel.instance(count, dtoList);
    }

    @Override
    public Article findByChannelIdAndType(Long channelId, String type) {
        return articleDao.findByChannelIdAndType(channelId, type);
    }

}
