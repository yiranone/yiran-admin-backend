package com.ext.service.impl;

import com.ext.dao.BannerDao;
import com.ext.entity.Banner;
import com.ext.entity.QBanner;
import com.ext.service.BannerService;
import com.ext.dto.BannerDTO;
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
public class BannerServiceImpl extends CrudBaseServiceImpl<Long, Banner> implements BannerService {

    @Autowired
    private BannerDao bannerDao;

    public PageModel<BannerDTO> selectPageDetail(PageRequest pageRequest, BannerDTO search) {
        QBanner qBanner = QBanner.banner;
        QSysChannel qSysChannel = QSysChannel.sysChannel;

        Predicate[] pres = PredicateBuilder.builder()
                .addEqualOrNullExpression(qBanner.isDelete, Boolean.FALSE)
                .addEqualIfNotBlank(qBanner.channelId, search.getChannelId())
                .addEntityByAnnotation(search, qBanner)
                .toArray();

        JPAQuery<Tuple> q = queryFactory.select(qBanner, qSysChannel)
                .from(qBanner)
                .leftJoin(qSysChannel).on(qSysChannel.channelId.eq(qBanner.channelId))
                .where(pres);

        PageRequestUtil.injectQuery(pageRequest, q, qBanner, qSysChannel);

        List<Tuple> ts = q.fetch();
        List<BannerDTO> dtoList = new ArrayList<>();
        for (Tuple r : ts) {
            Banner db = r.get(qBanner);
            SysChannel channel = r.get(qSysChannel);
            BannerDTO dto = BannerDTO.from(db, channel);
            dtoList.add(dto);
        }
        long count = q.fetchCount();
        return PageModel.instance(count, dtoList);
    }

    @Override
    public List<Banner> findAllByChannelId(Long channelId) {
        QBanner qBanner = QBanner.banner;
        return this.selectList(qBanner.channelId.eq(channelId)
                .and(qBanner.isDelete.eq(Boolean.FALSE)));
    }

}
