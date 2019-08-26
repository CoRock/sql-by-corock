ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

DROP TABLE Emp PURGE;   -- 영구 삭제
CREATE TABLE Emp (
    empno       NUMBER(4, 0), 
    ename       VARCHAR2(10), 
    job         VARCHAR2(9), 
    mgr         NUMBER(4, 0), 
    hiredate    DATE, 
    sal         NUMBER(7, 2),
    comm        NUMBER(7, 2), 
    deptno      NUMBER(2, 0)
);

INSERT INTO Emp VALUES (7369, '김철수', '사원', 7902, '2000-12-17', 200, NULL, 20);
INSERT INTO Emp VALUES (7499, '이찬수', '주임', 7698, '2001-02-20', 260, 300, 30);
INSERT INTO Emp VALUES (7521, '박종수', '주임', 7698, '2002-02-22', 325, 500, 30);
INSERT INTO Emp VALUES (7566, '임채호', '과장', 7839, '2001-04-02', 497, NULL, 20);
INSERT INTO Emp VALUES (7654, '나대호', '주임', 7698, '2001-09-28', 325, 1400, 30);
INSERT INTO Emp VALUES (7698, '박지성', '과장', 7839, '2001-05-01', 485, NULL, 30);
INSERT INTO Emp VALUES (7782, '구자철', '과장', 7839, '2001-06-09', 445, NULL, 10);
INSERT INTO Emp VALUES (7788, '송기성', '부장', 7566, '1997-04-17', 500, NULL, 20);
INSERT INTO Emp VALUES (7839, '김철호', '대표', NULL, '2001-11-17', 800, NULL, 10);
INSERT INTO Emp VALUES (7844, '성명준', '주임', 7698, '2001-09-08', 350, 0, 30);
INSERT INTO Emp VALUES (7876, '황인태', '사원', 7788, '2007-05-23', 210, NULL, 20);
INSERT INTO Emp VALUES (7900, '박민성', '사원', 7698, '2001-12-03', 295, NULL, 30);
INSERT INTO Emp VALUES (7902, '박진성', '부장', 7566, '2001-12-03', 600, NULL, 20);
INSERT INTO Emp VALUES (7934, '최철호', '사원', 7782, '2012-01-23', 230, NULL, 10);



CREATE UNIQUE INDEX pk_emp ON Emp (empno) ;
ALTER TABLE Emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

DROP TABLE Dept PURGE;
CREATE TABLE Dept (
    DEPTNO    NUMBER(2,0),
    DNAME     VARCHAR2(14), 
    LOC       VARCHAR2(13)
);

INSERT INTO Dept VALUES (10, '경리팀', '부산');
INSERT INTO Dept VALUES (20, '연구팀', '대전');
INSERT INTO Dept VALUES (30, '총무팀', '대구');
INSERT INTO Dept VALUES (40, '전산팀', '인천');

CREATE UNIQUE INDEX pk_dept ON Dept (deptno);
ALTER TABLE Dept ADD  CONSTRAINT pk_dept PRIMARY KEY (deptno);

ALTER TABLE Emp ADD CONSTRAINT fk_deptno FOREIGN KEY (deptno) REFERENCES Dept (deptno);



DROP TABLE Professor PURGE;
CREATE TABLE Professor (
    profno      NUMBER(4) PRIMARY KEY,
    name        VARCHAR2(10) NOT NULL, 
    id          VARCHAR2(15) NOT NULL,
    position    VARCHAR2 (20) NOT NULL,
    pay         NUMBER (3) NOT NULL,
    hiredate    DATE NOT NULL,
    bonus       NUMBER(4) ,
    deptno      NUMBER(3),
    email       VARCHAR2(50),
    hpage       VARCHAR2(50)
) TABLESPACE Users;

INSERT INTO Professor
     VALUES ( 1001, '조인형', 'captain', '정교수', 550,
              TO_DATE('1980-06-23', 'YYYY-MM-DD'), 100, 101, 'captain@abc.net', 'http://www.abc.net' );

INSERT INTO Professor
     VALUES ( 1002, '박승곤', 'sweety', '조교수', 380,
              TO_DATE('1987-01-30', 'YYYY-MM-DD'), 60, 101, 'sweety@abc.net','http://www.abc.net' );

INSERT INTO Professor
     VALUES ( 1003, '송도권', 'powerman', '전임강사', 270,
              TO_DATE('1998-03-22', 'YYYY-MM-DD'), NULL, 101, 'pman@power.com', 'http://www.power.com' );

