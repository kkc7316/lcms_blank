/**
 * BaseController.java
 * Created at 2016-11-25
 * Created by mazan
 * Copyright (C) 2016 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.framework.controller;

import java.lang.reflect.Method;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.svw.lcms.common.base.ISysConstants;
import com.svw.lcms.common.base.services.IEntityService;
import com.svw.lcms.framework.domain.BaseModel;
import com.svw.lcms.framework.services.IUtilService;

/**
 * <p>ClassName: BaseController</p>
 * <p>Description: 无关业务的controller</p>
 * <p>Author: mazan</p>
 * <p>Date: 2016-11-25</p>
 */
public class BaseController<T extends BaseModel> implements ISysConstants {

    /**
     * 日志    
     */
    public static final Logger LOGGER = Logger.getLogger(BaseController.class);
    /**
     * utilService
     */
    @Autowired
    @Qualifier("utilService")
    protected IUtilService utilService;
   
    /**
     * entityService
     */
    @Autowired
    @Qualifier("entityService")
    private IEntityService<T> entityService;
    /**
     * 
     * <p>
     * Description: 页面参数赋值
     * </p>
     * 
     * @param domain domain
     * @param request 请求对象
     * @param parameterList 参数对象
     * @return 赋值对象
     * @throws Exception Exception
     */
    protected Object initParameters(Class<T> domain, HttpServletRequest request, Map<String, Object> parameterList)
        throws Exception {
        Object objDomain;
        objDomain = domain.newInstance();
        Method[] mts;
        mts = domain.getMethods();
        String temp;
        Object obj;
        for (Method method : mts) {
            temp = method.getName();
            if (temp.startsWith("set")) {
                temp = temp.substring(temp.indexOf("set") + "set".length(), temp.length());
                if (StringUtils.isNotBlank(temp)) {
                    //                    Character.toUpperCase(fieldString.charAt(0)) + fieldString.substring(1);
                    temp = Character.toLowerCase(temp.charAt(0)) + temp.substring(1, temp.length());
                    obj = request.getParameter(this.getQueryFilterAlias() + temp);
                    if (obj != null && StringUtils.isNotBlank(obj.toString())) {
                        parameterList.put(temp, obj.toString().trim());
                        method.invoke(objDomain, new Object[] { obj });
                    }
                }
            }
        }
        return objDomain;
    }
    
    /**
     * 
     * <p>Description: 页面查询别名</p>
     * 如果为"",则直接使用domain名称作为查询条件
     * @return alias
     */
    protected String getQueryFilterAlias() {
        //查询别名默认为filter.
        return "filter.";
    }
    
    
    
}
