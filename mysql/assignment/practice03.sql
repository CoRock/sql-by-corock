/**
 * 문제 1: 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
 */
  select e.emp_no 사번, concat(e.first_name, ' ', e.last_name) 이름, s.salary 연봉
    from employees e, salaries s
   where e.emp_no = s.emp_no
order by s.salary desc;


/**
 * 문제 2: 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
 */
  select e.emp_no '사번', concat(e.first_name, ' ', e.last_name) '이름', t.title '현재 직책'
    from employees e, titles t
   where e.emp_no = t.emp_no
     and t.to_date = '9999-01-01'
order by concat(e.first_name, ' ', e.last_name) asc;


/**
 * 문제 3: 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요.
 */
  select e.emp_no '사번', concat(e.first_name, ' ', e.last_name) '이름', d.dept_name '현재 부서'
    from dept_emp c, departments d, employees e
   where c.dept_no = d.dept_no
     and c.emp_no = e.emp_no
     and c.to_date = '9999-01-01'
order by concat(e.first_name, ' ', e.last_name) asc;


/**
 * 문제 4: 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
 */
  select e.emp_no as '사번',
         concat(e.first_name, ' ', e.last_name) as '이름',
         s.salary as '연봉',
         t.title as '직책',
         d.dept_name as '부서'
    from dept_emp c, departments d, employees e, salaries s, titles t
   where c.dept_no = d.dept_no
     and c.emp_no = e.emp_no
     and e.emp_no = s.emp_no
     and e.emp_no = t.emp_no
     and date_format(t.to_date, '%Y') like '9999'
order by concat(e.first_name, ' ', e.last_name) asc;

select s.to_date, t.to_date from salaries s, titles t
where s.emp_no = t.emp_no
order by s.to_date asc, t.to_date asc;

/**
 * 문제 5: ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요.
 * (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.)
 * 이름은 first_name과 last_name을 합쳐 출력 합니다.
 */
select e.emp_no as '사번', concat(e.first_name, ' ', e.last_name) as '이름'
  from employees e, titles t
 where e.emp_no = t.emp_no
   and t.to_date != '9999-01-01'
   and title = 'Technique Leader';


/**
 * 문제 6: 현재, 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.
 */
  select e.last_name as '이름', d.dept_name as '부서명', t.title as '직책'
    from dept_emp c, departments d, employees e, titles t
   where c.dept_no = d.dept_no and c.emp_no = e.emp_no and e.emp_no = t.emp_no
     and c.to_date = '9999-01-01' and e.last_name like 'S%';


/**
 * 문제 7: 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.
 */
  select concat(e.first_name, ' ', e.last_name) as '사원', s.salary as '급여'
    from employees e, salaries s, titles t
   where e.emp_no = s.emp_no and e.emp_no = t.emp_no
     and s.to_date = '9999-01-01' and t.title = 'Engineer'
order by s.salary desc;


/**
 * 문제 8: 현재 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오.
 */
  select t.title '직책', s.salary as '급여'
    from salaries s, titles t
   where s.emp_no = t.emp_no
     and s.to_date = '9999-01-01' and s.salary >= 50000
order by s.salary desc;


/**
 * 문제 9: 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.
 */
  select d.dept_name '부서', avg(s.salary) '연봉'
    from dept_emp c, departments d, employees e, salaries s
   where c.dept_no = d.dept_no and c.emp_no = e.emp_no and e.emp_no = s.emp_no
group by d.dept_name
order by avg(s.salary) desc;


/**
 * 문제 10: 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
 */
  select t.title as '직책', avg(s.salary) as '연봉'
    from salaries s, titles t
   where s.emp_no = t.emp_no
     and s.to_date = '9999-01-01'
group by t.title
order by avg(s.salary) desc;


/**
 * 예제 5: 현재 직책별로 평균 연봉과 인원수를 구하되 직책별로 인원이 100명 이상인 직책만 출력하세요.
 */
  select t.title as '직책', avg(s.salary) as '평균 연봉', count(*) as 인원수
    from employees e, salaries s, titles t
   where e.emp_no = s.emp_no
     and e.emp_no = t.emp_no
     and s.to_date = '9999-01-01'
     and t.to_date = '9999-01-01'
group by t.title
  having 인원수 >= 100;


/**
 * 예제 6: 현재 부서별로 현재 직책이 Engineer인 직원들에 대해서만 평균급여를 구하세요.
 */
  select d.dept_name, avg(e.salary)
    from employees a, dept_emp b, titles c, departments d, salaries e
   where a.emp_no = b.emp_no
     and a.emp_no = c.emp_no
     and a.emp_no = e.emp_no
     and b.dept_no = d.dept_no
     and b.to_date = '9999-01-01'
     and c.to_date = '9999-01-01'
     and e.to_date = '9999-01-01'
     and c.title = 'Engineer'
group by d.dept_name;



-- 밑에는 내가 한거
select d.dept_name, avg(s.salary) as '평균급여'
  from dept_emp c, departments d, employees e, salaries s, titles t
 where c.dept_no = d.dept_no
   and c.emp_no = e.emp_no
   and e.emp_no = s.emp_no
   and e.emp_no = t.emp_no
   and c.to_date = '9999-01-01';
-- and d.dept_name = 'Engineer'
-- group by d.dept_name;


/**
 * 예제 7:
 * 현재 직책별로 급여의 총합을 구하되 Engineer직책은 제외하세요.
 * 단, 총합이 2,000,000,000이상인 직책만 나타내며 급여총합에 대해서 내림차순(DESC)로 정렬하세요.
 */
  select c.title, sum(e.salary)
    from employees a, titles c, salaries e
   where a.emp_no = c.emp_no
     and a.emp_no = e.emp_no
     and c.to_date = '9999-01-01'
     and e.to_date = '9999-01-01'
     and c.title <> 'Engineer'
group by c.title
  having sum(e.salary) >= 2000000000;

-- 밑에는 내가 한거
  select t.title as '직책', sum(s.salary) as '급여총합'
    from salaries s, titles t
   where s.emp_no = t.emp_no
     and s.to_date = '9999-01-01'
     and t.title != 'Engineer'
group by title
  having sum(s.salary) >= 2000000000
order by sum(s.salary) desc;
