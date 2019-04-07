DROP TABLE S_Emp;

/** 7.1.1 number 최대 38자리, number(전체자리수, 소수이하자리수) */
CREATE TABLE T_Emp (
    id           NUMBER(5) NOT NULL,
    name         VARCHAR2(25),
    salary       NUMBER(7, 2),
    phone        VARCHAR2(15),
    dept_name    VARCHAR2(25) 
);

/**
 * 7.1.2 테이블 이름 변경
 * RENAME A TO B: 테이블 이름 A를 B로 변경
 */
SELECT * FROM Tab WHERE tname = 'T_EMP';
RENAME T_Emp TO S_Emp;
SELECT * FROM Tab WHERE tname = 'S_EMP';


/** 7.1.3 insert into 테이블 */
INSERT INTO S_Emp VALUES(100, '이상헌', 2000, '010-2222-3333', '개발부');
INSERT INTO S_Emp VALUES(101, '최순철', 3000, '010-3333-4444', '총무부');
INSERT INTO S_Emp VALUES(102, '장혜숙', 4000, '010-4444-5555', '영업부');

-- ORA-01438: value larger than specified precision allowed for this column
-- INSERT INTO S_Emp VALUES(123456, '장미숙', 4000, '010-4444-5555', '영업부');

-- ORA-00947: not enough values
-- INSERT INTO S_Emp VALUES('장미숙', 4000, '010-4444-5555', '영업부');

INSERT INTO S_Emp (id, name, salary) VALUES (103, '김철수', 5000);
-- 값을 입력하지 않은 필드는 null
SELECT * FROM S_Emp;


/**
 * 7.1.4 필드 추가
 * alter table 테이블 add 필드명 자료형
 */
ALTER TABLE S_Emp ADD hire_date DATE;
SELECT * FROM S_Emp;


/** 7.1.5 필드 수정 */
-- ORA-12899: value too large for column "HR"."S_EMP"."PHONE"
INSERT INTO S_Emp
     VALUES(102, '장혜숙', 4000, '82-010-4444-5555-6666', '영업부', '2018-01-01');
ALTER TABLE S_Emp MODIFY phone VARCHAR2(50);

SELECT * FROM S_Emp;
DESC S_Emp;     -- 필드 정보 확인

-- (주의) 필드 사이즈를 줄일 경우
-- ORA-01441: cannot decrease column length because some values is too big
ALTER TABLE S_Emp MODIFY phone VARCHAR2(10);


/**
 * 7.1.6 필드 이름 변경, A를 B로 변경
 * alter table 테이블 rename column A to B;
 */
ALTER TABLE S_Emp RENAME COLUMN id TO t_id;
SELECT * FROM S_Emp;


/** 7.1.7 필드 삭제 */
ALTER TABLE S_Emp DROP COLUMN dept_name;
SELECT * FROM S_Emp;


/**
 * 7.1.8 레코드 수정
 * update 테이블 set 필드명 = 변경할 값 where 조건
 */
UPDATE S_Emp SET hire_date = SYSDATE WHERE t_id = 100;
UPDATE S_Emp SET hire_date = SYSDATE WHERE t_id = 101;
UPDATE S_Emp SET hire_date = SYSDATE WHERE t_id = 102;

-- 조건에 맞는 레코드가 없으면 수정이 되지 않음
UPDATE S_Emp SET hire_date = SYSDATE WHERE t_id = 200;
-- 조건절이 없는 경우 => 모든 레코드의 값이 변경됨
UPDATE S_Emp SET hire_date = SYSDATE;
SELECT * FROM S_Emp;

INSERT INTO S_Emp (t_id, hire_date) VALUES (400, SYSDATE);

-- 조건절이 없으면 모든 레코드가 삭제됨(주의)
DELETE FROM S_Emp WHERE t_id = 200;



-- ORA-02291: integrity constraint (HR.FK_DEPTNO) violated parent key not found
-- INSERT INTO Emp (empno, ename, deptno) VALUES(8888, '이도훈', 50);