INSERT INTO Professor
     VALUES ( 2001, '양선희', 'lamb1', '전임강사', 250,
              TO_DATE('2001-09-01', 'YYYY-MM-DD'), NULL, 102, 'lamb1@hamail.net', NULL );

INSERT INTO Professor
     VALUES ( 2002, '김영조', 'number1', '조교수', 350,
              TO_DATE('1985-11-30', 'YYYY-MM-DD'), 80, 102, 'number1@naver.com', 'http://num1.naver.com' );

INSERT INTO Professor
     VALUES ( 2003, '주승재', 'bluedragon', '정교수', 490,
              TO_DATE('1982-04-29', 'YYYY-MM-DD'), 90, 102, 'bdragon@naver.com', NULL );

INSERT INTO Professor
     VALUES ( 3001,'김도형', 'angel1004', '정교수', 530,
              TO_DATE('1981-10-23', 'YYYY-MM-DD'), 110, 103, 'angel1004@hanmir.com', NULL );

INSERT INTO Professor
     VALUES ( 3002,'나한열', 'naone10', '조교수', 330,
              TO_DATE('1997-07-01', 'YYYY-MM-DD'), 50, 103, 'naone10@empal.com', NULL );

INSERT INTO Professor
     VALUES ( 3003,'김현정', 'only-u', '전임강사', 290,
              TO_DATE('2002-02-24', 'YYYY-MM-DD'), NULL, 103, 'only_u@abc.com', NULL );

INSERT INTO Professor
     VALUES ( 4001,'심슨', 'simson', '정교수', 570,
              TO_DATE('1981-10-23', 'YYYY-MM-DD'), 130, 201, 'chebin@daum.net', NULL );

INSERT INTO Professor
     VALUES ( 4002,'최슬기', 'gogogo', '조교수', 330,
              TO_DATE('2009-08-30', 'YYYY-MM-DD'), NULL, 201, 'gogogo@def.com', NULL );

INSERT INTO Professor
     VALUES ( 4003,'박원범', 'mypride', '조교수', 310,
              TO_DATE('1999-12-01', 'YYYY-MM-DD'), 50 ,202, 'mypride@hanmail.net', NULL );

INSERT INTO Professor
     VALUES ( 4004,'차범철', 'ironman', '전임강사', 260,
              TO_DATE('2009-01-28', 'YYYY-MM-DD'), NULL, 202, 'ironman@naver.com', NULL );

INSERT INTO Professor
     VALUES ( 4005, '바비', 'standkang', '정교수', 500,
              TO_DATE('1985-09-18', 'YYYY-MM-DD'), 80, 203, 'standkang@naver.com', NULL );

INSERT INTO Professor
     VALUES ( 4006, '전민', 'napeople', '전임강사', 220,
              TO_DATE('2010-06-28', 'YYYY-MM-DD'), NULL, 301, 'napeople@jass.com', NULL );

INSERT INTO Professor
     VALUES ( 4007, '허은', 'silver-her', '조교수', 290,
              TO_DATE('2001-05-23', 'YYYY-MM-DD'), 30, 301, 'silver-her@daum.net', NULL );

COMMIT;



DROP TABLE Department PURGE;
CREATE TABLE Department (
    deptno    NUMBER(3)       PRIMARY KEY ,
    dname     VARCHAR2(30)    NOT NULL,
    part      NUMBER(3),
    build     VARCHAR2(30)
) TABLESPACE Users;

INSERT INTO Department VALUES (101, '컴퓨터공학과', 100, '정보관');
INSERT INTO Department VALUES (102, '멀티미디어공학과', 100, '멀티미디어관');
INSERT INTO Department VALUES (103, '소프트웨어공학과', 100, '소프트웨어관');
INSERT INTO Department VALUES (201, '전자공학과', 200, '전자제어관');
INSERT INTO Department VALUES (202, '기계공학과', 200, '기계실험관');
INSERT INTO Department VALUES (203, '화학공학과', 200, '화학실습관');
INSERT INTO Department VALUES (301, '문헌정보학과', 300, '인문관');
INSERT INTO Department VALUES (100, '컴퓨터정보학부', 10, NULL);
INSERT INTO Department VALUES (200, '메카트로닉스학부', 10, NULL);
INSERT INTO Department VALUES (300, '인문사회학부', 20, NULL);
INSERT INTO Department VALUES (10, '공과대학', NULL, NULL);
INSERT INTO Department VALUES (20, '인문대학', NULL, NULL);

COMMIT;



