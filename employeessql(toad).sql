


select count(*) from employees;


select count(*) from departments;

select * from departments;


select emp_no,first_name, gender, hire_date
FROM employees;


SELECT emp_no as "사번",
		concat(first_name," ",last_name) AS "이름",
         gender AS "성별", 
         hire_date AS "입사일"
    FROM employees;


select now() from dual;

-- distinct 중복행 제거 

SELECT title FROM titles;


SELECT DISTINCT title FROM titles;


select *
from titles
WHERE title = "Staff";


select *
from salaries
where salary BETWEEN 50000 AND 60000;

SELECT concat( first_name, ' ', last_name ) AS 이름,
         gender AS 성별, 
         hire_date AS 입사일
    FROM employees
   WHERE hire_date < '1991-01-01' ;



   SELECT emp_no, dept_no    
   FROM dept_emp
  WHERE dept_no in( 'd005', 'd009' );
  
  
  
      SELECT concat( first_name, ' ', last_name) AS 이름,
           gender AS 성별, 
           hire_date AS 입사일
      FROM employees
  ORDER BY hire_date;
  
    
      SELECT concat( first_name, ' ', last_name) AS 이름,
           gender AS 성별, 
           hire_date AS 입사일
      FROM employees
  ORDER BY hire_date,first_name;
  
  SELECT emp_no, salary
      FROM salaries
     WHERE from_date like '2001-%' 
  ORDER BY salary DESC;


  
    SELECT concat( first_name, ' ', last_name ) AS 이름,
         hire_date AS 입사일
    FROM employees
   WHERE hire_date LIKE "1989%";



    SELECT concat( first_name, ' ', last_name ) AS 이름,
         hire_date AS 입사일
    FROM employees
   WHERE hire_date >="1989-01-01" and hire_date <="1989-12-31";




SELECT UPPER('SEoul'), UCASE('seOUL') from dual; 


SELECT concat(first_name, ' ',last_name), gender, hire_date
  FROM employees
 WHERE upper(last_name) = 'ACTON' ;
 
 
 SELECT SUBSTRING('Happy Day',3,2);


SELECT concat( first_name, ' ', last_name ) AS 이름,
         hire_date AS 입사일
    FROM employees
   WHERE substring( hire_date, 1, 4)="1989";
   
   
   SELECT LPAD('hi',5,'?'), LPAD('joe',7,'*'); 
   
    SELECT RPAD('hi',5,'?'), RPAD('joe',7,'*'); 



SELECT emp_no, LPAD( cast(salary as char), 10, '*')      
  FROM salaries     
 WHERE from_date like '2001-%'       
   AND salary < 70000;
   
   
   SELECT concat("-----------",LTRIM(' hello ')), concat(RTRIM(' hello '),"-----------"); 


SELECT TRIM(' hi '),TRIM(BOTH 'x' FROM 'xxxhixxx'); 
   
   
SELECT TRIM(' hi '),TRIM(leading 'x' FROM 'xxxhixxx'); 


SELECT TRIM(' hi '),TRIM(trailing 'x' FROM 'xxxhixxx'); 


SELECT emp_no, 
       TRIM( LEADING '*' FROM LPAD( cast(salary as char), 10, '*') )        FROM salaries      
 WHERE from_date like '2001-%'          
   AND salary < 70000;
   
   
   
   SELECT ABS(2), ABS(-2); 
   
   
   SELECT MOD(234,10), 253 % 7, MOD(29,9); 

SELECT FLOOR(1.23), FLOOR(-1.23); 

SELECT CEILING(1.23), CEILING(-1.23); 

SELECT ROUND(-1.23), ROUND(-1.58), ROUND(1.58); 



SELECT ROUND(1.298,1),ROUND(1.298,0); 

SELECT POW(2,2),POWER(2,-2); 


SELECT SIGN(-32), SIGN(0), SIGN(234); 


SELECT GREATEST(2,0),GREATEST(4.0,3.0,5.0),GREATEST("B","A","C"); 


SELECT LEAST(2,0),LEAST(34.0,3.0,5.0),LEAST("b","A","C"); 


SELECT CURDATE(),CURRENT_DATE; 

SELECT CURTIME(),CURRENT_TIME;

SELECT NOW(),SYSDATE(),CURRENT_TIMESTAMP; 

