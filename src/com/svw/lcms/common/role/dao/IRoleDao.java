/**
 * IsysRoleDao.java
 * Created at 2015-11-09
 * Created by mazan
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.role.dao;

import java.util.List;
import java.util.Map;

import com.svw.lcms.common.role.domain.SysRole;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>
 * ClassName: IRoleDao
 * </p>
 * <p>
 * Description: 角色dao
 * </p>
 * <p>
 * Author: mazan
 * </p>
 * <p>
 * Date: 2015-11-9
 * </p>
 */
public interface IRoleDao {

    /**
     * <p>
     * Description: 角色列表查询
     * </p>
     * 
     * @param page 分页
     * @param map 条件
     * @return 返回结果集
     */
    public List<SysRole> findAllRoleList(PageInfo page, Map<String, Object> map);


    /**
     * 
     * <p>
     * Description: 根据属性进行查重操作
     * </p>
     * 
     * @param model 角色对象
     * @return 结果集
     */
    public List<SysRole> validateRoleNameUnique(SysRole model);


    /**
     * 
     * <p>
     * Description: 根据属性进行查重操作
     * </p>
     * 
     * @param model 角色对象
     * @return 结果集
     */
    public List<SysRole> validateRoleCodeUnique(SysRole model);

}