DROP TABLE Student PURGE;
CREATE TABLE Student (
    studno      NUMBER(4)       PRIMARY KEY,
    name        VARCHAR2(10)    NOT NULL,
    id          VARCHAR2(20)    NOT NULL UNIQUE,
    grade       NUMBER          CHECK(GRADE BETWEEN 1 AND 6),
    jumin       CHAR(13)        NOT NULL,
    birthday    DATE,
    tel         VARCHAR2(15),
    height      NUMBER(4),
    weight      NUMBER(3),
    deptno1     NUMBER(3),
    deptno2     NUMBER(3),
    profno      NUMBER(4)
) TABLESPACE Users;

INSERT INTO Student VALUES ( 9411,'서진수','75true',4,'7510231901813',TO_DATE('1975-10-23','YYYY-MM-DD'),'055)381-2158',180,72,101,201,1001);

INSERT INTO Student
     VALUES ( 9412, '서재수', 'pooh94', 4, '7502241128467', TO_DATE('1975-02-24', 'YYYY-MM-DD'),
              '051)426-1700', 172, 64, 102, NULL, 2001 );

INSERT INTO Student
     VALUES ( 9413, '이미경', 'angel000', 4, '7506152123648', TO_DATE('1975-06-15', 'YYYY-MM-DD'),
              '053)266-8947', 168, 52, 103, 203, 3002 );

INSERT INTO Student
     VALUES ( 9414, '김재수', 'gunmandu', 4, '7512251063421', TO_DATE('1975-12-25', 'YYYY-MM-DD'),
              '02)6255-9875', 177, 83, 201, NULL, 4001 );

INSERT INTO Student
     VALUES ( 9415, '박동호', 'pincle1', 4, '7503031639826', TO_DATE('1975-03-03', 'YYYY-MM-DD'),
              '031)740-6388', 182, 70, 202, NULL, 4003 );

INSERT INTO Student
     VALUES ( 9511, '김신영', 'bingo', 3, '7601232186327', TO_DATE('1976-01-23', 'YYYY-MM-DD'),
              '055)333-6328', 164, 48, 101, NULL, 1002 );

INSERT INTO Student
     VALUES ( 9512, '신은경', 'jjang1', 3, '7604122298371', TO_DATE('1976-04-12', 'YYYY-MM-DD'),
              '051)418-9627', 161, 42, 102, 201, 2002 );

INSERT INTO Student
     VALUES ( 9513, '오나라', 'nara5', 3, '7609112118379', TO_DATE('1976-09-11', 'YYYY-MM-DD'),
              '051)724-9618', 177, 55, 202, NULL, 4003 );

INSERT INTO Student
     VALUES ( 9514, '구유미', 'guyume', 3, '7601202378641', TO_DATE('1976-01-20', 'YYYY-MM-DD'),
              '055)296-3784', 160, 58, 301, 101, 4007 );

INSERT INTO Student
     VALUES ( 9515, '임세현', 'shyun1', 3, '7610122196482', TO_DATE('1976-10-12', 'YYYY-MM-DD'),
              '02)312-9838', 171, 54, 201, NULL, 4001 );

INSERT INTO Student
     VALUES ( 9611, '일지매', 'onejimae', 2, '7711291186223', TO_DATE('1977-11-29', 'YYYY-MM-DD'),
              '02)6788-4861', 182, 72, 101, NULL, 1002 );

INSERT INTO Student
     VALUES ( 9612, '김진욱', 'samjang7', 2, '7704021358674', TO_DATE('1977-04-02', 'YYYY-MM-DD'),
              '055)488-2998', 171, 70, 102, NULL, 2001 );

INSERT INTO Student
     VALUES ( 9613, '안광훈', 'nonnon1', 2, '7709131276431', TO_DATE('1977-09-13', 'YYYY-MM-DD'),
              '053)736-4981', 175, 82, 201, NULL, 4002 );

INSERT INTO Student
     VALUES ( 9614, '김문호', 'munho', 2, '7702261196365', TO_DATE('1977-02-26', 'YYYY-MM-DD'),
              '02)6175-3945', 166, 51, 201, NULL, 4003 );

INSERT INTO Student
     VALUES ( 9615, '노정호', 'star123', 2, '7712141254963', TO_DATE('1977-12-14', 'YYYY-MM-DD'),
              '051)785-6984', 184, 62, 301, NULL, 4007 );

INSERT INTO Student
     VALUES ( 9711,'이윤나', 'prettygirl', 1, '7808192157498', TO_DATE('1978-08-19', 'YYYY-MM-DD'),
              '055)278-3649', 162, 48, 101, NULL, NULL );