select first_name,date_format(hire_date,"%Y년 %m월 %d일 %H시 ")
from employees; 


select date_format(now(),"%Y년 %m월 %d일 %p %h시 %i분 %s초")
from dual;


select date_format(sysdate(),"%Y년 %m월 %d일 %p %h시 %i분 %s초")
from dual;


SELECT concat(first_name, ' ', last_name) AS name,               
      concat(cast( PERIOD_DIFF( DATE_FORMAT(now(), '%Y%m'),  
                    DATE_FORMAT(hire_date, '%Y%m') ) as char), "개월") as 근무월수, now(), hire_date
  FROM employees ;


select first_name, hire_date, date_add(hire_date, interval 6 month)
from employees;


select concat("현재시간은", cast(now() as char),"입니다") from dual;

select concat("현재시간은", date_format(now(),"%Y 년 %m월 %d일"),"입니다") from dual;

select cast(1-2 as unsigned) from dual;


select cast(cast(1-2 as unsigned) as signed);

select cast(1 as unsigned) -2.0 ;


-- 집계함수

select *
from salaries
where emp_no=10060;

select avg(salary)
from salaries
where emp_no=10060;

select emp_no, avg(salary) as"평균연봉"
from salaries
group by emp_no
order by 평균연봉;

-- 사원별 평균연봉
SELECT AVG(salary) , SUM(salary),max(salary)
FROM salaries
 group by emp_no;


-- 현재 급여중에 최고 급여 

select *
from salaries;

select max(salary), min(salary),avg(salary)
from salaries
where to_date ="9999-01-01";
 
 -- 사원별 직책 변경 횟수
 
 select *
 from titles;
 
 
  
 select emp_no, count(title)
 from titles
 group by emp_no;
 
 -- 평균연봉중 20000만 이상을 평균월급이 높은순으로 출력 
 SELECT emp_no "사원번호", AVG(salary) 
FROM salaries
 group by emp_no
 having avg(salary) >20000
 order by AVG(salary) desc;
 
 
 select a.title, avg(b.salary),count(a.emp_no)
 from titles a,salaries b
 where a.emp_no=b.emp_no and
  a.to_date ="9999-01-01" and b.to_date="9999-01-01"
  group by a.title
  having count(*) >200;
  
  
  -- 1
  
SELECT concat( first_name, ' ', last_name ) AS 이름
    FROM employees
    where emp_no=10944;
 
 
 -- 2
 
 select concat( first_name, ' ', last_name ) AS 이름, gender "성별", hire_date "입사일"
 from employees
 order by hire_date ;
 
 
 -- 3
 
 select gender, count(gender)
 from employees
 group by gender;
 
 select gender, count(emp_no) 
   from employees 
 group by gender; 

 -- 4
 
 select count(*)
 from salaries
 where to_date ="9999-01-01";
 
 -- 5
 
 select count(*)
 from departments;
 
 -- 6
 
 select count(*)
 from dept_manager
 where to_date ="9999-01-01";
 
 select count(*)
 from dept_manager;
 
 -- 7
 
 select * , length(dept_name)
 from departments
 order by length(Dept_name) desc;
 
 
 -- 8
 
 select count(*)
 from salaries
 where salary >=120000 and to_date ="9999-01-01" ;
 
 
 -- 9
 select distinct(title), length(title)
 from titles
 order by length(title) desc ;
 
 -- 10
 
 select count(*)
 from titles
 where title='Engineer' and to_date ="9999-01-01";
 
 -- 11 
 
 select *
 from titles
 where emp_no=13250
 order by from_date ;
 
 
 -- 1
 
 select max(salary) "최고임금", min(salary) "최저임금", max(salary)-min(salary) "최고임금-최저임금"
 from salaries;
 
 
 -- 2
 
 select max(hire_date)
 from employees;
 
 
 -- 3
 
 select min(hire_Date)
 from employees;
 
 
 -- 4
 select avg(salary)
 from salaries
 where to_date="9999-1-1";
 
 
 -- 5
 
 select max(salary), min(salary)
 from salaries
 where to_date="9999-1-1";
 
 
 -- 6
 select date_format(now(),"%Y")-date_format(max(birth_date),"%Y") "어린사원" , date_format(now(),"%Y")-date_format(min(birth_date),"%Y") "많은 사원"
 from employees;
 
 
