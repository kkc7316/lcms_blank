/**
 * BaseController.java
 * Created at 2015-10-19
 * Created by Administrator
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.base.controller;

import java.lang.reflect.Method;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.svw.lcms.common.user.domain.SysUser;
import com.svw.lcms.framework.domain.BaseModel;
import com.svw.lcms.framework.services.IUtilService;

/**
 * <p>
 * ClassName: BaseController
 * </p>
 * <p>
 * Description: 基类
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-10-19
 * </p>
 */
public class BaseController<T extends BaseModel> {

    /**
     * 服务器内部错误
     */
    public static final Integer STATE_INNER_SERVER_ERROR = 500;

    /**
     * LOCAL_HOST2
     */
    public static final String LOCAL_HOST2 = "localhost:8080";

    /**
     * LOCAL_HOST
     */
    public static final String LOCAL_HOST = "127.0.0.1:8080";

    /** 日志 **/
    protected static Logger logger = Logger.getLogger(BaseController.class);

    /**
     * utilService
     */
    @Autowired
    @Qualifier("utilService")
    protected IUtilService utilService;
    
    
    
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
                    obj = request.getParameter("filter." + temp);
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
     * <p>
     * Description: 基于@ExceptionHandler异常处理
     * </p>
     * 
     * @param request 请求
     * @param response 响应
     * @param ex ex
     * @return errorMessage
     */
    @ExceptionHandler
    public String exp(HttpServletRequest request, HttpServletResponse response, Exception ex) {

        logger.error(ex, ex);

        request.setAttribute("ex", ex);
        
        //如果是json格式的ajax请求
        if (request.getHeader("accept").indexOf("application/json") > -1
                || (request.getHeader("X-Requested-With") != null 
                    && request.getHeader("X-Requested-With")
                    .indexOf("XMLHttpRequest") > -1)) {

            return ajaxExceptionHandle(request, response, ex);

        } else {
            //普通请求
            //根据生成环境和开发环境，分别指向不同的异常处理页面
            //生产环境--不对外暴露异常信息：根据服务器host判断
            String host;
            host = getHost(request);
            
            if (host.equalsIgnoreCase(LOCAL_HOST) || host.equalsIgnoreCase(LOCAL_HOST2)) {
                //debug--开发环境可见
                return "exception/debugError"; 
            } else {
                //生产环境--请联系管理员
                return "exception/productError";
            }
        }
    }

    /**
     * <p>
     * Description: ajax异常处理
     * </p>
     * 
     * @param request req
     * @param response rep
     * @param ex ex
     * 
     * @return Str
     */
    public String ajaxExceptionHandle(HttpServletRequest request, HttpServletResponse response, Exception ex) {

        //如果是json格式的ajax请求
        //        response.setStatus(STATE_INNER_SERVER_ERROR);
        //        response.setContentType("application/json;charset=utf-8");
        //        try {
        //            PrintWriter writer;
        //            writer = response.getWriter();
        //            writer.write(ex.getMessage());
        //            writer.flush();
        //        } catch (IOException ioe) {
        //            logger.error(ioe);
        //        }
        //        return null;
        return "exception/error-ajax";
    }


    //===========================================//

    /**
     * 获得服务端ip：192.168.19.93
     * <p>
     * Description: getServerIp
     * </p>
     * 
     * @return ip
     */
    @SuppressWarnings("unused")
    private String getServerIp() {
        String ip = null;
        try {
            ip = InetAddress.getLocalHost().getHostAddress();
        } catch (UnknownHostException e) {
            logger.error("", e);
        }
        return ip;

    }

    /**
     * 
     * <p>
     * Description: 获得Host
     * </p>
     * 
     * @param request req
     * @return host
     */
    private String getHost(HttpServletRequest request) {

        String host;
        host = request.getHeader("Host");

        return host;
    }

    /**
     * 
     * <p>
     * Description: 获取登录用户信息
     * </p>
     * 
     * @param request 请求
     * @return 用户
     */
    protected SysUser getCurrentUser(HttpServletRequest request) {
        Object obj;
        obj = request.getSession().getAttribute("currentUser");
        return obj != null ? (SysUser) obj : null;
    }


}
