-- 1 ---------------------------------------
alter table teacher
add(BIRTHDAY date, SALARY decimal);

declare
cursor curs is select * from teacher;
teach teacher%rowtype;
i number(3):=1;
begin
  open curs;
  fetch curs into teach;
  while(curs%found)
  loop
    update teacher
    set BIRTHDAY = to_date(i||'.01.1990','DD.MM.YYYY'),
    SALARY = i*100
    where teacher = teach.teacher;
    i:=i+1;
    if(i=30) then i := 1; end if;
    fetch curs into teach;
  end loop;
  close curs;
  commit;
end;

select * from teacher;
-- 2 --------------------------------------------
select regexp_substr(teacher_name,'(\S+)',1, 1)||' '||
      substr(regexp_substr(teacher_name,'(\S+)',1, 2),1, 1)||'. '||
      substr(regexp_substr(teacher_name,'(\S+)',1, 3),1, 1)||'. ' from teacher;
-- 3 ----------------------------------------
select teacher_name from teacher where to_char(birthday,'dy') = 'пн';
-- 4 ----------------------------------------------------
create view next_month_birthday as
select * from teacher where extract(month from birthday) = extract(month from add_months(current_date,1));

select * from next_month_birthday;
-- 5 -----------------------------------------------------------------
insert into teacher
values ('ИИИ','Иванов Иван Иванович', 'ИСиТ', to_date('01.02.1990','DD.MM.YYYY'),1000);
insert into teacher
values ('ППП','Петров Петр Петрович', 'ИСиТ', to_date('01.03.1990','DD.MM.YYYY'),1000);

create view month_birthday_count as
select to_char(birthday,'month') as Месяц, count(*) as Количество_преподавателей
from teacher group by to_char(birthday,'month');

select * from month_birthday_count;
-- 6 ----------------------------------------------------------------------------
insert into teacher
values ('ССС','Сидоров Сидор Сидорович', 'ИСиТ', to_date('01.03.1992','DD.MM.YYYY'),1000);

declare
cursor curs is select * from teacher 
where mod((extract(year from current_date)+1)-extract(year from birthday),10)=0;
teach teacher%rowtype;
begin
  open curs;
  fetch curs into teach;
  while curs%found
  loop
    dbms_output.put_line(teach.teacher_name||' '||teach.birthday);
    fetch curs into teach;
  end loop;
  close curs;
end;
-- 7 ---------------------------------------------------------------
declare
cursor curs is select p.pulpit, round(avg(t.salary)) avg_salary from teacher t inner join pulpit p on t.pulpit = p.pulpit group by p.pulpit;
cursor f_curs is select p.faculty, round(avg(t.salary)) as Salary from pulpit p inner join teacher t on p.pulpit=t.pulpit group by p.faculty;
pulp pulpit.pulpit%type;
t_avg teacher.salary%type;
f pulpit.faculty%type;
avg_sum teacher.salary%type;
i number(3):=0;
begin
  avg_sum:=0;
  open curs;
  fetch curs into pulp, t_avg;
  while curs%found
  loop
    dbms_output.put_line('Pulpit: '||pulp||' avg: '||t_avg);
    avg_sum:=avg_sum + t_avg;
    i:=i+1;
    fetch curs into pulp, t_avg;
  end loop;
  dbms_output.put_line('Faculties');
  open f_curs;
  fetch f_curs into f, t_avg;
  while f_curs%found
  loop
    dbms_output.put_line('Faculty: '||f||' avg: '||t_avg);
    fetch f_curs into f, t_avg;
  end loop;
  close f_curs;
  dbms_output.put_line('Total in university: '||round(avg_sum/i));
  close curs;
end;
-- 8 ------------------------------------------------------
declare
  type address is record(
    city varchar2(100):='Moscow',
    street varchar2(100):='Street-1',
    house varchar2(20):='12'
  );
  type person is record(
    name teacher.teacher_name%type,
    code teacher.teacher%type,
    addr address
  );
  teach person;
begin
  dbms_output.put_line(teach.addr.city||' '||teach.addr.street||' '||teach.addr.house||' '||teach.name||' '||teach.code);
  teach.addr.city := 'Minsk';
  teach.addr.street := 'Street';
  teach.addr.house := '3';
  dbms_output.put_line(teach.addr.city||' '||teach.addr.street||' '||teach.addr.house||' '||teach.name||' '||teach.code);
  --select teacher_name, teacher into teach from teacher;
end;