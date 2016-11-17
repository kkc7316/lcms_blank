/**
 * ReflactUtil.java
 * Created at 2016-01-28
 * Created by mazan
 * Copyright (C) 2016 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.utils;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import org.apache.commons.lang.StringUtils;

/**
 * <p>
 * ClassName: ReflactUtil
 * </p>
 * <p>
 * Description: 反射工具类
 * </p>
 * <p>
 * Author: Administrator
 * </p>
 * <p>
 * Date: 2016-1-28
 * </p>
 */
public class ReflactUtil {

    /**
     * 检查字段字符串是不是包含空格
     * 
     * @param fieldString fieldString
     */
    private static void checkFormat(String fieldString) {
        if (StringUtils.isBlank(fieldString)) {
            throw new RuntimeException("fieldString can't be empty");
        }
    }

    /**
     * 将字符串第一个字符变成大写
     * 
     * @param fieldString fieldString
     * @return str
     */
    public static String firstUpperCase(String fieldString) {
        checkFormat(fieldString);
        return Character.toUpperCase(fieldString.charAt(0)) + fieldString.substring(1);
    }

    /**
     * 根据属性获得set方法名
     * 
     * @param fieldString fieldString
     * @return str
     */
    public static String getSetterOfField(String fieldString) {
        return "set" + firstUpperCase(fieldString);
    }

    /**
     * 根据属性获得get方法名
     * 
     * @param fieldString fieldString
     * @return str
     */
    public static String getGetterOfField(String fieldString) {
        return "get" + firstUpperCase(fieldString);
    }

    /**
     * 根据一个OGNL表达式获取某对象属性的类型"user.contact.email"
     * 
     * @param object obj
     * @param expression exp
     * @return clz
     */
    public static Class<?> getPropertyTypeByOgnlExpression(Object object, String expression) {
        if (StringUtils.isBlank(expression) || object == null) {
            throw new IllegalArgumentException("expression or object cannot be null");
        }
        try {
            String[] tokens;
            tokens = expression.split("\\.");

            Field field = null;
            Class<?> clz = object.getClass();
            for (int i = 0; i < tokens.length; i++) {
                String token;
                token = tokens[i];
                field = clz.getDeclaredField(token);
                clz = field.getType();
            }

            return clz;
        } catch (NoSuchFieldException e) {
            throw new RuntimeException("illegal ognl expression: " + expression, e);
        }
    }

    /**
     * 
     * <p>
     * Description: 通过属性名获取属性值
     * </p>
     * 
     * @param owner 对象实例
     * @param fieldName 对象属性名
     * @return obj
     */
    public static Object getFieldValueByFildName(Object owner, String fieldName) {
        Class<?> ownerClass;
        ownerClass = owner.getClass();
        //m
        String fieldGetter;
        fieldGetter = getGetterOfField(fieldName);

        Method method = null;

        Object fieldValue = null;

        try {
            method = ownerClass.getMethod(fieldGetter);
        } catch (SecurityException e) {
            throw new RuntimeException(e);
        } catch (NoSuchMethodException e) {
            throw new RuntimeException(" can't find '" + fieldGetter + "' method", e);
        }
        try {
            fieldValue = method.invoke(owner);

        } catch (IllegalArgumentException e) {
            throw new RuntimeException(e);
        } catch (IllegalAccessException e) {
            throw new RuntimeException(e);
        } catch (InvocationTargetException e) {
            throw new RuntimeException(e);
        }

        return fieldValue;
    }
    
    

}
