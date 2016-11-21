/**
 * ResourceController.java
 * Created at 2016-02-06
 * Created by mazan
 * Copyright (C) 2016 SHANGHAI VOLKSWAGEN, All rights reserved.
 */

package com.svw.lcms.common.resources.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
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
import com.svw.lcms.common.dict.services.IDictService;
import com.svw.lcms.common.resources.domain.SysResource;
import com.svw.lcms.common.resources.services.IResourceService;
import com.svw.lcms.framework.web.page.PageInfo;
import com.svw.lcms.framework.web.page.PageUtil;
import com.svw.lcms.utils.StrUtil;

/**
 * <p>
 * ClassName: ResourceController
 * </p>
 * <p>
 * Description: 资源管理Controller
 * </p>
 * <p>
 * Author: Administrator
 * </p>
 * <p>
 * Date: 2016-2-6
 * </p>
 */
@Controller
@RequestMapping(value = "/resource")
public class ResourceController extends BaseController<SysResource> {


    /**
     * resourceType：1 权限 child
     */
    private static final String TYPE_PERMISSION = "1";

    /**
     * 注入roleService
     */
    @Autowired
    @Qualifier("resourceService")
    private IResourceService resourceService;

    /**
     * 字典子表service
     */
    @Autowired
    @Qualifier("dictService")
    private IDictService dictService;
    /**
     * <p>
     * Description: 进入资源列表
     * </p>
     * 
     * @return viewModel
     */
    @RequestMapping("/resourceListPage.do")
    public ModelAndView roleList() {
        ModelAndView viewModel;
        viewModel = new ModelAndView();
        //进入角色列表页面
        viewModel.setViewName("system/resource/resourceList");
        return viewModel;
    }

    /**
     * <p>
     * Description: 资源列表
     * </p>
     * 
     * @param request req
     * @param response rep
     * @return obj
     * @throws Exception ex
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/resourceList.do")
    @ResponseBody
    public Object getResourceList(HttpServletRequest request, HttpServletResponse response) throws Exception {

        //分页信息
        PageInfo page;
        page = PageUtil.getPage(request);
        List<SysResource> list;
        //查询条件集
        Map<String, Object> parameterList;
        parameterList = new HashMap<String, Object>();
        //给查询条件parameterList赋值
        initParameters(SysResource.class, request, parameterList);
        //查询相应的信息 并将其返回到页面
        list = this.resourceService.findAllResourceList(page, parameterList);
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
            obj.put("resourceName", list.get(i).getResourceName());
            obj.put("resourceCode", list.get(i).getResourceCode());

            Date createDate;
            createDate = list.get(i).getCreateDate();
            obj.put("createDate", createDate.toString().substring(0, 19));
            listMap[i] = obj;
        }
        map.put("root", listMap);

        return map;
    }

    /**
     * 
     * <p>
     * Description: 资源新增、编辑初始化
     * </p>
     * 
     * @param id id编号
     * @return 资源编辑页面
     */
    @RequestMapping("/addResourceInit.do")
    public ModelAndView addResourceInit(@RequestParam(value = "id") Long id) {
        ModelAndView viewModel;
        viewModel = new ModelAndView();

        SysResource resource;
        if (id != null) {
            resource = this.resourceService.getById(id);
            if (StringUtils.isBlank(resource.getResourceType())) {
                resource.setResourceType(TYPE_PERMISSION);
            }
        } else {
            //新增默认值
            resource = new SysResource();
            resource.setDelFlag(NOT_DEL);
            resource.setResourceType(TYPE_PERMISSION);
        }
        //资源类型
        viewModel.addObject("resourceTypeMap", this.dictService.findAllDictListByParentKey("RESOURCE_TYPE"));
        viewModel.addObject("resource", resource);
        viewModel.setViewName("system/resource/addResource");
        return viewModel;
    }

    /**
     * 
     * <p>
     * Description:所有资源列表tree
     * </p>
     * 
     * @param request 请求
     * @param response 响应
     * @return 查询内容
     * @throws Exception 异常
     */
    @RequestMapping("/getAllResourcesList.do")
    @ResponseBody
    public Object getAllResourceList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //查询对应的资源角色
        List<Map<String, Object>> resourceList;
        resourceList = this.resourceService.getAllResourceList();

        //封装成json格式
        //        return JsonUtil.convertEntityListToJsonWithName(resourceList);

        return resourceList;
    }

    /**
     * 
     * <p>
     * Description: 添加资源
     * </p>
     * 
     * @param request 请求
     * @param response 响应
     * @param model 对象
     * @param parentId 父资源
     * @param result result
     * @return 信息
     * @throws Exception 异常
     */
    @RequestMapping("/doAddResource.do")
    @ResponseBody
    public ModelAndView doAddRole(@ModelAttribute SysResource model, @RequestParam(value = "parentId") String parentId,
            BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView viewModel;
        viewModel = new ModelAndView();

        //验证parentId
        if (null == parentId || "".equals(parentId)) {
            viewModel.addObject("validateMsg", "前端验证未起效果，后台验证失败。");
            viewModel.addObject("validateError", "父资源为空。");
            viewModel.setViewName("common/input");
            return viewModel;
        }
        /*
         * 验证资源名称、资源代码是否存在 如果返回true，说明不存在，执行更新或添加操作
         */
        String validateMsg;
        //validateMsg = "";
        validateMsg = this.resourceService.validateUnique(model);
        if (!"".equals(validateMsg)) {
            viewModel.addObject("validateMsg", validateMsg);
            viewModel.setViewName("common/failed");
            return viewModel;
        }

        //保存资源
        this.resourceService.saveOrUpdate(model, parentId, getCurrentUser(request));
        viewModel.setViewName("common/success");
        viewModel.addObject("validateMsg", "保存成功。");
        return viewModel;
    }

    /**
     * 
     * <p>
     * Description: 资源批量删除
     * </p>
     * 
     * @param ids 列的集合
     * @param request 请求
     * @return map 数据map
     */
    @RequestMapping(value = "/deleteResource.do")
    @ResponseBody
    public Object deleteResource(@RequestParam(value = "ids") String ids, HttpServletRequest request) {
        //判断标志
        boolean flag;
        flag = true;
        //存放id的数组
        String[] array;
        array = ids.split(",");

        Map<String, Object> map;
        map = new HashMap<String, Object>();

        //执行删除
        flag = this.resourceService.delete(array, getCurrentUser(request));

        map.put("success", flag);
        return map;
    }



}
