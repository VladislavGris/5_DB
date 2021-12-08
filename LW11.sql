-- 1 ------------------------
declare
  pulpit_row pulpit%rowtype;
begin
  select * into pulpit_row from pulpit p where p.faculty='ЛХФ' and p.pulpit='ЛВ';
  dbms_output.put_line('Точная выборка:'||pulpit_row.pulpit||''||pulpit_row.faculty);
  exception
  when others
  then dbms_output.put_line(sqlerrm);
end;
-- 2 ---------------------------
declare
  pulpit_row pulpit%rowtype;
begin
  select * into pulpit_row from pulpit p where p.faculty='ЛХФ';
  dbms_output.put_line('Точная выборка:'||pulpit_row.pulpit||''||pulpit_row.faculty);
  exception
  when others
  then dbms_output.put_line(sqlerrm||' ORA'||sqlcode);
end;
-- 3 ---------------------------
declare
  pulpit_row pulpit%rowtype;
begin
  select * into pulpit_row from pulpit p where p.faculty='ЛХФ';
  dbms_output.put_line('Точная выборка:'||pulpit_row.pulpit||''||pulpit_row.faculty);
  exception
  when too_many_rows
  then dbms_output.put_line('результат состоит из нескольких строк ORA'||sqlcode);
  when others
  then dbms_output.put_line(sqlerrm);
end;
-- 4 -------------------------
declare
  pulpit_row pulpit%rowtype;
begin
  select * into pulpit_row from pulpit p where p.faculty='XXX';
  dbms_output.put_line('Точная выборка:'||pulpit_row.pulpit||''||pulpit_row.faculty);
  exception
  when no_data_found
  then  dbms_output.put_line('данные не найдены '||sqlcode);
        dbms_output.put_line(sqlerrm);
  when too_many_rows
  then dbms_output.put_line('результат состоит из нескольких строк ORA'||sqlcode);
  when others
  then dbms_output.put_line(sqlerrm);
end;

declare
  found boolean;
  isopen boolean;
  notfound boolean;
  n pls_integer;
  pulpit_row pulpit%rowtype;
begin
  select * into pulpit_row from pulpit p where p.faculty='ЛХФ'and p.pulpit='ЛВ';
  found := sql%found;
  isopen := sql%isopen;
  notfound := sql%notfound;
  n := sql%rowcount;
  dbms_output.put_line('Точная выборка:'||pulpit_row.pulpit||''||pulpit_row.faculty);
  if found then dbms_output.put_line('found = TRUE');
  else          dbms_output.put_line('found = FALSE');
  end if;
  if isopen then dbms_output.put_line('isopen = TRUE');
  else          dbms_output.put_line('isopen = FALSE');
  end if;
  if notfound then dbms_output.put_line('notfound = TRUE');
  else          dbms_output.put_line('notfound = FALSE');
  end if;
  dbms_output.put_line('n = '||n);
  exception
  when others
  then dbms_output.put_line(sqlerrm);
end;
-- 5 ----------------------------
declare 
  found boolean;
  isopen boolean;
  notfound boolean;
  n pls_integer;
  auditorium_cur auditorium%rowtype;
begin 
  update auditorium set auditorium='314-1',
                        auditorium_name = '314-1',
                        auditorium_capacity = 90,
                        auditorium_type = 'ЛК'
                  where auditorium='301-1';
  rollback;
  found := sql%found;
  isopen := sql%isopen;
  notfound := sql%notfound;
  n := sql%rowcount;
  
  dbms_output.put_line(auditorium_cur.auditorium_name || ' ' ||
                        auditorium_cur.auditorium_capacity|| ' '||
                        auditorium_cur.auditorium_type);
                        
  if found then dbms_output.put_line('found = TRUE');
  else          dbms_output.put_line('found = FALSE');
  end if;
  if isopen then dbms_output.put_line('isopen = TRUE');
  else          dbms_output.put_line('isopen = FALSE');
  end if;
  if notfound then dbms_output.put_line('notfound = TRUE');
  else          dbms_output.put_line('notfound = FALSE');
  end if;
  dbms_output.put_line('n = '||n);
  --rollback;
  --commit;
 exception
  when others
    then dbms_output.put_line(sqlerrm);
end;

