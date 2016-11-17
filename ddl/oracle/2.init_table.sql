--LCMS_BLANK_BLANK V0.1
--用户表
create table LCMS_BLANK.TS_USER
(
  pk_id          NUMBER(19) not null,
  employee_num   VARCHAR2(20),
  employee_name  VARCHAR2(100),
  employee_email VARCHAR2(50),
  is_supplier    VARCHAR2(4),
  dept           VARCHAR2(200),
  svw_code       VARCHAR2(20),
  remark         VARCHAR2(4000),
  del_flag       VARCHAR2(4) default '0' not null,
  create_user    VARCHAR2(50) not null,
  create_date    DATE not null,
  update_user    VARCHAR2(50),
  update_date    DATE,
  constraint PK_TS_USER primary key (PK_ID) using index tablespace LCMS_BLANK_INDEX
)tablespace LCMS_BLANK_DATA;
comment on table LCMS_BLANK.TS_USER is '用户表';
comment on column LCMS_BLANK.TS_USER.pk_id is '主键';
comment on column LCMS_BLANK.TS_USER.employee_num is '用户工号';
comment on column LCMS_BLANK.TS_USER.employee_name is '用户名称';
comment on column LCMS_BLANK.TS_USER.employee_email is '用户邮箱';
comment on column LCMS_BLANK.TS_USER.is_supplier is '是否供应商';
comment on column LCMS_BLANK.TS_USER.dept is '部门';
comment on column LCMS_BLANK.TS_USER.svw_code is 'SVW供应商编号';
comment on column LCMS_BLANK.TS_USER.remark is '备注';
comment on column LCMS_BLANK.TS_USER.del_flag is '删除标识 0：未删除，1：删除';
comment on column LCMS_BLANK.TS_USER.create_user is '记录创建人';
comment on column LCMS_BLANK.TS_USER.create_date is '记录创建时间';
comment on column LCMS_BLANK.TS_USER.update_user is '记录更新人';
comment on column LCMS_BLANK.TS_USER.update_date is '记录更新时间';

-- 角色表
create table LCMS_BLANK.TS_ROLE
(
  pk_id       NUMBER(19) not null,
  role_name   VARCHAR2(200),
  role_code   VARCHAR2(20),
  role_desc   VARCHAR2(300),
  remark      VARCHAR2(4000),
  del_flag    VARCHAR2(4) default '0' not null,
  create_user VARCHAR2(50) not null,
  create_date DATE not null,
  update_user VARCHAR2(50),
  update_date DATE,
  constraint PK_TS_ROLE primary key (PK_ID) using index tablespace LCMS_BLANK_INDEX
)tablespace LCMS_BLANK_DATA;
comment on table LCMS_BLANK.TS_ROLE is '角色表';
comment on column LCMS_BLANK.TS_ROLE.pk_id is '主键';
comment on column LCMS_BLANK.TS_ROLE.role_name is '角色名称';
comment on column LCMS_BLANK.TS_ROLE.role_code is '角色代码';
comment on column LCMS_BLANK.TS_ROLE.role_desc is '角色说明';
comment on column LCMS_BLANK.TS_ROLE.remark is '备注';
comment on column LCMS_BLANK.TS_ROLE.del_flag is '删除标识 0：未删除，1：删除';
comment on column LCMS_BLANK.TS_ROLE.create_user is '记录创建人';
comment on column LCMS_BLANK.TS_ROLE.create_date is '记录创建时间';
comment on column LCMS_BLANK.TS_ROLE.update_user is '记录更新人';
comment on column LCMS_BLANK.TS_ROLE.update_date is '记录更新时间';

