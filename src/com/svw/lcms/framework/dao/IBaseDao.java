/**
 * IbaseDao.java
 * Created at 2015-09-23
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.framework.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.svw.lcms.framework.web.page.PageInfo;

/**
 * 
 * <p>
 * ClassName: IBaseDao
 * </p>
 * <p>
 * Description: 简单的dao接口，提供通用数据访问方法
 * </p>
 * <p> 
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-9-23
 * </p>
 */
public interface IBaseDao<T, PK> {

    
    /**
     * <p>
     * Description: 通过主键查询model对象
     * </p>
     * 
     * @param modelClass model类对象
     * @param id 主键
     * @return model对象
     */
    public T loadById(Class<T> modelClass, PK id);

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
    public T getById(Class<T> modelClass, PK id);



    /**
     * 
     * <p>
     * Description: 通过非主键字段查询model对象
     * </p>
     * 
     * @param modelClass model类对象
     * @param propertyName 属性名
     * @param propertyValue 属性值
     * @return model对象
     */
    public T findByProperty(Class<T> modelClass, String propertyName, Object propertyValue);
    
    /**
     * 
     * <p>
     * Description: 通过非主键字段查询model对象
     * </p>
     * 
     * @param modelClass model类对象
     * @param propertyName 属性名
     * @param propertyValue 属性值
     * @return List<model对象>
     */
    public List<T> findListByProperty(Class<T> modelClass, String propertyName, Object propertyValue);
    
    
    /**
     * 
     * <p>
     * Description: 查询所有model对象
     * </p>
     * 
     * @param modelClass model类对象
     * @return model对象列表
     */
    public List<T> findAll(Class<T> modelClass);
    
    /**
     * 
     * <p>
     * Description: 查询所有model对象
     * </p>
     * 
     * @param modelClass model类对象
     * @param pageInfo 分页参数
     * @return model对象列表
     */
    public List<T> findAll(Class<T> modelClass, PageInfo pageInfo);
    
    
    //----------------------------------------//
    /**
     * 
     * <p>
     * Description: 保存一个model
     * </p>
     * 
     * @param t model对象
     * @return Serializable 
     */
    public Serializable save(T t);

    /**
     * 
     * <p>
     * Description: 保存或更新一个model
     * </p>
     * 
     * @param t model对象
     */
    public void saveOrUpdate(T t);

    
    /**
     * <p>Description: 批量保存/更新</p>
     * @param entityList
     */
    public void saveOrUpdateEntityList(List<T> entityList);
    //----------------------------//



    /**
     * 
     * <p>
     * Description: 删除一个model
     * </p>
     * 
     * @param t model对象
     */
    public void delete(T t);

    /**
     * 
     * <p>
     * Description: 根据主键删除一个model
     * </p>
     * 
     * @param modelClass model类对象
     * @param id 主键
     */
    public void deleteById(Class<T> modelClass, PK id);

    /**
     * 
     * <p>
     * Description: 更新一个model
     * </p>
     * 
     * @param t model对象
     */
    public void update(T t);

    /**
     * 
     * <p>Description: 更新一个model</p>
     * @param t model对象
     */
    public void merge(T t);
    
    //----------------------------hql翻页-----------------------//
    
    /**
     * 
     * <p>Description: hql翻页</p>
     * @param countHql  总数hql
     * @param queryHql  查询hql
     * @param params    查询条件
     * @param pageInfo  翻页
     * @return list
     */
    public List<T> findEntityPageListByHql(String countHql, String queryHql, Map<String, Object> params, PageInfo pageInfo);
 
    /**
     * 
     * <p>Description: hql翻页--总数</p>
     * 导出限制
     * @param countHql  总数hql
     * @param params    查询条件
     * @return list
     */
    public Long getEntityCountByHql(String countHql, Map<String, Object> params);
    /**
     * 
     * <p>Description: hql翻页--记录</p>
     * @param countHql  总数hql
     * @param queryHql  查询hql
     * @param params    查询条件
     * @param pageInfo  翻页
     * @return list
     */
    public List<T> getEntityListByHql(String queryHql, Map<String, Object> params, PageInfo pageInfo);






    //----------------------------sql翻页-----------------------//
    
    /**
     * 
     * <p>Description: sql翻页</p>
     * @param countHql  总数sql
     * @param queryHql  查询sql
     * @param params    查询条件
     * @param pageInfo  翻页
     * @return list
     */
    public List<Map<String, Object>> findEntityPageListBySql(String countSql, String querySql, Map<String, Object> params, PageInfo pageInfo);

    /**
     * 
     * <p>Description: sql翻页--总数</p>
     * 导出限制
     * @param countHql  总数hql
     * @param params    查询条件
     * @return list
     */
    public Long getEntityCountBySql(String countSql, Map<String, Object> params);
 
    /**
     * 
     * <p>Description: sql翻页--记录</p>
     * @param countHql  总数hql
     * @param queryHql  查询hql
     * @param params    查询条件
     * @param pageInfo  翻页
     * @return list
     */
    public List<Map<String, Object>> getEntityListBySql(String querySql, Map<String, Object> params, PageInfo pageInfo);


    //--------------------通用查询-------------------------//
    
    
    
}
