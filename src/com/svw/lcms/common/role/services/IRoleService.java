/**
 * IsysRoleService.java
 * Created at 2015-11-09
 * Created by mazan
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.role.services;

import java.util.List;
import java.util.Map;

import com.svw.lcms.common.base.services.IEntityService;
import com.svw.lcms.common.role.domain.SysRole;
import com.svw.lcms.common.user.domain.SysUser;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>
 * ClassName: IRoleService
 * </p>
 * <p>
 * Description: 角色service接口
 * </p>
 * <p>
 * Author: mazan
 * </p>
 * <p>
 * Date: 2015-11-9
 * </p>
 */
public interface IRoleService extends IEntityService<SysRole> {

    /**
     * <p>
     * Description: 角色列表查询
     * </p>
     * 
     * @param page 分页
     * @param map 查询条件
     * @return 结果
     */
    public List<SysRole> findAllRoleList(PageInfo page, Map<String, Object> params);


    /**
     * 
     * <p>
     * Description: 验证唯一性
     * </p>
     * 
     * @param model 角色对象
     * @return 页面信息
     */
    public String validateUnique(SysRole model);

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
    public void saveOrUpdateRoleAndResources(SysRole model, SysUser user, String[] array);

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
    public void deleteRoleAndResources(String[] array, SysUser user);

}