-- 6 ---------------------------------------------------
declare 
  auditorium_cur auditorium%rowtype;
begin 
  update auditorium set auditorium='314-1',
                        auditorium_name = '314-1',
                        auditorium_capacity = 90,
                        auditorium_type = 123
                  where auditorium='301-1';
  
  dbms_output.put_line(auditorium_cur.auditorium_name || ' ' ||
                        auditorium_cur.auditorium_capacity|| ' '||
                        auditorium_cur.auditorium_type);
 exception
  when others
    then dbms_output.put_line(sqlerrm);
end;
-- 7 ---------------------------------------------------------------
declare 
  found boolean;
  isopen boolean;
  notfound boolean;
  n pls_integer;
  auditorium_cur auditorium%rowtype;
begin 
  insert into auditorium(auditorium, auditorium_name, auditorium_capacity, auditorium_type)
  values ('302-1', '302-1', 90, 'ЛК');
  --rollback;
  found := sql%found;
  isopen := sql%isopen;
  notfound := sql%notfound;
  n := sql%rowcount;
  
  dbms_output.put_line(auditorium_cur.auditorium_name || ' ' ||
                        auditorium_cur.auditorium_capacity|| ' '||
                        auditorium_cur.auditorium_type);
                        
  if found then dbms_output.put_line('found = TRUE');
  else          dbms_output.put_line('found = FALSE');
  end if;
  if isopen then dbms_output.put_line('isopen = TRUE');
  else          dbms_output.put_line('isopen = FALSE');
  end if;
  if notfound then dbms_output.put_line('notfound = TRUE');
  else          dbms_output.put_line('notfound = FALSE');
  end if;
  dbms_output.put_line('n = '||n);
  rollback;
  --commit;
 exception
  when others
    then dbms_output.put_line(sqlerrm);
end;
-- 8 -----------------------------------------------------------
begin 
  insert into auditorium(auditorium, auditorium_name, auditorium_capacity, auditorium_type)
  values ('302-1', '302-1', 90, 123);
 exception
  when others
    then dbms_output.put_line(sqlerrm);
end;
-- 9 ------------------------------------------------
declare 
  found boolean;
  isopen boolean;
  notfound boolean;
  n pls_integer;
  auditorium_cur auditorium%rowtype;
begin 
  delete auditorium where auditorium = '301-1';
  rollback;
  found := sql%found;
  isopen := sql%isopen;
  notfound := sql%notfound;
  n := sql%rowcount;
  
  dbms_output.put_line(auditorium_cur.auditorium_name || ' ' ||
                        auditorium_cur.auditorium_capacity|| ' '||
                        auditorium_cur.auditorium_type);
                        
  if found then dbms_output.put_line('found = TRUE');
  else          dbms_output.put_line('found = FALSE');
  end if;
  if isopen then dbms_output.put_line('isopen = TRUE');
  else          dbms_output.put_line('isopen = FALSE');
  end if;
  if notfound then dbms_output.put_line('notfound = TRUE');
  else          dbms_output.put_line('notfound = FALSE');
  end if;
  dbms_output.put_line('n = '||n);
  --rollback;
  --commit;
 exception
  when others
    then dbms_output.put_line(sqlerrm);
end;
-- 10 ------------------------------------------------------------
begin 
  delete auditorium where auditorium_type = 123;
 exception
  when others
    then dbms_output.put_line(sqlerrm);
end;
-- 11 -----------------------------------------------------------
declare
  cursor t_curs is select teacher,teacher_name, pulpit from teacher;
  t teacher.teacher%type;
  t_name teacher.teacher_name%type;
  p teacher.pulpit%type;
begin
  open t_curs;
  dbms_output.put_line('rowcount: '||t_curs%rowcount);
    loop
       fetch t_curs into t, t_name, p;
       exit when t_curs%notfound;
       dbms_output.put_line(t_curs%rowcount||' '||t||' '||t_name||' '||p);
    end loop;
  dbms_output.put_line('rowcount: '||t_curs%rowcount);
  close t_curs;
  exception
     when others then dbms_output.put_line(sqlerrm);
end;
-- 12 ----------------------------------------------------------------------------
declare
   cursor s_curs is select subject, subject_name, pulpit from SUBJECT;
   res_row subject%rowtype;
