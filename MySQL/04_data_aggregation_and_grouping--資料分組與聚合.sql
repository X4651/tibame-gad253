-- 1. 顯示所有員工的最高、最低、總和及平均薪資，依序將表頭命名為 Maximum, Minimum, Sum
-- 和 Average，請將結果顯示為四捨五入的整數。
SELECT 
    ROUND(MAX(sal)) AS Maximum,
    ROUND(MIN(sal)) AS Minimum,
    ROUND(SUM(sal)) AS Sum,
    ROUND(AVG(sal)) AS Average
FROM emp;

-- 2. 顯示每種職稱的最低、最高、總和及平均薪水。
SELECT 
    job,
    ROUND(MIN(sal),2) AS 'MIN(sal)',
    ROUND(MAX(sal),2) AS 'MAX(sal)',
    ROUND(SUM(sal),2) AS 'SUM(sal)',
    ROUND(AVG(sal),6) AS 'AVG(sal)'
FROM emp
GROUP BY job;

-- 3. 顯示每種職稱的人數。
SELECT job,COUNT(*) FROM emp
GROUP BY job;

-- 4. 顯示資料項命名為Number of Managers來表示擔任主管的人數。
SELECT COUNT(DISTINCT mgr) AS 'Number of Managers' FROM emp
WHERE mgr IS NOT NULL;

-- 5. 顯示資料項命名為DIFFERENCE的資料來表示公司中最高和最低薪水間的差額。
SELECT (MAX(sal) - MIN(sal)) AS DIFFERENCE FROM emp;

-- 6. 顯示每位主管的員工編號及該主管下屬員工最低的薪資，
-- 排除沒有主管和下屬員工最低薪資少於1000的主管，並以下屬員工最低薪資作降冪排列。
SELECT mgr,MIN(sal) FROM emp
WHERE mgr IS NOT NULL
GROUP BY mgr
HAVING MIN(sal) >= 1000
ORDER BY MIN(sal) DESC;

-- 7. 顯示在2011及2013年進公司的員工數量，並給該資料項一個合適的名稱。
SELECT YEAR(hiredate) AS Year,COUNT(*) AS Number_of_Employees FROM emp
WHERE YEAR(hiredate) IN (2011, 2013)
GROUP BY YEAR(hiredate)
ORDER BY Year;