/**
 * DictDaoImpl.java
 * Created at 2015-10-22
 * Created by Administrator
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.dict.dao.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.svw.lcms.common.dict.dao.IDictDao;
import com.svw.lcms.common.dict.domain.SysDict;
import com.svw.lcms.framework.dao.impl.BaseDaoImpl;
import com.svw.lcms.framework.web.exception.BusinessException;
import com.svw.lcms.framework.web.page.PageInfo;
import com.svw.lcms.utils.DaoHelper;

/**
 * <p>
 * ClassName: DictDaoImpl
 * </p>
 * <p>
 * Description: 字典DaoImpl
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-10-22
 * </p>
 */
@Repository("dictDao")
public class DictDaoImpl extends BaseDaoImpl<SysDict, Serializable> implements IDictDao {

    /**
     * 
     * <p>
     * Description: dictIdx列表查询
     * </p>
     * 
     * @param pageInfo 分页
     * @param map 条件
     * @return 结果
     */
    @Override
    public List<SysDict> findAllDictList(PageInfo pageInfo, Map<String, Object> map) {
        String countHql;
        countHql = "select count(id) from SysDict where 1=1 " + DaoHelper.getQueryFilterEqualWithMap(null, map);
 
        String queryHql;
        queryHql = "from SysDict where 1=1 " 
                + DaoHelper.getQueryFilterEqualWithMap(null, map)
                + " order by updateDate desc, createDate desc, id desc,orderNum asc";
        
        return this.findEntityPageListByHql(countHql, queryHql, map, pageInfo);
    }


    /**
     * 
     * <p>Description: 根据字典key查询所有字典值，包括被删除的字典值</p>
     * @param key 字典key值
     * @return 字典list
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<SysDict> findAllDictListByParentKey(String parentKey) {
        //查询hql
        String queryString;
        queryString = "from SysDict where 1=1 and parentKey = :parentKey order by orderNum asc";
        Query query;
        query = this.getCurrentSession().createQuery(queryString);
        query.setParameter("parentKey", parentKey);
        return query.list();
    }

    
    /**
     * <p>
     * Description: 根据父字典key和子字典key，获得字典Dict
     * </p>
     * 
     * @param dictKey 子字典key值
     * @param parentKey 父字典key值
     * @return SysDict
     */
    @Override
    public SysDict findDictByDictKeyAndParentKey(String dictKey, String parentKey) {
        String hql;
        hql = " from SysDict t " 
                + " where 1=1  " 
                + " and t.delFlag = '0' "
                + " and t.dictKey =:dictKey "
                + " and t.parentKey =:parentKey " 
                + " ";
        Query query;
        query = this.getCurrentSession().createQuery(hql);
        
        query.setParameter("dictKey", dictKey);
        query.setParameter("parentKey", parentKey);

        return (SysDict) query.uniqueResult();
    }

    /**
     * 
     * <p>
     * Description: 保存数据库
     * </p>
     * 
     * @param model 对象
     * @return 结果集
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<SysDict> findDictByDictValueAndParentKey(String keyValue, String parentKey) {
        //查询hql
        String queryString;
        queryString = "from SysDict " 
                + " where 1=1 and delFlag = '0' "
                + " and parentKey = :parentKey " 
                + " and dictValue = :dictValue ";
        Query query;
        query = this.getCurrentSession().createQuery(queryString);
        query.setParameter("dictValue", keyValue);
        query.setParameter("parentKey", parentKey);
        return query.list();
    }
    
    /**
     * <p>
     * Description: 根据 子字典key，获得字典值
     * </p>
     * 
     * @param dictKey 子字典key值
     * @return string
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<String> findDictValueByDictKey(String dictKey) {

        String hql;
        hql = " select t.dictValue from SysDict t " 
                + " where 1=1  " 
                + " and t.delFlag = '0' "
                + " and t.dictKey =:dictKey ";
        
        Query query;
        query = this.getCurrentSession().createQuery(hql);
        query.setParameter("dictKey", dictKey);

        return query.list();
    }

    /**
     * <p>
     * Description: 根据父字典key和子字典key，获得字典值
     * </p>
     * 
     * @param dictKey 子字典key值
     * @param parentKey 父字典key值
     * @throws BusinessException ex
     * @return value
     */
    @Override
    public String findDictValueByDictKeyAndParentKey(String dictKey, String parentKey) throws BusinessException {

        String hql;
        hql = " select t.dictValue from SysDict t " 
                + " where 1=1  " 
                + " and t.delFlag = '0' "
                + " and t.dictKey =:dictKey " 
                + " and t.parentKey =:parentKey ";
        
        Query query;
        query = this.getCurrentSession().createQuery(hql);
        query.setParameter("dictKey", dictKey);
        query.setParameter("parentKey", parentKey);

        Object obj;
        obj = query.uniqueResult();
        if (null == obj) {
            throw new BusinessException("字典" + dictKey + "不存在");
        }

        return (String) obj;
    }

}
