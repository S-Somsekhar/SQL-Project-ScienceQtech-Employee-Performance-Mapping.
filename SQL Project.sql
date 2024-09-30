Create database employee;
use employee;
-- Create an ER diagram for the given employee database
select emp_id, first_name, Last_name, gender, dept from emp_record_table; 
select emp_id, first_name, Last_name, gender, dept, EMP_RATING from emp_record_table where emp_rating<2;
select emp_id, first_name, Last_name, gender, dept, EMP_RATING from emp_record_table where emp_rating>4;
select emp_id, first_name, Last_name, gender, dept, EMP_RATING from emp_record_table where emp_rating between 2 and 4;
select concat(first_name, ' ', last_name) as NAME from emp_record_table where dept = "finance";
SELECT concat(e.FIRST_NAME, ' ', e.LAST_NAME) AS Manager_Name, COUNT(r.emp_id) AS Number_of_Reporters
FROM emp_record_table as e JOIN emp_record_table as r 
ON e.emp_id = r.manager_id GROUP BY e.FIRST_NAME, e.LAST_NAME HAVING COUNT(r.emp_id) > 0;
select * from emp_record_table where dept = "healthcare" union select * from emp_record_table where dept = "finance";
SELECT e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, e.ROLE, e.Dept, e.EMP_RATING, dept_max.Max_Rating
FROM emp_record_table e 
JOIN 
    (SELECT DEPT, MAX(EMP_RATING) AS Max_Rating
     FROM emp_record_table
     GROUP BY dept) dept_max
ON e.dept = dept_max.DEPT ORDER BY e.dept;
select max(salary) as Max_sal, min(salary) as Min_sal, role from emp_record_table group by role;
select emp_id, FIRST_NAME, LAST_NAME, role, dept, EXP, dense_rank() over( order by EXP desc) as Rank_by_exp from emp_record_table;
create view EMP_DATA as select emp_id, FIRST_NAME, LAST_NAME, gender, role, dept, salary, country from emp_record_table where salary>6000;
select * from emp_data;
select emp_id, first_name, last_name, role, dept, EXP from emp_record_table where exp>10 order by EXP desc;  
CREATE DEFINER=`root`@`localhost` PROCEDURE `EXP_over_3`()
 select * from emp_record_table where EXP>3 order by exp desc;
 call EXP_over_3();
select * from data_science_team;
select * from proj_table;
delimiter //
CREATE FUNCTION get_job_profile(exp INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE job_profile VARCHAR(50);
    
    IF exp <= 2 THEN
        SET job_profile = 'JUNIOR DATA SCIENTIST';
    ELSEIF exp > 2 AND exp <= 5 THEN
        SET job_profile = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF exp> 5 AND exp <= 10 THEN
        SET job_profile = 'SENIOR DATA SCIENTIST';
    ELSEIF exp > 10 AND exp <= 12 THEN
        SET job_profile = 'LEAD DATA SCIENTIST';
    ELSEIF exp> 12 AND exp <= 16 THEN
        SET job_profile = 'MANAGER';
    ELSE
        SET job_profile = 'NO STANDARD ROLE';
    END IF;
        RETURN job_profile;
END//
Delimiter ;
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP, ROLE, get_job_profile(EXP) AS STANDARD_PROFILE,
    CASE WHEN ROLE = get_job_profile(EXP) THEN 'MATCHES'
        ELSE 'DOES NOT MATCH'
    END AS PROFILE_MATCH
FROM data_science_team;
alter table emp_record_table modify FIRST_NAME varchar(15);
CREATE INDEX i1 ON emp_record_table(FIRST_NAME);
SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT FROM emp_record_table WHERE FIRST_NAME = 'Eric';
explain SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT FROM emp_record_table WHERE FIRST_NAME = 'Eric';
select EMP_ID, FIRST_NAME, LAST_NAME, role, dept, salary, EMP_RATING, salary*0.05*emp_rating as bonus from emp_record_table;
SELECT continent, country, AVG(salary) AS average_salary FROM emp_record_table GROUP BY continent, country;





