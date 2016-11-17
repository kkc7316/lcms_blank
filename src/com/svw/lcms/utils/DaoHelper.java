package com.svw.lcms.utils;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;

/**
 * <p>ClassName: DaoHelper</p>
 * <p>Description: Dao辅助类</p>
 * <p>Author: Administrator</p>
 * <p>Date: 2016年11月16日</p>
 */
public class DaoHelper {
    /**
     * <p>Description: 默认构造函数</p>
     */
    private DaoHelper() {
    }
    
    
    /**
     * <p>Description: 拼装精确查询</p>
     * @param alias 别名
     * @param params 查询条件
     * @return sql
     */
    public static String getQueryFilterEqualWithMap(String alias, Map<String, Object> params) {
        
        if (StringUtils.isBlank(alias)) {
            alias = "";
        }
        StringBuilder buider;
        buider = new StringBuilder();
        for (String key : params.keySet()) {
            buider.append(" and " + alias + key + "  =:");
            buider.append(key);
        }
        
        return buider.toString();
        
    }
    
    /**
     * <p>Description: 拼装模糊查询</p>
     * @param alias 别名
     * @param params 查询条件
     * @return sql
     */
    public static String getQueryFilterLikeWithMap(String alias, Map<String, Object> params) {
        
        if (StringUtils.isBlank(alias)) {
            alias = "";
        }
        StringBuilder buider;
        buider = new StringBuilder();
        for (String key : params.keySet()) {
            buider.append(" and " + alias + key + " like :");
            buider.append(key);
        }
        
        return buider.toString();
        
    }
    
    
}
