/**
 * IresourceService.java
 * Created at 2016-02-06
 * Created by mazan
 * Copyright (C) 2016 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.resources.services;

import java.util.List;
import java.util.Map;

import com.svw.lcms.common.base.services.IEntityService;
import com.svw.lcms.common.resources.domain.SysResource;
import com.svw.lcms.common.user.domain.SysUser;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>
 * ClassName: IResourceService
 * </p>
 * <p>
 * Description: 资源管理service
 * </p>
 * <p>
 * Author: Administrator
 * </p>
 * <p>
 * Date: 2016-2-6
 * </p>
 */
public interface IResourceService extends IEntityService<SysResource>{

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
     * 
     * <p>
     * Description: 根据属性查找对象书否存在
     * </p>
     * 
     * @param propertyName 属性名
     * @param propertyValue 属性值
     * @return 布尔值
     */
    public boolean findByProperty(String propertyName, String propertyValue);

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
     * 
     * <p>
     * Description: 删除资源
     * </p>
     * 
     * @param array 资源ids
     * @param user 当前用户
     * @return boolean
     */
    public boolean delete(String[] array, SysUser user);

    /**
     * 
     * <p>
     * Description: 新增、编辑资源 唯一性验证
     * </p>
     * 
     * @param model resource
     * @return str
     */
    public String validateUnique(SysResource model);

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
    public void saveOrUpdate(SysResource model, String parentId, SysUser user);

}
