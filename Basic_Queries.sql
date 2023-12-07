================================================================================

                    MOST FREQUENTLY ASKED SQL QURIES IN INTERVIEWS

================================================================================
SELECT * FROM EMP1;

1) SQL Query to find second highest salary of Employee
SELECT MAX(SAL) FROM EMP1 
WHERE SAL NOT IN (SELECT MAX(SAL) FROM EMP1);

--------------------------------------------------------------------------------
2) SQL Query to find Max Salary from each department

SELECT * FROM EMP1;

SELECT DEPTNO,MAX(SAL)
FROM EMP1
GROUP BY DEPTNO;

--------------------------------------------------------------------------------
3) Write SQL Query to display current date.
SELECT SYSDATE FROM DUAL;

--------------------------------------------------------------------------------
4) Write an SQL Query to check whether date passed to Query is date of given format 
or not.

SELECT
  CASE
    WHEN TO_DATE('02-NOV-23', 'DD-MON-YY', 'NLS_DATE_LANGUAGE=AMERICAN') IS NOT NULL
    THEN 'Valid Date'
    ELSE 'Invalid Date'
  END AS Date_Check
FROM dual;

SELECT
  CASE
    WHEN TO_DATE('02-NOV-23', 'DD-MON-YY') IS NOT NULL
    THEN 'Valid Date'
    ELSE 'Invalid Date'
  END AS Date_Check
FROM dual;
--------------------------------------------------------------------------------
5) Write a SQL Query to print the name of distinct employee whose HIREDATE is between 
01/01/81 to 31/12/81

SELECT * FROM EMP1;

SELECT DISTINCT ENAME, HIREDATE FROM EMP1
WHERE HIREDATE BETWEEN '01-JAN-81' AND '31-DEC-81';

--------------------------------------------------------------------------------
6) Write an SQL Query find number of employees according to job whose hIREDATE is 
between '01-JAN-81' AND '31-DEC-81.

SELECT * FROM EMP1;

SELECT JOB,COUNT(*) FROM EMP1
WHERE HIREDATE BETWEEN '01-JAN-81' AND '31-DEC-81'
GROUP BY JOB;

or

SELECT JOB, COUNT(*)
FROM EMP1
WHERE HIREDATE BETWEEN TO_DATE('1981-01-01', 'YYYY-MM-DD') AND TO_DATE('1981-12-31', 'YYYY-MM-DD')
GROUP BY JOB;

--------------------------------------------------------------------------------
7) Write an SQL Query to find employee whose Salary is equal or greater than 1000

SELECT * FROM EMP1;

SELECT * FROM EMP1 WHERE SAL >= 1000;

-------------------------------------------------------------------------------
8) Write an SQL Query to find name of employee whose name Start with ‘M’

SELECT * FROM EMP1;

SELECT ENAME FROM EMP1
WHERE ENAME LIKE 'M%';

--------------------------------------------------------------------------------
9) find all Employee records containing the word "RD", regardless of whether it was 
stored as Rd, or rd.

SELECT ENAME FROM EMP1 
WHERE LOWER(ENAME) LIKE LOWER('%rd%') ;

--------------------------------------------------------------------------------
10) Write a SQL Query to find year from hiredate.

SELECT * FROM EMP1;

SELECT HIREDATE, EXTRACT(YEAR FROM HIREDATE) FROM EMP1;

--------------------------------------------------------------------------------
11) To fetch ALTERNATE records from a table. (EVEN NUMBERED)

SELECT * FROM EMP1;

WITH CTE AS (
SELECT ROWNUM as rn, A.*
FROM EMP1 A
)
SELECT A.*
FROM CTE A
WHERE MOD(rn, 2)=0;

--------------------------------------------------------------------------------
12) To select ALTERNATE records from a table. (ODD NUMBERED)

WITH CTE AS (
SELECT ROWNUM as rn, A.*
FROM EMP1 A
)
SELECT A.*
FROM CTE A
WHERE MOD(rn, 2)<>0;

--------------------------------------------------------------------------------

13) Find the 3rd MAX salary in the emp1 table.

SELECT * FROM EMP1;

WITH CTE AS (
select ename,sal,dense_rank() over (order by sal DESC) as rank
from emp1 
)
SELECT ENAME,SAL FROM CTE
where rank=3
order by sal desc;

--Neglect Null

WITH CTE AS (
  SELECT ename, sal, DENSE_RANK() OVER (ORDER BY sal DESC) AS rank
  FROM emp1
  WHERE sal IS NOT NULL -- Filter out null salaries
)
SELECT ename, sal
FROM CTE
WHERE rank = 3
ORDER BY sal DESC;

