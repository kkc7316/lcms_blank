/**
 * SysDictIdx.java
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
 * <p>
 * ClassName: DictIdx
 * </p>
 * <p>
 * Description: 父字典实体
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-9-25
 * </p>
 */
@Entity
@Table(name = "TS_DICT")
public class SysDictIdx extends BaseModel implements java.io.Serializable {

    /**
     * 序列号
     */
    private static final long serialVersionUID = 7530202458836884341L;
    /**
     * 主键
     */
    @Id
    @Column(name = "PK_ID", columnDefinition = "number(19)")
    @GeneratedValue(generator = "seq", strategy = GenerationType.SEQUENCE)
    @SequenceGenerator(name = "seq", sequenceName = "SEQ_TS_DICT", allocationSize = 1)
    private Long id;
    /**
     * 字典key
     */
    @Column(name = "DICT_KEY", length = 50)
    private String dictKey;

    /**
     * 字典名称
     */
    @Column(name = "DICT_NAME", length = 100)
    private String dictName;
    
    /**
     * 是否系统配置 add by chenping  20160711 
     */
    @Column(name = "IS_SYSTEM_CONFIG")
    private String isSystemConfig;
    /**
     * 字典值清单
     */
    /*
     * @OneToMany(fetch = FetchType.LAZY) private List<SysDict> subDicts = new
     * ArrayList<SysDict>();
     */
    // Constructors

    /**
     * <p>
     * Description: 默认的构造函数
     * </p>
     */
    public SysDictIdx() {
    }

    /**
     * <p>
     * Description: 根据键构造一个字典索引类
     * </p>
     * 
     * @param dictKey 键
     */
    public SysDictIdx(String dictKey) {
        this.dictKey = dictKey;
    }

    public String getDictKey() {
        return this.dictKey;
    }

    public void setDictKey(String dictKey) {
        this.dictKey = dictKey;
    }

    public String getDictName() {
        return this.dictName;
    }

    public void setDictName(String dictName) {
        this.dictName = dictName;
    }

    /*
     * public List<SysDict> getSubDicts() { return this.subDicts; } public void
     * setSubDicts(List<SysDict> subDicts) { this.subDicts = subDicts; }
     */

    public String getIsSystemConfig() {
        return this.isSystemConfig;
    }

    public void setIsSystemConfig(String isSystemConfig) {
        this.isSystemConfig = isSystemConfig;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

}
