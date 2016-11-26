/**
 * SpringContextUtil.java
 * Created at 2015-09-23
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.framework.utils;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.NoSuchBeanDefinitionException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * <p>
 * ClassName: SpringContextUtil
 * </p>
 * <p>
 * Description: 在Spring容器之外获取Spring bean实例的工具类
 * </p>
 * <p>
 * Author: zhangqiuyi
 * </p>
 * <p>
 * Date: 2014-7-4
 * </p>
 */
public class SpringContextUtil implements ApplicationContextAware {

    /**
     * Spring配置文件上下文
     */
    private static ApplicationContext applicationContext;

    /**
     * 实现ApplicationContextAware接口的回调方法，设置上下文环境
     * 
     * @param applicationContext applicationContext
     * @throws BeansException 异常
     */
    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        SpringContextUtil.applicationContext = applicationContext;
    }

    public static ApplicationContext getApplicationContext() {
        return applicationContext;
    }

    /**
     * 
     * <p>
     * Description: 取得bean实例
     * </p>
     * 
     * @param name bean名称
     * @return bean实例
     * @throws BeansException 异常
     */
    public static Object getBean(String name) throws BeansException {
        return applicationContext.getBean(name);
    }

    /**
     * <p>
     * Description: 按照某个类型取得bean
     * </p>
     * 
     * @param name bean名称
     * @param requiredType 类型
     * @return bean实例
     * @throws BeansException 异常
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public static Object getBean(String name, Class requiredType) throws BeansException {
        return applicationContext.getBean(name, requiredType);
    }

    /**
     * <p>
     * Description: 是否包含某个bean
     * </p>
     * 
     * @param name bean名称
     * @return true or false
     */
    public static boolean containsBean(String name) {
        return applicationContext.containsBean(name);
    }

    /**
     * <p>
     * Description: bean是否是单例
     * </p>
     * 
     * @param name bean名称
     * @return true or false
     * @throws NoSuchBeanDefinitionException 查不到bean异常
     */
    public static boolean isSingleton(String name) throws NoSuchBeanDefinitionException {
        return applicationContext.isSingleton(name);
    }

    /**
     * <p>
     * Description: 取得bean的类型
     * </p>
     * 
     * @param name bean名称
     * @return 类型
     * @throws NoSuchBeanDefinitionException 查不到bean异常
     */
    @SuppressWarnings("rawtypes")
    public static Class getType(String name) throws NoSuchBeanDefinitionException {
        return applicationContext.getType(name);
    }

    /**
     * <p>
     * Description: 获取bean的别名数组
     * </p>
     * 
     * @param name bean名称
     * @return 别名
     * @throws NoSuchBeanDefinitionException 查不到bean异常
     */
    public static String[] getAliases(String name) throws NoSuchBeanDefinitionException {
        return applicationContext.getAliases(name);
    }
}
