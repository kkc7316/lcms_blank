/**
 * IdictIdxDao.java
 * Created at 2015-10-22
 * Created by Administrator
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.dict.dao;

import java.util.List;
import java.util.Map;

import com.svw.lcms.common.dict.domain.SysDictIdx;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>
 * ClassName: IDictIdxDao 主表
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
public interface IDictIdxDao {
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
    public List<SysDictIdx> findAllDictIdxList(PageInfo pageInfo, Map<String, Object> map);

    /**
     * 
     * <p>
     * Description: 获取字典信息
     * </p>
     * 
     * @param key key
     * @return dictIdx
     */
    public SysDictIdx findDictIdxByKey(String key);

    /**
     * 
     * <p>
     * Description: 根据Id查询字典
     * </p>
     * 
     * @param id 字典id
     * @return 字典对象
     */
    public SysDictIdx findDictIdxById(Long id);
    
}
