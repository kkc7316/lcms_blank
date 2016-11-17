/**
 * SysDict.java
 * Created at 2015-09-23
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.dict.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.svw.lcms.framework.domain.BaseModel;

/**
 * 
 * <p>
 * ClassName: SysDict
 * </p>
 * <p>
 * Description: 子字典实体
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-9-25
 * </p>
 */
@Entity
@Table(name = "TS_DICT_DETAIL")
public class SysDict extends BaseModel {

    /**
     * <p>
     * Field serialVersionUID: 序列化
     * </p>
     */
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @Id
    @Column(name = "PK_ID", columnDefinition = "number(19)")
    @GeneratedValue(generator = "seq", strategy = GenerationType.SEQUENCE)
    @SequenceGenerator(name = "seq", sequenceName = "SEQ_TS_DICT_DETAIL", allocationSize = 1)
    private Long id;
    /**
     * 字典key
     */
    @Column(name = "DICT_KEY", length = 50)
    private String dictKey;

    /**
     * 字典显示值
     */
    @Column(name = "DICT_VALUE", length = 100)
    private String dictValue;

    /**
     * 父类key
     */
    @Column(name = "PARENT_KEY")
    private String parentKey;

    /**
     * 是否系统配置
     */
    @Column(name = "IS_SYSTEM_CONFIG")
    private String isSysConfig;
    
    /**
     * 排序字段
     */
    @Column(name = "ORDER_NUM")
    private Long orderNum;

    /**
     * <p>
     * Description: 默认的构造函数
     * </p>
     */
    public SysDict() {
    }

    /**
     * <p>
     * Description: 构造函数
     * </p>
     * 
     * @param dictKey 字典Key
     * @param dictValue 字典值
     */
    public SysDict(String dictKey, String dictValue) {
        this.setDictKey(dictKey);
        this.setDictValue(dictValue);
    }

    public String getDictKey() {
        return this.dictKey;
    }

    public void setDictKey(String dictKey) {
        this.dictKey = dictKey;
    }

    public String getDictValue() {
        return this.dictValue;
    }

    public void setDictValue(String dictValue) {
        this.dictValue = dictValue;
    }

    public String getParentKey() {
        return this.parentKey;
    }

    public void setParentKey(String parentKey) {
        this.parentKey = parentKey;
    }

    public String getIsSysConfig() {
        return this.isSysConfig;
    }

    public void setIsSysConfig(String isSysConfig) {
        this.isSysConfig = isSysConfig;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getOrderNum() {
        return this.orderNum;
    }

    public void setOrderNum(Long orderNum) {
        this.orderNum = orderNum;
    }

}