INSERT INTO Student
     VALUES ( 9712, '안은수', 'silverwt', 1, '7801051776346', TO_DATE('1978-01-05', 'YYYY-MM-DD'),
              '02)381-5440', 175, 63, 201, NULL, NULL );

INSERT INTO Student
     VALUES ( 9713, '인영민', 'youngmin', 1, '7808091786954', TO_DATE('1978-08-09', 'YYYY-MM-DD'),
              '031)345-5677', 173, 69, 201, NULL, NULL );

INSERT INTO Student 
     VALUES ( 9714, '김주현', 'kimjh', 1, '7803241981987', TO_DATE('1978-03-24', 'YYYY-MM-DD'),
              '055)423-9870', 179, 81, 102, NULL, NULL );

INSERT INTO Student 
     VALUES ( 9715, '허우', 'wooya2702', 1, '7802232116784', TO_DATE('1978-02-23', 'YYYY-MM-DD'),
              '02)6122-2345', 163, 51, 103, NULL, NULL );

COMMIT;



DROP TABLE Emp2 CASCADE CONSTRAINTS;
CREATE TABLE Emp2 (
    EMPNO       NUMBER PRIMARY KEY,
    NAME        VARCHAR2(10) NOT NULL,
    BIRTHDAY    DATE,
    DEPTNO      VARCHAR2(06) NOT NULL,
    EMP_TYPE    VARCHAR2(15),
    TEL         VARCHAR2(15),
    HOBBY       VARCHAR2(30),
    PAY         NUMBER,
    POSITION    VARCHAR2(20),
    PEMPNO      NUMBER
);

INSERT INTO Emp2
     VALUES (19900101, '나사장',TO_DATE('19640125','YYYYMMDD'),'0001','정규직','054)223-0001','음악감상',100000000,'대표이사',null);
INSERT INTO Emp2
     VALUES (19960101, '전부장',TO_DATE('19730322','YYYYMMDD'),'1000','정규직','02)6255-8000','독서',72000000,'부장',19900101);
INSERT INTO Emp2
     VALUES (19970201,'최일도',TO_DATE('19750415','YYYYMMDD'),'1000','정규직','02)6255-8005','운동',50000000,'과장',19960101);
INSERT INTO Emp2
     VALUES (19930331,'백원만',TO_DATE('19760525','YYYYMMDD'),'1001','정규직','02)6255-8010','자전거타기',60000000,'차장',19960101);
INSERT INTO Emp2
     VALUES (19950303,'천만득',TO_DATE('19730615','YYYYMMDD'),'1002','정규직','02)6255-8020','마라톤',56000000,'과장',19960101);
INSERT INTO Emp2
     VALUES (19966102,'일지매',TO_DATE('19720705','YYYYMMDD'),'1003','정규직','052)223-4000','음악감상',75000000,'부장',19900101);
INSERT INTO Emp2 VALUES (19930402,'유관순',TO_DATE('19720815','YYYYMMDD'),'1004','정규직','042)998-7005','등산',51000000,'과장',19966102);
INSERT INTO Emp2 VALUES (19960303,'김문호',TO_DATE('19710925','YYYYMMDD'),'1005','정규직','031)564-3340','등산',35000000,'대리',19966102);
INSERT INTO Emp2 VALUES (19970112,'노정호',TO_DATE('19761105','YYYYMMDD'),'1006','정규직','054)223-4500','수영',68000000,'부장',19900101);
INSERT INTO Emp2 VALUES (19960212,'이윤나',TO_DATE('19721215','YYYYMMDD'),'1007','정규직','054)223-4600',null,49000000,'과장',19970112);
INSERT INTO Emp2 VALUES (20000101,'이태백',TO_DATE('19850125','YYYYMMDD'),'1008','계약직','051)123-4567','등산', 30000000,'',19960212);
INSERT INTO Emp2 VALUES (20000102,'김설악',TO_DATE('19830322','YYYYMMDD'),'1009','계약직','031)234-5678','낚시', 30000000,'',19960212);
INSERT INTO Emp2 VALUES (20000203,'최오대',TO_DATE('19820415','YYYYMMDD'),'1010','계약직','02)2345-6789','바둑', 30000000,'',19960212);
INSERT INTO Emp2 VALUES (20000334,'박지리',TO_DATE('19810525','YYYYMMDD'),'1011','계약직','053)456-7890','노래', 30000000,'',19960212);
INSERT INTO Emp2 VALUES (20000305,'정북악',TO_DATE('19800615','YYYYMMDD'),'1008','수습직','051)567-8901','독서', 22000000,'',19960212);
INSERT INTO Emp2 VALUES (20006106,'유도봉',TO_DATE('19800705','YYYYMMDD'),'1009','수습직','031)678-9012','술',   22000000,'',19960212);
INSERT INTO Emp2 VALUES (20000407,'윤주왕',TO_DATE('19800815','YYYYMMDD'),'1010','수습직','02)2789-0123','오락', 22000000,'',19960212);
INSERT INTO Emp2 VALUES (20000308,'강월악',TO_DATE('19800925','YYYYMMDD'),'1011','인턴직','053)890-1234','골프', 20000000,'',19960212);
INSERT INTO Emp2 VALUES (20000119,'장금강',TO_DATE('19801105','YYYYMMDD'),'1004','인턴직','042)901-2345','술',   20000000,'',19930402);
INSERT INTO Emp2 VALUES (20000210,'나한라',TO_DATE('19801215','YYYYMMDD'),'1005','인턴직','031)345-3456','독서', 20000000,'',19960303);
COMMIT;



