/**
 * RoleController.java
 * Created at 2015-11-09
 * Created by mazan
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.role.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.svw.lcms.common.base.controller.BaseController;
import com.svw.lcms.common.resources.domain.SysResource;
import com.svw.lcms.common.resources.services.IResourceService;
import com.svw.lcms.common.role.domain.SysRole;
import com.svw.lcms.common.role.services.IRoleService;
import com.svw.lcms.framework.web.page.PageInfo;
import com.svw.lcms.framework.web.page.PageUtil;

/**
 * <p>
 * ClassName: RoleController
 * </p>
 * <p>
 * Description: 角色controller
 * </p>
 * <p>
 * Author: mazan
 * </p>
 * <p>
 * Date: 2015-11-9
 * </p>
 */
@Controller
@RequestMapping(value = "/role")
public class RoleController extends BaseController<SysRole> {

    /**
     * 注入roleService
     */
    @Autowired
    @Qualifier("roleService")
    private IRoleService roleService;

    /**
     * 注入resourceService
     */
    @Autowired
    @Qualifier("resourceService")
    private IResourceService resourceService;
    /**
     * <p>
     * Description: 进入角色列表
     * </p>
     * 
     * @return viewModel
     */
    @RequestMapping("/roleListPage.do")
    public ModelAndView roleList() {
        ModelAndView viewModel;
        viewModel = new ModelAndView();
        //进入角色列表页面
        viewModel.setViewName("system/role/roleList");
        return viewModel;
    }

    /**
     * 
     * <p>
     * Description:权限列表tree
     * </p>
     * 
     * @param request 请求
     * @param response 响应
     * @return 查询内容
     * @throws Exception 异常
     */
    @RequestMapping("/getResourcesList.do")
    @ResponseBody
    public Object getResourceList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //获取该角色对应主键id
        String roleId;
        roleId = request.getParameter("roleId");
        //查询对应的资源角色
        List<SysResource> resourceList;
        resourceList = this.resourceService.getResourceListByRoleId(roleId);
        return resourceList;
    }

    /**
     * <p>
     * Description: 查询角色列表
     * </p>
     * 
     * @param request 请求
     * @param response 响应
     * @return 列表
     * @throws Exception 异常
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/roleList.do")
    @ResponseBody
    public Object getRoleList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //分页信息
        PageInfo page;
        page = PageUtil.getPage(request);
        List<SysRole> list;
        //查询条件集
        Map<String, Object> parameterList;
        parameterList = new HashMap<String, Object>();
        //给查询条件赋值
        initParameters(SysRole.class, request, parameterList);
        //查询相应的信息 并将其返回到页面
        list = this.roleService.findAllRoleList(page, parameterList);
        HashMap<String, Object> map;
        map = new HashMap<String, Object>();
        //放入页面条数
        map.put("totalCount", page.count);
        /*
         * list转json ,避免循环嵌套
         */
        Map<String, Object>[] listMap;
        listMap = new HashMap[list.size()];
        for (int i = 0; i < list.size(); i++) {
            HashMap<String, Object> obj;
            obj = new HashMap<String, Object>();
            obj.put("id", list.get(i).getId());
            obj.put("roleName", list.get(i).getRoleName());
            obj.put("roleCode", list.get(i).getRoleCode());
            obj.put("roleDesc", list.get(i).getRoleDesc());
            obj.put("resourcesName", list.get(i).getResourcesName());
            listMap[i] = obj;
        }
        map.put("root", listMap);
        return map;
    }

    /**
     * 
     * <p>
     * Description: 角色添加初始化
     * </p>
     * 
     * @param id id编号
     * @return 角色添加页面
     */
    @RequestMapping("/addRoleInit.do")
    public ModelAndView addRoleInit(@RequestParam(value = "id") Long id) {
        ModelAndView viewModel;
        viewModel = new ModelAndView();
        SysRole role;
        /*
         * 如果id存在，为更新角色 否则为新增
         */
        if (id != null) {
            role = this.roleService.getById(id);
            viewModel.addObject("updateRole", role);
        }
        viewModel.setViewName("system/role/addRole");
        return viewModel;
    }

    /**
     * 
     * <p>
     * Description: 添加角色
     * </p>
     * 
     * @param request 请求
     * @param response 响应
     * @param model 对象
     * @param resourcesIds 资源列表id数组
     * @param result result
     * @return 信息
     * @throws Exception 异常
     */
    @RequestMapping("/doAddRole.do")
    @ResponseBody
    public ModelAndView doAddRole(@ModelAttribute SysRole model,
            @RequestParam(value = "resourcesIds") String resourcesIds, BindingResult result,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView viewModel;
        viewModel = new ModelAndView();
//        //后台验证
//        this.validator.validate(model, result);
//
//        if (result.hasErrors()) {
//            viewModel.addObject("validateMsg", "前端验证未起效果，后台验证失败。");
//            viewModel.addObject("validateError", this.validator.defaultHtmlMessages);
//            viewModel.setViewName("common/input");
//            return viewModel;
//        }

        /*
         * 验证角色名称是否存在 如果返回true，说明不存在，执行更新或添加操作
         */
        String validateMsg;
        validateMsg = "";
        validateMsg = this.roleService.validateUnique(model);
        if (!"true".equals(validateMsg)) {
            viewModel.addObject("validateMsg", validateMsg);
            viewModel.setViewName("common/failed");
            return viewModel;
        } else {
            //该角色分配的资源
            String[] array;
            array = resourcesIds.split(COMMA);
            this.roleService.saveOrUpdateRoleAndResources(model, getCurrentUser(request), array);
            viewModel.setViewName("common/success");
            return viewModel;
        }
    }

    /**
     * 
     * <p>
     * Description: 角色批量删除
     * </p>
     * 
     * @param ids 列的集合
     * @param request 请求
     * @return map 数据map
     */
    @RequestMapping(value = "/deleteRole.do")
    @ResponseBody
    public Object deleteRole(@RequestParam(value = "ids") String ids, HttpServletRequest request) {
        //存放id的数组
        String[] array;
        array = ids.split(COMMA);
        
        Map<String, Object> map;
        map = new HashMap<String, Object>();
        //执行删除
        this.roleService.deleteRoleAndResources(array, getCurrentUser(request));
        map.put("success", true);
        return map;
    }


}
