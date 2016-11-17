package com.svw.lcms.common.base.services.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.svw.lcms.common.base.ISysConstants;
import com.svw.lcms.common.base.services.IEntityService;
import com.svw.lcms.common.user.domain.SysUser;
import com.svw.lcms.framework.dao.IBaseDao;
import com.svw.lcms.framework.domain.BaseModel;
import com.svw.lcms.framework.services.impl.BaseServiceImpl;
import com.svw.lcms.framework.web.exception.BusinessException;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>ClassName: EntityServiceImpl</p>
 * <p>Description: lcms 基类service</p>
 * <p>Author: Administrator</p>
 * <p>Date: 2016年11月14日</p>
 */
@Service("entityService")
public class EntityServiceImpl<T extends BaseModel> extends BaseServiceImpl implements IEntityService<T>, ISysConstants {
    
    /**
     * baseDao
     * --组合优于集成[原先baseServiceImpl实现了baseDao的功能]
     */
    @Autowired
    @Qualifier("baseDao")
    private IBaseDao<T, Long> baseDao;
    /**
     * 
     * <p>Description: 根据ID获得对象 </p>
     * @param id
     * @return
     */
    public T getById(Long id) {
        return (T) this.baseDao.getById(getModelClass(), id);
    }
    
    /**
     * 
     * <p>Description: 根据ID获得对象 </p>
     * @param id
     * @return
     */
    public T loadById(Long id) {
        return (T) this.baseDao.loadById(getModelClass(), id);
    }
    
    
    /**
     * 
     * <p>
     * Description: 通过非主键字段查询model对象
     * </p>
     * 
     * @param propertyName 属性名
     * @param propertyValue 属性值
     * @return model对象
     */
    public T findByProperty(String propertyName, Object propertyValue) {
        return (T) this.baseDao.findByProperty(getModelClass(), propertyName, propertyValue);
    }
    
    /**
     * 
     * <p>
     * Description: 通过非主键字段查询model对象
     * </p>
     * 
     * @param propertyName 属性名
     * @param propertyValue 属性值
     * @return list
     */
    public List<T> findListByProperty(String propertyName, Object propertyValue) {
        return this.baseDao.findListByProperty(getModelClass(), propertyName, propertyValue);
    }
    /**
     * 
     * <p>
     * Description: 不分页查询查询所有model对象
     * </p>
     * 
     * @return model对象列表
     */
    public List<T> findAll() {
        return this.baseDao.findAll(getModelClass());
    }
    
    /**
     * 
     * <p>
     * Description: 分页查询查询所有model对象
     * </p>
     * 
     * @param modelClass model类对象
     * @param pageInfo 分页参数
     * @return model对象列表
     */
    public List<T> findAll(PageInfo pageInfo) {
        return this.baseDao.findAll(getModelClass(), pageInfo);
    }
    
    /**
     * 
     * <p>
     * Description: 保存一个model
     * </p>
     * 
     * @param entity model对象
     * @return ID 
     */
    public Long save(T entity) {
        return (Long) this.baseDao.save(entity);
    }

    /**
     * 
     * <p>
     * Description: 保存一个model
     * </p>
     * 
     * @param entity model对象
     * @return ID 
     */
    public Long saveEntity(T entity, SysUser optUser) {
        this.beforeSaveEntity(entity, optUser);
        
        this.preCreate(entity, optUser);
        Long id;
        id = (Long) this.baseDao.save(entity);
        
        this.afterSaveEntity(entity, optUser);
        return id;
    }
    
    /**
     * 
     * <p>
     * Description: 保存一个model之前的操作
     * </p>
     * 
     * @param entity model对象
     * @param optUser 操作者
     */
    protected void beforeSaveEntity(T entity, SysUser optUser) {
        
    }
    /**
     * 
     * <p>
     * Description: 保存一个model之后的操作
     * </p>
     * 
     * @param entity model对象
     * @param optUser 操作者
     */
    protected void afterSaveEntity(T entity, SysUser optUser) {
        
    }
    /**
     * 
     * <p>
     * Description: 保存或更新一个model
     * </p>
     * 
     * @param entity model对象
     */
    public void saveOrUpdate(T entity) {
        this.baseDao.saveOrUpdate(entity);
    }
    
    
    /**
     * <p>Description: 批量保存/更新</p>
     * @param entityList
     */
    public void saveOrUpdateEntityList(List<T> entityList) {
        this.baseDao.saveOrUpdateEntityList(entityList);
    }
    
    /**
     * 
     * <p>
     * Description: 删除一个model
     * </p>
     * 
     * @param entity model对象
     */
    public void delete(T entity) {
        this.baseDao.delete(entity);
    }
    
    /**
     * 
     * <p>
     * Description: 更新一个model
     * </p>
     * 
     * @param entity model对象
     */
    public void update(T entity) {
        this.baseDao.update(entity);
    }