DROP TABLE Dept2 CASCADE CONSTRAINTS;
CREATE TABLE Dept2 (
    DCODE    VARCHAR2(06) PRIMARY KEY,
    DNAME    VARCHAR2(20) NOT NULL,
    PDEPT    VARCHAR2(06),
    AREA     VARCHAR2(16)
);

INSERT INTO Dept2 VALUES ('0001', '사장실', '', '포항본사');
INSERT INTO Dept2 VALUES ('1000', '경영지원부', '0001', '서울지사');
INSERT INTO Dept2 VALUES ('1001', '재무관리팀', '1000', '서울지사');
INSERT INTO Dept2 VALUES ('1002', '총무팀', '1000', '서울지사');
INSERT INTO Dept2 VALUES ('1003', '기술부', '0001', '포항본사');
INSERT INTO Dept2 VALUES ('1004', 'H/W지원', '1003', '대전지사');
INSERT INTO Dept2 VALUES ('1005', 'S/W지원', '1003', '경기지사');
INSERT INTO Dept2 VALUES ('1006', '영업부', '0001', '포항본사');
INSERT INTO Dept2 VALUES ('1007', '영업기획팀', '1006', '포항본사');
INSERT INTO Dept2 VALUES ('1008', '영업1팀', '1007', '부산지사');
INSERT INTO Dept2 VALUES ('1009', '영업2팀', '1007', '경기지사');
INSERT INTO Dept2 VALUES ('1010', '영업3팀', '1007', '서울지사');
INSERT INTO Dept2 VALUES ('1011', '영업4팀', '1007', '울산지사');

COMMIT;



DROP TABLE Cal PURGE;
CREATE TABLE Cal (
    week       VARCHAR2(1),
    DAY        VARCHAR2(10),
    num_day    VARCHAR2(2)
);

INSERT INTO Cal VALUES ('1', '일', '1');
INSERT INTO Cal VALUES ('1', '월', '2');
INSERT INTO Cal VALUES ('1', '화', '3');
INSERT INTO Cal VALUES ('1', '수', '4');
INSERT INTO Cal VALUES ('1', '목', '5');
INSERT INTO Cal VALUES ('1', '금', '6');
INSERT INTO Cal VALUES ('1', '토', '7');
INSERT INTO Cal VALUES ('2', '일', '8');
INSERT INTO Cal VALUES ('2', '월', '9');
INSERT INTO Cal VALUES ('2', '화', '10');
INSERT INTO Cal VALUES ('2', '수', '11');
INSERT INTO Cal VALUES ('2', '목', '12');
INSERT INTO Cal VALUES ('2', '금', '13');
INSERT INTO Cal VALUES ('2', '토', '14');
INSERT INTO Cal VALUES ('3', '일', '15');
INSERT INTO Cal VALUES ('3', '월', '16');
INSERT INTO Cal VALUES ('3', '화', '17');
INSERT INTO Cal VALUES ('3', '수', '18');
INSERT INTO Cal VALUES ('3', '목', '19');
INSERT INTO Cal VALUES ('3', '금', '20');
INSERT INTO Cal VALUES ('3', '토', '21');
INSERT INTO Cal VALUES ('4', '일', '22');
INSERT INTO Cal VALUES ('4', '월', '23');
INSERT INTO Cal VALUES ('4', '화', '24');
INSERT INTO Cal VALUES ('4', '수', '25');
INSERT INTO Cal VALUES ('4', '목', '26');
INSERT INTO Cal VALUES ('4', '금', '27');
INSERT INTO Cal VALUES ('4', '토', '28');
INSERT INTO Cal VALUES ('5', '일', '29');
INSERT INTO Cal VALUES ('5', '월', '30');
INSERT INTO Cal VALUES ('5', '화', '31');

