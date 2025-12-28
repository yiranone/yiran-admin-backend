package com.ext.service.impl;

import com.ext.dao.NoticeDao;
import com.ext.dto.NoticeDTO;
import com.ext.entity.Notice;
import com.ext.entity.QNotice;
import com.ext.service.NoticeService;
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
public class NoticeServiceImpl extends CrudBaseServiceImpl<Long, Notice> implements NoticeService {

    @Autowired
    private NoticeDao noticeDao;

    public PageModel<NoticeDTO> selectPageDetail(PageRequest pageRequest, NoticeDTO search) {
        QNotice qNotice = QNotice.notice;
        QSysChannel qSysChannel = QSysChannel.sysChannel;

        Predicate[] pres = PredicateBuilder.builder()
                .addEqualOrNullExpression(qNotice.isDelete, Boolean.FALSE)
                .addEqualIfNotBlank(qNotice.channelId, search.getChannelId())
                .addEntityByAnnotation(search, qNotice)
                .toArray();

        JPAQuery<Tuple> q = queryFactory.select(qNotice, qSysChannel)
                .from(qNotice)
                .leftJoin(qSysChannel).on(qSysChannel.channelId.eq(qNotice.channelId))
                .where(pres);

        PageRequestUtil.injectQuery(pageRequest, q, qNotice, qSysChannel);

        List<Tuple> ts = q.fetch();
        List<NoticeDTO> dtoList = new ArrayList<>();
        for (Tuple r : ts) {
            Notice db = r.get(qNotice);
            SysChannel channel = r.get(qSysChannel);
            NoticeDTO dto = NoticeDTO.from(db, channel);
            dtoList.add(dto);
        }
        long count = q.fetchCount();
        return PageModel.instance(count, dtoList);
    }

}
