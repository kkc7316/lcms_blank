/**
 * DictIdxDaoImpl.java
 * Created at 2015-10-22
 * Created by Administrator
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.dict.dao.impl;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.svw.lcms.common.dict.dao.IDictIdxDao;
import com.svw.lcms.common.dict.domain.SysDictIdx;
import com.svw.lcms.framework.dao.impl.BaseDaoImpl;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>
 * ClassName: DictIdxDaoImpl
 * </p>
 * <p>
 * Description: 字典DaoImpl
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-10-22
 * </p>
 */
@Repository("dictIdxDao")
public class DictIdxDaoImpl extends BaseDaoImpl<SysDictIdx, Serializable> implements IDictIdxDao {


    /**
     * 列表全部模糊查询
     */
    @Override
    protected boolean isAllLikeQuery() {
        return true;
    }


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
    @Override
    public List<SysDictIdx> findAllDictIdxList(PageInfo pageInfo, Map<String, Object> map) {
        List<Object> list;
        list = Arrays.asList(map.keySet().toArray());
        StringBuilder buider;
        buider = new StringBuilder("");
        for (Object object : list) {
            buider.append(" and upper(" + object.toString() + ") like :");
            buider.append(object.toString());
        }
        
        String countHql;
        countHql = "select count(id) from SysDictIdx where 1=1 " + buider.toString();

        String queryHql;
        queryHql = "from SysDictIdx where 1=1 " + buider.toString()
                + " order by updateDate desc, createDate desc, id desc";
        
        return this.findEntityPageListByHql(countHql, queryHql, map, pageInfo);
    }


    /**
     * 
     * <p>
     * Description: 获取字典信息
     * </p>
     * 
     * @param key key
     * @return dictIdx
     */
    @Override
    public SysDictIdx findDictIdxByKey(String key) {
        Criteria cr;
        cr = this.getCurrentSession().createCriteria(SysDictIdx.class);
        cr.add(Restrictions.eq("dictKey", key));
        return (SysDictIdx) cr.uniqueResult();
    }

    /**
     * 
     * <p>
     * Description: 根据Id查询字典
     * </p>
     * 
     * @param id 字典id
     * @return 字典对象
     */
    @Override
    public SysDictIdx findDictIdxById(Long id) {
        Criteria cr;
        cr = this.getCurrentSession().createCriteria(SysDictIdx.class);
        cr.add(Restrictions.eq("id", id));
        return (SysDictIdx) cr.uniqueResult();
    }
    
}
