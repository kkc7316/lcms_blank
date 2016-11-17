/**
 * IuserService.java
 * Created at 2015-10-16
 * Created by Administrator
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.user.services;

import java.util.List;
import java.util.Map;

import com.svw.lcms.common.base.services.IEntityService;
import com.svw.lcms.common.user.domain.SysUser;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>
 * ClassName: IUserService
 * </p>
 * <p>
 * Description: 用户管理service接口
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-10-16
 * </p>
 */
public interface IUserService extends IEntityService<SysUser> {

    /**
     * 
     * <p>
     * Description: 用户列表记录查询
     * </p>
     * 
     * @param page 分页
     * @param model 对象
     * @param userRoleName 用户角色名
     * @return 结果集
     */
    public List<SysUser> findAllUserList(PageInfo page, Map<String, Object> params);
    /**
     * 
     * <p>
     * Description: 根据主键id查询用户对象所具有的角色
     * </p>
     * 
     * @param id 主键id
     * @param conditionValue 查询条件
     * @return 角色集
     */
    public List<Object> findAllAllocateUserList(Long id, String conditionValue);

    
    /**
     * 
     * <p>
     * Description: 根据主键id查询用户对象未分配的角色
     * </p>
     * 
     * @param id 主键id
     * @param conditionValue 查询条件
     * @return 角色集
     */
    public List<Object> findAllUnAllocateUserList(Long id, String conditionValue);


    /**
     * <p>
     * Description: 查找用户是否有xxx权限
     * </p>
     * 
     * @param user 用户
     * @param resourceCode 权限代码
     * @return boolean
     */
    public boolean hasPermission(SysUser user, String resourceCode);
    
    
    /**
     * <p>Description: 更新用户角色信息</p>
     * @param updateUser    被更新的用户
     * @param currentUser   当前用户
     * @param roleIdArray   新的角色IDs
     */
    public void updateUserRoles(SysUser updateUser, SysUser currentUser, String[] roleIdArray);

}
