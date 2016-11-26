/**
 * BaseTemplateDao.java
 * Created at 2016-11-25
 * Created by mazan
 * Copyright (C) 2016 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.framework.dao.impl;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.svw.lcms.common.base.ISysConstants;
import com.svw.lcms.framework.dao.IBaseDao;
import com.svw.lcms.framework.utils.HqlPageSupport;
import com.svw.lcms.framework.utils.SqlPageSupport;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>ClassName: BaseTemplateDao</p>
 * <p>Description: 使用Spring 提供的HibernateTemplate</p>
 * <p>Author: mazan</p>
 * <p>Date: 2016-11-25</p>
 */
@Repository("baseTemplateDao")
public class BaseTemplateDaoImpl<T> extends HibernateDaoSupport implements IBaseDao<T, Long>, ISysConstants{

    /** 日志 **/
    protected Logger logger = Logger.getLogger(BaseTemplateDaoImpl.class);
     
    //-------------------------------------------//
    /**
     * <p>
     * Description: 根据对象id属性值加载
     * </p>
     * 
     * @param modelClass 对象
     * @param id id
     * @throws DaoException 异常
     * @return T 对象
     */
    @Override
    public T loadById(Class<T> modelClass, Long id) {
        return this.getHibernateTemplate().load(modelClass, id);
    }
    
    /**
     * 
     * <p>
     * Description: 通过主键查询model对象
     * </p>
     * 
     * @param modelClass model类对象
     * @param id 主键
     * @return model对象
     */
    @Override
    public T getById(Class<T> modelClass, Long id) {
        return this.getHibernateTemplate().get(modelClass, id);
    }

    /**
     * 
     * <p>
     * Description: 通过主键查询model对象
     * </p>
     * 
     * @param modelClass model类对象
     * @param propertyName 属性名
     * @param propertyValue 属性值
     * @return model对象
     */
    @SuppressWarnings("unchecked")
    @Override
    public T findByProperty(Class<T> modelClass, String propertyName, Object propertyValue) {
        String queryString;
        queryString = "from " + modelClass.getSimpleName() 
                + " where 1=1 and delFlag = '0' "
                + " and " + propertyName + " =:" + propertyName;
        
        //给查询条件赋值    
        Query query;
        query = this.getCurrentSession().createQuery(queryString);
        query.setParameter(propertyName, propertyValue);
        return (T) query.uniqueResult();
        
//        return this.getHibernateTemplate().findByNamedParam(queryString, paramName, value);
    }
    /**
     * 
     * <p>
     * Description: 通过主键查询model对象
     * </p>
     * 
     * @param modelClass model类对象
     * @param propertyName 属性名
     * @param propertyValue 属性值
     * @return List<model对象>
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<T> findListByProperty(Class<T> modelClass, String propertyName, Object propertyValue) {
        String queryString;
        queryString = "from " + modelClass.getSimpleName() 
                + " where 1=1 and delFlag = '0' "
                + " and " + propertyName + " =:" + propertyName;
        //给查询条件赋值    
        Query query;
        query = this.getCurrentSession().createQuery(queryString);
        query.setParameter(propertyName, propertyValue);
        return (List<T>) query.uniqueResult();
//        return this.getHibernateTemplate().find(queryString, propertyValue);
    }
    /**
     * 
     * <p>
     * Description: 查询所有model对象
     * </p>
     * @param modelClass model类对象
     * @return model对象列表
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<T> findAll(Class<T> modelClass) {
        return this.getHibernateTemplate()
                .find("from " + modelClass.getName() + " where delFlag = '0'");
    }

    /**
     * 
     * <p>
     * Description: 翻页
     * 查询所有model对象
     * 无查询条件
     * </p>
     * 
     * @param modelClass model类对象
     * @param pageInfo 分页参数
     * @return model对象列表
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<T> findAll(Class<T> modelClass, PageInfo pageInfo) {
        String countHql;
        countHql = "select count(1) from " + modelClass.getName()
            + "where delFlag='0'";
        
        String queryHql;
        queryHql = "from " + modelClass.getName()
            + "where delFlag='0'";
        
        return this.getHibernateTemplate()
                .executeFind(new HqlPageSupport(countHql, queryHql, pageInfo));
    }

    /**
     * 
     * <p>
     * Description: 保存一个model
     * </p>
     * 
     * @param t model对象
     * @return Serializable
     */
    @Override
    public Serializable save(T t) {
        return this.getHibernateTemplate().save(t);
    }
    /**
     * 
     * <p>
     * Description: 保存或更新一个model
     * </p>
     * 
     * @param t model对象
     * @throws DaoException 数据访问异常
     * 
     */
    @Override
    public void saveOrUpdate(T t) {
        this.getHibernateTemplate().saveOrUpdate(t);
    }

    /**
     * <p>Description: 批量保存/更新</p>
     * @param entityList
     */
    @Override
    public void saveOrUpdateEntityList(List<T> entityList) {
        this.getHibernateTemplate().saveOrUpdateAll(entityList);
    }

    /**
     * 
     * <p>
     * Description: 删除一个model
     * </p>
     * 
     * @param t model对象
     */
    @Override
    public void delete(T t) {
        this.getHibernateTemplate().delete(t);
    }

    /**
     * 
     * <p>
     * Description: 根据主键删除一个model
     * </p>
     * 
     * @param modelClass model类对象
     * @param id 主键
     */
    @Override
    public void deleteById(Class<T> modelClass, Long id) {
        this.getHibernateTemplate().delete(this.loadById(modelClass, id));
    }

    /**
     * 
     * <p>
     * Description: 更新一个model
     * </p>
     * 
     * @param t model对象
     */
    @Override
    public void update(T t) {
        this.getHibernateTemplate().update(t);
    }

