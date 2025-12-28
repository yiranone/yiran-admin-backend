package com.ext.dao;

import com.ext.entity.PlatformParamConfig;
import one.yiran.db.common.dao.BaseDao;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface PlatformParamConfigDao extends BaseDao<PlatformParamConfig, Long>,
        JpaSpecificationExecutor<PlatformParamConfig> {

    PlatformParamConfig findFirstByChannelIdAndConfigKey(Long channelId, String key);

    PlatformParamConfig findFirstByConfigKey(String configKey);
}
