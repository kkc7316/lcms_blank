/**
 * CustomMessageSource.java
 * Created at 2015-10-13
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.framework.i18n;

import org.springframework.context.MessageSource;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;

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
public class CustomMessageSource extends ReloadableResourceBundleMessageSource {
    /**
     * 
     */
    private static MessageSource messageSource = new CustomMessageSource();

    /**
     * 
     * <p>
     * Description: construct
     * </p>
     */
    private CustomMessageSource() {
        this.setBasename("internationalization/messages");
    }

    /**
     * 
     * <p>
     * Description: construct
     * </p>
     * 
     * @param messageSource messageSource
     */
    @SuppressWarnings("static-access")
    public CustomMessageSource(MessageSource messageSource) {
        this.messageSource = messageSource;
    }

    public static CustomMessageSourceAccessor getAccessor() {
        return new CustomMessageSourceAccessor(messageSource);
    }
}
