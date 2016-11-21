/**
 * 
 */
package com.svw.lcms.framework.services.impl;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.svw.lcms.framework.services.IBaseService;
import com.svw.lcms.framework.services.IUtilService;

/**
 * <p>ClassName: BaseServiceImpl</p>
 * <p>Description: 通用service</p>
 * <p>Author: Administrator</p>
 * <p>Date: 2016年11月14日</p>
 */
@Service("baseService")
public class BaseServiceImpl implements IBaseService {

    
    /**
     * 日志    
     */
    public static final Logger LOGGER = Logger.getLogger(BaseServiceImpl.class);
   
    /**
     * utilService
     */
    @Autowired
    @Qualifier("utilService")
    protected IUtilService utilService;
    
    /////////////////////////////////////////
    
}