    /**
     * 
     * <p>Description: 更新一个model</p>
     * @param t model对象
     */
    @Override
    public void merge(T t) {
        this.getHibernateTemplate().merge(t);
    }

    /**
     * 
     * <p>Description: hql翻页</p>
     * @param countHql  总数hql
     * @param queryHql  查询hql
     * @param params    查询条件
     * @param pageInfo  翻页
     * @return list
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<T> findEntityPageListByHql(String countHql, String queryHql, Map<String, Object> params,
            PageInfo pageInfo) {
        return this.getHibernateTemplate()
                .executeFind(new HqlPageSupport(countHql, queryHql, pageInfo, params, 
                        this.isAllLikeQuery(), this.getLikeQueryArray()));
    }

    /**
     * 
     * <p>Description: hql翻页--总数</p>
     * 导出限制
     * @param countHql  总数hql
     * @param params    查询条件
     * @return list
     */
    @Override
    public Long getEntityCountByHql(String countHql, Map<String, Object> params) {
        if (StringUtils.isEmpty(countHql)) {
            return 0l;
        }
        Query query = null;
        query = this.getCurrentSession().createQuery(countHql);
        this.setParamsWithMap(query, params);
        
        return (Long) query.uniqueResult();
    }

    /**
     * 
     * <p>Description: hql翻页--记录</p>
     * @param countHql  总数hql
     * @param queryHql  查询hql
     * @param params    查询条件
     * @param pageInfo  翻页
     * @return list
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<T> getEntityListByHql(String queryHql, Map<String, Object> params, PageInfo pageInfo) {
        return this.getHibernateTemplate()
                .executeFind(new HqlPageSupport(null, queryHql, pageInfo, params,
                        this.isAllLikeQuery(), this.getLikeQueryArray()));
    }

    //----------------------------sql-----------------------//
    /**
     * 
     * <p>Description: sql翻页</p>
     * @param countHql  总数sql
     * @param queryHql  查询sql
     * @param params    查询条件
     * @param pageInfo  翻页
     * @return list
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Map<String, Object>> findEntityPageListBySql(String countSql, String querySql,
            Map<String, Object> params, PageInfo pageInfo) {
        
        return this.getHibernateTemplate()
                .executeFind(new SqlPageSupport(countSql, querySql, pageInfo, params, 
                        this.isAllLikeQuery(), this.getLikeQueryArray()));
    }

    /**
     * 
     * <p>Description: sql翻页--总数</p>
     * 导出限制
     * @param countHql  总数hql
     * @param params    查询条件
     * @return list
     */
    @Override
    public Long getEntityCountBySql(String countSql, Map<String, Object> params) {
        if (StringUtils.isEmpty(countSql)) {
            return 0l;
        }
        Query query = null;
        query = this.getCurrentSession().createQuery(countSql);
        this.setParamsWithMap(query, params);
        
        return (Long) query.uniqueResult();
    }

    /**
     * 
     * <p>Description: sql翻页--记录</p>
     * @param countHql  总数hql
     * @param queryHql  查询hql
     * @param params    查询条件
     * @param pageInfo  翻页
     * @return list
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Map<String, Object>> getEntityListBySql(String querySql, Map<String, Object> params, PageInfo pageInfo) {
        return this.getHibernateTemplate()
                .executeFind(new SqlPageSupport(null, querySql, pageInfo, params,
                        this.isAllLikeQuery(), this.getLikeQueryArray()));
    }

    //-------------------------------//
    /**
     * 
     * <p>Description: 获得当前session</p>
     * @return currentSession
     */
    protected Session getCurrentSession() {
        return this.getHibernateTemplate().getSessionFactory().getCurrentSession();
    }
    
    
    /**
     * 
     * <p>Description: 设置query参数</p>
     * @param query
     * @param params
     */
    protected void setParamsWithMap(Query query, Map<String, Object> params){
        if(params != null && !params.isEmpty()){
            //哪些需要模糊查询的
            List<String> likeGroup;
            likeGroup = getLikeQueryList();
            
            for (Map.Entry<String, Object> entry : params.entrySet()) {
                
                String key;
                key = entry.getKey();
                Object obj = null;
                obj = entry.getValue();
                
                if (obj != null && StringUtils.isNotBlank(obj.toString())) {
                    if (obj instanceof Collection<?>) {
                        query.setParameterList(key, (Collection<?>) obj);
                    } else if (obj instanceof Object[]) {
                        query.setParameterList(key, (Object[]) obj);
                    } else {
                        //所有查询均为模糊查询
                        if(isAllLikeQuery()) {
                            query.setParameter(key, LIKES + obj + LIKES);
                        }
                        else {
                            
                            if (null != likeGroup && likeGroup.contains(key)) {
                                query.setParameter(key, LIKES + obj + LIKES);
                            } else {
                                query.setParameter(key, obj);
                            }
                        }
                        
                    }
                }
               
            }  
        }
    }
    
    /**
     * <p>Description: 获得模糊查询list</p>
     * @return list
     */
    private List<String> getLikeQueryList() {
        String[] likeGroupArray;
        likeGroupArray = this.getLikeQueryArray();
        
        if (null != likeGroupArray && likeGroupArray.length > 0) {
            return Arrays.asList(likeGroupArray);
        }
        return null;
    }
    /**
     * 
     * <p>Description: 是否全部模糊查询</p>
     * @return false 默认精准查询
     */
    protected boolean isAllLikeQuery() {
        return false;
    }
    
    /**
     * 
     * <p>Description: 模糊查询</p>
     * @return StringArray
     */
    protected String[] getLikeQueryArray() {
        return null;
    }
    
    
}