-- 资源表
create table LCMS_BLANK.TS_RESOURCE
(
  pk_id         NUMBER(19) not null,
  resource_name VARCHAR2(200),
  resource_code VARCHAR2(50),
  resource_type VARCHAR2(4),
  parent_id     NUMBER(19),
  remark        VARCHAR2(4000),
  del_flag      VARCHAR2(4) default '0' not null,
  create_user   VARCHAR2(50) not null,
  create_date   DATE not null,
  update_user   VARCHAR2(50),
  update_date   DATE,
  constraint PK_TS_RESOURCE primary key (PK_ID) using index tablespace LCMS_BLANK_INDEX
)tablespace LCMS_BLANK_DATA;
comment on table LCMS_BLANK.TS_RESOURCE is '资源表';
comment on column LCMS_BLANK.TS_RESOURCE.pk_id is '主键';
comment on column LCMS_BLANK.TS_RESOURCE.resource_name is '资源名称';
comment on column LCMS_BLANK.TS_RESOURCE.resource_code is '资源代码';
comment on column LCMS_BLANK.TS_RESOURCE.resource_type is '资源类型 1、权限 2、菜单';
comment on column LCMS_BLANK.TS_RESOURCE.parent_id is '父节点';
comment on column LCMS_BLANK.TS_RESOURCE.remark is '备注';
comment on column LCMS_BLANK.TS_RESOURCE.del_flag is '删除标识 0：未删除，1：删除';
comment on column LCMS_BLANK.TS_RESOURCE.create_user is '记录创建人';
comment on column LCMS_BLANK.TS_RESOURCE.create_date is '记录创建时间';
comment on column LCMS_BLANK.TS_RESOURCE.update_user is '记录更新人';
comment on column LCMS_BLANK.TS_RESOURCE.update_date is '记录更新时间';

-- 用户角色关联表
create table LCMS_BLANK.TR_USER_ROLES
(
  role_id     NUMBER(19),
  user_id     NUMBER(19),
  remark      VARCHAR2(4000),
  del_flag    VARCHAR2(4) default '0',
  create_user VARCHAR2(50),
  create_date DATE default SYSDATE,
  update_user VARCHAR2(50),
  update_date DATE
)tablespace LCMS_BLANK_DATA;
comment on table LCMS_BLANK.TR_USER_ROLES is '用户角色表';
comment on column LCMS_BLANK.TR_USER_ROLES.ROLE_ID is '角色ID';
comment on column LCMS_BLANK.TR_USER_ROLES.USER_ID is '用户ID';
comment on column LCMS_BLANK.TR_USER_ROLES.REMARK is '备注';
comment on column LCMS_BLANK.TR_USER_ROLES.DEL_FLAG is '删除标识 0：未删除，1：删除';
comment on column LCMS_BLANK.TR_USER_ROLES.CREATE_USER is '记录创建人';
comment on column LCMS_BLANK.TR_USER_ROLES.CREATE_DATE is '记录创建时间';
comment on column LCMS_BLANK.TR_USER_ROLES.UPDATE_USER is '记录更新人';
comment on column LCMS_BLANK.TR_USER_ROLES.UPDATE_DATE is '记录更新时间';


-- 角色资源关联表
create table LCMS_BLANK.TR_ROLE_RESOURCES
(
  role_id     NUMBER(19),
  resource_id NUMBER(19),
  remark      VARCHAR2(4000),
  del_flag    VARCHAR2(4) default '0',
  create_user VARCHAR2(50),
  create_date DATE default SYSDATE,
  update_user VARCHAR2(50),
  update_date DATE
)tablespace LCMS_BLANK_DATA;
comment on table LCMS_BLANK.TR_ROLE_RESOURCES is '角色资源表';
comment on column LCMS_BLANK.TR_ROLE_RESOURCES.ROLE_ID is '角色ID';
comment on column LCMS_BLANK.TR_ROLE_RESOURCES.RESOURCE_ID is '资源ID';
comment on column LCMS_BLANK.TR_ROLE_RESOURCES.REMARK is '备注';
comment on column LCMS_BLANK.TR_ROLE_RESOURCES.DEL_FLAG is '删除标识';
comment on column LCMS_BLANK.TR_ROLE_RESOURCES.CREATE_USER is '记录创建人';
comment on column LCMS_BLANK.TR_ROLE_RESOURCES.CREATE_DATE is '记录创建时间';
comment on column LCMS_BLANK.TR_ROLE_RESOURCES.UPDATE_USER is '记录更新人';
comment on column LCMS_BLANK.TR_ROLE_RESOURCES.UPDATE_DATE is '记录更新时间';

