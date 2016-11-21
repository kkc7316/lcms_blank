/**
 * IdictDao.java
 * Created at 2015-10-22
 * Created by Administrator
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.dict.services;

import java.util.List;
import java.util.Map;

import com.svw.lcms.common.base.services.IEntityService;
import com.svw.lcms.common.dict.domain.SysDict;
import com.svw.lcms.common.user.domain.SysUser;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>
 * ClassName: IDictDao
 * </p>
 * <p>
 * Description: 字典Service
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-10-22
 * </p>
 */
public interface IDictService extends IEntityService<SysDict> {

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
    public List<SysDict> findAllDictList(PageInfo page, Map<String, Object> map);




    /**
     * 
     * <p>Description: 根据字典key 进行查询字典子表中所以字典值，包括被删除的字典值</p>
     * @param key 字典key值
     * @return 字典list
     */
    public List<SysDict> findAllDictListByParentKey(String parentKey);

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
    public void saveOrUpdateDict(SysDict model, SysUser user);
    /**
     * 
     * <p>
     * Description: 验证key
     * </p>
     * 
     * @param key 字典key
     * @param strKey 待查询的key
     * @param dictValue 待查询的dictValue
     * @return 结果集
     */
    public String validitionDict(String key, String strKey, String dictValue);
    


    /**
     * <p>
     * Description: 字典值逻辑删除
     * </p>
     * 
     * @param dictIds 主键id 
     * @param user user
     */
    public void doDeleteDict(String dictIds, SysUser user);
    
    /**
     * <p>
     * Description: 字典值恢复
     * </p>
     * 
     * @param dictIds 主键id
     *  @param user user
     */
    public void doRecoverConfirm(String dictIds, SysUser user);
    
    /**
     * <p>
     * Description: 字典值物理删除
     * </p>
     * 
     * @param dictIds 主键id
     */
    public void deleteDict(String dictIds);


    /**
     * <p>
     * Description: 根据父字典key和子字典key，获得字典值
     * </p>
     * 
     * @param dictKey 子字典key值
     * @param parentKey 父字典key值
     * @return string
     */
    public String findDictValueByDictKeyAndParentKey(String dictKey, String parentKey);

    /**
     * <p>
     * Description: 根据父字典key和子字典key，获得字典记录
     * </p>
     * 
     * @param dictKey 子字典key值
     * @param parentKey 父字典key值
     * @return string
     */
    public SysDict findDictByDictKeyAndParentKey(String dictKey, String parentKey);

    /**
     * <p>
     * Description: 根据 子字典key，获得字典值
     * </p>
     * 
     * @param dictKey 子字典key值
     * @return string
     */
    public List<String> findDictValueByDictKey(String dictKey);


}
