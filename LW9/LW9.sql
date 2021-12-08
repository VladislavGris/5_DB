-- 2
create sequence S1
      increment by 10
      start with 1000
      nomaxvalue nominvalue nocycle nocache noorder;
    
select S1.nextval from dual;
drop sequence S1;
-- 3 
create sequence S2
      increment by 10
      start with 10
      maxvalue 100
      nominvalue nocycle nocache noorder;
      
select S2.nextval from dual;
select S2.currval from dual;
drop sequence S2;

-- 5 
create sequence S3
      start with -10
      increment by -10
      minvalue -100
      nocycle order;
      
select S3.nextval from dual;
select S3.currval from dual;

drop sequence S3;
-- 6
create sequence S4
      start with 1
      increment by 1
      maxvalue 10
      cycle
      cache 5
      noorder;
      
select S4.nextval from dual;
select S4.currval from dual;   

drop sequence S4;
-- 7
select * from sys.dba_sequences where sequence_owner='U1_GVA_PDB';
-- 8
create table T1 (N1 number(20),
                 N2 number(20),
                 N3 number(20),
                 N4 number(20)) cache;
alter table T1 storage (buffer_pool keep);

declare i number:=1;
begin loop
insert into T1 (N1, N2, N3, N4) values (S1.nextval, S2.nextval, S3.nextval, S4.nextval);
i:=i+1;
exit when i=8;
end loop;
end;

select * from T1;

drop table T1;
-- 9
create cluster ABC(X number(10),
                   V varchar2(12)
                  ) hashkeys 200;
drop cluster ABC
-- 10
create table A(XA number(10),
               VA varchar2(12), 
               YA number(20))
cluster ABC (XA, VA); 
drop table A
-- 11
create table B(XB number(10),
               VB varchar2(12), 
               YB number(20))
cluster ABC (XB, VB); 
drop table B
-- 12 
create table C(XC number(10),
               VC varchar2(12), 
               YC number(20))
cluster ABC (XC, VC);
drop table C
-- 13
select * from dba_clusters;
select * from dba_tables where owner = 'U1_GVA_PDB';
-- 14
create synonym synonymC for C;
select * from synonymC;

drop synonym synonymC;
-- 15
create public synonym synonymB for B;
select * from synonymB;

drop public synonym synonymB;
-- 16
create table AT(x number(10) primary key, y number(10));
create table BT(x number(10) primary key, ax number(10));
alter table BT
add constraint FK_BT_AT
foreign key (ax) references AT(x);

insert into AT(x,y) values (1,1);
insert into AT(x,y) values (2,2);
insert into AT(x,y) values (3,3);
insert into AT(x,y) values (4,4);

insert into BT(x,ax) values (1,1);
insert into BT(x,ax) values (2,2);
insert into BT(x,ax) values (3,3);
select * from AT;
select * from BT;

create view V1 as select AT.x as AX, AT.y as AY, BT.x as BX, BT.ax as BAX from AT inner join BT on AT.x = BT.ax;
select * from V1;
drop view V1;
drop table BT;
drop table AT;

-- 17
create materialized view MV
build immediate 
refresh complete start with (sysdate) next  (sysdate+2/1440) with rowid
as select * from AT;

select * from MV;
select * from AT;
select count(*) from MV;
insert into AT(x,y) values (8,8);
commit;
drop materialized view MV;