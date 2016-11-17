/**
 * PageInfo.java
 * Created at 2015-09-23
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.framework.web.page;

import java.io.Serializable;

/**
 * <p>
 * ClassName: PageInfo
 * </p>
 * <p>
 * Description: 翻页信息
 * </p>
 * <p>
 * Author: zhangwei
 * </p>
 * <p>
 * Date: 2014-7-9
 * </p>
 */
public class PageInfo implements Serializable {

    /**
     * 起始页
     */
    public static final int START = 0;
    /**
     * 一页记录数
     */
    public static final int LIMIT = 99999999;
    /**
     * UID
     */
    private static final long serialVersionUID = 1L;

    /**
     * 开始
     */
    public int start;
    /**
     * 结束
     */
    public int end;
    /**
     * 一页的记录
     */
    public int limit;
    /**
     * 总数
     */
    public long count;
}
