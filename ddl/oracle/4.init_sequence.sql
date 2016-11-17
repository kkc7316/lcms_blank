
-- Create sequence 
-- 当前资源最大ID:2
create sequence LCMS_BLANK.SEQ_TS_USER
minvalue 1
maxvalue 999999999999999999999999999
start with 10
increment by 1
nocache;

-- Create sequence 
-- 当前资源最大ID:1
create sequence LCMS_BLANK.SEQ_TS_ROLE
minvalue 1
maxvalue 999999999999999999999999999
start with 2
increment by 1
nocache;
-- Create sequence 
-- 当前资源最大ID:277
create sequence LCMS_BLANK.SEQ_TS_RESOURCE
minvalue 1
maxvalue 999999999999999999999999999
start with 300
increment by 1
nocache;

-- Create sequence 
-- 当前资源最大ID:0
create sequence LCMS_BLANK.SEQ_TS_DICT
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

-- Create sequence 
-- 当前资源最大ID:0
create sequence LCMS_BLANK.SEQ_TS_DICT_DETAIL
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

