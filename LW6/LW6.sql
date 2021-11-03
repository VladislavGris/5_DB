-- 1
select * from v$sga;
select SUM(VALUE) from v$sga;

-- 2
select * from v$sga_dynamic_components where current_size > 0;

-- 3
select COMPONENT, GRANULE_SIZE from v$sga_dynamic_components where current_size > 0;

-- 4
select sum(min_size), sum(max_size), sum(current_size) from v$sga_dynamic_components;

-- 5
select component, min_size, current_size, max_size from v$sga_dynamic_components;

-- 6
create table Table1(x int) storage(buffer_pool keep) tablespace TS_GVA;
insert into Table1(x) values (1);
commit;
select * from Table1;

drop table Table1;

select segment_name, segment_type, tablespace_name, buffer_pool from user_segments;

-- 7
create table Table2(x int) storage(buffer_pool default) tablespace TS_GVA;
insert into Table2(x) values (1);
commit;

drop table Table2;

select segment_name, segment_type, tablespace_name, buffer_pool from user_segments;

-- 8
show parameter log_buffer;

-- 9
select * from v$sgastat where pool = 'shared pool'
order by bytes desc
fetch first 10 rows only;

-- 10
select pool, name, bytes from v$sgastat where pool = 'large pool' and name = 'free memory';

-- 11
select username, server from v$session;

-- 12
select username, server from v$session;


select name,type,executions from v$db_object_cache order by executions;