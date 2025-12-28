package com.ext.dao;

import com.ext.entity.Notice;
import one.yiran.db.common.dao.BaseDao;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface NoticeDao extends BaseDao<Notice, Long>, JpaSpecificationExecutor<Notice> {

}
