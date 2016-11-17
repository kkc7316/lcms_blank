/**
 * BaseDaoImpl.java
 * Created at 2015-09-23
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.framework.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.springframework.stereotype.Repository;

import com.svw.lcms.common.base.ISysConstants;
import com.svw.lcms.framework.dao.IBaseDao;
import com.svw.lcms.framework.dao.SessionSupport;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * 
 * <p>
 * ClassName: BaseDaoImpl
 * </p>
 * <p>
 * Description: 数据访问的简单实现
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-9-23
 * </p>
 */
@Repository("baseDao")
public class BaseDaoImpl<T, PK extends Serializable> extends SessionSupport implements IBaseDao<T, PK>, ISysConstants {

    
    
    /** 日志 **/
    protected Logger logger = Logger.getLogger(BaseDaoImpl.class);
     
    /** likes 查询使用 % **/
    protected static final String LIKES = "%";
    
    
    /************** getters and setters ***************/
   

    /**
     * <p>
     * Description: 是否使用缓存
     * </p>
     * 
     * @return true or false
     */
    protected boolean usingCache() {
        return false;
    }

    //**************** find ****************//
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
    @SuppressWarnings("unchecked")
    @Override
    public T loadById(Class<T> modelClass, PK id) {
        return (T) this.getCurrentSession().load(modelClass, id);
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
    @SuppressWarnings("unchecked")
    @Override
    public T getById(Class<T> modelClass, PK id) {
        return (T) this.getCurrentSession().get(modelClass, id);
    }




    //**************** save ****************//
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
        return this.getCurrentSession().save(t);
    }


