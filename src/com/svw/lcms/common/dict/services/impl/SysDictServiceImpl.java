/**
 * DictServiceImpl.java
 * Created at 2015-10-22
 * Created by Administrator
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.dict.services.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.svw.lcms.common.base.services.impl.EntityServiceImpl;
import com.svw.lcms.common.dict.dao.IDictDao;
import com.svw.lcms.common.dict.domain.SysDict;
import com.svw.lcms.common.dict.services.IDictService;
import com.svw.lcms.common.user.domain.SysUser;
import com.svw.lcms.framework.web.exception.BusinessException;
import com.svw.lcms.framework.web.page.PageInfo;
import com.svw.lcms.utils.StrUtil;

/**
 * <p>
 * ClassName: DictServiceImpl
 * </p>
 * <p>
 * Description: 字典ServiceImpl
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-10-22
 * </p>
 */
@Service("dictService")
public class SysDictServiceImpl extends EntityServiceImpl<SysDict> implements IDictService {
    /**
     * dictDao
     */
    @Autowired
    @Qualifier("dictDao")
    private IDictDao dictDao;

    /**
     * 
     * <p>
     * Description: 字典列表记录查询
     * </p>
     * 
     * @param page 分页
     * @param map 参数
     * @return 结果集
     */
    @Override
    public List<SysDict> findAllDictList(PageInfo page, Map<String, Object> map) {
        return this.dictDao.findAllDictList(page, map);
    }

    /**
     * 
     * <p>Description: 根据字典key 进行查询字典子表中所以字典值，包括被删除的字典值</p>
     * @param key 字典key值
     * @return 字典list
     */
    @Override
    public List<SysDict> findAllDictListByParentKey(String parentKey) {
        return this.dictDao.findAllDictListByParentKey(parentKey);
    }



    /**
     * 
     * <p>
     * Description: 验证key
     * </p>
     * 
     * @param key 字典key
     * @param strKey 待查询的key
     * @param dictValue dictValue
     * @return 结果集
     */
    @Override
    public String validitionDict(String dictKey, String parentKey, String dictValue) {
        //验证字典key
        SysDict sysdict;
        sysdict = this.dictDao.findDictByDictKeyAndParentKey(dictKey, parentKey);
        if (null != sysdict) {
            if (IS_DEL.equals(sysdict.getDelFlag())) {
                return "字典key为" + dictKey + "的字典值已被删除<br/>请手动恢复该记录";
            } else {
                return "字典key为" + dictKey + "的值已经存在<br/>请重新填写";
            }
        }
        
        //验证字典value
        List<SysDict> listName;
        listName = this.dictDao.findDictByDictValueAndParentKey(dictValue, parentKey);
   
        if (null != listName && !listName.isEmpty()) {
            return "字典value为" + dictValue + "的值已经存在<br/>请重新填写";
        }

        return "true";
    }

    /**
     * 
     * <p>
     * Description: 执行保存函数
     * </p>
     * 
     * @param model 字典model
     * @param user 当前用户
     * @return 结果集
     */
    @Override
    public void saveOrUpdateDict(SysDict model, SysUser user) {
        
        if (model.getId() == null) {
            //则为新增
            model.setId(null);
            this.preCreate(model, user);
        } else {
            //则为修改
            SysDict dict;
            dict = this.getById(model.getId());
            dict.setDictValue(model.getDictValue());
            dict.setOrderNum(model.getOrderNum());
            if (model.getDictKey() != null) {
                dict.setDictKey(model.getDictKey());
            }
            if (null != model.getRemark()) {
                dict.setRemark(model.getRemark());
            }
            model = dict;
            this.preUpdate(model, user);
        }
        this.saveOrUpdate(model);
    }



    /**
     * <p>
     * Description: 字典真删除
     * </p>
     * 
     * @param ids 主键id
     */
    @Override
    @Transactional
    public void deleteDict(String ids) {
        String[] id;
        id = ids.split(",");
        Long[] ints;
        ints = new Long[id.length];
        for (int i = 0; i < id.length; i++) {
            ints[i] = Long.parseLong(id[i]);
        }
        for (Long str : ints) {
            this.deleteById(str);
        }
    }

    /**
     * <p>
     * Description: 字典值逻辑删除
     * </p>
     * 
     * @param ids 主键id
     * @param user user
     */
    @Override
    public void doDeleteDict(String ids, SysUser user) {
        
        String[] idz;
        idz = ids.split(COMMA);
        this.deleteByDelFlag(idz, user);
    }

    /**
     * <p>
     * Description: 字典值恢复
     * </p>
     * 
     * @param ids 主键id
     * @param user user
     */
    @Override
    @Transactional
    public void doRecoverConfirm(String ids, SysUser user) {
        String[] idz;
        idz = ids.split(COMMA);
        for (String id : idz) {
            SysDict sysDict = this.getById(Long.valueOf(id));
            sysDict.setDelFlag("0");
            this.preUpdate(sysDict, user);
            
            this.update(sysDict);
        }
    }


    /**
     * <p>
     * Description: 根据父字典key和子字典key，获得字典值
     * </p>
     * 
     * @param dictKey 子字典key值
     * @param parentKey 父字典key值
     * @throws BusinessException 异常
     * @return string
     */
    @Override
    public String findDictValueByDictKeyAndParentKey(String dictKey, String parentKey) throws BusinessException {

        return this.dictDao.findDictValueByDictKeyAndParentKey(dictKey, parentKey);
    }

    /**
     * <p>
     * Description: 根据父字典key和子字典key，获得字典记录
     * </p>
     * 
     * @param dictKey 子字典key值
     * @param parentKey 父字典key值
     * @return SysDict
     */
    @Override
    public SysDict findDictByDictKeyAndParentKey(String dictKey, String parentKey) {
        return this.dictDao.findDictByDictKeyAndParentKey(dictKey, parentKey);
    }

    /**
     * <p>
     * Description: 根据 子字典key，获得字典值
     * </p>
     * 
     * @param dictKey 子字典key值
     * @return string
     */
    @Override
    public List<String> findDictValueByDictKey(String dictKey) {
        return this.dictDao.findDictValueByDictKey(dictKey);
    }

}
