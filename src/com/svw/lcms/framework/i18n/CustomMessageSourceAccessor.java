/**
 * CustomMessageSourceAccessor.java
 * Created at 2015-10-13
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.framework.i18n;

import java.util.Locale;

import org.springframework.context.MessageSource;
import org.springframework.context.support.MessageSourceAccessor;

/**
 * 
 * <p>
 * ClassName: CustomMessageSource
 * </p>
 * <p>
 * Description: 消息处理类
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-10-23
 * </p>
 */
public class CustomMessageSourceAccessor extends MessageSourceAccessor {
    /**
     * 
     * <p>
     * Description: construct
     * </p>
     * 
     * @param messageSource messageSource
     */
    public CustomMessageSourceAccessor(MessageSource messageSource) {
        super(messageSource);
    }

    /**
     * 
     * <p>
     * Description: construct
     * </p>
     * 
     * @param messageSource messageSource
     * @param defaultLocale defaultLocale
     */
    public CustomMessageSourceAccessor(MessageSource messageSource, Locale defaultLocale) {
        super(messageSource, defaultLocale);
    }

    /**
     * 
     * <p>
     * Description: 消息获取
     * </p>
     * 
     * @param code code
     * @return 消息
     */
    public String getMessageWithCode(String code) {
        return "[" + code + "]" + getMessage(code);
    }

    /**
     * 
     * <p>
     * Description: 消息获取
     * </p>
     * 
     * @param code code
     * @param args args
     * @return 消息
     */
    public String getMessageWithCode(String code, Object[] args) {
        return "[" + code + "]" + getMessage(code, args);
    }
}
