package com.svw.lcms.common.base.services;

import java.util.List;

import com.svw.lcms.common.user.domain.SysUser;
import com.svw.lcms.framework.domain.BaseModel;
import com.svw.lcms.framework.web.page.PageInfo;

/**
 * <p>ClassName: IEntityService</p>
 * <p>Description: lcms基类service接口</p>
 * <p>Author: Administrator</p>
 * <p>Date: 2016年11月14日</p>
 */
public interface IEntityService<T extends BaseModel> {

    
    /**
     * 
     * <p>Description: 根据ID获得对象 </p>
     * @param id
     * @return T
     */
    public T getById(Long id);
    
    
    /**
     * 
     * <p>Description: 根据ID获得对象 </p>
     * @param id
     * @return T
     */
    public T loadById(Long id);
    
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
    public T findByProperty(String propertyName, Object propertyValue);
    
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
    public List<T> findListByProperty(String propertyName, Object propertyValue);
    
    /**
     * 
     * <p>
     * Description: 不分页查询查询所有model对象
     * </p>
     * 
     * @return model对象列表
     */
    public List<T> findAll();
    
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
    public List<T> findAll(PageInfo pageInfo);
    
    /**
     * 
     * <p>
     * Description: 保存一个model
     * </p>
     * 
     * @param entity model对象
     * @return ID 
     */
    public Long save(T entity);

    /**
     * 
     * <p>
     * Description: 保存一个model
     * </p>
     * 
     * @param entity model对象
     * @param optUser 操作者
     * @return ID 
     */
    public Long saveEntity(T entity, SysUser optUser);
    
    /**
     * 
     * <p>
     * Description: 保存或更新一个model
     * </p>
     * 
     * @param entity model对象
     */
    public void saveOrUpdate(T entity);
    
    /**
     * <p>Description: 批量保存/更新</p>
     * @param entityList
     */
    public void saveOrUpdateEntityList(List<T> entityList);
 
    /**
     * 
     * <p>
     * Description: 删除一个model
     * </p>
     * 
     * @param entity model对象
     */
    public void delete(T entity);

    /**
     * 
     * <p>
     * Description: 更新一个model
     * </p>
     * 
     * @param entity model对象
     */
    public void update(T entity);

    /**
     * 
     * <p>
     * Description: 更新一个model
     * </p>
     * @param optUser 操作者
     * @param entity model对象
     */
    public void updateEntity(T entity, SysUser optUser);
    /**
     * 
     * <p>Description: 更新一个model</p>
     * @param entity model对象
     */
    public void merge(T entity);
    
    /**
     * 
     * <p>
     * Description: 根据主键删除一个model
     * </p>
     * 
     * @param modelClass model类对象
     * @param id 主键
     */
    public void deleteById(Long id);
    
    /**
     * 
     * <p>Description: 伪删除</p>
     * @param modelClass class
     * @param id id
     * @param user user
     */
    public T deleteByDelFlag(Long id, SysUser currentUser);
    
    /**
     * 
     * <p>Description: 批量伪删除</p>
     * @param modelClass class
     * @param ids ids
     * @param user user
     */
    public void deleteByDelFlag(String[] ids, SysUser currentUser);
    
}
