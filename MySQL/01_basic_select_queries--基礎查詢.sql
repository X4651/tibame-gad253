-- 1. 建立一個查詢來顯示部門(dept)資料表中的所有資料。
-- 寫法一:指定資料庫
-- SELECT * FROM sample.dept;
-- 寫法二:不指定資料庫
SELECT * FROM dept;

-- 2. 建立一個查詢來顯示每一位員工的姓名、職稱、進公司日期及員工編號,並將員工編號顯示在
-- 最前面。
SELECT empno,ename,job,hiredate FROM emp;

-- 3. 建立一個查詢來顯示所有員工所擔任的職稱有哪些? (重複的資料只顯示一次)
SELECT DISTINCT job FROM emp;

-- 4. 建立一個查詢來顯示每一位員工的姓名、職稱、進公司日期及員工編號,將員工編號顯示在最
-- 前面。並將資料表頭重新命名為:Emp#, Employee, Job, Hire Date。
-- 特殊字元用""(符號或空白)
SELECT empno AS "Emp#",ename AS 'Employee',job AS 'Job',hiredate AS "Hire Date" FROM emp;

-- 5. 建立一個查詢將員工姓名及職稱串接為 一個資料項(資料中間利用一個逗號和一個空白做區隔),
-- 並將表頭重新命名為 Employee and Title。
SELECT CONCAT(ename,', ',job) AS "Employee and Title" FROM emp;

-- 6. 建立一個查詢來顯示前 5 筆員工的員工編號、姓名、部門編號及薪資。
SELECT empno,ename,deptno,sal FROM emp LIMIT 5;