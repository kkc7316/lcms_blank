package com.svw.lcms.framework.utils;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.svw.lcms.common.base.ISysConstants;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * 
 * <p>ClassName: HqlPageSupport</p>
 * <p>Description: Hql 翻页查询</p>
 * <p>Author: mazan</p>
 * <p>Date: 2016-11-25</p>
 */
@SuppressWarnings("rawtypes")
public class HqlPageSupport implements HibernateCallback, ISysConstants {
    
    /**
     * 列表查询数量Hql
     */
    private String countHql = null;
    /**
     * 列表查询Hql
     */
	private String queryHql = null;
	/**
	 * 翻页信息
	 */
	private PageInfo page = null;
	/**
	 * 查询条件
	 */
	private Map<String, Object> params = null;
	
	//----------------模糊查询相关----------------//
	/**
	 * 是否所有模糊查询，默认不模糊查询
	 */
	private boolean isAllLike = false;
	/**
	 * 模糊查询的字段
	 */
	private String[] likeQueryArray = null;
	/**
	 * 
	 * <p>Description: 不带查询条件的构造方法</p>
	 * @param countHql 数量Hql
	 * @param hql      列表Hql
	 * @param page     翻页信息
	 */
	public HqlPageSupport(String countHql, String queryHql, PageInfo page) {
		this.countHql = countHql;
		this.queryHql = queryHql;
		this.page = page;
	}
    /**
     * 
     * <p>Description: 带查询条件的构造方法</p>
     * @param countHql 数量Hql
     * @param hql      列表Hql
     * @param page     翻页信息
     * @param params   查询条件
     */
	public HqlPageSupport(String countHql, String queryHql, PageInfo page, Map<String, Object> params) {
	    this(countHql, queryHql, page);
		this.params = params;
	}

	/**
	 * 
     * <p>Description: 带查询条件的构造方法</p>
     * @param countHql 数量Hql
     * @param hql      列表Hql
     * @param page     翻页信息
     * @param params   查询条件
	 * @param isAllLike 全部模糊查询
	 */
    public HqlPageSupport(String countHql, String queryHql, PageInfo page, Map<String, Object> params,
            boolean isAllLike) {
        this(countHql, queryHql, page, params);
        this.isAllLike = isAllLike;
    }
    
    /**
     * 
     * <p>Description: 带查询条件的构造方法</p>
     * @param countHql 数量Hql
     * @param hql      列表Hql
     * @param page     翻页信息
     * @param params   查询条件
     * @param likeQueryArray    模糊查询的字段
     */
    public HqlPageSupport(String countHql, String queryHql, PageInfo page, Map<String, Object> params,
            String[] likeQueryArray) {
        this(countHql, queryHql, page, params);
        this.likeQueryArray = likeQueryArray;
    }
    
    /**
     * 
     * <p>Description: 带查询条件的构造方法</p>
     * @param countHql 数量Hql
     * @param queryHql      列表Hql
     * @param page     翻页信息
     * @param params   查询条件
     * @param isAllLike         模糊查询
     * @param likeQueryArray    模糊查询的字段
     */
    public HqlPageSupport(String countHql, String queryHql, PageInfo page, Map<String, Object> params,
            boolean isAllLike,String[] likeQueryArray) {
        this(countHql, queryHql, page, params);
        this.isAllLike = isAllLike;
        this.likeQueryArray = likeQueryArray;
    }
    //----------------------------------------------------//
    /**
	 * 
	 * <p>Title: doInHibernate</p>
	 * <p>Description: 回调函数</p>
	 * @param session  session
	 * @return List<T>
	 * @throws HibernateException  Hibernate异常
	 * @throws SQLException        SQL异常
	 * @see org.springframework.orm.hibernate3.HibernateCallback#doInHibernate(org.hibernate.Session)
	 */
	public List doInHibernate(Session session) throws HibernateException, SQLException {

	    Long count;
        if (null != this.page) {
            count = this.getCountByHql(session);
            this.page.count = count; //总记录数
        }
		
        List list;
        list = this.getEntityListByHql(session);
        
        return list;
	}

	
	
    /**
     * <p>Description: 查询出总数</p>
     * @param session   session
     * @return int
     */
    private Long getCountByHql(Session session) {
	    
        if (StringUtils.isEmpty(this.countHql)) {
            return 0l;
        }
        Query query = null;
        query = this.getHqlQuery(this.countHql, session);
        
        return (Long) query.uniqueResult();
	    
	}
	
    /**
     * 
     * <p>Description: hql翻页--记录</p>
     * @param countHql  总数hql
     * @param queryHql  查询hql
     * @param params    查询条件
     * @param pageInfo  翻页
     * @return list<T>
     */
    private List getEntityListByHql(Session session) {
        if (StringUtils.isEmpty(this.queryHql)) {
            return new ArrayList();
        }
       
        Query query = null;
        query = this.getHqlQuery(this.queryHql, session);
        if (null != this.page) {
            query.setFirstResult(this.page.start);
            query.setMaxResults(this.page.limit);
        }
        
        return query.list();
    }
    
    /**
     * 
     * <p>Description: 根据session获得query,并设置参数</p>
     * @param session session
     * @return query
     */
    private Query getHqlQuery(String hql, Session session) {
        if (StringUtils.isEmpty(hql)) {
            return null;
        }
        Query query = null;
        query = session.createQuery(hql);
        //为Hql参数设值
        this.setParamsWithMap(query);
        
        return query;
    }
    
    
	/**
	 * 
	 * <p>Description: 设置查询条件</p>
	 * @param query query
	 */
	private void setParamsWithMap(Query query){
        if(this.params != null && !this.params.isEmpty()){
            //哪些需要模糊查询的
            List<String> likeGroup;
            likeGroup = getLikeQueryList();
            
            for (Map.Entry<String, Object> entry : this.params.entrySet()) {
                
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
                        if(this.isAllLike) {
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
        
        if (null != likeQueryArray && likeQueryArray.length > 0) {
            return Arrays.asList(likeQueryArray);
        }
        return null;
    }
    
    
}
