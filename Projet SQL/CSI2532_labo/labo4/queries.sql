/*
select name, course_id
from instructor, teaches
where instructor.ID = teaches.ID;


select name, course_id
from instructor, teaches
where instructor.ID = teaches.ID and instructor.dept_name = 'Astronomy';


SELECT DISTINCT T.name, T.dept_name
FROM instructor as T, instructor as S
WHERE T.salary > S.salary and S.dept_name = 'Comp. Sci.'
ORDER BY T.name;


SELECT NAME
FROM instructor
WHERE name LIKE '%in%';


SELECT name, dept_name, salary
FROM instructor
WHERE salary BETWEEN 90000 and 100000

SELECT avg(salary)
FROM instructor
WHERE dept_name = 'Comp. Sci.'

SELECT Count(*)
FROM course;


SELECT count(DISTINCT ID)
FROM takes
WHERE (course_id, sec_id, semester, year) in
        (select course_id, sec_id, semester, year
        FROM teaches
        WHERE teaches.ID = '22591');
*/

SELECT dept_name, avg_salary
FROM (SELECT dept_name, avg(salary)
FROM instructor GROUP BY dept_name)
AS dept_avg(dept_name, avg_salary)
WHERE avg_salary > 42000