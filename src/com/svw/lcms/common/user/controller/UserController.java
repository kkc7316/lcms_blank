/**
 * UserController.java
 * Created at 2015-09-23
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.svw.lcms.common.base.controller.BaseController;
import com.svw.lcms.common.user.domain.SysUser;
import com.svw.lcms.common.user.services.IUserService;
import com.svw.lcms.framework.web.page.PageInfo;
import com.svw.lcms.framework.web.page.PageUtil;

/**
 * 
 * <p>
 * ClassName: UserController
 * </p>
 * <p>
 * Description: 用户管理
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-10-12
 * </p>
 */
@Controller
@RequestMapping(value = "/user")
public class UserController extends BaseController<SysUser> {
    /**
     * userService
     */
    @Autowired
    @Qualifier("userService")
    private IUserService userService;

    /**
     * 
     * <p>
     * Description: 用户列表页面
     * </p>
     * 
     * @param request 请求
     * @return 用户列表页面
     */
    @RequestMapping("/userListPage.do")
    public ModelAndView test(HttpServletRequest request) {
        ModelAndView model;
        model = new ModelAndView();
        model.setViewName("system/user/userList");
        return model;
    }

    /**
     * 
     * <p>
     * Description: 用户管理列表查询
     * </p>
     * 
     * @param request 请求对象
     * @param response 响应对象
     * @param model 对象--前台查询：filter.xxx
     * @return 用户数据
     * @throws Exception 异常
     */
    @RequestMapping("/userList.do")
    @ResponseBody
    public Object getUserList(HttpServletRequest request, HttpServletResponse response, SysUser model) throws Exception {
        PageInfo page;
        page = PageUtil.getPage(request);
        List<SysUser> list;
        String userRoleName;
        userRoleName = request.getParameter("uerRoles");
        
        Map<String, Object> parameterList;
        parameterList = new HashMap<String, Object>();
        parameterList.put("userRoleName", userRoleName);
        
        this.initParameters(SysUser.class, request, parameterList);
        
        list = this.userService.findAllUserList(page, parameterList);
        
        HashMap<String, Object> map;
        map = new HashMap<String, Object>();
        map.put("totalCount", page.count);
        map.put("root", list);
        return map;
    }
    /**
     * 
     * <p>
     * Description: 用户管理设置角色初始化
     * </p>
     * 
     * @param id 主键id
     * @return 用户管理设置角色页面
     */
    @RequestMapping("/addUserRoleInit.do")
    public ModelAndView addRoleInit(@RequestParam(value = "id") Long id) {
        ModelAndView viewModel;
        viewModel = new ModelAndView();
        //设置角色的用户
        SysUser sysUser;
        sysUser = this.userService.getById(id);
        
        viewModel.addObject("sysUser", sysUser);
        //获取用户已经分配的角色
        List<Object> allocateRoleList;
        allocateRoleList = this.userService.findAllAllocateUserList(sysUser.getId(), null);
        viewModel.addObject("allocateRoleList", allocateRoleList);
        //获取用户未分配的角色
        List<Object> unAllocateRoleList;
        unAllocateRoleList = this.userService.findAllUnAllocateUserList(sysUser.getId(), null);
        viewModel.addObject("unAllocateRoleList", unAllocateRoleList);
        //跳转到设置用户角色页面
        viewModel.setViewName("system/user/addUserRole");
        return viewModel;
    }

   

    /**
     * 
     * <p>
     * Description: 设置角色
     * </p>
     * 
     * @param request 请求
     * @param response 响应
     * @param id 用户主键id
     * @return 信息
     * @throws Exception 异常
     */
    @RequestMapping("/doSetUserRole.do")
    @ResponseBody
    public Object doSetUserRole(@RequestParam(value = "id") Long id, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        ModelAndView viewModel;
        viewModel = new ModelAndView();
        //被修改的用户
        SysUser updateUser;
        updateUser = this.userService.getById(id);
        
        //该用户分配的角色
        String selectvalue;
        selectvalue = request.getParameter("roleIds").toString();
        String[] roleIdArray;
        roleIdArray = selectvalue.split(",");
        //如果出现异常--ajax异常--被统一捕获处理
        this.userService.updateUserRoles(updateUser, getCurrentUser(request), roleIdArray);
        viewModel.setViewName("common/success");
        
        return viewModel;
    }

    /**
     * 
     * <p>
     * Description: 用户批量删除
     * </p>
     * 
     * @param ids 列的集合
     * @param request 请求
     * @return map 数据map
     */
    @RequestMapping(value = "/deleteUser.do")
    @ResponseBody
    public Object deleteUser(@RequestParam(value = "ids") String ids, HttpServletRequest request) {
        //存放id的数组
        String[] idArray;
        idArray = ids.split(",");
        Map<String, Object> map;
        map = new HashMap<String, Object>();
        //执行删除
        this.userService.deleteByDelFlag(idArray, getCurrentUser(request));
        map.put("success", true);
        return map;
    }

    /**
     * 
     * <p>
     * Description: 动态查询
     * </p>
     * 
     * @param type 查询类型
     * @param conditionValue 列的集合
     * @param id 角色ID
     * @param request 请求
     * @return map 数据map
     */
    @RequestMapping(value = "/conditionValueQuery.do")
    @ResponseBody
    public Object conditionValueQuery(@RequestParam(value = "type") String type, @RequestParam(value = "id") String id,
            @RequestParam(value = "conditionValue") String conditionValue, HttpServletRequest request) {
        Map<String, Object> map;
        map = new HashMap<String, Object>();
        //判断查询unAllocateRoleList还是allocateRoleList
        if ("allocateRoleList".equals(type)) {
            map.put("allocateRoleList", this.userService.findAllAllocateUserList(Long.parseLong(id), conditionValue));
        } else {
            map.put("unAllocateRoleList",
                    this.userService.findAllUnAllocateUserList(Long.parseLong(id), conditionValue));
        }
        map.put("success", true);
        return map;
    }

    /**
     * 
     * <p>
     * Description: 判断删除对象中是否含有当前登录用户
     * </p>
     * 
     * @param ids 列的集合
     * @param request 请求
     * @return map 数据map
     */
    @RequestMapping(value = "/isLoginUser.do")
    @ResponseBody
    public Object isLoginUser(@RequestParam(value = "ids") String ids, HttpServletRequest request) {
        Map<String, Object> map;
        map = new HashMap<String, Object>();
        //存放id的数组
        String[] idArray;
        idArray = ids.split(",");
        //获取当前登录人信息
        SysUser user;
        user = getCurrentUser(request);
        //页面提示信息
        String msg;
        msg = "";
        //判断标志
        boolean flag;
        flag = true;
        /*
         * 遍历删除对象id数组，匹配是否含有当前登录人工号
         */
        if (idArray != null && idArray.length > 0) {
            
            String tobeDeletedUserNum;
            for (int i = 0; i < idArray.length; i++) {
                //id不为空
                if (StringUtils.isNotBlank(idArray[i])) {
                    //根据id获得用户编号
                    tobeDeletedUserNum = (String) this.utilService.findColumnByColumn("EMPLOYEE_NUM", "TS_USER", "PK_ID", idArray[i].trim());
                    if (tobeDeletedUserNum.equals(user.getEmployeeNum())) {
                        msg = "删除用户中存在当前使用用户，确定删除？";
                        flag = false;
                        map.put("Msg", msg);
                        break;
                    }
                }
                
            }
        }
        map.put("success", flag);
        return map;
    }


}
