package com.ext.service.impl;

import com.ext.dao.PlatformParamConfigDao;
import com.ext.entity.PlatformParamConfig;
import com.ext.entity.QPlatformParamConfig;
import com.ext.service.PlatformParamConfigService;
import com.ext.dto.PlatformParamConfigDTO;
import com.querydsl.core.Tuple;
import com.querydsl.core.types.Predicate;
import com.querydsl.jpa.impl.JPAQuery;
import lombok.extern.slf4j.Slf4j;
import one.yiran.common.domain.PageModel;
import one.yiran.common.domain.PageRequest;
import one.yiran.common.exception.BusinessException;
import one.yiran.dashboard.entity.QSysChannel;
import one.yiran.dashboard.entity.SysChannel;
import one.yiran.dashboard.security.SessionContextHelper;
import one.yiran.dashboard.util.MemberCacheUtil;
import one.yiran.db.common.service.CrudBaseServiceImpl;
import one.yiran.db.common.util.PageRequestUtil;
import one.yiran.db.common.util.PredicateBuilder;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
public class PlatformParamConfigServiceImpl extends CrudBaseServiceImpl<Long,PlatformParamConfig> implements PlatformParamConfigService {

    @Autowired
    private PlatformParamConfigDao platformParamConfigDao;

    @Override
    public PageModel<PlatformParamConfigDTO> selectPageDetail(PageRequest pageRequest, PlatformParamConfigDTO search) {
        QPlatformParamConfig qPlatformParamConfig = QPlatformParamConfig.platformParamConfig;
        QSysChannel qSysChannel = QSysChannel.sysChannel;

        Predicate[] pres = PredicateBuilder.builder()
                .addEqualIfNotBlank(qPlatformParamConfig.configGroup, search.getConfigGroup())
                .addEqualOrNullExpression(qPlatformParamConfig.isDelete, false)
                .addEntityByAnnotation(search, qPlatformParamConfig)
                .toArray();

        JPAQuery<Tuple> q = queryFactory.select(qPlatformParamConfig, qSysChannel)
                .from(qPlatformParamConfig)
                .leftJoin(qSysChannel)
                .on(qSysChannel.channelId.eq(qPlatformParamConfig.channelId))
                .where(pres);

        PageRequestUtil.injectQuery(pageRequest, q, qPlatformParamConfig, qSysChannel);

        List<Tuple> ts = q.fetch();
        List<PlatformParamConfigDTO> configDTOs = new ArrayList<>();
        for (Tuple r : ts) {
            PlatformParamConfig db = r.get(qPlatformParamConfig);
            SysChannel sysChannel = r.get(qSysChannel);
            configDTOs.add(PlatformParamConfigDTO.from(db, sysChannel));
        }
        long count = q.fetchCount();
        return PageModel.instance(count, configDTOs);
    }

    @Override
    @Transactional
    public PlatformParamConfig saveOrUpdate(PlatformParamConfig platformParamConfig) {
        String key = "";
        if (platformParamConfig.getChannelId() != null) {
            key = platformParamConfig.getChannelId() + "_" + platformParamConfig.getConfigKey();
        } else {
            key = platformParamConfig.getConfigKey();
        }
        PlatformParamConfig dbConfig = null;
        if (platformParamConfig.getChannelId() == null) {
            dbConfig = platformParamConfigDao.findFirstByConfigKey(platformParamConfig.getConfigKey());
        } else {
            dbConfig = platformParamConfigDao.findFirstByChannelIdAndConfigKey(
                    platformParamConfig.getChannelId(), platformParamConfig.getConfigKey());
        }
        if (platformParamConfig.getId() == null && dbConfig != null) {
            throw BusinessException.build("The new data is abnormal, and the database already exists, key=" + platformParamConfig.getConfigKey());
        }
        if (dbConfig == null) {
            if (platformParamConfig.getId() == null)
                dbConfig = new PlatformParamConfig();
            else
                throw BusinessException.build("Data modification is abnormal. The database does not exist, key=" + platformParamConfig.getConfigKey());
        }
        if (StringUtils.equals(dbConfig.getValueType(), "Long")) {
            try {
                Long.valueOf(platformParamConfig.getConfigValue());
            } catch (Exception e) {
                throw BusinessException.build("The data is abnormal and the type must be Long:" + platformParamConfig.getConfigKey());
            }
        }
        dbConfig.setChannelId(platformParamConfig.getChannelId());
        dbConfig.setConfigGroup(platformParamConfig.getConfigGroup());
        dbConfig.setConfigKey(platformParamConfig.getConfigKey());
        dbConfig.setConfigName(platformParamConfig.getConfigName());
        dbConfig.setConfigValue(platformParamConfig.getConfigValue());
        dbConfig.setDescription(platformParamConfig.getDescription());

        if(platformParamConfig.getId() == null) {
            dbConfig.setCreateTime(new Date());
            dbConfig.setCreateBy(SessionContextHelper.getCurrentLoginName());
        }
        dbConfig.setUpdateBy(SessionContextHelper.getCurrentLoginName());
        dbConfig.setUpdateTime(new Date());

        platformParamConfigDao.save(dbConfig);
        log.info("清理系统缓存key {}", key);
        MemberCacheUtil.removeSystemConfig(key);
        MemberCacheUtil.setSystemConfig(key, dbConfig.getConfigValue());
        return dbConfig;
    }

    @Override
    public List<PlatformParamConfig> findByConfigKey(String configKey) {
        Assert.notNull(configKey,"configKey不能为空");
        return selectList(QPlatformParamConfig.platformParamConfig.configKey.eq(configKey));
    }

}