begin
   open s_curs;
   dbms_output.put_line('rowcount: '||s_curs%rowcount);
   fetch s_curs into res_row;
   while s_curs%found
     loop
       dbms_output.put_line(s_curs%rowcount||' '||res_row.subject||' '||res_row.subject_name||' '||res_row.pulpit);
       fetch s_curs into res_row;
     end loop;
   dbms_output.put_line('rowcount: '||s_curs%rowcount);
   close s_curs;
end;
-- 13 ----------------------------------------------------------------------------
declare
  cursor pt_curs is select p.pulpit, t.teacher_name
  from pulpit p inner join teacher t on p.pulpit=t.pulpit;
begin
    for r in pt_curs
    loop
        dbms_output.put_line(pt_curs%rowcount||' '||r.pulpit||' '||r.teacher_name);
    end loop;
end;
-- 14 ---------------------------------------------------------------------------------
select * from auditorium
declare 
  cursor aud_curs(minCap auditorium.auditorium%type,maxCap auditorium.auditorium%type)
  is select auditorium, auditorium_name, auditorium_capacity, auditorium_type from auditorium
  where auditorium_capacity >=minCap and auditorium_capacity <= maxCap;
  a auditorium.auditorium%type;
  a_name auditorium.auditorium_name%type;
  a_type auditorium.auditorium_type%type;
  aud_capac auditorium.auditorium_capacity%type;
  aud_row auditorium%rowtype;
begin
  open aud_curs(0,20);
  dbms_output.put_line('------- 0-20');
  loop
    fetch aud_curs into a,a_name, aud_capac,a_type;
    exit when aud_curs%notfound;
    dbms_output.put_line(aud_curs%rowcount||' '||a||' '||aud_capac||' '||a_name||' '||a_type);
  end loop;
  close aud_curs;
--  open aud_curs(21,30);
--  dbms_output.put_line('------- 21-30');
--  fetch aud_curs into aud_row;
--   while aud_curs%found
--     loop
--       dbms_output.put_line(aud_curs%rowcount||' '||aud_curs.auditorium||' '||aud_curs.auditorium_name||' '||aud_curs.auditorium_type||' '||aud_curs.auditorium_capacity);
--       fetch aud_curs into aud_row;
--     end loop;
--  close aud_curs;
  dbms_output.put_line('------- 21-30');
  for r in aud_curs(21,30)
  loop
    dbms_output.put_line(r.auditorium||' '||r.auditorium_name||' '||r.auditorium_type||' '||r.auditorium_capacity);
  end loop;
  dbms_output.put_line('------- 31-60');
  for r in aud_curs(31,60)
  loop
    dbms_output.put_line(r.auditorium||' '||r.auditorium_name||' '||r.auditorium_type||' '||r.auditorium_capacity);
  end loop;
  dbms_output.put_line('------- 61-80');
  for r in aud_curs(61,80)
  loop
    dbms_output.put_line(r.auditorium||' '||r.auditorium_name||' '||r.auditorium_type||' '||r.auditorium_capacity);
  end loop;
  dbms_output.put_line('------- 81-3000');
  for r in aud_curs(81,3000)
  loop
    dbms_output.put_line(r.auditorium||' '||r.auditorium_name||' '||r.auditorium_type||' '||r.auditorium_capacity);
  end loop;
end;
-- 15 ------------------------------------------------------------------------------------------------------
select * from auditorium;
declare
  curs sys_refcursor;
  aud_row auditorium%rowtype;
begin
  open curs for select * from auditorium where auditorium_capacity > 20;
  loop
    fetch curs into aud_row;
    EXIT WHEN curs%NOTFOUND;
    dbms_output.put_line(aud_row.auditorium||' '||aud_row.auditorium_name||' '||aud_row.auditorium_capacity||' '||aud_row.auditorium_type);
  end loop;
  fetch curs into aud_row;
end;
-- 16 ------------------------------------------------------------------------------------------------
declare 
  cursor curs_aut is select auditorium_type,
      cursor (select auditorium from auditorium aum
          where aut.auditorium_type = aum.auditorium_type)
      from auditorium_type aut;
  curs_aum sys_refcursor;
  aut auditorium_type.auditorium_type%type;
  txt varchar2(1000);
  aum auditorium.auditorium%type;
