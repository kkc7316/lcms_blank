/**
 * ResourceDaoImpl.java
 * Created at 2016-01-05
 * Created by xieshuang
 * Copyright (C) 2016 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.resources.dao.impl;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.transform.Transformers;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.stereotype.Repository;

import com.svw.lcms.common.resources.dao.IResourceDao;
import com.svw.lcms.common.resources.domain.SysResource;
import com.svw.lcms.framework.dao.impl.BaseDaoImpl;
import com.svw.lcms.framework.web.exception.BusinessException;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>
 * ClassName: ResourceDaoImpl
 * </p>
 * <p>
 * Description: 资源dao实现类
 * </p>
 * <p>
 * Author: xieshuang
 * </p>
 * <p>
 * Date: 2016-1-5
 * </p>
 */
@Repository("resourceDao")
public class ResourceDaoImpl extends BaseDaoImpl<SysResource, Serializable> implements IResourceDao {



    /**
     * <p>
     * Description: 资源列表
     * </p>
     * 
     * @param page 翻页
     * @param map 参数
     * @return list
     * @throws DaoException 异常
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<SysResource> findAllResourceList(PageInfo page, Map<String, Object> map) {
        List<Object> list;
        list = Arrays.asList(map.keySet().toArray());
        StringBuilder buider;
        buider = new StringBuilder("");
        for (Object object : list) {
            buider.append(" and " + "re." + object.toString().toString() + " like :");
            buider.append(object.toString());
        }
        String hql;
        //列表总数
        hql = "select count(id) from SysResource re where 1=1 and re.delFlag = 0" + buider.toString();
        Query query;
        query = this.getCurrentSession().createQuery(hql);
        for (Object object : list) {
            query.setParameter(object.toString(), LIKES + map.get(object).toString().trim() + LIKES);
        }
        Object obj;
        obj = query.uniqueResult();
        //查询结果转为Integer
        int count = 0;
        if (obj != null) {
            count = Integer.parseInt(obj.toString());
        }
        //角色列表
        String queryString;
        queryString = "from SysResource re where 1=1 and re.delFlag = '0' " + buider.toString()
                + " order by re.updateDate desc, re.createDate desc, re.id desc";
        query = this.getCurrentSession().createQuery(queryString);
        for (Object object : list) {
            query.setParameter(object.toString(), LIKES + map.get(object).toString().trim() + LIKES);
        }
        //使用缓存
        query.setCacheable(usingCache());
        //end
        query.setMaxResults(page.limit);
        //start
        query.setFirstResult(page.start);
        //total
        int totalRec;
        totalRec = count;
        page.count = totalRec;
        return query.list();
    }

    /**
     * <p>
     * Description: 所有资源列表
     * </p>
     * 
     * @return list
     */
    @Override
    public List<Map<String, Object>> getAllResourceList() {

        String sql;
        sql = " select r.PK_ID as id, " 
            + " r.PARENT_ID as parentId, "
            + " r.resource_code as resourceCode, "
            + " r.resource_name as resourceName " 
            + " from TS_RESOURCE r "
            + " where r.del_FLAG = '0' "
            + " start with parent_id is null connect by prior pk_id = parent_id";
        
        return this.getEntityListBySql(sql, null, null);
    }



    /**
     * 
     * <p>
     * Description: 根据父资源id,查找所有级联子资源
     * </p>
     * 
     * @param parentId id
     * @return list
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Long> getResourceListByParentId(Long parentId) {
        String sql;
        sql = " select r.PK_ID as id " 
            + " from TS_RESOURCE r "
            + " where r.del_FLAG = '0' "
            + " start with parent_id=:parentId " 
            + " connect by prior pk_id = parent_id";
        Query query;
        query = this.getCurrentSession().createSQLQuery(sql)
                .addScalar("id", StandardBasicTypes.LONG);
        query.setParameter("parentId", parentId);

        return query.list();
    }

    
    /**
     * 
     * <p>
     * Description: 获取角色对应资源tree
     * </p>
     * 
     * @param roleId 角色主键id
     * @return 结果集
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<SysResource> getResourceListByRoleId(String roleId) {
        String sql;
        Long id;
        Query query;
        /*
         * 如果新增，查出所有资源 如果是修改角色，查出角色对应的资源，设置check属性
         */
        if (StringUtils.isNotBlank(roleId)) {
            id = Long.parseLong(roleId);
            sql = "select r.PK_ID as id,r.PARENT_ID as parentId,r.resource_code as resourceCode,"
                    + " r.resource_name as name,"
                    + " (case when (select count(pk_id) from TS_RESOURCE "
                    + "               where r.pk_id in (" 
                    + "                 select sre.PK_ID as resourceId"
                    + "                 from ts_resource sre left join tr_role_resources trr on sre.pk_id =trr.resource_id "
                    + "                 left join ts_role tr on tr.pk_id = trr.role_id "
                    + "                 where tr.pk_id =:pkid)" 
                    + "             ) > 0 " 
                    + "           then 'true'  "
                    + "       else 'false' "
                    + "     end"
                    + " ) as checked,"
                    + " (case when r.parent_id is null then 'true' else 'false' end) as open "
                    
                    + " from TS_RESOURCE r "
                    + " where r.del_FLAG = '0' "
                    + " start with parent_id is null connect by prior pk_id = parent_id order by pk_id";
            query = this.getCurrentSession().createSQLQuery(sql);
            query.setParameter("pkid", id);
        } else {
            sql = "select r.PK_ID as id,r.PARENT_ID as parentId,r.resource_code as resourceCode,"
                    + " r.resource_name as name,"
                    + " (case when r.pk_id is null then 'true' else 'false' end) as checked,"
                    + " (case when r.parent_id is null then 'true' else 'false' end) as open "
                    + " from TS_RESOURCE r "
                    + " where r.del_FLAG = '0' "
                    + " start with parent_id is null  connect by prior pk_id = parent_id order by pk_id";
            
            query = this.getCurrentSession().createSQLQuery(sql);
        }
        query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        return query.list();
    }

    /**
     * <p>
     * Description: 根据resourceId删除角色-资源关联表记录
     * </p>
     * 
     * @param resourceId resourceId
     */
    @Override
    public void deleteRoleResourceListByResourceId(Long resourceId) {
        try {
            String sql;
            sql = "delete from tr_role_resources rr " + " where rr.resource_id =:resourceId";

            Query query;
            query = this.getCurrentSession().createSQLQuery(sql);
            query.setParameter("resourceId", resourceId);
            query.executeUpdate();
        } catch (HibernateException e) {
            logger.error("", e);
            throw new BusinessException("deleteRoleResourceListByResourceId error.", e);
        }

    }

    /**
     * <p>
     * Description: 根据roleId删除角色-资源关联表记录
     * </p>
     * 
     * @param roleId roleId
     */
    @Override
    public void deleteRoleResourceListByRoleId(Long roleId) {
        String sql;
        sql = "delete from tr_role_resources rr " + " where rr.role_id =:roleId";
        Query query;
        query = this.getCurrentSession().createSQLQuery(sql);
        query.setParameter("roleId", roleId);
        query.executeUpdate();

    }
}
