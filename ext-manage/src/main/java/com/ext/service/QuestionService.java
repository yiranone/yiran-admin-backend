package com.ext.service;

import com.ext.dto.QuestionDTO;
import com.ext.entity.Question;
import one.yiran.common.domain.PageModel;
import one.yiran.common.domain.PageRequest;
import one.yiran.db.common.service.CrudBaseService;

public interface QuestionService extends CrudBaseService<Long, Question> {

    PageModel<QuestionDTO> selectPageDetail(PageRequest pageRequest, QuestionDTO search);

}