-- 字典表
create table LCMS_BLANK.TS_DICT
(
  pk_id            NUMBER(19) not null,
  dict_key         VARCHAR2(50),
  dict_name        VARCHAR2(50),
  dict_desc        VARCHAR2(200),
  is_system_config VARCHAR2(4),
  remark           VARCHAR2(4000),
  del_flag         VARCHAR2(4) default '0' not null,
  create_user      VARCHAR2(50) not null,
  create_date      DATE not null,
  update_user      VARCHAR2(50),
  update_date      DATE,
  constraint PK_TS_DICT primary key (PK_ID) using index tablespace LCMS_BLANK_INDEX
)tablespace LCMS_BLANK_DATA;
comment on table LCMS_BLANK.TS_DICT is '父字典表';
comment on column LCMS_BLANK.TS_DICT.pk_id is '主键';
comment on column LCMS_BLANK.TS_DICT.dict_key is '字典代码';
comment on column LCMS_BLANK.TS_DICT.dict_name is '字典名';
comment on column LCMS_BLANK.TS_DICT.dict_desc is '字典描述';
comment on column LCMS_BLANK.TS_DICT.is_system_config is '是否系统配置 0：否，1：是';
comment on column LCMS_BLANK.TS_DICT.remark is '备注';
comment on column LCMS_BLANK.TS_DICT.del_flag is '删除标识 0：未删除，1：删除';
comment on column LCMS_BLANK.TS_DICT.create_user is '记录创建人';
comment on column LCMS_BLANK.TS_DICT.create_date is '记录创建时间';
comment on column LCMS_BLANK.TS_DICT.update_user is '记录更新人';
comment on column LCMS_BLANK.TS_DICT.update_date is '记录更新时间';

create table LCMS_BLANK.TS_DICT_DETAIL
(
  pk_id            NUMBER(19) not null,
  dict_key         VARCHAR2(200),
  dict_value       VARCHAR2(100),
  parent_key       VARCHAR2(50),
  is_system_config VARCHAR2(4),
  order_num        NUMBER(5),
  remark           VARCHAR2(4000),
  del_flag         VARCHAR2(4) default '0' not null,
  create_user      VARCHAR2(50) not null,
  create_date      DATE not null,
  update_user      VARCHAR2(50),
  update_date      DATE,
  constraint PK_TS_DICT_DETAIL primary key (PK_ID) using index tablespace LCMS_BLANK_INDEX
)tablespace LCMS_BLANK_DATA;
comment on table LCMS_BLANK.TS_DICT_DETAIL is '子字典表';
comment on column LCMS_BLANK.TS_DICT_DETAIL.pk_id is '主键';
comment on column LCMS_BLANK.TS_DICT_DETAIL.dict_key is '字典代码';
comment on column LCMS_BLANK.TS_DICT_DETAIL.dict_value is '字典显示值';
comment on column LCMS_BLANK.TS_DICT_DETAIL.parent_key is '父字典代码';
comment on column LCMS_BLANK.TS_DICT_DETAIL.is_system_config is '是否系统配置 0：否，1：是';
comment on column LCMS_BLANK.TS_DICT_DETAIL.order_num is '排序';
comment on column LCMS_BLANK.TS_DICT_DETAIL.remark is '备注';
comment on column LCMS_BLANK.TS_DICT_DETAIL.del_flag is '删除标识 0：未删除，1：删除';
comment on column LCMS_BLANK.TS_DICT_DETAIL.create_user is '记录创建人';
comment on column LCMS_BLANK.TS_DICT_DETAIL.create_date is '记录创建时间';
comment on column LCMS_BLANK.TS_DICT_DETAIL.update_user is '记录更新人';
comment on column LCMS_BLANK.TS_DICT_DETAIL.update_date is '记录更新时间';

