/** (문제) Emp 테이블에서 월급을 가장 많이 받는 사원정보를 조회하시오. */
SELECT MAX(sal) FROM Emp;
SELECT * FROM Emp WHERE sal = 800;

-- 서브쿼리를 이용한 방법
SELECT *
  FROM Emp
 WHERE sal = (SELECT MAX(sal) FROM Emp);
/*****************************************************************/


/**
 * (문제)
 * 1. 사원들의 평균 월급보다
 * 2. 많은 급여를 받는
 * 3. 사원의 이름, 부서명, 급여를 조회하시오(단일행 서브쿼리).
 */
SELECT AVG(sal) FROM Emp;

SELECT ename, dname, sal
  FROM Emp E, Dept d
 WHERE e.deptno = d.deptno
   AND sal > (SELECT AVG(sal) FROM Emp);
/******************************************************/


/**
 * (문제)
 * 1. 부서코드가 30에 속한 사원 중
 * 2. 최고급여보다 높은 월급을 받는
 * 3. 사원의 이름, 성, 직책명을 조회하시오(복수행 서브쿼리 : any, all).
 */
SELECT sal FROM Emp WHERE deptno = 30;
SELECT MAX(sal) FROM Emp WHERE deptno = 30;     -- 485

SELECT ename, dname, sal
  FROM Emp e, Dept d
 WHERE e.deptno = d.deptno
   AND sal > (SELECT MAX(sal) FROM Emp WHERE deptno = 30);

-- ORA-01427: single-row subquery returns more than one row
-- sal > all(집합): 집합의 모든 급여보다 높아야 함
SELECT ename, dname, sal
  FROM Emp e, Dept d
 WHERE e.deptno = d.deptno
   AND sal > ALL(SELECT sal FROM Emp WHERE deptno = 30);


SELECT ename, dname, sal
  FROM Emp e, Dept d
 WHERE e.deptno = d.deptno
   AND sal > (SELECT MIN(sal) FROM Emp WHERE deptno = 30);

-- sal > any(집합): 집합에서 하나만 만족하면 됨
SELECT ename, dname, sal
  FROM Emp e, Dept d
 WHERE e.deptno = d.deptno
   AND sal > ANY(SELECT sal FROM Emp WHERE deptno = 30);


-- 조인을 사용할 경우
SELECT ENAME, D.DEPTNO, DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- 서브쿼리를 사용할 경우
SELECT ename, deptno,
       (SELECT dname FROM Dept WHERE deptno = e.deptno) dname
  FROM Emp e;
/**************************************************************/


/** (문제) 본인이 속한 부서의 평균급여보다 낮은 급여를 받는 사원 ******/
SELECT AVG(sal) FROM Emp WHERE deptno = 20;
SELECT AVG(sal) FROM Emp WHERE deptno = 30;

SELECT e.ename, e.sal, deptno,
       (SELECT AVG(sal) FROM Emp WHERE deptno = e.deptno)
  FROM Emp e
 WHERE sal < (SELECT AVG(sal) FROM Emp WHERE deptno = e.deptno);
/****************************************************************/


/** 6.2.2.2 from 절에 위치한 서브쿼리 (인라인 뷰) ****************/
  SELECT empno, ename, sal, ROUND(e2.avgs), e2.maxs
    FROM Emp, (SELECT AVG(sal) avgs, MAX(sal) maxs FROM Emp) e2
   WHERE sal > e2.avgs AND sal < e2.maxs
ORDER BY sal DESC;
/*************************************************************/


/**
 * (문제)
 * 직책(job)이 "사원"인 사람들이 어떤 부서에 근무하고 있는지
 * 사원의 이름, 직책, 부서 이름을 나타내시오.
 * 단 from절에 서브쿼리문을 사용하여 문장을 완성하시오.
 */
SELECT ename, job, dname
  FROM (SELECT ename, job, deptno FROM Emp WHERE job = '사원') e, Dept d
 WHERE e.deptno = d.deptno;

-- 조인으로 하는 방법
SELECT ename, job, dname
  FROM Emp e, Dept d
 WHERE e.deptno = d.deptno
   AND job = '사원';
/**********************************************************************/


/**
 * (문제) 각 사원의 이름, 급여, 전 사원의 평균급여를 출력하시오.
 */
SELECT ename, sal, (SELECT AVG(sal) FROM Emp) avg_sal,
       sal - (SELECT AVG(sal) FROM Emp) 급여차액
  FROM Emp;
/*******************************************************/