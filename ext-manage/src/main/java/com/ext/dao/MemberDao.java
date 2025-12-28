package com.ext.dao;

import com.ext.entity.Member;
import one.yiran.db.common.dao.BaseDao;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.persistence.LockModeType;

@Repository
public interface MemberDao extends BaseDao<Member, Long>, JpaSpecificationExecutor<Member> {

    @Lock(value = LockModeType.PESSIMISTIC_WRITE)
    @Query(value = "SELECT t FROM Member t WHERE t.id = ?1")
    Member lockById(Long id);
}
