/**
 * SysUser.java
 * Created at 2015-09-23
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.user.domain;

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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.svw.lcms.common.role.domain.SysRole;
import com.svw.lcms.framework.domain.BaseModel;

/**
 * 
 * <p>
 * ClassName: SysUser
 * </p>
 * <p>
 * Description: 用户实体
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-9-25
 * </p>
 */
@Entity
@Table(name = "TS_USER")
@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler", "sysRoles", "sysDepts" })
public class SysUser extends BaseModel {
    /**
     * <p>
     * Field serialVersionUID: 序列号
     * </p>
     */
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @Id
    @Column(name = "PK_ID", columnDefinition = "number(19)")
    @GeneratedValue(generator = "seq", strategy = GenerationType.SEQUENCE)
    @SequenceGenerator(name = "seq", sequenceName = "SEQ_TS_USER", allocationSize = 1)
    private Long id;
    /**
     * 用户工号
     */
    @Column(name = "EMPLOYEE_NUM")
    private String employeeNum;

    /**
     * 用户名称
     */
    @Column(name = "EMPLOYEE_NAME")
    private String employeeName;

    /**
     * 是否供应商
     */
    @Column(name = "IS_SUPPLIER")
    private String isSupplier;

    /**
     * SVW供应商编号
     */
    @Column(name = "SVW_CODE")
    private String svwCode;

    /**
     * 用户邮箱
     */
    @Column(name = "EMPLOYEE_EMAIL")
    private String employeeEmail;

    /**
     * 部门
     */
    @Column(name = "DEPT")
    private String dept;

    /**
     * 更新日期转字符串 临时字段勿用
     */
    @Transient
    private String updateStringDate;

    /**
     * joinColumns jointable为本类的关联字段，inverseJoinColumns 为被关联对象的关联字段 用户角色
     */
    @LazyCollection(LazyCollectionOption.FALSE)
    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "TR_USER_ROLES", joinColumns = { @JoinColumn(name = "USER_ID", referencedColumnName = "PK_ID") }, inverseJoinColumns = { @JoinColumn(name = "ROLE_ID", referencedColumnName = "PK_ID") })
    private List<SysRole> sysRoles = new ArrayList<SysRole>();


    public String getEmployeeNum() {
        return this.employeeNum;
    }

    public void setEmployeeNum(String employeeNum) {
        this.employeeNum = employeeNum;
    }

    public String getEmployeeEmail() {
        return this.employeeEmail;
    }

    public void setEmployeeEmail(String employeeEmail) {
        this.employeeEmail = employeeEmail;
    }

    @JsonIgnore
    public List<SysRole> getSysRoles() {
        return this.sysRoles;
    }

    public void setSysRoles(List<SysRole> sysRoles) {
        this.sysRoles = sysRoles;
    }


    /**
     * 
     * <p>
     * Description: 用户所有角色
     * </p>
     * 
     * @return UerRoles
     */
    public String getUerRoles() {
        StringBuffer buff;
        buff = new StringBuffer("");
        String str = "";
        if (getSysRoles() != null && getSysRoles().size() > 0) {
            for (SysRole role : getSysRoles()) {
                buff.append(role.getRoleName());
                buff.append(",");
            }
            str = buff.toString();
            return str.substring(0, str.length() - 1);
        } else {
            return str;
        }
    }


    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmployeeName() {
        return this.employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public String getIsSupplier() {
        return this.isSupplier;
    }

    public void setIsSupplier(String isSupplier) {
        this.isSupplier = isSupplier;
    }

    public String getSvwCode() {
        return this.svwCode;
    }

    public void setSvwCode(String svwCode) {
        this.svwCode = svwCode;
    }

    public String getDept() {
        return this.dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public String getUpdateStringDate() {
        return this.updateStringDate;
    }

    public void setUpdateStringDate(String updateStringDate) {
        this.updateStringDate = updateStringDate;
    }

}