COMMIT;



DROP TABLE Gift PURGE;
CREATE TABLE Gift (
    gno        NUMBER,
    gname      VARCHAR2(25),
    g_start    NUMBER,
    g_end      NUMBER
);

INSERT INTO Gift VALUES(1, '참치세트', 1, 100000);
INSERT INTO Gift VALUES(2, '샴푸세트', 100001, 200000);
INSERT INTO Gift VALUES(3, '세차용품세트', 200001, 300000);
INSERT INTO Gift VALUES(4, '주방용품세트', 300001, 400000);
INSERT INTO Gift VALUES(5, '산악용자전거', 400001, 500000);
INSERT INTO Gift VALUES(6, 'LCD모니터', 500001, 600000);
INSERT INTO Gift VALUES(7, '노트북', 600001, 700000);
INSERT INTO Gift VALUES(8, '벽걸이TV', 700001, 800000);
INSERT INTO Gift VALUES(9, '드럼세탁기', 800001, 900000);
INSERT INTO Gift VALUES(10, '양쪽문냉장고', 900001, 1000000);

COMMIT;



DROP TABLE gogak PURGE;
CREATE TABLE gogak
(gno  NUMBER(8) ,
 gname VARCHAR2(12) ,
 jumin CHAR(13) ,
 POINT NUMBER) ;

INSERT INTO gogak VALUES (20010001,'서진수','7510231369824',980000);
INSERT INTO gogak VALUES (20010002,'서재수','7502241128467',73000);
INSERT INTO gogak VALUES (20010003,'이미경','7506152123648',320000);
INSERT INTO gogak VALUES (20010004,'김재수','7512251063421',65000);
INSERT INTO gogak VALUES (20010005,'박동호','7503031639826',180000);
INSERT INTO gogak VALUES (20010006,'김신영','7601232186327',153000);
INSERT INTO gogak VALUES (20010007,'신은경','7604212298371',273000);
INSERT INTO gogak VALUES (20010008,'오나라','7609112118379',315000);
INSERT INTO gogak VALUES (20010009,'김설희','7601202378641',542000);
INSERT INTO gogak VALUES (20010010,'임세현','7610122196482',265000);
INSERT INTO gogak VALUES (20010011,'최순규','7711291186223',110000);
INSERT INTO gogak VALUES (20010012,'정현영','7704021358674',99000);
INSERT INTO gogak VALUES (20010013,'안광훈','7709131276431',470000);
INSERT INTO gogak VALUES (20010014,'모병환','7702261196365',298000);
INSERT INTO gogak VALUES (20010015,'노정호','7712141254963',420000);
INSERT INTO gogak VALUES (20010016,'이윤나','7808192157498',598000);
INSERT INTO gogak VALUES (20010017,'안은수','7801051776346',625000);
INSERT INTO gogak VALUES (20010018,'인영민','7808091786954',670000);
INSERT INTO gogak VALUES (20010019,'김지영','7803242114563',770000);
INSERT INTO gogak VALUES (20010020,'허우','7802232116784',730000);
COMMIT ;



DROP TABLE hakjum purge ;
create table hakjum
(grade char(3) ,
 min_point  number ,
 max_point  number );

insert into hakjum values ('A+',96,100);
insert into hakjum values ('A0',90,95);
insert into hakjum values ('B+',86,89);
insert into hakjum values ('B0',80,85);
insert into hakjum values ('C+',76,79);
insert into hakjum values ('C0',70,75);
insert into hakjum values ('D',0,69);

commit;


drop table exam_01 purge ;

create table exam_01
(studno  number ,
 total number);

insert into exam_01 values (9411,97);
insert into exam_01 values (9412,78);
insert into exam_01 values (9413,83);
insert into exam_01 values (9414,62);
insert into exam_01 values (9415,88);
insert into exam_01 values (9511,92);
insert into exam_01 values (9512,87);
insert into exam_01 values (9513,81);
insert into exam_01 values (9514,79);
insert into exam_01 values (9515,95);
insert into exam_01 values (9611,89);
insert into exam_01 values (9612,77);
insert into exam_01 values (9613,86);
insert into exam_01 values (9614,82);
insert into exam_01 values (9615,87);
insert into exam_01 values (9711,91);
insert into exam_01 values (9712,88);
insert into exam_01 values (9713,82);
insert into exam_01 values (9714,83);
insert into exam_01 values (9715,84);

commit ;

drop table p_grade purge ;

