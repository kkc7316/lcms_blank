/**
 * ShiroService.java
 * Created at 2015-09-23
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.framework.realm;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.svw.lcms.common.user.domain.SysUser;

/**
 * 
 * <p>
 * ClassName: ShiroService
 * </p>
 * <p>
 * Description: 登录
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-9-23
 * </p>
 */
public class ShiroService {
    /**
     * sessionFactory
     */
    @Autowired
    public SessionFactory sessionFactory;

    
    /**
     * 登录验证，返回用户对象 即通过验证，返回null即未通过验证
     * 
     * @param loginId 用户名
     * @return 登录用户
     */
    @SuppressWarnings("unchecked")
    @Transactional
    public SysUser login(String loginId) {
        SysUser user = null;
        Session session;
        session = this.sessionFactory.getCurrentSession();
        List<SysUser> users = new ArrayList<SysUser>();
        //改成大小写不敏感-->匹配小写[效率会变慢]
        Query query;
        query = session.createQuery(" from SysUser where 1=1 and delFlag = '0' and LOWER(employeeNum)=:employeeNum");
        query.setParameter("employeeNum", loginId.toLowerCase());
        users = query.list();
        if (users != null && users.size() > 0) {
            user = users.get(0);
        }
        return user;
    }


    public SessionFactory getSessionFactory() {
        return this.sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

}
