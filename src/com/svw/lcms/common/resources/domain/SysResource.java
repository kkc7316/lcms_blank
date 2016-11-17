/**
 * SysResouce.java
 * Created at 2015-09-23
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.resources.domain;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.svw.lcms.framework.domain.BaseModel;

/**
 * 
 * <p>
 * ClassName: SysResouce
 * </p>
 * <p>
 * Description: 资源实体
 * </p>
 * <p>
 * Author: pagnfeng
 * </p>
 * <p>
 * Date: 2015-9-25
 * </p>
 */
@Entity
@Table(name = "TS_RESOURCE")
public class SysResource extends BaseModel {

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
    @SequenceGenerator(name = "seq", sequenceName = "SEQ_TS_RESOURCE", allocationSize = 1)
    private Long id;
    /**
     * 资源名称
     */
    @Column(name = "RESOURCE_NAME")
    private String resourceName = null;
    /**
     * 资源代码
     */
    @Column(name = "RESOURCE_CODE")
    private String resourceCode = null;
    /**
     * 资源类型
     */
    @Column(name = "RESOURCE_TYPE")
    private String resourceType = null;

    /**
     * 上级资源
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PARENT_ID", referencedColumnName = "PK_ID")
    private SysResource parentResource;

    /**
     * 下级资源列表
     */
    @OneToMany(mappedBy = "parentResource", cascade = { CascadeType.REMOVE }, fetch = FetchType.LAZY)
    private Set<SysResource> children;

    public String getResourceName() {
        return this.resourceName;
    }

    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }

    public String getResourceCode() {
        return this.resourceCode;
    }

    public void setResourceCode(String resourceCode) {
        this.resourceCode = resourceCode;
    }

    public String getResourceType() {
        return this.resourceType;
    }

    public void setResourceType(String resourceType) {
        this.resourceType = resourceType;
    }

    public SysResource getParentResource() {
        return this.parentResource;
    }

    public void setParentResource(SysResource parentResource) {
        this.parentResource = parentResource;
    }

    public Set<SysResource> getChildren() {
        return this.children;
    }

    public void setChildren(Set<SysResource> children) {
        this.children = children;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

}