create table p_grade
( position  varchar2(10) ,
  s_age number ,
  e_age number ,
  s_year number ,
  e_year number ,
  s_pay  number ,
  e_pay  number );

insert into p_grade values ('주임',0,24,1,2,12000000,29990000);
insert into p_grade values ('대리',25,28,3,5,30000000,45000000);
insert into p_grade values ('과장',29,32,6,8,45010000,51000000);
insert into p_grade values ('차장',33,36,9,10,51010000,60000000);
insert into p_grade values ('부장',37,40,11,13,60010000,75000000);
insert into p_grade values ('이사',41,55,14,99,75010000,100000000);

commit ;


drop table reg_test purge ;

CREATE TABLE reg_test
( text varchar2(10)) ;

INSERT ALL
INTO reg_test VALUES('ABC123')
INTO reg_test VALUES('ABC 123')
INTO reg_test VALUES('abc 123')
INTO reg_test VALUES('a1b2c3')
INTO reg_test VALUES('aabbcc123')
INTO reg_test VALUES('?/!@#$*&')
INTO reg_test VALUES('\~*().,')
INTO reg_test VALUES(123123)
INTO reg_test VALUES('123abc')
SELECT  *  FROM dual ;

commit;


-- insert all 실습용 테이블

drop table p_01 purge;
drop table p_02 purge;

CREATE TABLE p_01
(no  number ,
 name varchar2(10) );

CREATE TABLE p_02
(no number ,
 name varchar2(10) );



-- merge 실습용 테이블

drop table pt_01 purge;
drop table pt_02 purge;
drop table p_total purge;

create table pt_01
(판매번호 varchar2(8) , 제품번호 char(4) , 수량 number , 금액 number) ;

create table pt_02
(판매번호 varchar2(8) , 제품번호 char(4) , 수량 number , 금액 number) ;

create table p_total
(판매번호  varchar2(8) , 제품번호 char(4) , 수량 number , 금액 number) ;

INSERT ALL
 INTO pt_01 VALUES ('12010101','1000',1,500)
 INTO pt_01 VALUES ('12010102','1001',1,400)
 INTO pt_01 VALUES ('12010103','1003',1,300)
 INTO pt_02 VALUES ('12010201','1004',1,600)
 INTO pt_02 VALUES ('12010202','1000',1,500)
 INTO pt_02 VALUES ('12010203','1005',1,700)
 SELECT * FROM dual ;

commit;



-- DML 에러 로깅 기능 실습용 테이블
DROP Table dml_err_test purge;

CREATE TABLE dml_err_test
( no number primary key,
  name varchar2(10));

INSERT ALL
INTO dml_err_test VALUES (1,'AAA')
INTO dml_err_test VALUES (2,'BBB')
SELECT  * FROM dual ;

commit ;

create or replace procedure print_table( p_query in varchar2 )
AUTHID CURRENT_USER
is
    l_theCursor     integer default dbms_sql.open_cursor;
    l_columnValue   varchar2(4000);
    l_status        integer;
    l_descTbl       dbms_sql.desc_tab;
    l_colCnt        number;
begin
    execute immediate
    'alter session set
        nls_date_format=''yyyy-mm-dd:hh24:mi:ss'' ';
    dbms_sql.parse(  l_theCursor,  p_query, dbms_sql.native );
    dbms_sql.describe_columns
    ( l_theCursor, l_colCnt, l_descTbl );
    for i in 1 .. l_colCnt loop
        dbms_sql.define_column
        (l_theCursor, i, l_columnValue, 4000);
    end loop;
    l_status := dbms_sql.execute(l_theCursor);
    while ( dbms_sql.fetch_rows(l_theCursor) > 0 ) loop
        for i in 1 .. l_colCnt loop
            dbms_sql.column_value
            ( l_theCursor, i, l_columnValue );
            dbms_output.put_line
            ( rpad( l_descTbl(i).col_name, 30 )
              || ': ' ||
              l_columnValue );
        end loop;
        dbms_output.put_line( '-----------------' );
    end loop;
    execute immediate
        'alter session set nls_date_format=''yyyy-mm-dd'' ';
exception
    when others then
      execute immediate
          'alter session set nls_date_format=''yyyy-mm-dd'' ';
      raise;
end;
 /



-- 제약조건 테스트용 테이블
drop table test_novalidate purge ;

CREATE TABLE test_novalidate
( no number primary key ,
  name varchar2(10) not null );

INSERT INTO test_novalidate VALUES(1,'AAA');
INSERT INTO test_novalidate VALUES(2,'BBB');
INSERT INTO test_novalidate VALUES(3,'CCC');
COMMIt ;

drop table test_validate purge ;

