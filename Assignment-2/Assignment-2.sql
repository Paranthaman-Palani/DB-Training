select * from employees;

-- Question 1 
-- Write a SQL query to remove the details of an employee whose first name ends in ‘even’
select * from employee where lower(first_name) like '%even';
delete from employee where lower(first_name) like '%even';

-- 2.	Write a query in SQL to show the three minimum values of the salary from the table.
select * from employee order by salary limit 3;

-- 3.	Write a SQL query to remove the employees table from the database
drop table employees;

--4.	Write a SQL query to copy the details of this table into a new table with table name as Employee table and to delete the records in employees table
create table employee as (select * from employees);
select * from employee;

truncate table employees;
select * from employees;

--5.	Write a SQL query to remove the column Age from the table
alter table employee add column age int;
alter table employee drop column age;

--6.	Obtain the list of employees (their full name, email, hire_year) where they have joined the firm before 2000
select concat(first_name,' ',last_name) as full_name,email ,year(hire_date) as hire_year from employee where hire_year<2000;

--7.	Fetch the employee_id and job_id of those employees whose start year lies in the range of 1990 and 1999

select employee_id,job_id from employee where year(hire_date) >= 1990 and year(hire_date) <= 1999;//last job history

--8.	Find the first occurrence of the letter 'A' in each employees Email ID Return the employee_id, email id and the letter position

select employee_id,email,position('A',email) as letter_position from employee where letter_position>0;

--9.	Fetch the list of employees(Employee_id, full name, email) whose full name holds characters less than 12

select employee_id,concat(first_name,' ',last_name) as full_name,email from employee where len(full_name)-1<12;

--10.	Create a unique string by hyphenating the first name, last name , and email of the employees to obtain a new field named UNQ_ID Return the employee_id, and their corresponding UNQ_ID;

select employee_id,concat(first_name,'-',last_name,'-',email) as UNQ_ID from employee;

--11.	Write a SQL query to update the size of email column to 30
alter table employee modify column email varchar(30);
desc table employee;

-- 12.	Fetch all employees with their first name , email , phone (without extension part) and extension (just the extension)  Info : this mean you need to separate phone into 2 parts eg: 123.123.1234.12345 => 123.123.1234 and 12345 . first half in phone column and second half in extension column

--select first_name,email,substr(phone_number,9,4) from employee
select first_name,email,concat(split_part(phone_number,'.',1),'.',split_part(phone_number,'.',2)) as phone_column,split_part(phone_number,'.',-1) as extension_column from employee;

--13.	Write a SQL query to find the employee with second and third maximum salary.

select * from employee where salary in(select salary from employee order by salary desc limit 2 offset 1);

--14.	  Fetch all details of top 3 highly paid employees who are in department Shipping and IT
select * from employee where department_id in (select department_id from departments where department_name in ('IT','Shipping')) order by salary desc limit 3;

--15.	  Display employee id and the positions(jobs) held by that employee (including the current position)

-- select * from ((select employee.employee_id,job_history.job_id  from employee as employee,job_history, jobs as job where employee.employee_id=job_history.employee_id and job.job_id=job_history.job_id )
-- union
-- (select employee.employee_id,job_title  from employee as employee, jobs as job where employee.job_id=job.job_id) order by employee_id);

select employee_id,job_id  from employee
union
select employee_id,job_id from job_history 
order by employee_id;

--16.	Display Employee first name and date joined as WeekDay, Month Day, Year
--Eg : 
--Emp ID      Date Joined
--1	Mon, June 21st, 1999

select employee_id,concat(dayname(hire_date),', ',monthname(hire_date),' ',day(hire_date),'st,',year(hire_date))as date_joined from employee;

--17.	The company holds a new job opening for Data Engineer (DT_ENGG) with a minimum salary of 12,000 and maximum salary of 30,000 .  
--The job position might be removed based on market trends (so, save the changes) .  - Later, update the maximum salary to 40,000 . - Save the entries as well.-  Now, revert back the changes to the initial state, where the salary was 30,000

select * from jobs;
delete from jobs where job_id = 'DT_ENGG';

begin;
ALTER SESSION SET AUTOCOMMIT = false;
insert into jobs values ('DT_ENGG','Data Engineer',12000,30000);
commit;
update jobs set max_salary=40000 where job_id='DT_ENGG';
rollback;
ALTER SESSION UNSET AUTOCOMMIT;

--18.	Find the average salary of all the employees who got hired after 8th January 1996 but before 1st January 2000 and round the result to 3 decimals

select round(avg(salary),3) as average_salary  from employee where hire_date between '08/01/1996' and '01/01/2000';


--19.	 Display  Australia, Asia, Antarctica, Europe along with the regions in the region table (Note: Do not insert data into the table)

--A. Display all the regions
select * from regions; 

select  region_name from regions
union all select 'Australia' as REGION_NAME
union all select 'Asia' as REGION_NAME
union all select 'Antarctica' as REGION_NAME
union all select 'Europe' as REGION_NAME;
--B. Display all the unique regions
select  region_name from regions
union select 'Australia' as REGION_NAME
union select 'Asia' as REGION_NAME
union select 'Antarctica' as REGION_NAME
union select 'Europe' as REGION_NAME;










