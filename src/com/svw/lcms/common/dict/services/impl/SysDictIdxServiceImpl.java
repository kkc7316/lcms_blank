/**
 * DictIdxServiceImpl.java
 * Created at 2015-10-22
 * Created by Administrator
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.dict.services.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.svw.lcms.common.base.services.impl.EntityServiceImpl;
import com.svw.lcms.common.dict.dao.IDictIdxDao;
import com.svw.lcms.common.dict.domain.SysDictIdx;
import com.svw.lcms.common.dict.services.IDictIdxService;
import com.svw.lcms.common.user.domain.SysUser;
import com.svw.lcms.framework.i18n.CustomMessageSource;
import com.svw.lcms.framework.i18n.CustomMessageSourceAccessor;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>
 * ClassName: DictIdxServiceImpl
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
@Service("dictIdxService")
public class SysDictIdxServiceImpl extends EntityServiceImpl<SysDictIdx> implements IDictIdxService {

    /**
     * 国际化消息处理
     */
    protected CustomMessageSourceAccessor messages = CustomMessageSource.getAccessor();

    /**
     * dictIdxService
     */
    @Autowired
    @Qualifier("dictIdxDao")
    private IDictIdxDao dictIdxDao;

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
    public List<SysDictIdx> findAllDictIdxList(PageInfo page, Map<String, Object> map) {
        return this.dictIdxDao.findAllDictIdxList(page, map);
    }


    /**
     * 
     * <p>
     * Description: 获取字典信息
     * </p>
     * 
     * @param key key关键词
     * @return dictIdx字典
     */
    @Override
    public SysDictIdx findDictIdxByKey(String key) {
        return this.dictIdxDao.findDictIdxByKey(key);
    }

    /**
     * 
     * <p>
     * Description: 获取字典信息
     * </p>
     * 
     * @param id id关键词
     * @return SysDictIdx 字典
     */
    public SysDictIdx findDictIdxById(Long id) {
        return this.dictIdxDao.findDictIdxById(id);
    }

    /**
     * 
     * <p>
     * Description: 删除字典及子字典
     * </p>
     * 
     * @param ids 主键
     */
    @Override
    @Transactional
    public void deleteDictIdx(String ids) {
        String[] idz;
        idz = ids.split(",");
        //TODO
    }





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
    @Override
    public void saveOrUpdateDictIdx(SysDictIdx model, SysUser user) {
        if (model.getId() == null) {
            //则为新增
            model.setId(null);
            this.preCreate(model, user);
        } else {
            SysDictIdx dictIdx;
            dictIdx = this.dictIdxDao.findDictIdxById(model.getId());
            dictIdx.setDictName(model.getDictName());
            if (model.getRemark() != null) {
                dictIdx.setRemark(model.getRemark());
            }
            this.preUpdate(dictIdx, user);
            model = dictIdx;
        }
         this.saveOrUpdate(model);
    }

    /**
     * 
     * <p>
     * Description: 验证字典名称是否存在
     * </p>
     * 
     * @param dictName 字典dictName
     * @return 结果集
     */
    @Override
    public boolean validitionDictName(String dictName) {
        List<SysDictIdx> list;
//        list = this.dictIdxDao.validitionDictName(dictName);
        list = this.findListByProperty("dictName", dictName);
        if (list != null && !list.isEmpty()) {
            return true;
        }
        return false;
    }

}
