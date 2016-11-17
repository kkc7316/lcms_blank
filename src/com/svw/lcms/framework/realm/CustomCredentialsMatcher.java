/**
 * CustomCredentialsMatcher.java
 * Created at 2015-10-13
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.framework.realm;

import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.credential.SimpleCredentialsMatcher;

/**
 * <p>
 * ClassName: CustomCredentialsMatcher
 * </p>
 * <p>
 * Description: 自定义密码校验
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-10-13
 * </p>
 */
public class CustomCredentialsMatcher extends SimpleCredentialsMatcher {

    /**
     * (non-Javadoc) <p>Title: doCredentialsMatch</p>
     * @param token 登录信息
     * @param info 用户信息
     * @return
     * @see
     * org.apache.shiro.authc.credential.SimpleCredentialsMatcher#doCredentialsMatch
     * (org.apache.shiro.authc.AuthenticationToken,
     * org.apache.shiro.authc.AuthenticationInfo)
     */
    @Override
    public boolean doCredentialsMatch(AuthenticationToken authcToken, AuthenticationInfo info) {
        //单点登录，所以无密码
        return true;
    }

    
}
