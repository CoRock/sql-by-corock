-- 커미션(comm)이 null이면 급여의 3%를 커미션으로 계산
-- null과의 연산, 비교 => null
SELECT ename, job, sal, comm, sal * 0.03 커미션
  FROM Emp
 WHERE comm IS NULL;
-- WHERE comm = 0;
-- WHERE comm = NULL; (x)

-- nvl(A, B): A가 null이면 B, null이 아니면 A
SELECT ename, job, sal, comm, NVL(comm, sal * 0.03) 커미션
  FROM Emp;

/**
 * (문제) Emp 테이블에서 사원의 이름, 직책, 연봉을 나타내시오.
 * sal * 12 + comm => comm이 null인 경우 null로 처리됨
 */
SELECT * FROM Emp;
SELECT ename, job, sal, comm, (sal * 12 + comm) 연봉
  FROM Emp;
SELECT ename, job, sal, comm, ( sal * 12 + NVL(comm, 0) ) 연봉
  FROM Emp;

SELECT * FROM Professor;
SELECT name, pay, bonus, (pay * 12 + bonus) 연봉
  FROM Professor;
SELECT name, pay, bonus, ( pay * 12 + NVL(bonus, 0) ) 연봉
  FROM Professor;
/************************************************************/


-- NVL2(A, B, C): A가 null이 아니면 B, null이면 C
-- 커미션(comm)이 null이 아니면 5%, null이면 3%
SELECT ename, deptno, sal * NVL2(comm, 0.05, 0.03) 커미션
  FROM Emp;

-- bonus가 null이 아니면 pay의 10%, null이면 5%로 처리
SELECT name, pay, bonus, NVL2(bonus, 0.1, 0.05) 보너스
  FROM Professor;


-- 이름이 김~ 으로 시작하는 직원들
SELECT ename, deptno
FROM Emp
WHERE ename LIKE '김%';

-- LTRIM(A, B): A 필드에서 왼쪽의 B를 제거
-- NULLIF(A, B): A, B가 같으면 null, 다르면 A
SELECT ename, deptno, LTRIM(ename, '김'), NULLIF( ename, LTRIM(ename, '김') )
  FROM Emp
 WHERE NULLIF( ename, LTRIM(ename, '김') ) IS NOT NULL;


-- COALESCE(...): null이 아닌 첫번째 값
SELECT ename, comm, sal, COALESCE(comm, sal, 20) 치환값
  FROM Emp;
-- ename이 김철수인 사원의 sal을 null로 고치려면?
UPDATE Emp SET sal = NULL WHERE ename = '최철호';


/** DECODE(A, B, C, D): A와 B가 같으면 C, 다르면 D
 *  TRUNC(숫자): 소수 이하 버림
 */
SELECT ename, sal, sal / 100, TRUNC(sal / 100),
       DECODE( TRUNC(sal / 100), 0, 'E',
                                 1, 'D',
                                 2, 'C',
                                 3, 'B',
                                    'A' ) FROM Emp;
-- 최철호의 sal을 160으로 수정
UPDATE Emp SET sal = 160 WHERE ename = '최철호';
-- 황인태의 sal을 90으로 수정
UPDATE Emp SET sal = 90 WHERE ename = '황인태';


/**
 * (문제)
 * Score 테이블에서 이름, 국어, 영어, 수학, 총점, 평균, 등급을 나타내시오.
 * 등급은 평균점수가 90~100점이면 A등급, 80점대이면 B등급,
 * 70점대이면 C등급, 60점대이면 D등급, 60점 미만이면 F등급으로 나타내시오.
 */
CREATE TABLE Score (
    student_no    VARCHAR2(20) PRIMARY KEY,     -- 학번
    name          VARCHAR2(20) NOT NULL,        -- 이름
    kor           NUMBER(3) DEFAULT 0,          -- 국어
    eng           NUMBER(3) DEFAULT 0,          -- 영어
    mat           NUMBER(3) DEFAULT 0           -- 수학
);

