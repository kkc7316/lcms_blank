/**
 * SysRole.java
 * Created at 2015-09-23
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.role.domain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.svw.lcms.common.resources.domain.SysResource;
import com.svw.lcms.framework.domain.BaseModel;

/**
 * 
 * <p>
 * ClassName: SysRole
 * </p>
 * <p>
 * Description: 角色实体
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-9-25
 * </p>
 */
@Entity
@Table(name = "TS_ROLE")
@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler", "sysResources" })
public class SysRole extends BaseModel {

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
    @SequenceGenerator(name = "seq", sequenceName = "SEQ_TS_ROLE", allocationSize = 1)
    private Long id;
    /**
     * 角色名称
     */
    @Column(name = "ROLE_NAME")
    private String roleName;
    /**
     * 角色代码
     */
    @Column(name = "ROLE_CODE")
    private String roleCode;
    /**
     * 角色描述
     */
    @Column(name = "ROLE_DESC")
    private String roleDesc;

    /**
     * 资源名
     */
    @Transient
    private String resourcesName;

    /**
     * 角色资源信息
     */
    @LazyCollection(LazyCollectionOption.FALSE)
    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "TR_ROLE_RESOURCES", joinColumns = { @JoinColumn(name = "ROLE_ID", referencedColumnName = "PK_ID") }, inverseJoinColumns = { @JoinColumn(name = "RESOURCE_ID", referencedColumnName = "PK_ID") })
    private List<SysResource> sysResources = new ArrayList<SysResource>();

    public String getRoleName() {
        return this.roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public List<SysResource> getSysResources() {
        return this.sysResources;
    }

    public void setSysResources(List<SysResource> sysResources) {
        this.sysResources = sysResources;
    }

    public String getRoleCode() {
        return this.roleCode;
    }

    public void setRoleCode(String roleCode) {
        this.roleCode = roleCode;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getResourcesName() {
        return this.resourcesName;
    }

    public void setResourcesName(String resourcesName) {
        this.resourcesName = resourcesName;
    }

    public String getRoleDesc() {
        return this.roleDesc;
    }

    public void setRoleDesc(String roleDesc) {
        this.roleDesc = roleDesc;
    }

}
