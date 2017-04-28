

SELECT  CONCAT(employees.last_name, ' ' , employees.first_name) AS name, 		    employees.emp_no, 		
                 titles.emp_no,		
                 titles.title  
FROM	   employees, titles 
WHERE  employees.emp_no = titles.emp_no -- 조인조건
and employees.gender="F"; -- now 선택 조건 


select a.first_name,b.title,a.emp_no
from employees a, titles b
where a.emp_no=b.emp_no;

-- natural join
select count(*)
from employees natural join titles;


-- join ~ using

select count(*)
from employees join titles using (emp_no);

-- join ~ on

select count(*)
from employees a join titles b on a.emp_no=b.emp_no;

 -- 직책이 engneer 인 여직원의 일므과 직책 
 
 
 select *
 from employees a,titles b
 where a.emp_no=b.emp_no
 and b.title="Enginner" and a.gender="F";


 select *
 from employees a join titles b 
 on a.emp_no=b.emp_no
 where b.title="Enginner" and a.gender="F";
 
 
 -- 현재 회사 상황을 반영한 직원별 근무부서를  사번, 직원 전체이름, 근 무부서 형태로 출력해 보세요.

 select a.emp_no "사번",CONCAT(a.last_name, ' ' , a.first_name) "이름",c.dept_name "근무부서" 
 from employees a, dept_emp b, departments c
 where a.emp_no = b.emp_no and b.dept_no=c.dept_no
 and b.to_date="9999-1-1";
 
 -- 현재 회사에서 지급되고 있는 급여체계를 반영한 결과를 출력하세요. 사번,  전체이름, 연봉  이런 형태로 출력하세요.    


 
 select a.emp_no "사번", CONCAT(a.last_name, ' ' , a.first_name) "이름",b.salary "연봉"
 from employees a, salaries b
 where a.emp_no = b.emp_no
and b.to_date="9999-1-1";
 

-- 현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 추력


select b.dept_no
from employees a, dept_emp b
where a.emp_no=b.emp_no
and b.to_date="9999-1-1"
and concat(a.first_name,' ',a.last_name)="Fai Bale";



select a.emp_no,b.dept_no,a.first_name
from employees a, dept_emp b
where a.emp_no=b.emp_no
and b.dept_no="d004" and b.to_date="9999-1-1";


select a.emp_no,b.dept_no,a.first_name
from employees a, dept_emp b
where a.emp_no=b.emp_no
and b.to_date="9999-1-1"
and b.dept_no=(select b.dept_no
				from employees a, dept_emp b
				where a.emp_no=b.emp_no
				and b.to_date="9999-1-1"
				and concat(a.first_name,' ',a.last_name)="Fai Bale");
                
                
                
select a.emp_no,b.dept_no,a.first_name
from employees a, dept_emp b
where a.emp_no=b.emp_no
and b.to_date="9999-1-1"
and b.dept_no in (select dept_no from departments); -- 아무 의미 없음, = 일때ㅐ 서브쿼리가 다중행이면 오류


-- 현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의  이름, 급여를  나타내세요.


select concat(a.first_name,' ',a.last_name) "이름", b.salary
from employees a,salaries b
where a.emp_no=b.emp_no
and b.to_date="9999-1-1"
and b.salary <( select avg(salary)
				from  salaries b
				where  b.to_date="9999-1-1");


-- 현재가장  적은 평균 급여를 받고 있는 직책의 가장 적은 평균 급여를 구하세요 

-- 1) top k


select c.title, avg(b.salary)
from employees a,salaries b,titles c
where a.emp_no=b.emp_no and a.emp_no=c.emp_no
and c.to_date="9999-1-1" and b.to_date="9999-1-1"
group by c.title
order by avg(b.salary) limit 0,1;

-- 2 from절을 이용한 서브쿼리


