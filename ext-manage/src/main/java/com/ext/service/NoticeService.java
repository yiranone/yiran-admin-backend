package com.ext.service;

import com.ext.dto.NoticeDTO;
import com.ext.entity.Notice;
import one.yiran.common.domain.PageModel;
import one.yiran.common.domain.PageRequest;
import one.yiran.db.common.service.CrudBaseService;

public interface NoticeService extends CrudBaseService<Long, Notice> {

    PageModel<NoticeDTO> selectPageDetail(PageRequest pageRequest, NoticeDTO search);
}
