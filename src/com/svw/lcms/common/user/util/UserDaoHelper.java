package com.svw.lcms.common.user.util;

/**
 * <p>ClassName: UserDaoHelper</p>
 * <p>Description: userDao sql/hql辅助类</p>
 * <p>Author: Administrator</p>
 * <p>Date: 2016年11月15日</p>
 */
public class UserDaoHelper {

    
    private UserDaoHelper() {
    }
    
    
    /**
     * <p>Description: 查找用户是否有XXX权限</p>
     * @return sql
     */
    public static String hasPermission() {
        //多个角色都配这个权限，需要取distinct
        String sql;
        sql = " select DISTINCT re.pk_id as id " 
                + " from TS_RESOURCE re "
                + " left join TR_ROLE_RESOURCES rr on re.pk_id = rr.resource_id "
                + " left join Ts_Role ro on ro.pk_id = rr.role_id "
                + " left join TR_USER_ROLES ur on ur.role_id = ro.pk_id "
                + " where 1=1 " 
                + " and re.del_flag = '0' "
                + " and ro.del_flag = '0' " 
                + " and ur.user_id =:userId"
                + " and re.resource_code =:permissName " 
                + "";
        
        return sql;
    }
    
    
    
}
