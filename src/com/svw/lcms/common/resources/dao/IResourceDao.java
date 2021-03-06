/**
 * IresourceDao.java
 * Created at 2016-01-05
 * Created by xieshuang
 * Copyright (C) 2016 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.resources.dao;

import java.util.List;
import java.util.Map;

import com.svw.lcms.common.resources.domain.SysResource;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>
 * ClassName: IResourceDao
 * </p>
 * <p>
 * Description: 资源dao接口
 * </p>
 * <p>
 * Author: xieshuang
 * </p>
 * <p>
 * Date: 2016-1-5
 * </p>
 */
public interface IResourceDao {

    /**
     * <p>
     * Description: 资源列表
     * </p>
     * 
     * @param page 翻页
     * @param parameterList 参数
     * @return list
     */
    public List<SysResource> findAllResourceList(PageInfo page, Map<String, Object> parameterList);

    /**
     * <p>
     * Description: 所有资源列表
     * </p>
     * 
     * @return list
     */
    public List<Map<String, Object>> getAllResourceList();


    /**
     * 
     * <p>
     * Description: 根据父资源id,查找所有级联子资源
     * </p>
     * 
     * @param parentId id
     * @return list
     */
    public List<Long> getResourceListByParentId(Long parentId);

    /**
     * <p>Description: 根据角色ID，查找有权限的资源</p>
     * @param roleId 角色ID
     * @return list
     */
    public List<SysResource> getResourceListByRoleId(String roleId);
    
    /**
     * <p>
     * Description: 根据resourceId删除角色-资源关联表记录
     * </p>
     * 
     * @param resourceId resourceId
     */
    public void deleteRoleResourceListByResourceId(Long resourceId);

    /**
     * <p>
     * Description: 根据roleId删除角色-资源关联表记录
     * </p>
     * 
     * @param roleId roleId
     */
    public void deleteRoleResourceListByRoleId(Long roleId);

}