-- 레코드 입력
INSERT INTO Score VALUES ('1', 'kim', 90, 80, 70);
INSERT INTO Score VALUES ('2', 'park', 88, 85, 75);
INSERT INTO Score VALUES ('3', 'hong', 99, 89, 79);
INSERT INTO Score VALUES ('4', 'choi', 100, 100, 100);

-- ROUND(실수값, 소수이하자리수)
SELECT name, kor, eng, mat, (kor + eng + mat) 총점,
       (kor + eng + mat) / 3,
       ROUND((kor + eng + mat) / 3, 2) 평균,
       DECODE( TRUNC(((kor + eng + mat) / 3) / 10), 10, 'A',
                                                     9, 'A',
                                                     8, 'B',
                                                     7, 'C',
                                                     6, 'D',
                                                        'F' ) 등급
  FROM Score;


/** 9.2.2 case */

/**
 * (문제)
 * Professor 테이블에서 각 교수의 이름과 직위, 급여총액(pay+bonus)을 나타내시오.
 * 단, 이번달 급여는 정교수이면 급여총액의 10%를, 조교수이면 7%를,
 * 전임강사이면 5%를 더하여 주고 급여가 많은 사람부터 나타내시오.
 */
SELECT * FROM Professor;

-- CASE WHEN 조건 THEN 값 ~ ELSE 그 외의 모든 경우의 값 END
  SELECT name, position,
         CASE WHEN position = '정교수' THEN ( pay + NVL(bonus, 0) ) * 1.1
              WHEN position = '조교수' THEN ( pay + NVL(bonus, 0) ) * 1.07
              WHEN position = '전임강사' THEN ( pay + NVL(bonus, 0) ) * 1.05
              ELSE pay + NVL(bonus, 0)
         END 급여
    FROM Professor
ORDER BY 3 DESC;


/**
 * (문제)
 * Score 테이블에서 이름, 국어, 영어, 수학, 총점, 평균, 등급을 나타내시오.
 * 등급은 평균점수가 90~100점이면 A등급, 80점대이면 B등급,
 * 70점대이면 C등급, 60점대이면 D등급, 60점 미만이면 F등급으로 나타내시오.
 */
SELECT * FROM Score;

SELECT name, kor, eng, mat, (kor + eng + mat) 총점,
       ROUND( (kor + eng + mat) / 3, 2 ) 평균,
       CASE WHEN ( (KOR + ENG + MAT) / 3 ) >= 90 THEN 'A'
            WHEN ( (KOR + ENG + MAT) / 3 ) >= 80 THEN 'B'
            WHEN ( (KOR + ENG + MAT) / 3 ) >= 70 THEN 'C'
            WHEN ( (KOR + ENG + MAT) / 3 ) >= 60 THEN 'D'
            ELSE 'F'
       END 등급
  FROM Score;


-- 10 경리팀, 20 연구팀, 30 총무팀, 40 전산팀, null 미배정
-- cf. ORA-00918: column ambiguously defined
SELECT * FROM Emp;
SELECT * FROM Dept;

-- 사번, 이름, 부서코드, 부서이름(case ~ end 사용)
SELECT empno, ename, deptno,
       CASE WHEN deptno = 10 THEN '경리팀'
            WHEN deptno = 20 THEN '연구팀'
            WHEN deptno = 30 THEN '총무팀'
            WHEN deptno = 40 THEN '전산팀'
            ELSE '미배정'
       END dname
  FROM Emp;


/**
 * (문제)
 * Emp 테이블에서 전체 사원에 대하여
 * 부서번호, 이름, 급여, 해당부서 내 급여 순위를 출력하시오.
 */
-- RANK() OVER(ORDER BY 석차기준필드)
SELECT deptno, ename, sal, RANK() OVER(ORDER BY sal DESC) 급여순위
  FROM Emp;
  
-- 동률 순위를 무시하려면 DENSE_RANK() OVER(ORDER BY 석차기준필드)
SELECT deptno, ename, sal, DENSE_RANK() OVER(ORDER BY sal DESC) 급여순위
  FROM Emp;

-- PARTITION BY 그룹필드 ORDER BY 기준필드
SELECT deptno, ename, sal,
       RANK() OVER(PARTITION BY deptno ORDER BY sal DESC) "부서 내 급여순위"
  FROM Emp;