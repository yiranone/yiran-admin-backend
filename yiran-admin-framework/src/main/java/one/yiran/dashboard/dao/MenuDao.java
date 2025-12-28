package one.yiran.dashboard.dao;

import one.yiran.dashboard.entity.SysMenu;
import one.yiran.db.common.dao.BaseDao;
import org.springframework.stereotype.Repository;

@Repository
public interface MenuDao extends BaseDao<SysMenu, Long> {

    SysMenu findByMenuId(Long menuId);
}
