-- 1 C:\app\orclUsr\product\12.1.0\dbhome_1\NETWORK\ADMIN
-- 2 show parameters | show parameter instance;
-- 3
-- select tablespace_name, status, contents logging from sys.dba_tablespaces;
-- select file_name, tablespace_name,status, maxbytes,user_bytes from dba_data_files
-- union
-- select file_name, tablespace_name, status, maxbytes, user_bytes from dba_temp_files;
-- select * from dba_sys_privs;
-- select * from dba_profiles;
-- 6
-- connect gvacore/12345@//localhost:1521/gvapdb;
-- conn gvacore/12345@GVAPDB
-- connect gvacore/12345@(DESCRIPTION =(ADDRESS_LIST =(ADDRESS = (PROTOCOL = TCP)(HOST = DESKTOP-0EUKUTV)(PORT = 1521)))(CONNECT_DATA =(SERVICE_NAME = gvapdb)));
-- 7
select count(*) from Tab;
-- 10
select * from user_segments;
-- 11
create or replace view Segments as
select count(*) as segments,
      sum(extents) as extents,
      sum(blocks) as blocks,
      sum(bytes/1024) as kb
from user_segments;
select * from segments;