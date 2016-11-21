/**
 * IdictIdxService.java
 * Created at 2015-10-22
 * Created by Administrator
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.dict.services;

import java.util.List;
import java.util.Map;

import com.svw.lcms.common.base.services.IEntityService;
import com.svw.lcms.common.dict.domain.SysDictIdx;
import com.svw.lcms.common.user.domain.SysUser;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>
 * ClassName: IDictIdxService
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
public interface IDictIdxService extends IEntityService<SysDictIdx> {

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
    public List<SysDictIdx> findAllDictIdxList(PageInfo page, Map<String, Object> map);


    /**
     * 
     * <p>
     * Description: 获取字典信息
     * </p>
     * 
     * @param key key关键词
     * @return dictIdx字典
     */
    public SysDictIdx findDictIdxByKey(String key);
    
    /**
     * 
     * <p>
     * Description: 获取字典信息
     * </p>
     * 
     * @param key key关键词
     * @return dictIdx字典
     */
    public SysDictIdx findDictIdxById(Long key);

    /**
     * 
     * <p>
     * Description: 删除字典及子字典
     * </p>
     * 
     * @param ids 主键
     */
    public void deleteDictIdx(String ids);



    /**
     * 
     * <p>
     * Description: 字典新增或修改
     * </p>
     * 
     * @param model model对象
     * @param user 操作人员对象
     * @return 布尔值
     * */
    public void saveOrUpdateDictIdx(SysDictIdx model, SysUser user);
    
    /**
     * 
     * <p>
     * Description: 验证key
     * </p>
     * 
     * @param dictName 字典dictName
     * @return 结果集
     */
    public boolean validitionDictName(String dictName);
}
