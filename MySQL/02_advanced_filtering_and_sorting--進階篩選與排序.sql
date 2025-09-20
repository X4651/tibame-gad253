-- 1. 顯示出所有員工薪資超過2850元的員工之姓名和薪資。
SELECT ename,sal FROM emp
WHERE sal>2850;

-- 2. 顯示員工編號為7566員工的姓名和他所屬的部門編號。
SELECT ename,deptno FROM emp
WHERE empno = 7566;

-- 3. 顯示薪資不介於1500~2850元之間的所有員工之姓名和薪資。
SELECT ename,sal FROM emp
WHERE sal NOT BETWEEN 1500 AND 2850;

-- 4. 顯示於2011年2月20日和2011年5月1日間進入公司的員工之姓名,職稱和進公司日期，
-- 並依進公司日期由小到大排序。
SELECT ename,job,hiredate FROM emp
WHERE hiredate BETWEEN '2011-01-20' AND '2011-05-01'
ORDER BY hiredate;

-- 5. 顯示部門10和30所有員工之姓名和他所屬的部門編號，並依名字依英文字母順序排序。
SELECT ename,deptno FROM emp
WHERE deptno = 10 OR deptno = 30
ORDER BY ename;

-- 6. 顯示薪資超過1500“且”在10“或”30部門工作員工之姓名和薪資，
-- 把分別把表頭命名為Employee和Monthly Salary。
SELECT ename AS 'Employee',sal AS "Monthly Salary" FROM emp
WHERE sal > 1500 AND deptno IN (10,30);

-- 7. 顯示於2012年進公司的所有員工之姓名,職稱和進公司日期。
SELECT ename,job,hiredate FROM emp
WHERE hiredate LIKE '2012-%';

-- 8. 顯示沒有主管的員工之姓名和職稱。
SELECT ename,job FROM emp
WHERE mgr IS NULL;

-- 9. 顯示所有有賺取佣金的員工之姓名,薪資和佣金，並以薪資和佣金作降冪排列。
SELECT ename,sal,comm FROM emp
WHERE comm IS NOT NULL AND comm != 0
ORDER BY sal DESC,comm DESC;

-- 10.顯示所有名字裡第三個英文字母為A的員工之姓名與職稱。
SELECT ename,job FROM emp
WHERE ename LIKE '__A%';

-- 11.顯示名字裡有兩個“L”且在30部門工作或主管是7782的員工之姓名,
-- 主管員工編號及所屬的部門編號。
SELECT ename,mgr,deptno FROM emp
WHERE ename LIKE '%L%L%' AND (deptno = 30 OR mgr = 7782);

-- 12.顯示職稱為Clerk或Analyst且薪水不等於1000,3000,5000的員工之姓名,職稱和薪資。
SELECT ename,job,sal FROM emp
WHERE job IN ('Clerk','Analyst') AND sal NOT IN (1000,3000,5000);

-- 13.顯示佣金比薪水的1.1倍還多的員工之姓名,薪資和佣金。
SELECT ename,sal,comm FROM emp
WHERE comm > sal*1.1;

-- 14.顯示公司最資深的前三名員工之員工編號, 姓名,部門編號和進公司日期。
SELECT empno,ename,deptno,hiredate FROM emp
ORDER BY hiredate
LIMIT 3;
