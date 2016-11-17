package com.svw.lcms.framework.dao;

import java.util.List;

/**
 * <p>ClassName: IUtilDao</p>
 * <p>Description: 通用DAO</p>
 * <p>Author: Administrator</p>
 * <p>Date: 2016年11月15日</p>
 */
public interface IUtilDao {
    
    
    
    /**
     * 
     * <p>Description: 执行sql语句</p>
     */
    public void executeSqlNoResult(String sql);
    
    /**
     * 根据字段byColumn查找表tableName的字段wantedColumn的值
     * 
     * @param wantedColumn 要查找的字段
     * @param tableName 要查找的表
     * @param byColumn 所根据的字段
     * @param byValue 所根据的字段的值
     * @return 字段wantedColumn的值
     */
    public Object findColumnByColumn(String wantedColumn, String tableName, String byColumn, Object byValue);
    
    /**
     * 根据字段集合byColumns查找表tableName的字段wantedColumn的值
     * 
     * @param wantedColumn 要查找的字段
     * @param tableName 要查找的表
     * @param byColumns 所根据的字段集合
     * @param byValues 所根据的字段的值集合
     * @return 字段wantedColumn的值
     */
    public List<Object> findColumnListByColumn(String wantedColumn, String tableName, String byColumn, Object byValue);
    
}