select  min(salary)
from (select c.title "title", avg(b.salary) "salary"
from employees a,salaries b,titles c
where a.emp_no=b.emp_no and a.emp_no=c.emp_no
and c.to_date="9999-1-1" and b.to_date="9999-1-1"
group by c.title)a;


-- 현재 급여가 50000 이상인 직원 이름 출력


select a.first_name
from employees a, salaries b
where a.emp_no=b.emp_no
and b.to_date='9999-01-01'  and b.salary> 50000;


SELECT *   
   FROM employees 
   where emp_no in ( SELECT emp_no							                  
   FROM salaries								 
   WHERE salary > 50000                                                         
	AND to_date = '9999-01-01' );
    
 
 
 -- 가장 높은 월급을 받고 있는 부서에서 근무하는 직원들의 이름과 부서를 출력하시오 
 
 
 select b.dept_no, max(c.salary) "max_salary"
 from employees a,dept_emp b,salaries c 
 where a.emp_no=b.emp_no and c.emp_no=a.emp_no
 and c.to_date="9999-01-01"
 and b.to_date="9999-01-01"
 group by b.dept_no;
 
 
 -- 1) where절에 서브ㅝ쿼리를 사용하는 방법
 
select a.first_name,c.dept_no, b.salary
from employees a,salaries b,dept_emp c
where a.emp_no=b.emp_no and a.emp_no = c.emp_no
and b.to_date="9999-01-01" and  c.to_date="9999-01-01"
and(c.dept_no , b.salary) in ( select b.dept_no, max(c.salary) "max_salary"
				from employees a,dept_emp b,salaries c 
				where a.emp_no=b.emp_no and c.emp_no=a.emp_no
				and c.to_date="9999-01-01"
				and b.to_date="9999-01-01"
				group by b.dept_no);
    
    

 -- 2) from절에 서브ㅝ쿼리를 사용하는 방법
 
 select a.first_name,c.dept_no, b.salary
from employees a,salaries b,dept_emp c, 
		(select b.dept_no, max(c.salary) "max_salary"
				from employees a,dept_emp b,salaries c 
				where a.emp_no=b.emp_no and c.emp_no=a.emp_no
				and c.to_date="9999-01-01"
				and b.to_date="9999-01-01"
				group by b.dept_no)d
where a.emp_no=b.emp_no and a.emp_no = c.emp_no and d.dept_no = c.dept_no
and b.to_date="9999-01-01" and  c.to_date="9999-01-01"
and b.salary=d.max_salary;

-- 1. 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.

select a.emp_no "사번", concat(a.first_name,' ',a.last_name) "이름", salary "연봉"
from employees a,salaries b
where a.emp_no=b.emp_no
and b.to_date="9999-01-01"
order by salary desc; 


-- 2 .  전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.


select a.emp_no "사번",  concat(a.first_name,' ',a.last_name) "이름", b.title "직책"
from employees a,titles b
where a.emp_no=b.emp_no
and b.to_date="9999-01-01"
order by 이름;



-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요..


select a.emp_no "사번",  concat(a.first_name,' ',a.last_name) "이름", c.dept_name "부서이름"
from employees a,dept_emp b, departments c
where a.emp_no=b.emp_no and b.dept_no=c.dept_no
and b.to_date="9999-01-01"
order by 이름;


-- 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.


select a.emp_no "사번",  concat(a.first_name,' ',a.last_name) "이름", d.salary "연봉", e.title "직책", c.dept_name "부서이름"
from employees a,dept_emp b, departments c, salaries d, titles e
where a.emp_no=b.emp_no and b.dept_no=c.dept_no and a.emp_no=d.emp_no and a.emp_no = e.emp_no
and b.to_date="9999-01-01" and  d.to_date="9999-01-01" and e.to_date="9999-01-01"
order by 이름;


-- Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요. (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.) 이름은 first_name과 last_name을 합쳐 출력 합니다.


