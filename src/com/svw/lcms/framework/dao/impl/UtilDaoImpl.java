package com.svw.lcms.framework.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.svw.lcms.framework.dao.IUtilDao;
import com.svw.lcms.framework.dao.SessionSupport;

/**
 * <p>ClassName: UtilDaoImpl</p>
 * <p>Description: 通用DAO</p>
 * <p>Author: Administrator</p>
 * <p>Date: 2016年11月15日</p>
 */
@Repository("utilDao")
public class UtilDaoImpl extends SessionSupport implements IUtilDao {

    //-----------------------------------------------------------//
    /**
     * 
     * <p>Description: 执行sql语句</p>
     */
    public void executeSqlNoResult(String sql) {
        Query query;
        query = this.getCurrentSession().createSQLQuery(sql);
        query.executeUpdate();
    }
    
    
    //-------------------------column----------------------------//
    /**
     * 根据字段byColumn查找表tableName的字段wantedColumn的值
     * 
     * @param wantedColumn 要查找的字段
     * @param tableName 要查找的表
     * @param byColumn 所根据的字段
     * @param byValue 所根据的字段的值
     * @return 字段wantedColumn的值
     */
    @Override
    public Object findColumnByColumn(String wantedColumn, String tableName, String byColumn, Object byValue) {
        String sql;
        sql = " SELECT " + wantedColumn
            + " FROM " + tableName
            + " WHERE " + byColumn + "=:" + byColumn;
        Query query;
        query = this.getCurrentSession().createSQLQuery(sql);
        query.setParameter(byColumn, byValue);
        
        return query.uniqueResult();
    }

    /**
     * 根据字段集合byColumns查找表tableName的字段wantedColumn的值
     * 
     * @param wantedColumn 要查找的字段
     * @param tableName 要查找的表
     * @param byColumns 所根据的字段集合
     * @param byValues 所根据的字段的值集合
     * @return 字段wantedColumn的值
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<Object> findColumnListByColumn(String wantedColumn, String tableName, String byColumn, Object byValue) {
        String sql;
        sql = " SELECT " + wantedColumn
            + " FROM " + tableName
            + " WHERE " + byColumn + "=:" + byColumn;
        Query query;
        query = this.getCurrentSession().createSQLQuery(sql);
        query.setParameter(byColumn, byValue);
        
        return query.list();
    }
    
    
    
}
