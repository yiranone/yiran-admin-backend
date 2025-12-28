package com.ext.dao;

import com.ext.entity.Banner;
import one.yiran.db.common.dao.BaseDao;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface BannerDao extends BaseDao<Banner, Long>, JpaSpecificationExecutor<Banner> {

}