/** 7.2.9 제약조건이 설정되지 않은 테이블 */
CREATE TABLE C_Emp (
    id         NUMBER(5),
    name       VARCHAR2(25),
    salary     NUMBER(7, 2),
    phone      VARCHAR2(15),
    dept_id    NUMBER(7)
);

INSERT INTO C_Emp (id, name) VALUES (1, '김철수');
INSERT INTO C_Emp (id, name) VALUES (1, '이기철');
INSERT INTO C_Emp (id, name) VALUES (1, '김철수');
SELECT * FROM C_Emp;
DELETE FROM C_Emp;

-- primaryt key 제약조건 추가
-- alter table 테이블 add constraint 제약조건이름 primary key(필드명)
ALTER TABLE C_Emp ADD CONSTRAINT c_emp_id_pk PRIMARY KEY(id);

-- 데이터사전 조회: 테이블 이름이 C_EMP인 테이블의 제약조건 확인
SELECT * FROM User_Constraints WHERE table_name = 'C_EMP';

INSERT INTO C_Emp (id, name) VALUES (1, '김철수');
-- ORA-00001: unique constraint (HR.C_EMP_ID_PK) violated
-- INSERT INTO C_Emp (id, name) VALUES (1, '이기철');
-- INSERT INTO C_Emp (id, name) VALUES (1, '김철수');

DROP TABLE C_Emp;
-- 테이블을 만들면서 제약조건을 설정하는 방법
CREATE TABLE C_Emp (
    id         NUMBER(5) CONSTRAINT c_emp_id_pk PRIMARY KEY,
--  id         NUMBER(5) PRIMARY KEY,
    name       VARCHAR2(25),
    salary     NUMBER(7, 2),
    phone      VARCHAR2(15),
    dept_id    NUMBER(7)
);

-- SYS_C0012094: 제약조건이름을 붙이지 않을 경우 시스템에서 이름을 붙임
SELECT * FROM User_Constraints WHERE table_name = 'C_EMP';

INSERT INTO C_Emp (id, name) VALUES (1, '김철수');
-- ORA-00001: unique constraint (HR.SYS_C0012094) violated
-- INSERT INTO C_Emp (id, name) VALUES (1, '이기철');


/** 2. check 제약조건 */
-- 테이블 제거
DROP TABLE C_Emp;

-- 제약조건 이름 추가
-- CONSTRAINT 제약조건이름 CHECK(입력값 체크 조건)
CREATE TABLE C_Emp (
    id         NUMBER(5),
    name       VARCHAR2(25),
    salary     NUMBER(7, 2) CONSTRAINT c_emp_salary_ck CHECK(salary BETWEEN 100 AND 1000),
    phone      VARCHAR2(15),
    dept_id    NUMBER(7)
);

SELECT * FROM User_Constraints WHERE table_name = 'C_EMP';

INSERT INTO C_Emp (id, name, salary) VALUES (1, 'kim', 500);
-- ORA-02290: check constraint (HR.C_EMP_SALARY_CK) violated
-- INSERT INTO C_Emp (id, name, salary) VALUES (2, 'park', 1500);
SELECT * FROM User_Constraints WHERE constraint_name = 'C_EMP_SALARY_CK';


/** 3. Foreign key 제약조건 */
-- 외래키, 외부키
-- 다른 테이블의 PK를 참조

-- 부서 테이블에 존재하지 않는 부서코드 50이 입력될 경우 데이터에 오류가 발생함
-- ORA-02291: integrity constraint (HR.FK_DEPTNO) violated - parent key not found
INSERT INTO Emp (empno, ename, deptno) VALUES (7777, 'kim', 50);
SELECT * FROM Dept;

SELECT * FROM User_Constraints WHERE constraint_name = 'FK_DEPTNO';
SELECT * FROM User_Constraints WHERE constraint_name = 'PK_DEPT';
DESC Dept;

