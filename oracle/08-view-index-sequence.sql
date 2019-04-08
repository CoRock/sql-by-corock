-- Ctrl + E: 실행계획 확인
-- index unique scan: 인덱스 테이블 검사

-- primary key => 인덱스가 자동으로 생성됨
DESC Emp;
-- table access by index rowid: 인덱스의 rowid를 찾아감
SELECT rowid, empno, ename FROM Emp WHERE empno = 7900;
-- table access full: 모든 레코드를 일일이 검사
SELECT * FROM Emp WHERE ename = '송기성';


/** 8.2.5 인덱스 실습 */
-- parsing(명령어 분석) -> 실행계획 수립(옵티마이저) -> 실행
-- sql developer : F10(실행계획 보기)
-- toad : Ctrl + E(실행계획 보기)
-- full scan 모든 레코드를 검사
-- 인덱스를 사용한 검사(by index rowid)
-- index unique scan : 유일한 값
-- index range scan : 유일하지 않은 값

select empno, ename from emp where empno=7900;

select empno, ename from emp

where ename='송기성';

-- Emp 테이블의 ename 필드를 검색하기 위한 인덱스 생성
-- CREATE INDEX 인덱스이름 ON 테이블(필드)
CREATE INDEX emp_ename_idx ON Emp(ename);
-- cost 2, bytes 87 in Toad
-- index range scan: non-unique 인덱스 테이블을 조회
-- table access by index rowid: 찾은 rowid의 레코드를 조회

-- 인덱스 제거
DROP INDEX emp_ename_idx;


-- 인덱스 테스트를 위한 테이블 생성
CREATE TABLE Emp3 (
    no      NUMBER,
    name    VARCHAR2(10),
    sal     NUMBER
);

-- PL/SQL (Procedural Language)
-- 테스트용 레코드 100만건 입력
DECLARE                                -- 선언문
    -- 변수   자료형    := 값;
    i       NUMBER         := 1;       -- i 변수에 1 대입; := 대입연산자
    name    VARCHAR(20)    := 'kim';
    sal     NUMBER         := 0;
BEGIN
    WHILE i < 1000000 LOOP
        IF i MOD 2 = 0 THEN            -- i를 2로 나눈 나머지(MOD)가 0이면
            name := 'kim' || TO_CHAR(i);
            sal := 300;
        ELSIF i MOD 3 = 0 THEN
            name := 'park' || TO_CHAR(i);
            sal := 400;
        ELSIF i MOD 5 = 0 THEN
            name := 'hong' || TO_CHAR(i);
            sal := 500;
        ELSE
            name := 'shin' || TO_CHAR(i);
            sal := 250;
        END IF;                                     -- if의 끝
        INSERT INTO Emp3 VALUES (i, name, sal);     -- 레코드 입력
        i := i + 1;                                 -- i 값 증가
    END LOOP;                                       -- while의 끝
END;
/

-- Ctrl + E 실행계획 확인
-- 인덱스를 사용하지 않을 경우 : table access full, cost:894
SELECT * FROM Emp3 WHERE NAME = 'shin691' AND sal > 200;

-- 인덱스 추가
-- create index 인덱스이름 on 테이블(컬럼)
CREATE INDEX emp_name_idx ON Emp3(name, sal);

-- index range scan, cost:11
SELECT * FROM Emp3 WHERE NAME = 'shin691' AND sal > 200;

-- 시스템 테이블(데이터 사전)에서 인덱스 정보 조회
-- nonunique index
SELECT * FROM user_indexes WHERE table_name = 'EMP3';

-- 인덱스 제거
DROP INDEX emp_name_idx;


-- primary key는 인덱스가 자동으로 생성됨
CREATE TABLE Emp4 (
    no      NUMBER PRIMARY KEY,
    name    VARCHAR2(10),
    sal     NUMBER
);

-- primary key 제약조건이 지정된 필드는 인덱스가 자동으로 만들어짐
-- unique index: primary key, unique 제약조건 컬럼에 적용
SELECT * FROM user_indexes WHERE table_name = 'EMP4';

-- Emp3 테이블의 no 필드에 primary key 제약조건 설정
ALTER TABLE Emp3 ADD CONSTRAINT emp3_no_pk PRIMARY KEY(no);