select a.emp_no "사번",  concat(a.first_name,' ',a.last_name) "이름"
from employees a,titles b
where a.emp_no=b.emp_no
and b.title="Technique Leader" and b.to_date !="9999-01-01";



-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.

select concat(a.first_name,' ',a.last_name) "이름", d.dept_name "부서명", b.title
from employees a,titles b,dept_emp c, departments d
where a.emp_no=b.emp_no and a.emp_no=c.emp_no and c.dept_no = d. dept_no
and concat(a.first_name,' ',a.last_name) like 'S%'
and b.to_date ="9999-01-01" and c.to_date ="9999-01-01";


-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.


select  concat(a.first_name,' ',a.last_name) "이름", c.salary, b.title, b.to_date
from  employees a,titles b,salaries c
where a.emp_no=b.emp_no and a.emp_no=c.emp_no 
and b.to_date ="9999-01-01" and c.to_date ="9999-01-01" 
and b.title="Engineer" 
and c.salary > 40000
order by salary desc; 


-- 현재 최소 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오?????

select  b.title "직책", min(c.salary) "연봉" 
from employees a,titles b,salaries c
where a.emp_no=b.emp_no and a.emp_no=c.emp_no 
and b.to_date ="9999-01-01" and c.to_date ="9999-01-01"
group by b.title
having min(c.salary)>50000 
order by min(c.salary) desc;



-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.


select d.dept_name "부서이름", avg(b.salary) "연봉"
from employees a,salaries b,dept_emp c, departments d
where a.emp_no=b.emp_no and a.emp_no=c.emp_no and c.dept_no = d.dept_no
and b.to_date ="9999-01-01" and c.to_date ="9999-01-01"
group by d.dept_name
order by avg(b.salary) desc;


-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.


select c.title "직책이름", avg(b.salary) "연봉"
from employees a,salaries b,titles c
where a.emp_no=b.emp_no and a.emp_no=c.emp_no 
and b.to_date ="9999-01-01" and c.to_date ="9999-01-01"
group by c.title
order by avg(b.salary) desc;


-- 1 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?

select count(*)
from employees e,salaries s
where e.emp_no=s.emp_no
and s.to_date ="9999-01-01"
and s.salary > (select avg(s.salary)
				from salaries s
				where s.to_date ="9999-01-01");


-- 2 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다.


select e.emp_no "사번", e.first_name "이름", d.dept_name "부서이름", s.salary "연봉"
from   employees e,salaries s, dept_emp de, departments d,
(select dept_name, max(salary) "maxsal"
from  employees e,salaries s, dept_emp de, departments d
where e.emp_no=s.emp_no and e.emp_no = de.emp_no and de.dept_no =d.dept_no
and s.to_date ="9999-01-01" and de.to_date ="9999-01-01" 
group by d.dept_name) e
where e.emp_no=s.emp_no and e.emp_no = de.emp_no and de.dept_no =d.dept_no and e.dept_name=d.dept_name
and s.to_date ="9999-01-01" and de.to_date ="9999-01-01"
and s.salary = e.maxsal
order by  s.salary desc;





-- 3  현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 

select e.emp_no,concat(e.first_name,' ',e.last_name) "이름", s.salary, a.평균급여 
from
(select d.dept_name,avg(salary) "평균급여"
from employees e,salaries s, dept_emp de, departments d
where e.emp_no=s.emp_no and e.emp_no = de.emp_no and de.dept_no =d.dept_no
and s.to_date ="9999-01-01" and de.to_date ="9999-01-01" 
group by d.dept_name)a, employees e, salaries s, dept_emp de, departments d
where e.emp_no=s.emp_no and e.emp_no = de.emp_no and de.dept_no =d.dept_no and a.dept_name = d.dept_name
and s.to_date ="9999-01-01" and de.to_date ="9999-01-01" 
and a.평균급여 < s.salary;



-- 4 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.

