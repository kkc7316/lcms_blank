/**
 * RoleDaoImpl.java
 * Created at 2015-11-09
 * Created by mazan
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.role.dao.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.svw.lcms.common.role.dao.IRoleDao;
import com.svw.lcms.common.role.domain.SysRole;
import com.svw.lcms.framework.dao.impl.BaseDaoImpl;
import com.svw.lcms.framework.utils.DaoHelper;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>
 * ClassName: RoleDaoImpl
 * </p>
 * <p>
 * Description: 角色管理Dao
 * </p>
 * <p>
 * Author: mazan
 * </p>
 * <p>
 * Date: 2015-11-9
 * </p>
 */
@Repository("roleDao")
public class RoleDaoImpl extends BaseDaoImpl<SysRole> implements IRoleDao {


    /**
     * 
     * <p>
     * Description: 根据属性进行查重操作
     * </p>
     * 
     * @param model 角色对象
     * @return 结果集
     */
    @SuppressWarnings({ "unchecked" })
    @Override
    public List<SysRole> validateRoleNameUnique(SysRole model) {
        StringBuilder buider;
        buider = new StringBuilder("");
        if (model.getId() != null && !"".equals(String.valueOf(model.getId()))) {
            buider.append(" and id not in ( :ids )");
        }
        String queryString;
        queryString = "from SysRole where 1=1 and delFlag = '0' and roleName =:rolename" + buider.toString();
        //给查询条件赋值
        Query query;
        query = this.getCurrentSession().createQuery(queryString);
        query.setParameter("rolename", model.getRoleName().trim());
        if (model.getId() != null && !"".equals(String.valueOf(model.getId()))) {
            query.setParameter("ids", model.getId());
        }
        return query.list();
    }

    /**
     * 
     * <p>
     * Description: 根据属性进行查重操作
     * </p>
     * 
     * @param model 角色对象
     * @return 结果集
     */
    @SuppressWarnings({ "unchecked" })
    @Override
    public List<SysRole> validateRoleCodeUnique(SysRole model) {
        StringBuilder buider;
        buider = new StringBuilder("");
        if (model.getId() != null && !"".equals(String.valueOf(model.getId()))) {
            buider.append(" and id not in ( :ids )");
        }
        String queryString;
        queryString = "from SysRole where 1=1 and delFlag = '0' and roleCode =:rolecode" + buider.toString();
        //给查询条件赋值    
        Query query;
        query = this.getCurrentSession().createQuery(queryString);
        query.setParameter("rolecode", model.getRoleCode().trim());
        if (model.getId() != null && !"".equals(String.valueOf(model.getId()))) {
            query.setParameter("ids", model.getId());
        }
        return query.list();
    }

    /**
     * <p>
     * Description: 角色列表查询
     * </p>
     * 
     * @param pageInfo 分页
     * @param params 条件
     * @return 返回结果集
     * @throws DaoException 异常
     */
    @Override
    public List<SysRole> findAllRoleList(PageInfo pageInfo, Map<String, Object> params) {
        //列表总数
        String countHql;
        countHql = " select count(id) from SysRole ro where 1=1 and ro.delFlag = 0" 
                + DaoHelper.getQueryFilterLikeWithMap("ro", params)
                + " order by updateDate desc, createDate desc, id desc";
        //角色列表
        String queryHql;
        queryHql = " from SysRole ro left join fetch ro.sysResources where 1=1 and ro.delFlag = '0' "
                 + DaoHelper.getQueryFilterLikeWithMap("ro", params);
        
        return this.findEntityPageListByHql(countHql, queryHql, params, pageInfo);
    }



   


}