    /**
     * 
     * <p>
     * Description: 更新一个model
     * </p>
     * @param optUser 操作者
     * @param entity model对象
     */
    public void updateEntity(T entity, SysUser optUser) {
        this.beforeUpdateEntity(entity, optUser);
        
        this.preUpdate(entity, optUser);
        this.baseDao.save(entity);
        
        this.afterUpdateEntity(entity, optUser);
    }
    
    /**
     * 
     * <p>
     * Description: 更新一个model之前的操作
     * </p>
     * @param optUser 操作者
     * @param entity model对象
     */
    protected void beforeUpdateEntity(T entity, SysUser optUser) {
    }

    /**
     * 
     * <p>
     * Description: 更新一个model之后的操作
     * </p>
     * @param optUser 操作者
     * @param entity model对象
     */
    protected void afterUpdateEntity(T entity, SysUser optUser) {
    }

    /**
     * 
     * <p>Description: 更新一个model</p>
     * @param entity model对象
     */
    public void merge(T entity) {
        this.baseDao.merge(entity);
    }
    /**
     * 
     * <p>
     * Description: 根据主键删除一个model
     * </p>
     * 
     * @param modelClass model类对象
     * @param id 主键
     */
    public void deleteById(Long id) {
        this.baseDao.deleteById(getModelClass(), id);
    }
    /**
     * 
     * <p>Description: 伪删除</p>
     * @param modelClass class
     * @param id id
     * @param currentUser 当前用户
     */
    @Override
    public T deleteByDelFlag(Long id, SysUser currentUser) {
        //获得entity
        T entity;
        entity = this.getById(id);
        //伪删除
        this.preDelete(entity, currentUser);
        //更新
        this.baseDao.update(entity);
        //有可能需要此对象，做一些关联的事情
        return entity;
    }
    /**
     * 
     * <p>Description: 批量伪删除</p>
     * @param modelClass class
     * @param ids ids
     * @param currentUser 当前用户
     */
    @Override
    public void deleteByDelFlag(String[] ids, SysUser currentUser) {
       if (ids != null && ids.length > 0) {
           for (int i = 0; i < ids.length; i++) {
               this.deleteByDelFlag(Long.valueOf(ids[i]), currentUser);
           }
       }
        
    }
    
    
    
    
    /**********************************************/
    /**
     * 
     * <p>Description: 创建</p>
     * @param entity T
     * @param CurrentUser   当前用户
     */
    public void preCreate(T entity, SysUser CurrentUser) {
        entity.setDelFlag(NOT_DEL);
        
        entity.setCreateUser(CurrentUser.getEmployeeNum());
        entity.setCreateDate(new Date());
        entity.setUpdateUser(CurrentUser.getEmployeeNum());
        entity.setUpdateDate(new Date());
    }
    /**
     * 
     * <p>Description: 更新</p>
     * @param entity T
     * @param CurrentUser   当前用户
     */
    public void preUpdate(T entity, SysUser CurrentUser) {
        entity.setUpdateUser(CurrentUser.getEmployeeNum());
        entity.setUpdateDate(new Date());
    }


    
    /**
     * 
     * <p>Description: 更新</p>
     * @param entity T
     * @param CurrentUser  当前用户
     */
    public void preDelete(T entity, SysUser CurrentUser) {
        entity.setDelFlag(IS_DEL);
        this.preUpdate(entity, CurrentUser);
    }



    /////////////////////////////////////////////////////////////
    /**
     * 
     * <p>Description: 根据service名称，获得ModelClass对象</p>
     * @return class
     */
    @SuppressWarnings("unchecked")
    protected Class<T> getModelClass() {
        Class<T> modelClass = null;
        try {
            modelClass = (Class<T>) Class.forName(this.getDomainName());
        } catch (ClassNotFoundException e) {
            throw new BusinessException("Class[" + this.getDomainName() + "] not found Exception!");
        }
        
        return modelClass;
    }
    
    
    /**
     * 获得domain name，如果Service的实现类的命名是Domain+ServiceImpl的方式，子类就不用重写该方法
     * 或者Service本身就是实现类，并未实现接口，子类也不用重写该方法
     * 
     * @return domain name
     */
    protected String getDomainName() {
        String suffix1 = "ServiceImpl";
        String suffix2 = "Service";
        String className = this.getClass().getSimpleName();
        if (className.endsWith(suffix1)) {
            return className.substring(0, className.length() - suffix1.length());
        } else if (className.endsWith(suffix2)) {
            return className.substring(0, className.length() - suffix2.length());
        } else {
            LOGGER.error("ServiceImpl class name's format must be \"DomainName\" + \"Service(Impl)\", "
                        + "or you can overwrite the method getDomainName in your ServiceImpl!");
        }
        return null;
    }
    
}
