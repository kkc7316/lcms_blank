/**
 * BaseModel.java
 * Created at 2015-09-23
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.framework.domain;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 所有model的基类
 * 
 * @author pangfeng 2015-9-25
 */
@MappedSuperclass
public class BaseModel implements Serializable {
    /**
     * <p>
     * Field serialVersionUID: 版本id
     * </p>
     */
    private static final long serialVersionUID = 1L;

    //    /**
    //     * 数据模型的唯一标识 采用序列方式生成主键 generator 值随便写和GenericGenerator中的name对应 vative
    //     * 根基实际数据库采用不同策略，oracle则使用序列，sqlserver使用自增张方式 .数据模型的唯一标识
    //     */
    //    @Id
    //    @Column(name = "PK_ID", columnDefinition = "char(32)")
    //    @GeneratedValue(generator = "huuid")
    //    @GenericGenerator(name = "huuid", strategy = "uuid")
    //    private String id;

    /**
     * 备注
     */
    @Column(name = "REMARK", length = 4000)
    private String remark = null;
    /**
     * 删除标记
     */
    @Column(name = "DEL_FLAG")
    private String delFlag = null;
    /**
     * 创建人
     */
    @Column(name = "CREATE_USER")
    private String createUser = null;

    /**
     * 创建时间
     */
    @Column(name = "CREATE_DATE", updatable = false)
    private Date createDate = null;

    /**
     * 更新人
     */
    @Column(name = "UPDATE_USER")
    private String updateUser = null;

    /**
     * 更新时间
     */
    @Column(name = "UPDATE_DATE")
    private Date updateDate = null;

    public String getRemark() {
        return this.remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getDelFlag() {
        return this.delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag;
    }

    public String getCreateUser() {
        return this.createUser;
    }

    public void setCreateUser(String createUser) {
        this.createUser = createUser;
    }

    public Date getCreateDate() {
        return this.createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getUpdateUser() {
        return this.updateUser;
    }

    public void setUpdateUser(String updateUser) {
        this.updateUser = updateUser;
    }

    public Date getUpdateDate() {
        return this.updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    /**
     * 
     * <p>
     * Description: 创建时间格式化输出
     * </p>
     * 
     * @return 格式化输出时间
     */
    public String getCreateDateStr() {
        if (getCreateDate() != null) {
            return new SimpleDateFormat("dd/MM/yyyy").format(getCreateDate());
        } else {
            return "";
        }
    }

    /**
     * toString方法
     * 
     * @return 对象的序列化结果
     */
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
    }

}