CREATE TABLE test_validate
 ( no number
    CONSTRAINT tv_no_pk PRIMARY KEY ,
   name  varchar2(10)
    CONSTRAINT tv_name_nn NOT NULL) ;

INSERT INTO test_validate VALUES (1,'AAA');
INSERT INTO test_validate VALUES (2,'BBB');
INSERT INTO test_validate VALUES (3,'CCC');
COMMIT ;

drop table test_enable purge;

CREATE TABLE test_enable
 ( no number
    CONSTRAINT te_no_pk PRIMARY KEY ,
   name varchar2(10)
    CONSTRAINT te_name_nn NOT NULL) ;



-- 집계함수 연습을 위한 테이블
DROP TABLE Product PURGE;
CREATE TABLE Product (
    p_code     NUMBER(3) PRIMARY KEY,
    p_name     VARCHAR2(20) NOT NULL,
    p_price    NUMBER
);

INSERT INTO Product VALUES (100, '새우짱', 800);
INSERT INTO Product VALUES (101, '감자짱', 900);
INSERT INTO Product VALUES (102, '맛큰산', 1000);
INSERT INTO Product VALUES (103, '에이서', 900);
INSERT INTO Product VALUES (104, '맛짱구', 800);
INSERT INTO Product VALUES(105, '샤보레', 1500);
COMMIT;



DROP TABLE Panmae PURGE ;
CREATE TABLE Panmae (
    p_date     VARCHAR2(8) NOT NULL,
    p_code     NUMBER NOT NULL,
    p_qty      NUMBER,
    p_total    NUMBER,
    p_store    VARCHAR2(5)
);

INSERT INTO Panmae VALUES ('20110101', 100, 3, 2400, '1000');
INSERT INTO Panmae VALUES ('20110101', 101, 5, 4500, '1001');
INSERT INTO Panmae VALUES ('20110101', 102, 2, 2000, '1003');
INSERT INTO Panmae VALUES ('20110101', 103, 6, 5400, '1004');
INSERT INTO Panmae VALUES ('20110102', 102, 2, 2000, '1000');
INSERT INTO Panmae VALUES ('20110102', 103, 5, 4500, '1002');
INSERT INTO Panmae VALUES ('20110102', 104, 3, 2400, '1002');
INSERT INTO Panmae VALUES ('20110102', 105, 2, 3000, '1000');
INSERT INTO Panmae VALUES ('20110103', 100, 10, 8000, '1004');
INSERT INTO Panmae VALUES ('20110103', 100, 2, 1600, '1000');
INSERT INTO Panmae VALUES ('20110103', 100, 3, 2400, '1001');
INSERT INTO Panmae VALUES ('20110103', 101, 4, 3600, '1003');
INSERT INTO Panmae VALUES ('20110104', 100, 2, 1600, '1002');
INSERT INTO Panmae VALUES ('20110104', 100, 4, 3200, '1003');
INSERT INTO Panmae VALUES ('20110104', 100, 5, 4000, '1004');
INSERT INTO Panmae VALUES ('20110104', 101, 3, 2700, '1001');
INSERT INTO Panmae VALUES ('20110104', 101, 4, 3600, '1002');
INSERT INTO Panmae VALUES ('20110104', 101, 3, 2700, '1003');
INSERT INTO Panmae VALUES ('20110104', 102, 4, 4000, '1001');
INSERT INTO Panmae VALUES ('20110104', 102, 2, 2000, '1002');
INSERT INTO Panmae VALUES ('20110104', 103, 2, 1800, '1003');

COMMIT;



DROP TABLE Member PURGE;
CREATE TABLE MEMBER (
    no            NUMBER(4) NOT NULL,
    name          VARCHAR2(20) NOT NULL,
    jumin         CHAR(13) PRIMARY KEY,
    passwd        VARCHAR2(10) NOT NULL,
    id            VARCHAR2(15) NOT NULL UNIQUE,
    an_key        VARCHAR2(15),
    an_key_dap    VARCHAR2(20)
);

INSERT INTO Member VALUES (1001, '이진수', '7510231234567', 'a1234', 'simson', '아내이름?', '김현숙');
INSERT INTO Member VALUES (1002, '김현숙', '7509222345678', 'b1234', 'bobby', '남편이름?', '이진수');
INSERT INTO Member VALUES (1003, '이미영', '1410234567890', 'c1234', 'daddy', '아빠이름?', '이진수');
INSERT INTO Member VALUES (1004, '이민우', '1609223456789', 'd1234', 'mommy', '엄마이름?', '김현숙');

COMMIT;