select e.emp_no "사번", concat(e.first_name,' ',e.last_name) "이름", d.dept_name "부서이름", concat(em.first_name,' ',em.last_name) "매니저이름" 
from  employees e, dept_manager dm, dept_emp de, departments d, employees em
where e.emp_no = de.emp_no and de.dept_no=d.dept_no and dm.dept_no = d.dept_no and dm.emp_no = em.emp_no
and de.to_date ="9999-01-01" and dm.to_date ="9999-01-01" ;




-- 5 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.

select e.emp_no "사번", concat(e.first_name,' ',e.last_name) "이름", t.title "직책", s.salary "연봉", d.dept_name "부서명" 
from(
select d.dept_name,avg(s.salary)
from employees e,salaries s, dept_emp de, departments d
where e.emp_no= s.emp_no and e.emp_no=de.emp_no and de.dept_no=d.dept_no
and s.to_date ="9999-01-01" and de.to_date ="9999-01-01"
group by d.dept_name order by avg(s.salary) desc
limit 0,1) a, employees e, titles t,salaries s, dept_emp de, departments d
where e.emp_no = t.emp_no and e.emp_no = s.emp_no and e.emp_no=de.emp_no and de.dept_no=d.dept_no and d.dept_name=a.dept_name
and t.to_date ="9999-01-01" and s.to_date ="9999-01-01"and de.to_date ="9999-01-01"
order by s.salary desc;



-- 6 평균 연봉이 가장 높은 부서는? 


select d.dept_name "부서명" ,avg(s.salary) "평균연봉"
from employees e,salaries s, dept_emp de, departments d
where e.emp_no= s.emp_no and e.emp_no=de.emp_no and de.dept_no=d.dept_no
and s.to_date ="9999-01-01" and de.to_date ="9999-01-01"
group by d.dept_name order by avg(s.salary) desc
limit 0,1;



-- 7 평균 연봉이 가장 높은 직책?


select t.title "직책명" ,avg(s.salary) "평균연봉"
from employees e,salaries s, titles t
where e.emp_no= s.emp_no and e.emp_no=t.emp_no
and s.to_date ="9999-01-01" and t.to_date ="9999-01-01"
group by t.title order by avg(s.salary) desc
limit 0,1;


--  8 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은? 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.


select  concat(e.first_name,' ',e.last_name) "이름", d.dept_name "부서이름", s.salary "연봉",  concat(e1.first_name,' ',e1.last_name) "메니저 이름", s1.salary "매니저 연봉"
from employees e, dept_manager dm, salaries s, departments d,dept_emp de, employees e1, salaries s1
where e.emp_no=de.emp_no and de.dept_no=d.dept_no and d.dept_no = dm.dept_no and dm.emp_no=e1.emp_no and e1.emp_no=s1.emp_no
and s.to_date ="9999-01-01" and dm.to_date ="9999-01-01" and de.to_date ="9999-01-01" and s1.to_date="9999-01-01"
and s.salary > s1.salary;




select concat(e.first_name,' ',e.last_name) "이름", s.salary "연봉",  d.dept_name "부서이름", a.이름 "메니저 이름", a.salary "매니저 연봉"
from(select d.dept_name, concat(e.first_name,' ',e.last_name) "이름", s.salary
from employees e, dept_manager dm, salaries s, departments d, dept_emp de
where e.emp_no=dm.emp_no and d.dept_no=dm.dept_no and e.emp_no=s.emp_no and e.emp_no=de.emp_no and de.dept_no=d.dept_no
and  s.to_date ="9999-01-01" and dm.to_date ="9999-01-01" and de.to_date ="9999-01-01")a, employees e, dept_emp de, salaries s, departments d
where e.emp_no=de.emp_no and d.dept_no=de.dept_no and e.emp_no=s.emp_no and d.dept_name=a.dept_name
and  s.to_date ="9999-01-01" and de.to_date ="9999-01-01"
and s.salary > a.salary ; 


