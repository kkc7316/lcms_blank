--添加用户
insert into LCMS.ts_user (PK_ID, EMPLOYEE_NUM, EMPLOYEE_NAME, EMPLOYEE_EMAIL, IS_SUPPLIER, DEPT, SVW_CODE, REMARK, DEL_FLAG, CREATE_USER, CREATE_DATE, UPDATE_USER, UPDATE_DATE)
values (1, 'admin', '管理员', '', '0', '', '', '', '0', 'admin', sysdate, 'admin', sysdate);

insert into LCMS.ts_user (PK_ID, EMPLOYEE_NUM, EMPLOYEE_NAME, EMPLOYEE_EMAIL, IS_SUPPLIER, DEPT, SVW_CODE, REMARK, DEL_FLAG, CREATE_USER, CREATE_DATE, UPDATE_USER, UPDATE_DATE)
values (2, 'test', '测试用户', '', '0', '', '', '', '0', 'admin', sysdate, 'admin', sysdate);

-- 给用户配置角色
insert into LCMS.tr_user_roles (ROLE_ID, USER_ID, REMARK, DEL_FLAG, CREATE_USER, CREATE_DATE, UPDATE_USER, UPDATE_DATE)
values (1, 1, null, '0', 'admin', sysdate, 'admin', sysdate);

commit;

----------------
-- 字典主表
insert into LCMS.ts_dict (PK_ID, DICT_KEY, DICT_NAME, DICT_DESC, IS_SYSTEM_CONFIG, REMARK, DEL_FLAG, CREATE_USER, CREATE_DATE, UPDATE_USER, UPDATE_DATE)
    values (LCMS.seq_ts_dict.nextval, 'RESOURCE_TYPE', '资源类型', null, '0', null, '0', 'admin',sysdate, 'admin',sysdate);
insert into LCMS.ts_dict (PK_ID, DICT_KEY, DICT_NAME, DICT_DESC, IS_SYSTEM_CONFIG, REMARK, DEL_FLAG, CREATE_USER, CREATE_DATE, UPDATE_USER, UPDATE_DATE)
    values (LCMS.seq_ts_dict.nextval, 'YES_NO', '是否', null, '0', null, '0', 'admin',sysdate, 'admin',sysdate);
--insert into LCMS.ts_dict (PK_ID, DICT_KEY, DICT_NAME, DICT_DESC, IS_SYSTEM_CONFIG, REMARK, DEL_FLAG, CREATE_USER, CREATE_DATE, UPDATE_USER, UPDATE_DATE)
--    values (LCMS.seq_ts_dict.nextval, 'SYS_CONFIG', '系统参数配置', null, '0', null, '0', 'admin',sysdate, 'admin',sysdate);

    
    
-- 字典子表
insert into LCMS.ts_dict_detail (PK_ID, DICT_KEY, DICT_VALUE, PARENT_KEY, IS_SYSTEM_CONFIG, ORDER_NUM, REMARK, DEL_FLAG, CREATE_USER, CREATE_DATE, UPDATE_USER, UPDATE_DATE)
    values (LCMS.seq_ts_dict_detail.nextval, '1', '权限', 'RESOURCE_TYPE', null,1, null, '0', 'admin',sysdate, 'admin',sysdate);
insert into LCMS.ts_dict_detail (PK_ID, DICT_KEY, DICT_VALUE, PARENT_KEY, IS_SYSTEM_CONFIG, ORDER_NUM, REMARK, DEL_FLAG, CREATE_USER, CREATE_DATE, UPDATE_USER, UPDATE_DATE)
    values (LCMS.seq_ts_dict_detail.nextval, '2', '菜单', 'RESOURCE_TYPE', null,2, null, '0', 'admin',sysdate, 'admin',sysdate);

insert into LCMS.ts_dict_detail (PK_ID, DICT_KEY, DICT_VALUE, PARENT_KEY, IS_SYSTEM_CONFIG, ORDER_NUM, REMARK, DEL_FLAG, CREATE_USER, CREATE_DATE, UPDATE_USER, UPDATE_DATE)
    values (LCMS.seq_ts_dict_detail.nextval, '0', '否', 'YES_NO', null,1, null, '0', 'admin',sysdate, 'admin',sysdate);
insert into LCMS.ts_dict_detail (PK_ID, DICT_KEY, DICT_VALUE, PARENT_KEY, IS_SYSTEM_CONFIG, ORDER_NUM, REMARK, DEL_FLAG, CREATE_USER, CREATE_DATE, UPDATE_USER, UPDATE_DATE)
    values (LCMS.seq_ts_dict_detail.nextval, '1', '是', 'YES_NO', null,2, null, '0', 'admin',sysdate, 'admin',sysdate);
    
 
    