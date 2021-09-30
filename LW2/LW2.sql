-- Задание 1
create tablespace TS_GVA
datafile 'C:\app\Tablespaces\TS_GVA'
size 7M
autoextend on next 5M
maxsize 20M
extent management local;

--drop tablespace TS_GVA;

-- Задание 2
create temporary tablespace TS_GVA_TEMP
TEMPFILE 'C:\app\Tablespaces\TS_GVA_TEMP'
size 5M
autoextend on next 3M
maxsize 30M
extent management local;

--drop tablespace TS_GVA_TEMP;

-- Задание 3
select tablespace_name, status, contents logging from sys.dba_tablespaces;
select file_name, tablespace_name,status, maxbytes,user_bytes from dba_data_files
union
select file_name, tablespace_name, status, maxbytes, user_bytes from dba_temp_files;

-- Задание 4
alter session set "_ORACLE_SCRIPT" = true;
create role RL_GVACORE;
--drop role RL_GVACORE;
grant create session,
      create table,
      create view,
      create procedure,
      drop any table,
      drop any view,
      drop any procedure to RL_GVACORE;
      
-- Задание 5
select * from dba_sys_privs where grantee='RL_GVACORE'


-- Задание 6
create profile PF_GVACORE limit
password_life_time 180
sessions_per_user 3
failed_login_attempts 7
password_lock_time 1
password_reuse_time 10
password_grace_time default
connect_time 180
idle_time 30

-- Здание 7
select * from dba_profiles where profile='PF_GVACORE'
select * from dba_profiles where profile='DEFAULT'

-- Задание 8
create user GVACORE identified by abcd0503
default tablespace TS_GVA quota unlimited on TS_GVA
temporary tablespace TS_GVA_TEMP
profile PF_GVACORE
account unlock
password expire;
grant RL_GVACORE to GVACORE;
--drop user GVACORE

-- Задание 10
create table tt(a number(2));
create view tt_view as select * from tt;
drop view tt_view;
drop table tt;

-- Задание 11
create tablespace GVA_QDATA
datafile 'C:\app\Tablespaces\GVA_QDATA'
size 10M
extent management local
offline;

alter tablespace GVA_QDATA online;
alter user GVACORE quota 2M on GVA_QDATA;

create table tt(a number(2)) tablespace GVA_QDATA;
insert into tt(a) values (1);
insert into tt(a) values (2);
insert into tt(a) values (3);

select * from tt;
drop table tt;