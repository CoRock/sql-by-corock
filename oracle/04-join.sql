-- 사원 정보 (empno, ename, job, mgr, hiredate, sal, comm, deptno)
SELECT * FROM Emp;

-- 부서정보 (deptno, dname, loc)
SELECT * FROM Dept;

-- 사번, 사원이름, 부서이름, 근무지 (empno, ename, dname, loc)
SELECT empno, ename, dname, loc
  FROM Emp, Dept                    -- 조인할 테이블
 WHERE Emp.deptno = Dept.deptno;    -- 조인 조건 (테이블이름.필드이름)


/**** ANSI join (표준 문법) ****/
SELECT empno, ename, dname, loc
  FROM Emp INNER JOIN Dept
    ON Emp.deptno = Dept.deptno;
/******************************/


/* (문제) Student, Department 테이블을 검색하여 이름, 학과코드, 학과이름을 출력하시오. */
SELECT * FROM Student;      -- deptno1: 학과코드
SELECT * FROM Department;   -- deptno: 학과코드

-- 오라클 방식의 join
SELECT s.name, s.deptno1, d.dname
  FROM Student s, Department d
 WHERE s.deptno1 = d.deptno;

-- ANSI SQL 방식의 join
SELECT s.name, s.deptno1, d.dname
  FROM Student s JOIN Department d
    ON s.deptno1 = d.deptno;

-- cf. 사번, 사원이름, 부서코드, 부서이름, 근무지
-- ORA-00918: column ambiguously defined
SELECT e.empno, e.ename, e.deptno, d.dname, d.loc
  FROM Emp e, Dept d
 WHERE e.deptno = d.deptno;
/********************************************************************************/


/**
 * (문제)
 * Student 테이블과 Department 테이블, Professor 테이블을 조인하여
 * 학생의 이름과 학과이름, 지도교수 이름을 출력하시오.
 */
SELECT * FROM Student;
SELECT * FROM Department;
SELECT * FROM Professor;

SELECT s.name sname, dname, p.name pname
  FROM Student s, Department d, Professor p
 WHERE s.deptno1 = d.deptno
   AND d.deptno = p.deptno;
   
SELECT s.name sname, dname, p.name pname
  FROM Student s, Department d, Professor p 
 WHERE s.deptno1 = d.deptno
   AND s.deptno1 = p.deptno;
/******************************************************************/


/* 4.4.3 Self join *****************************************************/
-- 김철수 상급자의 사번은 7902(박진성 부장)
SELECT * FROM Emp;
SELECT * FROM Emp WHERE empno = 7902;

-- 사번, 사원이름, 상급자사번, 상급자이름
SELECT e.empno 사번, e.ename 사원이름, m.empno 관리자사번, m.ename 관리자이름
  FROM Emp e, Emp m
 WHERE e.mgr = m.empno;
/***********************************************************************/


/* 4.4.4 외부 조인(OUTER JOIN) ************************/
SELECT * FROM Student;
SELECT * FROM Professor;

-- 내부조인(INNER JOIN): 양쪽 테이블에 모두 자료가 있는 경우
SELECT studno, s.name, p.name
  FROM Student s, Professor p
 WHERE s.profno = p.profno;

-- 외부조인(OUTER JOIN): 한쪽 테이블에 자료가 없는 경우
SELECT studno, s.name, p.name
  FROM Student s, Professor p
 WHERE s.profno = p.profno(+);

SELECT studno, s.name, p.name
  FROM Student s LEFT OUTER JOIN Professor p
    ON s.profno = p.profno(+);
/*****************************************************/


/* 4.4.5 ANSI join ***********************************/
-- 내부조인(INNER JOIN): 양쪽 테이블에 모두 자료가 있는 경우
SELECT studno, s.name, p.name
  FROM Student s, Professor p
 WHERE s.profno = p.profno;

SELECT studno, s.name, p.name
  FROM Student s INNER JOIN Professor p
    ON s.profno = p.profno;

SELECT studno, s.name, p.name
  FROM Student s INNER JOIN Professor p
 USING (profno);

-- 모든 학생 출력(지도교수가 배정되지 않은 학생도 출력됨)
SELECT studno, s.name, p.name
  FROM Student s LEFT OUTER JOIN Professor p
    ON s.profno = p.profno;

-- 모든 교수 출력(지도하는 학생이 없는 레코드도 출력됨)
SELECT studno, s.name, p.name
  FROM Student s RIGHT OUTER JOIN Professor p
    ON s.profno = p.profno;

SELECT studno, s.name, p.name
  FROM Student s FULL OUTER JOIN Professor p
    ON s.profno = p.profno;
/*****************************************************/