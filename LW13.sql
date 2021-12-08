-- 1 --------------------------------------------
create or replace procedure GET_TEACHERS(PCODE in TEACHER.PULPIT%TYPE)
is
  cursor curs is 
  select teacher_name 
  from teacher
  where pulpit = PCODE;
  teach teacher.teacher_name%type;
begin
  open curs;
  fetch curs into teach;
  while curs%found
  loop
    dbms_output.put_line(teach);
    fetch curs into teach;
  end loop;
  close curs;
end GET_TEACHERS;

begin
  GET_TEACHERS('ÈÑèÒ');
end;
-- 2 -------------------------------------------------------
create or replace function GET_NUM_TEACHERS(PCODE in TEACHER.PULPIT%TYPE)
return number is
  tcount number(5);
begin
  select count(*)
  into tcount
  from teacher
  where pulpit = PCODE;
  return tcount;
end GET_NUM_TEACHERS;
declare
  tcount number(5);
begin
  tcount := get_num_teachers('ÈÑèÒ');
  dbms_output.put_line('Count: '||tcount);
end;
-- 3 -------------------------------------------------
create or replace procedure get_teachers(fcode faculty.faculty%type)
is
  cursor curs is 
  select t.teacher_name
  from teacher t inner join pulpit p on t.pulpit = p.pulpit
  where p.faculty = fcode;
  tname teacher.teacher_name%type;
begin
  open curs;
  fetch curs into tname;
  while curs%found
  loop
    dbms_output.put_line(tname);
    fetch curs into tname;
  end loop;
  close curs;
end get_teachers;
begin
  get_teachers('ÈÄèÏ');
end;

create or replace procedure get_subjects(pcode subject.pulpit%type)
is
  cursor curs is
  select subject_name
  from subject
  where pulpit = pcode;
  sname subject.subject_name%type;
begin
  open curs;
  fetch curs into sname;
  while curs%found
  loop
    dbms_output.put_line(sname);
    fetch curs into sname;
  end loop;
  close curs;
end get_subjects;
begin
  get_subjects('ÈÑèÒ');
end;
-- 4 ----------------------------------------------
create or replace function get_num_teachers(fcode faculty.faculty%type)
return number is
  nteach number(5);
begin
  select count(*)
  into nteach
  from teacher t inner join pulpit p on t.pulpit = p.pulpit
  where p.faculty = fcode;
  return nteach;
end get_num_teachers;
declare
  tcount number(5);
begin
  tcount := get_num_teachers('ÈÄèÏ');
  dbms_output.put_line('Teacher count: '||tcount);
end;

create or replace function get_num_subjects(pcode subject.pulpit%type)
return number is
  scount number(5);
begin
  select count(*)
  into scount
  from subject
  where pulpit = pcode;
  return scount;
end get_num_subjects;
declare
  tcount number(5);
begin
  tcount := get_num_subjects('ÈÑèÒ');
  dbms_output.put_line('Subject count: '||tcount);
end;
-- 5 -----------------------------------------------------
create or replace package teachers as

  procedure get_teachers(PCODE TEACHER.PULPIT%TYPE);
  procedure get_subjects(pcode subject.pulpit%type);
  function get_num_teachers(fcode faculty.faculty%type) return number;
  function get_num_subjects(pcode subject.pulpit%type) return number;

end teachers;

create or replace package body teachers is
  procedure GET_TEACHERS(PCODE in TEACHER.PULPIT%TYPE)
  is
    cursor curs is 
    select teacher_name 
    from teacher
    where pulpit = PCODE;
    teach teacher.teacher_name%type;
  begin
    open curs;
    fetch curs into teach;
    while curs%found
    loop
      dbms_output.put_line(teach);
      fetch curs into teach;
    end loop;
    close curs;
  end GET_TEACHERS;
  
  procedure get_subjects(pcode subject.pulpit%type)
  is
    cursor curs is
    select subject_name
    from subject
    where pulpit = pcode;
    sname subject.subject_name%type;
  begin
    open curs;
    fetch curs into sname;
    while curs%found
    loop
      dbms_output.put_line(sname);
      fetch curs into sname;
    end loop;
    close curs;
  end get_subjects;
  
  function get_num_teachers(fcode faculty.faculty%type)
  return number is
    nteach number(5);
  begin
    select count(*)
    into nteach
    from teacher t inner join pulpit p on t.pulpit = p.pulpit
    where p.faculty = fcode;
    return nteach;
  end get_num_teachers;
  function get_num_subjects(pcode subject.pulpit%type)
  return number is
    scount number(5);
  begin
    select count(*)
    into scount
    from subject
    where pulpit = pcode;
    return scount;
  end get_num_subjects;
end teachers;

-- 6 ----------------------------------------------------------
begin
  teachers.GET_TEACHERS('ÈÑèÒ');
  teachers.get_subjects('ÈÑèÒ');
  dbms_output.put_line('Teacher count: '||get_num_teachers('ÈÄèÏ'));
  dbms_output.put_line('Subject count: '||get_num_subjects('ÈÑèÒ'));
end;