    //**************** saveOrUpdate ****************//
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
        this.getCurrentSession().saveOrUpdate(t);
    }

    /**
     * <p>Description: 批量保存/更新</p>
     * @param entityList
     */
    public void saveOrUpdateEntityList(List<T> entityList) {
        int count = 0;
        Session session;
        session = this.sessionFactory.getCurrentSession();

        for (int i = 0; i < entityList.size(); i++) {

            T model;
            model = entityList.get(i);
            session.saveOrUpdate(model);

            count++;
            //清空Session缓存。
            if (i % BATCH_SUBMIT_NUM == 0) {
                session.flush();
                session.clear();
            }
        }
        //扫尾
        session.flush();

        logger.info("批量保存/更新的entityList数量：" + count);
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
        return query.list();
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
        String queryString;
        queryString = "from " + modelClass.getName() + " where delFlag = '0'";
        Query query;
        query = this.getCurrentSession().createQuery(queryString);
        return query.list();
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
        String hql;
        hql = "select count(1) from " + modelClass.getName()
            + "where delFlag='0'";
        Query query;
        query = this.getCurrentSession().createQuery(hql);
        Object obj;
        obj = query.uniqueResult();
        int count = 0;
        if (obj != null) {
            count = Integer.parseInt(obj.toString());
        }
        String queryString;
        queryString = "from " + modelClass.getName()
            + "where delFlag='0'";
        query = this.getCurrentSession().createQuery(queryString);
        query.setCacheable(usingCache());
        query.setMaxResults(pageInfo.limit);
        query.setFirstResult(pageInfo.start);
        int totalRec;
        totalRec = count;
        pageInfo.count = totalRec;
        return query.list();
    }

    //=================== delete ====================//
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
        this.getCurrentSession().delete(t);

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
    public void deleteById(Class<T> modelClass, PK id) {
        this.getCurrentSession().delete(this.loadById(modelClass, id));
    }

    //=============== update ==================//
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
        this.getCurrentSession().update(t);
    }
    
    /**
     * 
     * <p>Description: 更新一个model</p>
     * @param t model对象
     */
    @Override
    public void merge(T t) {
        this.getCurrentSession().merge(t);
    }
    
    
  //----------------------------hql-----------------------//
    /**
     * 
     * <p>Description: hql翻页</p>
     * @param countHql  总数hql
     * @param queryHql  查询hql
     * @param params    查询条件
     * @param pageInfo  翻页
     * @return list
     */
    public List<T> findEntityPageListByHql(String countHql, String queryHql, Map<String, Object> params, PageInfo pageInfo) {
        Long count;
        if (null != pageInfo) {
            count = this.getEntityCountByHql(countHql, params);
            pageInfo.count = count;
        }
        
        List<T> list;
        list = this.getEntityListByHql(queryHql, params, pageInfo);
        
        return list;
        
    }
 
    /**
     * 
     * <p>Description: hql翻页--总数</p>
     * 导出限制
     * @param countHql  总数hql
     * @param params    查询条件
     * @return list
     */
    public Long getEntityCountByHql(String countHql, Map<String, Object> params) {
        if (StringUtils.isEmpty(countHql)) {
            return 0l;
        }
        Query query = null;
        query = this.getHqlQuery(countHql, params);
        
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
    public List<T> getEntityListByHql(String queryHql, Map<String, Object> params, PageInfo pageInfo) {
        if (StringUtils.isEmpty(queryHql)) {
            return new ArrayList<T>();
        }
       
        Query query = null;
        query = this.getHqlQuery(queryHql, params);
        query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        if (null != pageInfo) {
            query.setFirstResult(pageInfo.start);
            query.setMaxResults(pageInfo.limit);
        }
        
        return query.list();
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
    public List<Map<String, Object>> findEntityPageListBySql(String countSql, String querySql, Map<String, Object> params, PageInfo pageInfo) {
        Long count;
        if (null != pageInfo) {
            count = this.getEntityCountBySql(countSql, params);
            pageInfo.count = count;
        }
        
        List<Map<String, Object>> list;
        list = this.getEntityListBySql(querySql, params, pageInfo);
        
        return list;
        
    }

    /**
     * 
     * <p>Description: sql翻页--总数</p>
     * 导出限制
     * @param countHql  总数hql
     * @param params    查询条件
     * @return list
     */
    public Long getEntityCountBySql(String countSql, Map<String, Object> params) {
        if (StringUtils.isEmpty(countSql)) {
            return 0l;
        }
        Query query = null;
        query = this.getSqlQuery(countSql, params);
        
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
    public List<Map<String, Object>> getEntityListBySql(String querySql, Map<String, Object> params, PageInfo pageInfo) {
        if (StringUtils.isEmpty(querySql)) {
            return new ArrayList<Map<String,Object>>();
        }
       
        Query query = null;
        query = this.getSqlQuery(querySql, params);
        query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        if (null != pageInfo) {
            query.setFirstResult(pageInfo.start);
            query.setMaxResults(pageInfo.limit);
        }
        
        return query.list();
    }

    //------------------------private-----------------------//
    /**
     * 
     * <p>Description: 根据条件拼装query</p>
     * @param hql hql语句
     * @param params 条件参数
     * @return query
     */
    private Query getHqlQuery(String hql, Map<String, Object> params) {
        if (StringUtils.isEmpty(hql)) {
            return null;
        }
        Query query = null;
        query = this.getCurrentSession().createQuery(hql);
        //为Hql参数设值
        this.setParamsWithMap(query, params);
        
        return query;
    }
    /**
     * 
     * <p>Description: 根据条件拼装query</p>
     * @param hql hql语句
     * @param params 条件参数
     * @return query
     */
    private Query getSqlQuery(String sql, Map<String, Object> params) {
        if (StringUtils.isEmpty(sql)) {
            return null;
        }
        Query query = null;
        query = this.getCurrentSession().createSQLQuery(sql);
        //为Sql参数设值
        this.setParamsWithMap(query, params);
        
        return query;
    }
    /**
     * 
     * <p>Description: 设置query参数</p>
     * @param query
     * @param params
     */
    private void setParamsWithMap(Query query, Map<String, Object> params){
        if(params != null && !params.isEmpty()){
            for (Map.Entry<String, Object> entry : params.entrySet()) {
                
                String key;
                key = entry.getKey();
                Object obj = null;
                obj = entry.getValue();
                if (obj != null) {
                    if (obj instanceof Collection<?>) {
                        query.setParameterList(key, (Collection<?>) obj);
                    } else if (obj instanceof Object[]) {
                        query.setParameterList(key, (Object[]) obj);
                    } else {
                        query.setParameter(key, obj);
                    }
                }
               
            }  
        }
    }

    
    
}