-- 테이블 제거
DROP TABLE C_Emp;

-- 제약조건 이름 추가
-- constraint 제약조건이름 references 참조할테이블(PK컬럼)
CREATE TABLE C_Emp (
    id         NUMBER(5),
    name       VARCHAR2(25),
    salary     NUMBER(7, 2),
    phone      VARCHAR2(15),
--  dept_id    NUMBER(7) CONSTRAINT c_emp_deptid_fk REFERENCES Dept(deptno)
    dept_id    NUMBER(7)
);

INSERT INTO C_Emp (id, name, dept_id) VALUES (1, 'kim', 10);
INSERT INTO C_Emp (id, name, dept_id) VALUES (2, 'lee', 20);
-- ORA-02291: integrity constraint (HR.C_EMP_DEPTID_FK) violated - parent key not found
INSERT INTO C_Emp (id, name, dept_id) VALUES (3, 'park', 50);

SELECT id, name, dept_id
  FROM C_Emp c, Dept d
 WHERE c.dept_id = d.deptno;


/** 4. unique 제약조건 */
-- primary key: unique(중복안됨) + not null(필수입력)
-- 테이블 제거
DROP TABLE C_Emp;

-- 제약조건 이름 추가
-- constraint 제약조건이름 unique
CREATE TABLE C_Emp (
    id         NUMBER(5),
    name       VARCHAR2(25) CONSTRAINT c_emp_name_un UNIQUE,
    salary     NUMBER(7, 2),
    phone      VARCHAR2(15),
    dept_id    NUMBER(7)
);

INSERT INTO C_Emp (id, name) VALUES (1, 'kim');
-- ORA-00001: unique constraint (HR.C_EMP_NAME_UN) violated
INSERT INTO C_Emp (id, name) VALUES (2, 'kim');
INSERT INTO C_Emp (id) VALUES (3);
INSERT INTO C_Emp (id) VALUES (4);
SELECT * FROM C_Emp;


-- 제약조건 삭제
-- alter table 테이블 drop constraint 제약조건이름
ALTER TABLE C_Emp DROP CONSTRAINT c_emp_name_un;
INSERT INTO C_Emp (id, name) VALUES (2, 'kim');
INSERT INTO C_Emp (id, name) VALUES (3, 'kim');
INSERT INTO C_Emp (id, name) VALUES (4, 'kim');

-- 제약조건 추가
-- alter table 테이블 add constraint 제약조건이름 제약조건종류(필드명)
-- ORA-02299: cannot validate (HR.C_EMP_NAME_UN) - duplicate keys found
ALTER TABLE C_Emp ADD CONSTRAINT c_emp_name_un UNIQUE(name);
SELECT * FROM C_Emp;
DELETE FROM C_Emp;

-- not null 제약조건, 추가할 수 없음, modify로 가능
-- ALTER TABLE C_Emp ADD CONSTRAINT c_emp_name_nn NOT NULL(name);
-- ALTER TABLE C_Emp ADD CONSTRAINT c_emp_name_nn NOT NULL(name);
ALTER TABLE C_Emp DROP CONSTRAINT c_emp_name_un;
ALTER TABLE C_Emp MODIFY name VARCHAR2(25) CONSTRAINT c_emp_name_nn NOT NULL;

-- ORA-01400: cannot insert NULL into ("HR"."C_EMP"."NAME")
INSERT INTO C_Emp (id) VALUES (5);


-- 제약조건 비활성화(일시정지)
ALTER TABLE C_Emp DISABLE CONSTRAINT c_emp_name_nn;
INSERT INTO C_Emp (id) VALUES (5);
INSERT INTO C_Emp (id) VALUES (6);
INSERT INTO C_Emp (id) VALUES (7);

-- ORA-02293: cannot validate (HR.C_EMP_NAME_NN) - check constraint violated
DELETE FROM C_Emp WHERE name IS NULL;
ALTER TABLE C_Emp ENABLE CONSTRAINT c_emp_name_nn;