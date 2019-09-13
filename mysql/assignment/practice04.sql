/**
 * 문제 1. 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
 */
SELECT COUNT(s.emp_no)
  FROM employees e, salaries s
 WHERE e.emp_no = s.emp_no
   AND s.to_date = '9999-01-01'
   AND s.salary > (SELECT AVG(salary) FROM salaries);


/**
 * 문제 2.
 * 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요.
 * 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다.
 */
SELECT 
    e.emp_no '사번',
    CONCAT(e.first_name, ' ', e.last_name) '이름',
    e2.dept_name '부서',
    e2.max_salary '연봉'
FROM
    employees e,
    (SELECT 
        e.emp_no, MAX(salary) AS max_salary, d.dept_name
    FROM
        dept_emp c, departments d, employees e, salaries s
    WHERE
        c.emp_no = e.emp_no
            AND c.dept_no = d.dept_no
            AND e.emp_no = s.emp_no
            AND c.to_date = '9999-01-01'
            AND s.to_date = '9999-01-01'
    GROUP BY d.dept_name) e2
WHERE
    e.emp_no = e2.emp_no
ORDER BY e2.max_salary DESC;


/**
 * 문제 3. 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요.
 */


/**
 * 문제 4. 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
 */


/**
 * 문제 5. 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
 */


/**
 * 문제 6. 평균 연봉이 가장 높은 부서는?
 */


/**
 * 문제 7. 평균 연봉이 가장 높은 직책?
 */


/**
 * 문제 8. 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
 * 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
 */
