/**
 * BaseController.java
 * Created at 2015-10-19
 * Created by Administrator
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.base.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.svw.lcms.common.base.ILcmsConstants;
import com.svw.lcms.common.user.domain.SysUser;
import com.svw.lcms.framework.domain.BaseModel;
import com.svw.lcms.framework.utils.StrUtil;
import com.svw.lcms.framework.web.exception.BusinessException;

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
public class BaseController<T extends BaseModel> extends com.svw.lcms.framework.controller.BaseController<T> implements ILcmsConstants {


    /**
     * LOCAL_HOST2
     */
    public static final String LOCAL_HOST2 = "localhost:8080";

    /**
     * LOCAL_HOST
     */
    public static final String LOCAL_HOST = "127.0.0.1:8080";

    /** 日志 **/
    protected static final Logger LOGGER = Logger.getLogger(BaseController.class);
    
    /**
     * 
     * <p>Description: 扩展父类的initParameters</p>
     * @param request   请求
     * @param parameterList 查询条件列表
     * @return  Obj
     * @throws Exception 异常
     */
    protected Object initParameters(HttpServletRequest request, Map<String, Object> parameterList)
            throws Exception {
        //通过反射获得domain类
        return super.initParameters(getModelClass(), request, parameterList);
    }
    

    /**
     * 
     * <p>Description: 根据controller名称，获得ModelClass对象</p>
     * @return class
     */
    @SuppressWarnings("unchecked")
    protected Class<T> getModelClass() {
        //当前controller类的路径
        String controller;
        controller = this.getClass().getName();
        
        String[] token;
        token = controller.split("\\.");
        
        if (token.length <4) {
            throw new BusinessException("illegal serviceImpl class package:" + controller);
        }
        String endString;
        endString = token[token.length-2] + "." + token[token.length-1];
        //获得domain类的路径
        String domainPath;
        domainPath = StrUtil.removeByEndStr(controller, endString) 
                + "domain" + "." 
                + this.getDomainName();
        
        Class<T> modelClass = null;
        try {
            modelClass = (Class<T>) Class.forName(domainPath);
        } catch (ClassNotFoundException e) {
            throw new BusinessException("Class[" + domainPath + "] not found!");
        }
        return modelClass;
    }
    /**
     * 获得domain name，如果Service的实现类的命名是Domain+ServiceImpl的方式，子类就不用重写该方法
     * 或者Service本身就是实现类，并未实现接口，子类也不用重写该方法
     * 
     * @return domain name
     */
    protected String getDomainName() {
        String suffix1 = "Controller";
        String className = this.getClass().getSimpleName();
        if (className.endsWith(suffix1)) {
            return className.substring(0, className.length() - suffix1.length());
        } else {
            LOGGER.error("Controller class name's format must be \"DomainName\" + \"Controller\", "
                        + "or you can overwrite the method getDomainName in your ServiceImpl!");
        }
        return null;
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

        LOGGER.error(ex, ex);

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
        return "exception/ajaxError";
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
            LOGGER.error("", e);
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
        obj = request.getSession().getAttribute(CURRENT_USER);
        return obj != null ? (SysUser) obj : null;
    }

}
