/**
 * DictIdxController.java
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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.svw.lcms.common.base.controller.BaseController;
import com.svw.lcms.common.dict.domain.SysDictIdx;
import com.svw.lcms.common.dict.services.IDictIdxService;
import com.svw.lcms.common.dict.services.IDictService;
import com.svw.lcms.framework.web.page.PageInfo;
import com.svw.lcms.framework.web.page.PageUtil;
import com.svw.lcms.utils.StrUtil;

/**
 * 
 * <p>
 * ClassName: DictIdxController
 * </p>
 * <p>
 * Description: 父字典管理
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-10-12
 * </p>
 */
@Controller
public class DictIdxController extends BaseController<SysDictIdx> {

    /**
     * 主字典表dictIdxService
     */
    @Autowired
    @Qualifier("dictIdxService")
    private IDictIdxService dictIdxService;

    /**
     * 注入子字典表的service
     */
    @Autowired
    @Qualifier("dictService")
    private IDictService dictService;

    /**
     * 
     * <p>
     * Description: 字典列表页面
     * </p>
     * 
     * @return 字典列表页面
     */
    @RequestMapping("/dictIdxListPage.do")
    public ModelAndView dictIdxListPage() {
        ModelAndView viewModel;
        viewModel = new ModelAndView();
        viewModel.setViewName("system/dict/dictIdxList");
        return viewModel;
    }

    /**
     * 
     * <p>
     * Description: 字典新增
     * </p>
     * 
     * @return 字典新增页面
     */
    @RequestMapping("/addDictIdx.do")
    public ModelAndView addDictIdx() {
        ModelAndView viewModel;
        viewModel = new ModelAndView();
        viewModel.setViewName("system/dict/addDictIdx");
        return viewModel;
    }

    /**
     * 
     * <p>
     * Description: 新增字典
     * </p>
     * 
     * @param model model
     * @param request request
     * @return 字典新增页面
     */
    @RequestMapping("/doAddDictIdx.do")
    public ModelAndView doAddDictIdx(@ModelAttribute SysDictIdx model, HttpServletRequest request) {
        this.dictIdxService.saveEntity(model, getCurrentUser(request));
        ModelAndView viewModel;
        viewModel = new ModelAndView();
        viewModel.setViewName("common/success");
        return viewModel;
    }

    /**
     * 
     * <p>
     * Description: 更新字典
     * </p>
     * 
     * @param model model
     * @param request request
     * @return 字典更新页面
     */
    @RequestMapping("/updateDictIdx.do")
    public ModelAndView updateDictIdx(@ModelAttribute SysDictIdx model, HttpServletRequest request) {
        this.dictIdxService.updateEntity(model, getCurrentUser(request));
        ModelAndView viewModel;
        viewModel = new ModelAndView();
        viewModel.setViewName("common/success");
        return viewModel;
    }

    /**
     * 
     * <p>
     * Description: 新增或修改字典
     * </p>
     * 
     * @param request 请求
     * @param model model
     * @return 信息
     * @throws Exception 异常
     */
    @RequestMapping("/saveOrUpdateDictIdx.do")
    public ModelAndView saveOrUpdate(@ModelAttribute SysDictIdx model, HttpServletRequest request) throws Exception {
        ModelAndView viewModel;
        viewModel = new ModelAndView();
        //防止重复提交
        //成功标志
        this.dictIdxService.saveOrUpdateDictIdx(model, getCurrentUser(request));
        viewModel.setViewName("common/success");
        return viewModel;
    }

    /**
     * 
     * <p>
     * Description: 字典编辑页面
     * </p>
     * 
     * @param request request
     * @return 字典编辑页面
     */
    @RequestMapping("/detailDictIdx.do")
    public ModelAndView detailDictIdx(HttpServletRequest request) {
        String dictKey;
        dictKey = request.getParameter("dictKey");
        SysDictIdx model;
        model = new SysDictIdx();
        if (dictKey != null) {
            model = this.dictIdxService.findDictIdxByKey(dictKey);
            request.getSession().setAttribute("parentKey", model.getDictKey());
        }
        request.getSession().setAttribute("model", model);
        ModelAndView viewModel;
        viewModel = new ModelAndView();
        viewModel.setViewName("system/dict/detailDictIdx");
        return viewModel;
    }

    /**
     * 
     * <p>
     * Description: 字典详情页面
     * </p>
     * 
     * @param request request
     * @return 字典详情页面
     */
    @RequestMapping("/dictIdxDetail.do")
    public ModelAndView dictIdxDetail(HttpServletRequest request) {
        ModelAndView viewModel;
        String dictKey;
        dictKey = request.getParameter("dictKey");
        SysDictIdx model;
        model = new SysDictIdx();
        if (dictKey != null) {
            model = this.dictIdxService.findDictIdxByKey(dictKey);
            request.getSession().setAttribute("parentKey", model.getDictKey());
        }
        request.getSession().setAttribute("model", model);
        viewModel = new ModelAndView();
        viewModel.setViewName("system/dict/dictIdxDetail");
        return viewModel;
    }

    /**
     * 
     * <p>
     * Description: 一级字典名称验证
     * </p>
     * 
     * @param dictName 字典dictName
     * @param request 用户请求 
     * @return 结果集
     */
    @RequestMapping("/dictNameValidation.do")
    @ResponseBody
    public Object dictNameValidation(HttpServletRequest request, @RequestParam(value = "dictName") String dictName) {
        Map<String, Object> map;
        map = new HashMap<String, Object>();
        
        if(this.dictIdxService.validitionDictName(dictName)) {
            //获得返回值
            map.put("msg", "字典值已存在");
        }
        else {
            map.put("msg", "true");
        }
        return map;
    }

    /**
     * 
     * <p>
     * Description: 字典删除
     * </p>
     * 
     * @param request 请求对象
     * @param response 响应对象昂
     * @return 字典数据
     * @throws Exception 异常
     */
    @RequestMapping("/doDelDictIdx.do")
    @ResponseBody
    public Object doDelDictIdx(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String dictIdxIds;
        dictIdxIds = request.getParameter("dictIdxIds");
        HashMap<String, Object> map;
        map = new HashMap<String, Object>();
        if (!StringUtils.isEmpty(dictIdxIds)) {
            dictIdxIds = dictIdxIds.substring(2, dictIdxIds.length() - 2);
            this.dictIdxService.deleteDictIdx(dictIdxIds);
            map.put("success", true);
        } else {
            map.put("error", false);
        }
        return map;
    }

    /**
     * 
     * <p>
     * Description: 字典管理列表查询
     * </p>
     * 
     * @param request 请求对象
     * @param response 响应对象昂
     * @return 字典数据
     * @throws Exception 异常
     */
    @RequestMapping("/dictIdxList.do")
    @ResponseBody
    public Object getShopInJson(HttpServletRequest request, HttpServletResponse response) throws Exception {
        PageInfo page;
        page = PageUtil.getPage(request);
        List<SysDictIdx> list;
        Map<String, Object> parameterList;
        parameterList = new HashMap<String, Object>();
        SysDictIdx filter;
        filter = (SysDictIdx) initParameters(SysDictIdx.class, request, parameterList);
        list = this.dictIdxService.findAllDictIdxList(page, parameterList);
        HashMap<String, Object> map;
        map = new HashMap<String, Object>();
        map.put("totalCount", page.count);
        map.put("root", list);
        return map;
    }




}
