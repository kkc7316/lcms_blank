package com.svw.lcms.framework.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.svw.lcms.framework.dao.IUtilDao;
import com.svw.lcms.framework.services.IUtilService;
@Service("utilService")
public class UtilServiceImpl implements IUtilService {

    /**
     * utilDao
     */
    @Autowired
    @Qualifier("utilDao")
    private IUtilDao utilDao;
    
    
    /**
     * 
     * <p>Description: 执行sql语句</p>
     */
    @Override
    public void executeSqlNoResult(String sql) {
        this.utilDao.executeSqlNoResult(sql);
    }
    
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
        return this.utilDao.findColumnByColumn(wantedColumn, tableName, byColumn, byValue);
    }

    /**
     * 根据字段byColumn查找表tableName的字段wantedColumn的值,list
     * 
     * @param wantedColumn 要查找的字段
     * @param tableName 要查找的表
     * @param byColumn 所根据的字段
     * @param byValue 所根据的字段的值
     * @return 字段wantedColumn的值
     */
    @Override
    public List<Object> findColumnListByColumn(String wantedColumn, String tableName, String byColumn, Object byValue) {
        return this.utilDao.findColumnListByColumn(wantedColumn, tableName, byColumn, byValue);
    }

}