begin
  open curs_aut;
   fetch curs_aut into aut, curs_aum;
   while(curs_aut%found)
      loop
        txt:=rtrim(aut)||':';
        loop
          fetch curs_aum into aum;
          exit when curs_aum%notfound;
          txt := txt||','||rtrim(aum);
        end loop;
        dbms_output.put_line(txt);
        fetch curs_aut into aut, curs_aum;
      end loop;
  close curs_aut;
  exception
  when others
      then dbms_output.put_line(sqlerrm);
end;
-- 17 -------------------------------------------------------
select * from auditorium where auditorium_capacity >= 40 and auditorium_capacity <= 80;
declare 
  cursor curs_auditorium(min_capac auditorium.auditorium%type, max_capac auditorium.auditorium%type)
    is select auditorium, auditorium_capacity
      from auditorium
      where auditorium_capacity >=min_capac and auditorium_capacity <= max_capac for update;
  aum auditorium.auditorium%type;
  cty auditorium.auditorium_capacity%type;
begin
  open curs_auditorium(40,80);
  fetch curs_auditorium into aum, cty;
  while(curs_auditorium%found)
    loop
      cty := cty * 0.9;
      update auditorium
      set auditorium_capacity = cty
      where current of curs_auditorium;
      dbms_output.put_line(' '||aum||' '||cty);
      fetch curs_auditorium into aum, cty;
    end loop;
  close curs_auditorium;
  rollback;
  exception
  when others
    then dbms_output.put_line(sqlerrm);
end;
-- 18 -------------------------------------------------------------------
select * from auditorium order by auditorium_capacity;
declare 
  cursor cur(min_capac auditorium.auditorium%type,max_capac auditorium.auditorium%type)
  is select auditorium, auditorium_capacity from auditorium
  where auditorium_capacity between min_capac and max_capac for update;
  aum auditorium.auditorium%type;
  cty auditorium.auditorium_capacity%type;
begin
  open cur(0,20);
  fetch cur into aum, cty;
  while(cur%found)
      loop
          delete auditorium where current of cur;
          fetch cur into aum, cty;
      end loop;
  close cur;
  for pp in cur(0,120) loop
     dbms_output.put_line(pp.auditorium||' '||pp.auditorium_capacity);
  end loop; 
  rollback;
end;
-- 19 ---------------------------------------------------------------------
select * from auditorium
declare
  cursor curs_auditorium (capacity auditorium.auditorium%type)
  is select auditorium, auditorium_capacity, rowid
  from auditorium
  where auditorium_capacity >= capacity for update;
  aum auditorium.auditorium%type;
  cty auditorium.auditorium%type;
begin
  for xxx in curs_auditorium(40)
  loop
    case
    when xxx.auditorium_capacity >= 50
      then
      begin
        delete auditorium
        where rowid = xxx.rowid;
      end;
      
    when xxx.auditorium_capacity >= 40
      then update auditorium
        set auditorium_capacity = auditorium_capacity+3
        where rowid = xxx.rowid;
    end case;
  end loop;
  
  for yyy in curs_auditorium(0)
  loop
    dbms_output.put_line(' '||yyy.auditorium||' '||yyy.auditorium_capacity);
  end loop;
  rollback;
  exception
  when others
    then dbms_output.put_line(sqlerrm);
end;
-- 20 --------------------------------------------------------
declare 
  cursor curs_teacher is select teacher, teacher_name, pulpit from teacher;
  r_teacher teacher.teacher%type;
  teacher_name teacher.teacher_name%type;
  pulpit teacher.pulpit%type;
  k integer :=1;
begin
    open curs_teacher;
    loop
      fetch curs_teacher into r_teacher, teacher_name, pulpit;
      exit when curs_teacher%notfound;
      dbms_output.put_line(' '||curs_teacher%rowcount||' '
                            ||r_teacher||' '
                            ||teacher_name||' '
                            ||pulpit);
      if (k mod 3 = 0) 
        then dbms_output.put_line('-------------------------------------'); 
      end if;
      k:=k+1;
    end loop;
     dbms_output.put_line('rowcount = '|| curs_teacher%rowcount);
   close curs_teacher;
    exception
    when others
      then  dbms_output.put_line(sqlerrm);
end;