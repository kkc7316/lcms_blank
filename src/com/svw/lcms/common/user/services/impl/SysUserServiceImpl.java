/**
 * UserServiceImpl.java
 * Created at 2015-10-16
 * Created by Administrator
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.user.services.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.svw.lcms.common.base.services.impl.EntityServiceImpl;
import com.svw.lcms.common.role.domain.SysRole;
import com.svw.lcms.common.role.services.IRoleService;
import com.svw.lcms.common.user.dao.IUserDao;
import com.svw.lcms.common.user.domain.SysUser;
import com.svw.lcms.common.user.services.IUserService;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>
 * ClassName: UserServiceImpl
 * </p>
 * <p>
 * Description: 用户管理service
 * </p>
 * <p>
 * Author: Administrator
 * </p>
 * <p>
 * Date: 2015-10-16
 * </p>
 */
@Service("userService")
public class SysUserServiceImpl extends EntityServiceImpl<SysUser> implements IUserService {

    /**
     * 数字19
     */
    public static final int NINETEEN = 19;
    /**
     * <p>
     * Field roleDao
     * </p>
     */
    @Autowired
    @Qualifier("roleService")
    private IRoleService roleService;

    /**
     * 用户dao
     */
    @Autowired
    @Qualifier("userDao")
    private IUserDao userDao;

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
    @Override
    public List<SysUser> findAllUserList(PageInfo page, Map<String, Object> params) {
        List<SysUser> userList;
        userList = this.userDao.findAllUserList(page, params);
        //
        for (SysUser sysUser : userList) {
            Date updatedate;
            updatedate = sysUser.getUpdateDate();
            if (updatedate != null) {
                sysUser.setUpdateStringDate(updatedate.toString().substring(0, NINETEEN));
            }
        }
        return userList;
    }


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
    @Override
    public List<Object> findAllAllocateUserList(Long id, String conditionValue) {
        return this.userDao.findAllAllocateUserList(id, conditionValue);
    }

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
    @Override
    public List<Object> findAllUnAllocateUserList(Long id, String conditionValue) {
        return this.userDao.findAllUnAllocateUserList(id, conditionValue);
    }

    /**
     * <p>
     * Description: 查找用户是否有XXX权限
     * </p>
     * 
     * @param user 用户
     * @param permissName 权限名
     * @return boolean
     */
    @Override
    public boolean hasPermission(SysUser user, String permissName) {
        return this.userDao.hasPermission(user, permissName);
    }

    /**
     * <p>Description: 更新用户角色信息</p>
     * @param updateUser    被更新的用户
     * @param currentUser   当前用户
     * @param roleIdArray   新的角色IDs
     */
    @Override
    public void updateUserRoles(SysUser updateUser, SysUser currentUser, String[] roleIdArray) {
        this.preUpdate(updateUser, currentUser);
        this.saveOrUpdate(updateUser);
        
        //更新角色信息--在事务commit之前,updateUser都可以修改
        List<SysRole> sysRoleList;
        sysRoleList = new ArrayList<SysRole>();
        if (null != roleIdArray && roleIdArray.length > 0) {
            for (String roleId : roleIdArray) {
                if (StringUtils.isNotBlank(roleIdArray[0])) {
                    sysRoleList.add(this.roleService.getById(Long.parseLong(roleId)));
                }
            }
        }
        updateUser.setSysRoles(sysRoleList);
        
    }

}
