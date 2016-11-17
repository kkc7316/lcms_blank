/**
 * UserDaoImpl.java
 * Created at 2015-10-16
 * Created by Administrator
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.user.dao.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.Query;
import org.hibernate.transform.Transformers;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.stereotype.Repository;

import com.svw.lcms.common.base.ISysConstants;
import com.svw.lcms.common.user.dao.IUserDao;
import com.svw.lcms.common.user.domain.SysUser;
import com.svw.lcms.common.user.util.UserDaoHelper;
import com.svw.lcms.framework.dao.impl.BaseDaoImpl;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>
 * ClassName: UserDaoImpl
 * </p>
 * <p>
 * Description: 用户管理dao
 * </p>
 * <p>
 * Author: pagnfeng
 * </p>
 * <p>
 * Date: 2015-10-16
 * </p>
 */
@Repository("userDao")
public class UserDaoImpl extends BaseDaoImpl<SysUser, Serializable> implements IUserDao , ISysConstants{

    
    /**
     * setParamter方法--全部模糊查询
     */
    @Override
    protected boolean isAllLikeQuery() {
        return true;
    }
//    /**
//     * 
//     * <p>Description: 用户列表--模糊查询</p>
//     * @return Stri ngArray
//     */
//    @Override
//    protected String[] getLikeQueryArray() {
//        return new String[]{"employeeNum","employeeName","svwCode","userRoleName"};
//    }

    /**
     * 
     * <p>
     * Description: 用户列表查询
     * </p>
     * 
     * @param pageInfo 分页
     * @param model 对象
     * @param userRoleName 用户角色名
     * @return 结果
     * @throws DaoException 异常
     */
    @Override
    public List<SysUser> findAllUserList(PageInfo pageInfo, Map<String, Object> params) {
        StringBuilder buider;
        //拼接查询条件  模糊查询
        buider = new StringBuilder("");
        if (StringUtils.isNotBlank(ObjectUtils.toString(params.get("employeeNum")))) {
            buider.append(" and s.employeeNum like :employeeNum");
        }
        if (StringUtils.isNotBlank(ObjectUtils.toString(params.get("svwCode")))) {
            buider.append(" and upper(s.svwCode) like upper(:svwCode)");
        }
        if (StringUtils.isNotBlank(ObjectUtils.toString(params.get("employeeName")))) {
            buider.append(" and s.employeeName like :employeeName");
        }
        if (StringUtils.isNotBlank(ObjectUtils.toString(params.get("userRoleName")))) {
            buider.append(" and upper(r.roleName) like upper(:userRoleName)");
        }
        
        String countHql;

        countHql = "select count(distinct s.id) from SysUser s left join s.sysRoles r where 1=1 and s.delFlag ='0'"
                    + buider.toString();
        //数据查询sql
        String queryHql;
        queryHql = "select distinct s from SysUser s left join s.sysRoles r where 1=1 and s.delFlag = '0'"
                + buider.toString() 
                + " order by s.updateDate desc, s.createDate desc, s.id desc";
        
        return this.findEntityPageListByHql(countHql, queryHql, params, pageInfo);
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
    @SuppressWarnings("unchecked")
    @Override
    public List<Object> findAllAllocateUserList(Long id, String conditionValue) {
        String queryString;
        queryString = " SELECT r.pk_id roleId,"
                + " R.ROLE_NAME roleName,"
                + " r.role_desc roleDesc "
                + " FROM TS_ROLE R "
                + " LEFT JOIN TR_USER_ROLES TR ON R.PK_ID = TR.ROLE_ID "
                + " WHERE R.DEL_FLAG = '0' "
                + " AND TR.USER_ID =:id ";
        if (StringUtils.isNotBlank(conditionValue)) {
            queryString += " AND (R.ROLE_NAME like:conditionValue or r.role_desc like:conditionValue ) ";
        }
        Query query;
        query = this.getCurrentSession().createSQLQuery(queryString);
        query.setParameter("id", id);
        if (StringUtils.isNotBlank(conditionValue)) {
            query.setParameter("conditionValue", LIKES + conditionValue + LIKES);
        }
        query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        return query.list();
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
    @SuppressWarnings("unchecked")
    @Override
    public List<Object> findAllUnAllocateUserList(Long id, String conditionValue) {
        String queryString;
        queryString = "select r.pk_id roleId,"
                + " r.role_name roleName, "
                + " r.role_desc roleDesc "
                + " from ts_role r "
                + " where r.del_flag = '0'"
                + " and r.pk_id not in( "
                + "   select ur.role_id from tr_user_roles ur where ur.user_id=:id"
                + " )";
        if (conditionValue != null) {
            queryString += " AND (R.ROLE_NAME like:conditionValue or r.role_desc like:conditionValue ) ";
        }
        Query query;
        query = this.getCurrentSession().createSQLQuery(queryString);
        query.setParameter("id", id);
        if (conditionValue != null) {
            query.setParameter("conditionValue", "%" + conditionValue + "%");
        }
        query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        return query.list();
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

        Query query;
        query = this.getCurrentSession().createSQLQuery(UserDaoHelper.hasPermission())
                .addScalar("id", StandardBasicTypes.LONG);
        query.setParameter("userId", user.getId());
        query.setParameter("permissName", permissName);

        Long permissId;
        permissId = (Long) query.uniqueResult();

        if (null == permissId) {
            return false;
        }

        return true;
    }


}
