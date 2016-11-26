/**
 * PageUtil.java
 * Created at 2015-09-23
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.framework.web.page;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

/**
 * 
 * <p>
 * ClassName: PageUtil
 * </p>
 * <p>
 * Description: 分页工具类
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-9-23
 * </p>
 */
public class PageUtil {
    /**
     * 
     * <p>
     * Description: 翻页查询
     * </p>
     * 
     * @param request 请求对象
     * @return 翻页对象
     * @throws Exception 翻页错误
     */
    public static PageInfo getPage(HttpServletRequest request) throws Exception {
        //起始记录 第几条开始
        String sv;
        sv = request.getParameter("start");
        //每页记录数 pagesize
        String lv;
        lv = request.getParameter("limit");
        int start = 0;
        int limit = 0;
        PageInfo pageInfo;
        pageInfo = new PageInfo();
        if (StringUtils.isEmpty(sv)) {
            //从0开始 初始化查询
            start = 0;
        } else {
            //翻页
            start = Integer.parseInt(sv);
        }
        if (StringUtils.isEmpty(lv)) {
            //最大记录
            limit = Integer.MAX_VALUE - start;
        } else {
            limit = Integer.parseInt(lv);
        }
        //start count
        pageInfo.start = start;
        //end count
        pageInfo.end = start + limit;
        
        //当前记录
        request.setAttribute("start", start);
        //结束记录
        request.setAttribute("end", pageInfo.end);
        pageInfo.limit = limit;// 每页记录数
        pageInfo.count = 0; //总记录数
        
        //总页数(afterPageText)--ExtJs自己计算
        
        return pageInfo;
    }
}
