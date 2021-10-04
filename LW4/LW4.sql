-- Задание 1
select * from v$pdbs;
-- Задание 2
select * from v$instance;
-- Задание 3
select * from product_component_version;
-- Задание 4
-- Задание 5
select * from v$pdbs;
-- Задание 6
create tablespace TS_GVA_PDB
  datafile 'C:\app\Tablespaces\TS_GVA_PDB'
  size 7M
  autoextend on next 5M
  maxsize 20M
 extent management local;

 create temporary tablespace TS_GVA_TEMP_PDB
  tempfile 'C:\app\Tablespaces\TS_GVA_TEMP_PDB'
  size 5M
  autoextend on next 3M
  maxsize 30M
 extent management local;
 
alter session set "_ORACLE_SCRIPT" = true;

create role RL_GVA_PDB container=current;
commit;

grant create session,
      create table,
      create view,
      create procedure,
      drop any table,
      drop any view,
      drop any procedure 
to RL_GVA_PDB;
commit;

create profile PF_GVA_PDB limit
  password_life_time 180
  sessions_per_user 3
  failed_login_attempts 7
  password_lock_time 1
  password_reuse_time 10
  password_grace_time default
  connect_time 180
  idle_time 30
  container=current;
commit;
create user U1_GVA_PDB identified by abcd0503
default tablespace TS_GVA_PDB quota unlimited on TS_GVA_PDB
temporary tablespace TS_GVA_TEMP_PDB
profile PF_GVA_PDB
account unlock
container=current;

grant RL_GVA_PDB to U1_GVA_PDB;
commit;
-- Задание 7
create table GVA_Tabe(id number(2) primary key, value number(2));
insert into GVA_Tabe(id, value) values (1, 1);
insert into GVA_Tabe(id, value) values (2, 2);
insert into GVA_Tabe(id, value) values (3, 3);

select * from GVA_Tabe;

--Задание 8
select * from all_users;
select * from dba_tablespaces;
select * from dba_data_files;
select * from dba_temp_files;
select * from dba_roles;
select grantee, privilege from dba_sys_privs;
select * from dba_profiles;

-- Задание 9
create user C##GVA identified by abcd0503
account unlock;

grant create session to C##GVA;
grant create session to C##GVA container=current;

drop pluggable database GVA_PDB including datafiles;