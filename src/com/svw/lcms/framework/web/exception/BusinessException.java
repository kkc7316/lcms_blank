/**
 * BusinessException.java
 * Created at 2016-01-15
 * Created by mazan
 * Copyright (C) 2016 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.framework.web.exception;

/**
 * 
 * <p>
 * ClassName: BusinessException
 * </p>
 * <p>
 * Description: 系统业务异常 
 * 1.返回到前台页面的异常，必须进行转义
 * 2.业务异常日志要能带很好的异常信息，方便维护
 * 3.异常国际化
 * eg:收发时，并发问题/数据异常/接口异常...
 * 
 * </p>
 * <p>
 * Author: Administrator
 * </p>
 * <p>
 * Date: 2016-1-18
 * </p>
 */
public class BusinessException extends RuntimeException {

    /**
     * serialVersionUID
     */
    private static final long serialVersionUID = 2332608236621015980L;
    /**
     * code
     */
    private String code;

    /**
     * <p>
     * Description: 默认异常
     * </p>
     */
    public BusinessException() {
        super();
    }

    /**
     * <p>
     * Description: BusinessException
     * </p>
     * 
     * @param message 异常消息
     */
    public BusinessException(String message) {
        super(message);
    }

    /**
     * <p>
     * Description: BusinessException
     * </p>
     * 
     * @param code code
     * @param message 异常消息
     */
    public BusinessException(String code, String message) {
        super(message);
        this.code = code;
    }

    /**
     * <p>
     * Description: BusinessException
     * </p>
     * 
     * @param cause ex
     */
    public BusinessException(Throwable cause) {
        super(cause);
    }

    /**
     * <p>
     * Description: BusinessException
     * </p>
     * 
     * @param message 异常消息
     * @param cause ex
     */
    public BusinessException(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     * <p>
     * Description: BusinessException
     * </p>
     * 
     * @param code code
     * @param message 异常消息
     * @param cause ex
     */
    public BusinessException(String code, String message, Throwable cause) {
        super(message, cause);
        this.code = code;
    }

    public String getCode() {
        return this.code;
    }

    public void setCode(String code) {
        this.code = code;
    }

}
