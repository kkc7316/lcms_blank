/**
 * RoleServiceImpl.java
 * Created at 2015-11-09
 * Created by mazan
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.role.services.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.svw.lcms.common.base.services.impl.EntityServiceImpl;
import com.svw.lcms.common.resources.domain.SysResource;
import com.svw.lcms.common.resources.services.IResourceService;
import com.svw.lcms.common.role.dao.IRoleDao;
import com.svw.lcms.common.role.domain.SysRole;
import com.svw.lcms.common.role.services.IRoleService;
import com.svw.lcms.common.user.domain.SysUser;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>
 * ClassName: RoleServiceImpl
 * </p>
 * <p>
 * Description: 角色列表查询
 * </p>
 * <p>
 * Author: mazan
 * </p>
 * <p>
 * Date: 2015-11-9
 * </p>
 */
@Service("roleService")
public class SysRoleServiceImpl extends EntityServiceImpl<SysRole> implements IRoleService {
    /**
     * <p>
     * Field roleDao
     * </p>
     */
    @Autowired
    @Qualifier("roleDao")
    private IRoleDao roleDao;

    /**
     * <p>
     * Field resourceService
     * </p>
     */
    @Autowired
    @Qualifier("resourceService")
    private IResourceService resourceService;

    /**
     * 
     * <p>
     * Description: 验证唯一性
     * </p>
     * 
     * @param model 角色对象
     * @return 页面信息
     */
    @Override
    public String validateUnique(SysRole model) {
        //返回页面提示信息
        String msg;
        msg = "";
        List<SysRole> roleList;
        /*
         * 验证角色名称唯一性
         */
        if (model.getRoleName().trim() != null && !"".equals(model.getRoleName().trim())) {
            roleList = this.roleDao.validateRoleNameUnique(model);
            if (roleList.size() > 0) {
                msg = "该角色名称已存在";
            }
        }
        msg = this.validateRoleCode(model, msg);
        if (msg.length() == 0) {
            msg = "true";
        }
        return msg;
    }

    /**
     * 
     * <p>
     * Description: 验证角色编号是否重复
     * </p>
     * 
     * @param model 角色对象
     * @param msg 错误信息
     * @return 错误信息
     */
    private String validateRoleCode(SysRole model, String msg) {
        List<SysRole> roleList;
        if (model.getRoleCode() != null && !"".equals(model.getRoleCode())) {
            roleList = this.roleDao.validateRoleCodeUnique(model);
            if (roleList.size() > 0) {
                msg += "<br/>角色代码已存在";
            } else if (msg.length() == 0 && roleList.size() > 0) {
                msg = "角色代码已存在";
            }
        }
        return msg;
    }

    /**
     * <p>
     * Description: 角色列表查询
     * </p>
     * 
     * @param page 分页
     * @param map 查询条件
     * @return 结果
     */
    @Override
    public List<SysRole> findAllRoleList(PageInfo page, Map<String, Object> map) {
        List<SysRole> roleList;
        roleList = this.roleDao.findAllRoleList(page, map);
        for (SysRole role : roleList) {
            String str;
            str = new String();
            /*
             * 将角色对象具有的资源list取出拼接成字符串 并放入资源名称字段中
             */
            List<SysResource> sysResources;
            sysResources = role.getSysResources();
            for (SysResource resources : sysResources) {
                if (!"根目录".equals(resources.getResourceName())) {
                    str += resources.getResourceName() + ";";
                }
            }
            if (str.length() != 0) {
                str = str.substring(0, str.length() - 1);
                role.setResourcesName(str);
            }
        }
        return roleList;
    }



    /**
     * 
     * <p>
     * Description: 添加或者保存对象
     * </p>
     * 
     * @param model 对象
     * @param user 登录人
     * @param array 数组
     * @return 布尔值
     */
    @Override
    public boolean saveOrUpdateRoleAndResources(SysRole model, SysUser user, String[] array) {
        boolean flagResult;
        flagResult = false;
        SysRole sysRole;
        //新增
        if (model.getId() == null || "".equals(String.valueOf(model.getId()))) {
            model.setId(null);
            this.preCreate(model, user);

        } else {
            /*
             * 修改角色信息
             */
            sysRole = this.getById(model.getId());
            sysRole.setRoleName(model.getRoleName().trim());
            sysRole.setRoleDesc(model.getRoleDesc().trim());
            sysRole.setRoleCode(model.getRoleCode().trim());
            model = sysRole;
            this.preUpdate(model, user);
        }
        
        this.saveOrUpdate(model);
        
        //更新角色与资源的对应关系
        List<SysResource> sysResouceList;
        sysResouceList = new ArrayList<SysResource>();
        if (array != null && array.length > 0) {
            for (String resourceId : array) {
                if (StringUtils.isNotBlank(resourceId)) {
                    sysResouceList.add(this.resourceService.getById(Long.parseLong(resourceId)));
                }
            }
        }
        model.setSysResources(sysResouceList);
        return flagResult;
    }

    /**
     * 
     * <p>
     * Description: 执行批量删除
     * </p>
     * 
     * @param array 主键数组
     * @param user 登录人
     * @return 布尔值
     */
    @Override
    public boolean deleteRoleAndResources(String[] array, SysUser user) {
        boolean flag;
        flag = true;
        //批量删除
        if (array != null && array.length > 0) {
            for (int i = 0; i < array.length; i++) {
                SysRole sysRole;
                sysRole = this.deleteByDelFlag(Long.parseLong(array[i].trim()), user);
                //删除角色-资源关联表
                sysRole.setSysResources(new ArrayList<SysResource>());
            }
        }
        return flag;
    }





}
