/**
 * IdictDao.java
 * Created at 2015-10-22
 * Created by Administrator
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.dict.dao;

import java.util.List;
import java.util.Map;

import com.svw.lcms.common.dict.domain.SysDict;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>
 * ClassName: IDictDao
 * </p>
 * <p>
 * Description: 字典Dao
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-10-22
 * </p>
 */
public interface IDictDao {
    /**
     * 
     * <p>
     * Description: dictIdx列表查询
     * </p>
     * 
     * @param pageInfo 分页
     * @param map 条件
     * @return 结果
     */
    public List<SysDict> findAllDictList(PageInfo pageInfo, Map<String, Object> map);


    /**
     * 
     * <p>Description: 根据字典key查询所有字典值，包括被删除的字典值</p>
     * @param key 字典key值
     * @return 字典list
     */
    public List<SysDict> findAllDictListByParentKey(String parentKey);
    
    /**
     * <p>
     * Description: 根据父字典key和子字典key，获得字典
     * </p>
     * 
     * @param dictKey 子字典key值
     * @param parentKey 父字典key值
     * @return SysDict
     */
    public SysDict findDictByDictKeyAndParentKey(String dictKey, String parentKey);
    
    /**
     * 
     * <p>
     * Description: 验证在Parentkey的情况下有没有相同的Value存在
     * </p>
     * 
     * @param parentKey parentKey
     * @param value 待验证的value
     * @return 结果集
     */
    public List<SysDict> findDictByDictValueAndParentKey(String value, String parentKey);


    
   

    /**
     * <p>
     * Description: 根据 子字典key，获得字典值
     * </p>
     * 
     * @param dictKey 子字典key值
     * @return string
     */
    public  List<String> findDictValueByDictKey(String dictKey);

    /**
     * <p>
     * Description: 根据父字典key和子字典key，获得字典值
     * </p>
     * 
     * @param dictKey 子字典key值
     * @param parentKey 父字典key值
     * @return dictValue
     */
    public String findDictValueByDictKeyAndParentKey(String dictKey, String parentKey);



    
}
