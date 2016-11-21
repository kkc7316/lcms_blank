/**
 * DictController.java
 * Created at 2015-09-23
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.dict.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.svw.lcms.common.base.controller.BaseController;
import com.svw.lcms.common.dict.domain.SysDict;
import com.svw.lcms.common.dict.services.IDictService;
import com.svw.lcms.framework.web.page.PageInfo;
import com.svw.lcms.framework.web.page.PageUtil;

/**
 * 
 * <p>
 * ClassName: DictController
 * </p>
 * <p>
 * Description: 子字典管理
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-10-12
 * </p>
 */
@Controller
public class DictController extends BaseController<SysDict> {
    /**
     * dictService
     */
    @Autowired
    @Qualifier("dictService")
    private IDictService dictService;


    /**
     * 
     * <p>
     * Description: 字典管理列表查询
     * </p>
     * 
     * @param request 请求对象
     * @param response 响应对象昂
     * @return 字典数据结果集
     * @throws Exception 异常
     */
    @RequestMapping("/dictList.do")
    @ResponseBody
    public Object getDictList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        PageInfo page;
        page = PageUtil.getPage(request);
        List<SysDict> list;
        Map<String, Object> parameterList;
        parameterList = new HashMap<String, Object>();
        //        this.filter = (SysDict) initParameters(SysDict.class, request, parameterList);
        Object obj;
        obj = request.getSession().getAttribute("parentKey");
        parameterList.put("parentKey", obj);
        list = this.dictService.findAllDictList(page, parameterList);
        HashMap<String, Object> map;
        map = new HashMap<String, Object>();
        map.put("totalCount", page.count);
        map.put("root", list);
        return map;
    }

    /**
     * 
     * <p>
     * Description: 字典key验证
     * </p>
     * 
     * @param key 字典key
     * @param dictValue 字典dictValue
     * @param request 用户请求
     * @return 结果集
     */
    @RequestMapping("/dictValidation.do")
    @ResponseBody
    public Object dictValidation(HttpServletRequest request, 
            @RequestParam(value = "key") String key,
            @RequestParam(value = "dictValue") String dictValue) {
        
        //获得父类key的值
        Object obj;
        obj = request.getSession().getAttribute("parentKey");
        //获得返回值
        String value;
        value = this.dictService.validitionDict(key, obj.toString(), dictValue);
        
        Map<String, Object> map;
        map = new HashMap<String, Object>();
        map.put("msg", value); 
        
        return map;
    }

    /**
     * 
     * <p>
     * Description: 字典值新增
     * </p>
     * 
     * @return 字典值新增页面
     */
    @RequestMapping("/addDict.do")
    public ModelAndView addDict() {
        ModelAndView viewModel;
        viewModel = new ModelAndView();
        viewModel.setViewName("system/dict/addDict");
        return viewModel;
    }

    /**
     * 
     * <p>
     * Description: 字典值编辑
     * </p>
     * 
     * @param request request
     * @return 字典值编辑页面
     */
    @RequestMapping("/updateDict.do")
    public ModelAndView updateDict(HttpServletRequest request) {
        ModelAndView viewModel;
        Long id;
        id = Long.parseLong(request.getParameter("id"));
        SysDict dict;
        dict = new SysDict();
        dict = this.dictService.getById(id);
        request.setAttribute("dict", dict);
        viewModel = new ModelAndView();
        viewModel.setViewName("system/dict/updateDict");
        return viewModel;
    }

    /**
     * 
     * <p>
     * Description: 新增或修改字典值
     * </p>
     * 
     * @param request 请求
     * @param model model
     * @return 信息
     * @throws Exception 异常
     */
    @RequestMapping(value = "/saveOrUpdateDict.do")
    @ResponseBody
    public Object saveOrUpdate(@ModelAttribute SysDict model, HttpServletRequest request) throws Exception {
        Map<String, Object> map;
        map = new HashMap<String, Object>();
        //防止重复提交
        
        //获得父类key的值
        Object obj;
        obj = request.getSession().getAttribute("parentKey");
        //将其父类的key赋值给相应的model
        model.setParentKey(obj.toString()); 
        this.dictService.saveOrUpdateDict(model, getCurrentUser(request));
        
        map.put("success", true);
        return map;
    }


    /**
     * <p>
     * Description: 字典值物理删除
     * </p>
     * 
     * @param request 请求对象
     * @param response 响应对象昂
     * @return 字典数据
     * @throws Exception 异常
     */
    @RequestMapping("/doDelDict.do")
    @ResponseBody
    public Object doDelDict(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String dictIds;
        dictIds = request.getParameter("dictIds");
        HashMap<String, Object> map;
        map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(dictIds)) {
            dictIds = dictIds.substring(2, dictIds.length() - 2);
            this.dictService.deleteDict(dictIds);
            map.put("success", true);
        } else {
            map.put("error", false);
        }
        return map;
    }

    /**
     * <p>
     * Description: 字典值逻辑删除
     * </p>
     * 
     * @param request 请求对象
     * @param response 响应对象昂
     * @return 字典数据
     * @throws Exception 异常
     */
    @RequestMapping("/doDeleteDict.do")
    @ResponseBody
    public Object doDeleteDict(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String dictIds;
        dictIds = request.getParameter("dictIds");
        HashMap<String, Object> map;
        map = new HashMap<String, Object>();
        
        if (StringUtils.isNotEmpty(dictIds)) {
            dictIds = dictIds.substring(2, dictIds.length() - 2);
            this.dictService.doDeleteDict(dictIds, getCurrentUser(request));
            map.put("success", true);
        } else {
            map.put("error", false);
        }
        return map;
    }

    /**
     * <p>
     * Description: 字典值逻辑删除
     * </p>
     * 
     * @param request 请求对象
     * @param response 响应对象昂
     * @return 字典数据
     * @throws Exception 异常
     */
    @RequestMapping("/doRecoverConfirm.do")
    @ResponseBody
    public Object doRecoverConfirm(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String dictIds;
        dictIds = request.getParameter("dictIds");
        HashMap<String, Object> map;
        map = new HashMap<String, Object>();
        if (!StringUtils.isEmpty(dictIds)) {
            dictIds = dictIds.substring(2, dictIds.length() - 2);
            this.dictService.doRecoverConfirm(dictIds, getCurrentUser(request));
            map.put("success", true);
        } else {
            map.put("error", false);
        }
        return map;
    }
}
