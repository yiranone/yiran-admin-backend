package com.ext.run;

import com.ext.constants.PlatformConfigEnum;
import com.ext.dao.PlatformParamConfigDao;
import com.ext.entity.PlatformParamConfig;
import com.ext.service.PlatformParamConfigService;
import lombok.extern.slf4j.Slf4j;
import one.yiran.dashboard.util.MemberCacheUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
public class PlatformParamConfigRunner implements ApplicationRunner {

    @Resource
    private ConfigurableEnvironment environment;
    @Resource
    private PlatformParamConfigDao platformParamConfigDao;
    @Resource
    private PlatformParamConfigService platformParamConfigService;

    @Override
    public void run(ApplicationArguments args) {
        PlatformConfigEnum[] vs = PlatformConfigEnum.values();
        for (PlatformConfigEnum e : vs) {
            String key = e.name();
            if (StringUtils.isBlank(key))
                continue;
            List<PlatformParamConfig> lists = platformParamConfigService.findByConfigKey(key);
            if (lists.isEmpty()) {
                PlatformParamConfig c = new PlatformParamConfig();
                c.setConfigKey(key);
                c.setConfigName(e.getDesc());
                c.setConfigValue("");
                c.setConfigGroup("sys");
                c.setCreateBy("sys");
                c.setCreateTime(new Date());
                c.setDescription("初始化,没有设置");
                platformParamConfigService.insert(c);
            }
        }
        //设置各家商户缓存数据
        platformParamConfigDao.findAll().stream().forEach(dd -> {
            String key = dd.getConfigKey();
            if (dd.getChannelId() != null) {
                key = dd.getChannelId() + "_" + dd.getConfigKey();
            }
            log.info("加载系统缓存 {}->{}", key, dd.getConfigValue());
            MemberCacheUtil.setSystemConfig(key, dd.getConfigValue());
        });
        log.info("******************************************************************************");
    }
}
