package com.ext.service;

import com.ext.entity.PlatformParamConfig;
import com.ext.dto.PlatformParamConfigDTO;
import one.yiran.common.domain.PageModel;
import one.yiran.common.domain.PageRequest;
import one.yiran.db.common.service.CrudBaseService;

import java.util.List;

public interface PlatformParamConfigService extends CrudBaseService<Long, PlatformParamConfig> {

    PageModel<PlatformParamConfigDTO> selectPageDetail(PageRequest pageRequest, PlatformParamConfigDTO search);

    PlatformParamConfig saveOrUpdate(PlatformParamConfig platformParamConfig);

    List<PlatformParamConfig> findByConfigKey(String configKey);

}
