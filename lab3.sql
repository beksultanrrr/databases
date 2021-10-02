--ex1;
select  *from course where credits>3;
select *from classroom where building='Packard' or building='Watson';
select *from course where dept_name='Comp. Sci.';
select teaches.course_id, section.course_id
from teaches,section where teaches.semester='Fall' and section.semester='Fall';
select *from  student  where tot_cred between 45 and 90;
select  *from student where name like '%a' or name like '%e'  or name like '%e'  or name like '%i' or name like '%o' or name like '%u';
select *from course ,  prereq where prereq_id='CS-101' and course.course_id = prereq.course_id;
---------------------------------------------------------------------Ex2
----a
select dept_name, avg(salary) from instructor
group by dept_name
order by avg(salary);
----b
SELECT building , COUNT(course_id)
   from section
    GROUP BY building, course_id
order by count(*) desc
limit 1;
------c
select course.dept_name ,  count(course_id)
from course group by dept_name
order by  count(*) asc
limit  5;
------
--d
SELECT name,takes.ID, COUNT(takes.ID)
    FROM takes,student
    where takes.ID=student.ID  and  takes.course_id like 'CS%'
    GROUP BY takes.ID, student.ID
    HAVING COUNT(*) > 3;
--e
select *from instructor
where dept_name = 'Biology' or dept_name = 'Philosophy' or dept_name = 'Music';
----f
select  distinct instructor.ID,year
from instructor,teaches
where teaches.ID=instructor.ID and year not in(
    select year
    from teaches
    where (year='2017' and year<>'2018')
    );

-----------------------------------------------------------------------------
----------------------------------------------------------------------------3
-----a
select distinct student.name
       from takes, student,course where takes.id=student.id and ( takes.grade='' or takes.grade='A-') and student.dept_name='Comp. Sci.' and course.dept_name='Comp. Sci.'
order by student.name;
-----------b
select *from advisor;
select distinct student.name,takes.grade
from takes, student,course, advisor  where advisor.s_ID= takes.id and
advisor.s_ID = student.id and takes.id = student.id
                    and ( takes.grade='C' or takes.grade='C-' or  takes.grade='F' or  takes.grade='+C' );
----------------c
select distinct department.dept_name
from student,
     takes,
     department
where student.id = takes.id
  and department.dept_name = student.dept_name
  and department.dept_name not in (select department.dept_name
                                   from student,
                                        takes,
                                        department
                                   where student.id = takes.id
                                     and department.dept_name = student.dept_name
                                     and (takes.grade = 'F' or takes.grade = 'C'));
-----------------------------------------------------d
select distinct name, teaches.ID
from takes,teaches,instructor
where instructor.id=teaches.id and takes.course_id=teaches.course_id and takes.course_id  not in  (
    select takes.course_id
    from takes
    where grade = 'A'
    );

-----e
select distinct  course_id,end_hr,end_min
from time_slot, section
where section.time_slot_id= time_slot.time_slot_id and end_hr<13 or (end_hr=13 and end_min=0);
-----------
