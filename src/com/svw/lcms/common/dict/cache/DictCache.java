/**
 * DictCache.java
 * Created at 2015-09-23
 * Created by pangfeng
 * Copyright (C) 2015 SHANGHAI VOLKSWAGEN, All rights reserved.
 */
package com.svw.lcms.common.dict.cache;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.lang3.StringUtils;

import com.svw.lcms.common.dict.domain.SysDict;

/**
 * <p>
 * ClassName: DictCache
 * </p>
 * <p>
 * Description: 字典Cache处理
 * </p>
 * <p>
 * Author: pangfeng
 * </p>
 * <p>
 * Date: 2015-9-25
 * </p>
 */
public class DictCache {

    /**
     * 字典缓存Buffer，系统启动时加入
     */
    private static ConcurrentHashMap<String, List<SysDict>> buffer;

    /**
     * <p>
     * Description: 根据字典类型取得值
     * </p>
     * 
     * @param parentKey 字典类型
     * @return 字典值列表
     * @throws Exception 异常
     */
    public static List<SysDict> getDictList(String parentKey) throws Exception {
        if (buffer == null) {
            initialize(false);
        }
        List<SysDict> dictList;
        dictList = buffer.get(parentKey);
        return dictList;
    }

    /**
     * <p>
     * Description: 根据字典类型和字典key取得值
     * </p>
     * 
     * @param parentKey 字典类型
     * @param dictKey 字典Key
     * @return 字典值
     * @throws Exception 异常
     */
    public static String get(String parentKey, String dictKey) throws Exception {
        if (buffer == null) {
            initialize(false);
        }
        List<SysDict> dictList;
        dictList = buffer.get(parentKey);
        if (dictList == null) {
            return "";
        } else {
            for (SysDict dict : dictList) {
                if (StringUtils.equals(dict.getDictKey(), dictKey)) {
                    return dict.getDictValue();
                }
            }

            return "";
        }
    }

    /**
     * <p>
     * Description: 更新Map中的字典list
     * </p>
     * 
     * @param parentKey 字典类型
     * @param dictList 字典List
     * @throws Exception 异常
     */
    public static void put(String parentKey, List<SysDict> dictList) throws Exception {
        if (buffer == null) {
            initialize(false);
        }
        buffer.put(parentKey, dictList);
    }

    /**
     * <p>
     * Description: 将字典逐一加入到map
     * </p>
     * 
     * @param parentKey 字典类型
     * @param dictKey 字典key
     * @param dictValue 字典值
     * @throws Exception 异常
     */
    public static void put(String parentKey, String dictKey, String dictValue) throws Exception {
        if (buffer == null) {
            initialize(false);
        }
        List<SysDict> dictList = buffer.get(dictKey);
        if (dictList == null) {
            dictList = new ArrayList<SysDict>();
        }
        dictList.add(new SysDict(dictKey, dictValue));
        buffer.put(parentKey, dictList);
    }

    /**
     * 
     * <p>
     * Description: 从缓存中去掉某个字典值
     * </p>
     * 
     * @param parentKey 字典类型
     * @param dictKey 字典Key
     * @throws Exception 异常
     */
    public static void remove(String parentKey, String dictKey) throws Exception {
        if (buffer == null) {
            return;
        }
        List<SysDict> dictList;
        dictList = buffer.get(dictKey);
        if (dictList != null) {
            for (SysDict dict : dictList) {
                if (StringUtils.equals(dict.getDictKey(), dictKey)) {
                    dictList.remove(dict);
                    break;
                }
            }
            if (dictList.size() == 0) {
                buffer.remove(parentKey);
            }
        }
    }

    /**
     * <p>
     * Description: 根据字典的parentKey，加载其节点值，形成json字符串
     * </p>
     * 
     * @param parentKey 字典根节点值
     * @param emptyOption 空选项类型：1不限2请选择
     * @return json字符串
     */
    public static String getList(String parentKey, String emptyOption) {
        List<SysDict> dictList;
        dictList = new ArrayList<SysDict>();
        String[] parentKeyArr;
        parentKeyArr = StringUtils.split(parentKey, ",");

        if (StringUtils.isNotEmpty(emptyOption)) {
            SysDict dict;
            dict = new SysDict();
            dict.setParentKey(parentKey);
            // 不限
            if (StringUtils.equals("1", emptyOption)) {
                dict.setDictValue("不限");
            }
            // 请选择
            if (StringUtils.equals("2", emptyOption)) {
                dict.setDictValue("请选择");
            }
            // 请选择
            if (StringUtils.equals("3", emptyOption)) {
                dict.setDictValue("空白");
            }
            dictList.add(dict);
        }

        if (parentKeyArr.length == 1) {
            dictList.addAll(buffer.get(parentKey));
        } else if (parentKeyArr.length == 0) {
            //将全部字典加载到页面上
            for (Map.Entry<String, List<SysDict>> e : buffer.entrySet()) {
                dictList.addAll(e.getValue());
            }
        } else {
            for (String pkey : parentKeyArr) {
                dictList.addAll(buffer.get(pkey));
            }
        }

        if (dictList.size() == 0) {
            return "[]";
        }

        Map<String, Object> map;
        map = new HashMap<String, Object>();
        map.put("total", dictList.size());
        map.put("rows", dictList);
        // return JSON.toJSONString(map);
        return "";
    }

    /**
     * <p>
     * Description: 加载字典到缓存，使用的是WebBuilder的数据库连接方式
     * </p>
     * 
     * @param parentKey 字典根节点值
     * @throws Exception 异常
     */
    private static void loadDicts(String parentKey) throws Exception {
        //        Connection conn = null;
        //        ResultSet rs = null;
        //        String preType = null;
        //        List<SysDict> dictList = new ArrayList<SysDict>();
        //        String queryString = "";
        //        if (StringUtils.isNotEmpty(parentKey)) {
        //            queryString = "and parent_key = '" + parentKey + "' ";
        //        }
        //        try {
        //            conn = DbUtil.getConnection();
        //            rs = DbUtil.getResultSet(conn, "select PARENT_KEY, DICT_KEY,DICT_VALUE,DEL_FLAG from SYS_DICT "
        //                    + "where 1 = 1 " + queryString + "order by parent_key, dict_sort");
        //            while (rs.next()) {
        //                parentKey = rs.getString(1);
        //                if (preType != null && !preType.equals(parentKey)) {
        //                    buffer.put(preType, dictList);
        //                    dictList = new ArrayList<SysDict>();
        //                }
        //                SysDict dict = new SysDict(rs.getString(2), rs.getString(3));
        //                dict.setParentKey(parentKey);
        //                dict.setDelFlag(rs.getString(4));
        //                dictList.add(dict);
        //                preType = parentKey;
        //            }
        //            if (preType != null) {
        //                buffer.put(preType, dictList);
        //            }
        //        } finally {
        //            DbUtil.closeResultSet(rs);
        //            DbUtil.closeConnection(conn);
        //        }
    }

    /**
     * <p>
     * Description: 刷新某个父节点的字典列表
     * </p>
     * 
     * @param parentKey 父节点值
     * @throws Exception 异常
     */
    public static synchronized void refresh(String parentKey) throws Exception {
        loadDicts(parentKey);
    }

    /**
     * <p>
     * Description: 初始化字典的方法
     * </p>
     * 
     * @param reload 是否重新加载
     * @throws Exception 异常
     */
    public static synchronized void initialize(boolean reload) throws Exception {
        if (!reload && buffer != null) {
            return;
        }
        buffer = new ConcurrentHashMap<String, List<SysDict>>();
        loadDicts(null);
    }

}
