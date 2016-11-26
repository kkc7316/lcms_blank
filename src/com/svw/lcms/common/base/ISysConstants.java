package com.svw.lcms.common.base;

/**
 * <p>ClassName: ISysConstants</p>
 * <p>Description: 系统常量</p>
 * <p>Author: Administrator</p>
 * <p>Date: 2016年11月14日</p>
 */
public interface ISysConstants {
    
    /**
     * 服务器内部错误
     */
    public static final Integer STATE_INNER_SERVER_ERROR = 500;
    
    
    //------------------------------------------//
    /**
     * 当前用户-session的key
     */
    public static final String CURRENT_USER = "currentUser";
    
    /**
     * 当前用户权限-session的key
     */
    public static final String CURRENT_PERMISSION = "currentPermission";
    
    //-----------------------------------------//
    /**
     * 逗号
     */
    public static final String COMMA = ",";

    /**
     * likes 查询使用 %
     */
    public static final String LIKES = "%";
    
    //------------------------------------------//
    /** 已删除 **/
    public static final String IS_DEL = "1";

    /** 未删除 **/
    public static final String NOT_DEL = "0";
    
    
    //----------------------------------//
    /**
     * 批量提交数
     */
    public static final int BATCH_SUBMIT_NUM = 50;
    
}
