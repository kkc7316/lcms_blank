/**
 * Realm.java
 * Created at 2015-09-23
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.framework.realm;

import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.svw.lcms.common.base.ISysConstants;
import com.svw.lcms.common.resources.domain.SysResource;
import com.svw.lcms.common.role.domain.SysRole;
import com.svw.lcms.common.user.domain.SysUser;

/**
 * 
 * <p>
 * ClassName: Realm
 * </p>
 * <p>
 * Description: 登录Realm
 * </p>
 * <p>
 * Author: pangeng
 * </p>
 * <p>
 * Date: 2015-9-23
 * </p>
 */
public class Realm extends AuthorizingRealm implements ISysConstants {

    /**
     * shiroService
     */
    @Autowired
    @Qualifier("shiroService")
    private ShiroService shiroService;

    /**
     * 根据用户登录名获得用户权限
     * 
     * @param principals 登录信息
     * @return 登录授权
     */
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        Session session;
        session = SecurityUtils.getSubject().getSession();
        Object obj;
        obj = session.getAttribute(CURRENT_PERMISSION);
        SimpleAuthorizationInfo info;
        info = null;
        if (obj == null) {
            SysUser user = null;
            obj = session.getAttribute(CURRENT_USER);
            user = (SysUser) obj;
            if (user != null) {
                info = new SimpleAuthorizationInfo();
                List<SysRole> userRoleList;
                userRoleList = user.getSysRoles();
                for (SysRole role : userRoleList) {
                    info.addRole(role.getRoleName());
                }
                for (SysRole role : user.getSysRoles()) {
                    for (SysResource res : role.getSysResources()) {
                        info.addStringPermission(res.getResourceCode());
                    }
                }
                this.setSession(CURRENT_PERMISSION, info);
            }
        } else {
            info = (SimpleAuthorizationInfo) obj;
        }
        return info;
    }

    /**
     * 登录时验证--根据用户登录名获得用户角色列表
     * 
     * @param authcToken 登录令牌
     * @return 登录授权
     * @exception AuthenticationException 登录错误
     */
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
        UsernamePasswordToken token;
        token = (UsernamePasswordToken) authcToken;
        String username;
        username = token.getUsername();
        SysUser user = null;
        //登录操作
        user = this.shiroService.login(username);
        if (user == null) {
            throw new AuthenticationException("user password err");
        }

        this.setSession("currentUser", user);
        SimpleAuthenticationInfo authenticationInfo;
        authenticationInfo = new SimpleAuthenticationInfo(user.getEmployeeNum(), //用户名
                null, //密码
                getName() //realm name
        );
        //去除
        SecurityUtils.getSubject().getSession().removeAttribute("currentPermission");
        doGetAuthorizationInfo(SecurityUtils.getSubject().getPrincipals());
        return authenticationInfo;
    }

    /**
     * 
     * <p>
     * Description: 注销
     * </p>
     */
    public void releaseCachedAuthorizationInfo() {
        clearCachedAuthorizationInfo(SecurityUtils.getSubject().getPrincipals());
    }

    /**
     * 
     * <p>
     * Description: 设置用户信息
     * </p>
     * 
     * @param key key
     * @param value value
     */
    private void setSession(Object key, Object value) {
        Subject currentUser;
        currentUser = SecurityUtils.getSubject();
        if (currentUser != null) {
            Session session;
            session = currentUser.getSession();
            if (session != null) {
                session.setAttribute(key, value);
            }
        }
    }

    public ShiroService getShiroService() {
        return this.shiroService;
    }

    public void setShiroService(ShiroService shiroService) {
        this.shiroService = shiroService;
    }

}
