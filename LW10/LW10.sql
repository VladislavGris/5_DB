-- 1
begin
  null;
end;

-- 2
set serveroutput on 
begin
  dbms_output.put_line('Hello world');
end;

-- 3
declare
  x number(3) := 3;
  y number(3) := 0;
  z number(10,2);
begin
  z:=x/y;
  exception when others
      then dbms_output.put_line(sqlcode||': error = '||sqlerrm);
end;

-- 4
declare
  x number(3) := 3;
  y number(3) := 0;
  z number(10,2);
begin
  dbms_output.put_line('x='||x||', y='||y);
  begin
    z:=x/y;
    exception when others
      then dbms_output.put_line(sqlcode||': error = '||sqlerrm);
  end;
  dbms_output.put_line('z='||z);
end;

-- 5
show parameter plsql_warnings;
select name,value from v$parameter where name='plsql_warnings';

--6
select keyword from v$reserved_words where length = 1 and keyword not between 'A' and 'Z';

--7
select keyword from v$reserved_words where length > 1 and keyword!='A' order by keyword;

--8
show parameter plsql

--9
declare
  n1 number(3) := 4;
  n2 number(3) := 5;
  sumn number(10,2); 
  div number(10,2);
  
  fix number(10,2)    := 3.14;
  neg number(32, 5)   := 12.234567;
  en number(32,-2)    := 123456789.123456;
  
  bf binary_float     := 123456789.12345678911;
  bd binary_double    := 123456789.12345678911;
  exp number(32,10)    := 12345E-10;
  b1 boolean          := true; 
begin
   sumn :=n1+n2;
   div := mod(n1,n2);
   dbms_output.put_line('n1='||n1);
   dbms_output.put_line('n2='||n2);
   dbms_output.put_line('n1+n2='||sumN);
   dbms_output.put_line('n1%n2='||div);
        
   dbms_output.put_line('fix='||fix);
   dbms_output.put_line('neg='||neg);
   dbms_output.put_line('en='||en);
   
   dbms_output.put_line('bf='||bf);
   dbms_output.put_line('bd='||bd);
   dbms_output.put_line('exp='||exp);
    if b1 then 
      dbms_output.put_line('true'); 
    end if;
end;

-- 18
declare
   n constant number(1) := 1;
   vc constant varchar2(10) := 'VCH';
   ch constant char(10) :='CH';
begin
  dbms_output.put_line('const n = '||n);
  dbms_output.put_line('const vc = '||vc);
  dbms_output.put_line('const ch = '||ch);
        
  n := 2;
  exception when others
    then dbms_output.put_line('error = '||n);
end;

-- 19-20
select auditorium_name from AUDITORIUM;
declare
   name varchar(25) := 'Smith';
   surname name%TYPE := 'Jones';
   x  AUDITORIUM%ROWTYPE;
begin
   x.auditorium_name := '123-1';
   dbms_output.put_line('name = '||name);
   dbms_output.put_line('surname = '||surname);
   dbms_output.put_line(x.auditorium_name);
end;

-- 21
declare
   x number := 17;
begin
   if 8>x then dbms_output.put_line('8>'||x);
   elsif 8=x then dbms_output.put_line('8='||x);
   else dbms_output.put_line('8<'||x);
   end if;
end;

-- 23
declare
  x number := 17;
begin
  case x
     when 17 then dbms_output.put_line('17');
  end case;
  case
      when 8>x then dbms_output.put_line('8>'||x);
      when x between 13 and 20 then dbms_output.put_line('between 13 and 20');
      else dbms_output.put_line('other');
  end case;
end;
    
-- 24-26
declare
  x number :=0;
begin
  loop x:=x+1;
     dbms_output.put(x);
    exit when x>5;
  end loop;
  dbms_output.put_line('');
  for k in 1..5
  loop 
        dbms_output.put(k); 
  end loop;
   dbms_output.put_line('');    
   while (x>0)
      loop x:=x-1;
      dbms_output.put_line(x);
      end loop;
end;