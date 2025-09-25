-- 1. 顯示系統目前的日期並將表頭命名為”系統日期”。
SELECT CURDATE() AS '系統日期';

-- 2. 顯示所有員工之員工編號,姓名、薪資及將薪資增加15%並且以整數表示，並將表頭命名為”New Salary”。
SELECT empno,ename,sal,ROUND(sal*1.15) AS 'New Salary' FROM emp;


-- 3. 接續第二題，增加一個資料項表頭命名為Increase (將New Salary 減掉 Salary 的值)。
SELECT empno,ename,sal,ROUND(sal*1.15) AS 'New Salary',ROUND(sal*1.15) - sal AS Increase FROM emp;

-- 4. 顯示每位員工的姓名，資料項(MONTHS_WORKED) : 計算到今天為止工作了幾個月。
SELECT ename,TIMESTAMPDIFF(MONTH, hiredate, CURDATE()) AS MONTHS_WORKED FROM emp;

-- 5. 顯示如下格式：<員工姓名> earns <薪水> monthly but wants <3倍的薪水> ，
-- 並將表頭顯示為Dream Salaries。
SELECT CONCAT(ename,' earns ',sal," monthly but wants ",ROUND(sal*3)) AS " Dream Salaries"
FROM emp;

-- 6. 顯示所有員工之姓名和薪資，設定薪資長度為15個字元並且在左邊加上$符號，將表頭命名為SALARY。
SELECT ename,LPAD(ROUND(sal,2), 15, '$') AS SALARY FROM emp;

-- 7. 顯示員工之姓名，進公司日期，資料項(DAY) : 顯示員工被雇用的那天為星期幾，
-- 並以星期一作為一週的起始日,依星期排序。
SELECT ename, hiredate, 
       CASE WEEKDAY(hiredate)
            WHEN 0 THEN '1'
            WHEN 1 THEN '2'
            WHEN 2 THEN '3'
            WHEN 3 THEN '4'
            WHEN 4 THEN '5'
            WHEN 5 THEN '6'
            WHEN 6 THEN '7'
       END AS DAY
FROM emp
ORDER BY WEEKDAY(hiredate);

-- 8. 顯示員工的姓名和名為COMM的欄位 : 顯示佣金額，如果該員工沒有賺取佣金則顯示”No Commission"。
SELECT ename,IFNULL(comm, 'No Commission') AS COMM FROM emp;

-- 9. 顯示資料項命名為 EMPLOYEE_AND_THEIR_SALARIES 的資料來顯示所有員工之名字和薪資，
-- 且用星號來表示他們的薪資，每一個星號表示100元，並以薪資由高到低來顯示。
SELECT CONCAT(ename, ' ', REPEAT('*', ROUND(sal / 100))) AS EMPLOYEE_AND_THEIR_SALARIES FROM emp
ORDER BY sal DESC;
