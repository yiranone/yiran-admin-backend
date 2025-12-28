package com.ext.service.impl;

import com.ext.dao.QuestionDao;
import com.ext.dto.QuestionDTO;
import com.ext.entity.Question;
import com.ext.entity.QQuestion;
import com.ext.service.QuestionService;
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
public class QuestionServiceImpl extends CrudBaseServiceImpl<Long, Question> implements QuestionService {

    @Autowired
    private QuestionDao questionDao;

    public PageModel<QuestionDTO> selectPageDetail(PageRequest pageRequest, QuestionDTO search) {
        QQuestion qQuestion = QQuestion.question;
        QSysChannel qSysChannel = QSysChannel.sysChannel;

        Predicate[] pres = PredicateBuilder.builder()
                .addEqualOrNullExpression(qQuestion.isDelete, Boolean.FALSE)
                .addEqualIfNotBlank(qQuestion.channelId, search.getChannelId())
                .addEntityByAnnotation(search, qQuestion)
                .toArray();

        JPAQuery<Tuple> q = queryFactory.select(qQuestion, qSysChannel)
                .from(qQuestion)
                .leftJoin(qSysChannel).on(qSysChannel.channelId.eq(qQuestion.channelId))
                .where(pres);

        PageRequestUtil.injectQuery(pageRequest, q, qQuestion, qSysChannel);

        List<Tuple> ts = q.fetch();
        List<QuestionDTO> dtoList = new ArrayList<>();
        for (Tuple r : ts) {
            Question db = r.get(qQuestion);
            SysChannel channel = r.get(qSysChannel);
            QuestionDTO dto = QuestionDTO.from(db, channel);
            dtoList.add(dto);
        }
        long count = q.fetchCount();
        return PageModel.instance(count, dtoList);
    }

}
