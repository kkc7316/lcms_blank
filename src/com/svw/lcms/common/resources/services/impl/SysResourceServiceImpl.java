/**
 * ResourceServiceImpl.java
 * Created at 2016-02-06
 * Created by mazan
 * Copyright (C) 2016 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.resources.services.impl;

import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.svw.lcms.common.base.services.impl.EntityServiceImpl;
import com.svw.lcms.common.resources.dao.IResourceDao;
import com.svw.lcms.common.resources.domain.SysResource;
import com.svw.lcms.common.resources.services.IResourceService;
import com.svw.lcms.common.user.domain.SysUser;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>
 * ClassName: ResourceServiceImpl
 * </p>
 * <p>
 * Description: 资源管理接口
 * </p>
 * <p>
 * Author: Administrator
 * </p>
 * <p>
 * Date: 2016-2-6
 * </p>
 */
@Service("resourceService")
public class SysResourceServiceImpl extends EntityServiceImpl<SysResource> implements IResourceService {

    /**
     * <p>
     * Field resourceDao
     * </p>
     */
    @Autowired
    @Qualifier("resourceDao")
    private IResourceDao resourceDao;

    /**
     * <p>
     * Description: 资源列表
     * </p>
     * 
     * @param page 翻页
     * @param parameterList 参数
     * @return list
     */
    @Override
    public List<SysResource> findAllResourceList(PageInfo page, Map<String, Object> parameterList) {
        return this.resourceDao.findAllResourceList(page, parameterList);
    }


    /**
     * <p>
     * Description: 所有资源列表
     * </p>
     * 
     * @return list
     */
    @Override
    public List<Map<String, Object>> getAllResourceList() {
        return this.resourceDao.getAllResourceList();
    }

    /**
     * 
     * <p>
     * Description: 根据父资源id,查找所有级联子资源
     * </p>
     * 
     * @param parentId id
     * @return list
     */
    @Override
    public List<Long> getResourceListByParentId(Long parentId) {
        return this.resourceDao.getResourceListByParentId(parentId);
    }

    /**
     * 
     * <p>
     * Description: 获取角色对应资源tree
     * </p>
     * 
     * @param roleId 角色主键id
     * @return 结果集
     */
    public List<SysResource> getResourceListByRoleId(String roleId) {
        return this.resourceDao.getResourceListByRoleId(roleId);
    }
    /**
     * 
     * <p>
     * Description: 删除资源
     * </p>
     * 
     * @param array 资源ids
     * @param user 当前用户
     * @return boolean
     */
    @Override
    public boolean delete(String[] array, SysUser user) {
        boolean flag;
        flag = true;

        //所有的子资源[去重]
        Set<Long> totalChildrenSet;
        totalChildrenSet = new HashSet<Long>();

        //批量删除
        if (array != null && array.length > 0) {

            for (int i = 0; i < array.length; i++) {
                //parentId
                Long id;
                id = Long.parseLong(array[i].trim());
                //add parentId
                totalChildrenSet.add(id);
                //                SysResource sysResource;
                //                //根据id获得对象
                //                sysResource = this.resourceDao.getById(id);
                //                //伪删除
                //                this.beforeDelete(sysResource, user);
                //                flag = this.resourceDao.saveOrUpdate(sysResource);
                //                
                //同时级联查询出对应的所有子资源
                List<Long> childrenIdList;
                //                childrenIdList = new ArrayList<Long>();
                childrenIdList = this.getResourceListByParentId(id);

                totalChildrenSet.addAll(childrenIdList);

            }

            //级联删除children.. 
            this.deleteChildrenList(totalChildrenSet, user);

            //删除该资源对应的 角色-资源 关联信息
            this.deleteSysRoleResources(totalChildrenSet, user);
        }
        return flag;
    }

    /**
     * 
     * <p>
     * Description: 新增、编辑资源 唯一性验证
     * </p>
     * 
     * @param model resource
     * @return str
     */
    @Override
    public String validateUnique(SysResource model) {

        Long id;
        id = model.getId();
        
        List<SysResource> list;
        //新增验证
        if (null == id || "".equals(String.valueOf(id))) {

            //验证资源名称
            list = this.findListByProperty("resourceName", model.getResourceName());
            if (list != null && !list.isEmpty()) {
                return "该资源名称已经存在";
            }
            
            //验证资源code
            list = this.findListByProperty("resourceCode", model.getResourceName());
            if (list != null && !list.isEmpty()) {
                return  "该资源编号已经存在";
            }

        } else {
            SysResource oldResource;
            oldResource = this.getById(id);
            if (!model.getResourceName().equals(oldResource.getResourceName())) {
                //验证资源名
                list = this.findListByProperty("resourceName", model.getResourceName());
                if (list != null && !list.isEmpty()) {
                    return "该资源名称已经存在";
                }
            }
            if (!model.getResourceCode().equals(oldResource.getResourceCode())) {
                //验证代码
                list = this.findListByProperty("resourceCode", model.getResourceName());
                if (list != null && !list.isEmpty()) {
                    return  "该资源编号已经存在";
                }
            }

        }
        return "";

    }

    /**
     * 
     * <p>
     * Description: 保存资源
     * </p>
     * 
     * @param model resource
     * @param parentId parentId
     * @param user user
     * @return boolean
     */
    @Override
    public void saveOrUpdate(SysResource model, String parentId, SysUser user) {
        //父资源
        SysResource parentResource;
        parentResource = this.getById(Long.valueOf(parentId));

        SysResource sysResource;
        //新增
        if (model.getId() == null || "".equals(String.valueOf(model.getId()))) {
            model.setId(null);
            model.setParentResource(parentResource);
            this.preCreate(model, user);

        } else {
            /*
             * 修改角色信息
             */
            sysResource = this.getById(model.getId());
            sysResource.setResourceName(model.getResourceName().trim());
            sysResource.setResourceCode(model.getResourceCode().trim());
            sysResource.setParentResource(parentResource);
            sysResource.setResourceType(model.getResourceType().trim());
            sysResource.setDelFlag(model.getDelFlag().trim());
            sysResource.setRemark(model.getRemark().trim());

            model = sysResource;
            this.preUpdate(model, user);
        }
        this.saveOrUpdate(model);


    }



    // private 
    /**
     * <p>
     * Description: 删除子资源列表
     * </p>
     * 
     * @param childrenList list
     * @param user user
     */
    private void deleteChildrenList(Set<Long> childrenList, SysUser user) {

        Iterator<Long> it;
        it = childrenList.iterator();
        //set迭代遍历
        while (it.hasNext()) {
            Long id;
            id = it.next();

            //获得SysResource
            SysResource resource;
            resource = this.getById(id);

            //beforeDelete
            this.preDelete(resource, user);

            //伪删除
            this.saveOrUpdate(resource);
        }

    }

    /**
     * <p>
     * Description: 删除用户资源关联表
     * </p>
     * 
     * @param childrenList childrenList
     * @param user user
     */
    private void deleteSysRoleResources(Set<Long> childrenList, SysUser user) {

        Iterator<Long> it;
        it = childrenList.iterator();
        //set迭代遍历
        while (it.hasNext()) {
            Long id;
            id = it.next();
            this.resourceDao.deleteRoleResourceListByResourceId(id);
        }

    }




}
