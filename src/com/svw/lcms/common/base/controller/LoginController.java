/**
 * LoginController.java
 * Created at 2015-09-23
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.base.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.svw.lcms.common.base.controller.BaseController;
import com.svw.lcms.framework.i18n.CustomMessageSource;
import com.svw.lcms.framework.i18n.CustomMessageSourceAccessor;

/**
 * 
 * <p>
 * ClassName: LoginController
 * </p>
 * <p>
 * Description: 登录控制类
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-10-12
 * </p>
 */
@SuppressWarnings("rawtypes")
@Controller
public class LoginController extends BaseController {

    /** 日志 **/
    private static Logger logger = Logger.getLogger(LoginController.class);
    
    /**
     * 国际化消息处理
     */
    protected CustomMessageSourceAccessor messages = CustomMessageSource.getAccessor();


    /**
     * 
     * <p>
     * Description: 后台登录页面
     * </p>
     * 
     * @return 登录页面
     */
//    @RequestMapping("/login_@del!.do")
    @RequestMapping("/welcome.do")
    public ModelAndView defaultPage() {
        ModelAndView model;
        model = new ModelAndView();
        model.setViewName("login@del"); //后台登录页面
        return model;
    }


    /**
     * 
     * <p>
     * Description: 登录方法
     * </p>
     * 
     * @param request 请求
     * @param response 响应
     * @return 进入主页面
     */
    @RequestMapping("/sso.do")
    public ModelAndView myNotificationWorkListFirst(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mv;
        mv = new ModelAndView();
        //sso登录方式
        String userName;
        userName = request.getHeader("iv-user");
        if (!StringUtils.isEmpty(userName)) {
            logger.info("===================was log========SSO Login User Is:" + userName);
            //shiro登录方式 先生成tonken
            UsernamePasswordToken tonken;
            tonken = new UsernamePasswordToken(userName, "SSO_PWD");
            Subject currentUser;
            currentUser = SecurityUtils.getSubject();
            //执行登录方法 会调用Realm类的 doGetAuthenticationInfo方法
            try {
                currentUser.login(tonken);
                request.getSession().setAttribute("loginTime", new SimpleDateFormat("yyyy年MM月dd日 HH:mm").format(new Date()));
                mv.setViewName("frame/index"); //iframe风格
                
            } catch (AuthenticationException e) {
                //登录失败
                request.setAttribute("message", this.messages.getMessage("ERR_SYS_00003"));
                mv.setViewName("exception/login_error");
            }
            tonken.setRememberMe(true);
        } else {
            //禁止登录
            mv.setViewName("exception/prohibition");
        }
        return mv;
    }

    /**
     * 
     * <p>
     * Description: 登录方法
     * </p>
     * 
     * @param request 请求
     * @param response 响应
     * @return 进入主页面
     */
    @RequestMapping("/login.do")
    public ModelAndView notificationWorkListFirst(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mv;
        mv = new ModelAndView();
        
        //页面登录方式
        String userName;
        userName = request.getParameter("userUID");
        String passWord;
        passWord = request.getParameter("password");
        
        logger.info("===================was log========APP Login User Is:" + userName);
        if (!StringUtils.isEmpty(userName)) {
            //shiro登录方式 先生成tonken
            UsernamePasswordToken tonken;
            tonken = new UsernamePasswordToken(userName, passWord);
            Subject currentUser;
            currentUser = SecurityUtils.getSubject();
            //执行登录方法 会调用Realm类的 doGetAuthenticationInfo方法
            try {
                currentUser.login(tonken);
                request.getSession().setAttribute("loginTime", new SimpleDateFormat("yyyy年MM月dd日 HH:mm").format(new Date()));
                mv.setViewName("frame/index"); //iframe风格
                
            } catch (AuthenticationException e) {
                //登录失败
                request.setAttribute("message", this.messages.getMessage("ERR_SYS_00003"));
                //mv.setViewName("login");
                mv.setViewName("exception/login_error");
            }
            tonken.setRememberMe(true);
        } else {
            //测试打开后台登录页面
            mv.setViewName("login@del");
            //正式上线禁止,隐藏后台登录url，维护用
//            mv.setViewName("exception/prohibition");
        }
        
        return mv;
    }

    /**
     * 
     * <p>
     * Description: header页面
     * </p>
     * 
     * @return header页面
     */
    @RequestMapping("/head.do")
    public ModelAndView headPage() {
        ModelAndView model;
        model = new ModelAndView();
        model.setViewName("frame/header");
        return model;
    }

    /**
     * 
     * <p>
     * Description: navigation页面
     * </p>
     * 
     * @return navigation页面
     */
    @RequestMapping("/navigation.do")
    public ModelAndView navigationPage() {
        ModelAndView model;
        model = new ModelAndView();
        model.setViewName("frame/nav");
        return model;
    }

    /**
     * 
     * <p>
     * Description: navigation页面
     * </p>
     * 
     * @param request 用户请求
     * @return navigation页面
     */
    @RequestMapping("/content.do")
    public ModelAndView contentPage(HttpServletRequest request) {
        
        //mv
        ModelAndView model;
        model = new ModelAndView();
        model.setViewName("frame/inner_index");
        return model;
    }

    /**
     * 
     * <p>
     * Description: bottom页面
     * </p>
     * 
     * @return bottom页面
     */
    @RequestMapping("/bottom.do")
    public ModelAndView bottom() {
        ModelAndView model;
        model = new ModelAndView();
        model.setViewName("frame/bottom");
        return model;
    }

    /**
     * 
     * <p>
     * Description: navigation页面
     * </p>
     * @param  request 请求
     * @param  response 响应
     * @return navigation页面
     */
    @RequestMapping("/home.do")
    public ModelAndView homePage(HttpServletRequest request, HttpServletResponse response) {
        
        ModelAndView model;
        model = new ModelAndView();
        model.setViewName("frame/index_div");
        
        return model;
    }
    
    
    
}