--------------------------------------------------------------------------------
14.Find the 3rd MIN salary in the emp table.

WITH CTE AS (
  SELECT ename, sal, DENSE_RANK() OVER (ORDER BY sal) AS rank
  FROM emp1
  WHERE sal IS NOT NULL -- Filter out null salaries
)
SELECT ename, sal
FROM CTE
WHERE rank = 3
ORDER BY sal;

--------------------------------------------------------------------------------
15) Select FIRST 5 records from a table.

select rownum,a.* from emp1 a
where rownum<=5;

--------------------------------------------------------------------------------
16) Select LAST 5 records from a table

select * from emp1;
SELECT ROWNUM, a.*
FROM (
  SELECT *
  FROM emp1
  ORDER BY ROWNUM DESC
) a
WHERE ROWNUM <= 5;

or

WITH CTE AS (
  SELECT a.*
  FROM emp1 a order by rownum desc
)
SELECT rownum, a.* FROM CTE a
WHERE rownum <= 5
ORDER BY rownum;

--------------------------------------------------------------------------------
17) List dept no., Dept name for all the departments in which there are no employees 
in the department.

SELECT * FROM EMP1;

select deptno,count(*) from emp1
group by deptno
having count(*)=0;

--------------------------------------------------------------------------------
18)How to get 3 Max salaries ?

SELECT * FROM EMP1;

SELECT DISTINCT ename, sal
FROM emp1
WHERE sal IS NOT NULL
ORDER BY sal DESC
FETCH FIRST 3 ROWS ONLY;

--------------------------------------------------------------------------------
19) How to get 3 Min salaries ?

SELECT DISTINCT ename, sal
FROM emp1
WHERE sal IS NOT NULL
ORDER BY sal 
FETCH FIRST 3 ROWS ONLY;

--------------------------------------------------------------------------------
20)Select all record from emp table where deptno =10 or 20 

SELECT * FROM EMP1;

select * from emp1
where deptno in (10,20);

-------------------------------------------------------------------------------
21)Select all record from emp table where deptno=10 and 20 

select * from emp1
where deptno=10 and deptno=20;

--------------------------------------------------------------------------------
22) Select all records where ename starts with ‘S’ and its lenth is 5 char

select * from emp1;

select * from emp1
where ename like 'S____';

--------------------------------------------------------------------------------
23) Select all records where ename may be any no of character but it should end with 
‘G’.

select * from emp1;

select * from emp1
where lower(ename) like lower('%g');

--------------------------------------------------------------------------------
24) In emp table add comm+sal as total sal .

select * from emp1;

select comm,sal,nvl(comm,0)+nvl(sal,0) as Total from emp1 order by total;

--------------------------------------------------------------------------------
25) Select all employees whose salary <3000 from emp1 table.

select * from emp1 where sal<3000;

--------------------------------------------------------------------------------
26)How can I create an empty table emp1 with same structure as emp?

Create table empCopy as select * from emp1 where 1=2;

select * from empCopy;

--------------------------------------------------------------------------------
27) Select all records where dept no of both emp and dept table matches

select * from dept;
select * from emp1;

select a.*,b.*
from emp1 a,dept b
where a.deptno=b.deptno;

-------------------------------------------------------------------------------
28) If there are two tables emp1 and emp2, and both have common record. How can I 
fetch all the recods but common records only once?

select * from emp10;
select * from emp20;

select * from emp10 union select * from emp20; --remove duplicate records

If you want to include duplicates from one of the tables while keeping common 
records unique, you can use UNION ALL instead of UNION

---------------------------------------------------------------------------------

29)  How can I retrive all records of emp10 those should not present in emp20?

select * from emp10 minus select * from emp20;

--------------------------------------------------------------------------------

30) Count the total sal deptno wise where more than 2 employees exist.

select * from emp1;

SELECT deptno, sum(sal) As totalsal
FROM emp1
GROUP BY deptno
HAVING COUNT(empno) > 2;

--------------------------------------------------------------------------------

31) Display the names of employees who are working in the company for the past 5 
years.

select * from emp1;

select ename from emp1 where (sysdate-hiredate)>(5*365);

--------------------------------------------------------------------------------

32) Display the names of employees working in department number 10 or 20 or 40 or 
employees working as clerks, salesman or analyst.

select * from emp1;

select ename from emp1
where deptno in (10,20,40) or job in ('CLERK','SALESMAN','ANALYST');

--------------------------------------------------------------------------------
33) Display employee names for employees whose name ends with alphabet n.

select ename from emp1 where ename like '%N';

or 

select ename from emp1 where lower(ename) like lower('%N');
