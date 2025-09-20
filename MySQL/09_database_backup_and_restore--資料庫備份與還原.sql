-- 方法1 用Workbench介面化匯出匯入p450
-- 注意左下選Schemas

-- 方法2 用指令輸出CSV檔指令p474
/*
(SELECT 'empno','ename','job','mgr','hiredate','sal','comm','deptno' )
UNION
(SELECT empno, ename, job, ifnull(mgr,''), hiredate, sal, ifnull(comm, ''), deptno
FROM emp)
INTO OUTFILE 'd:/temp/emp4.csv'
FIELDS TERMINATED BY ','
ESCAPED BY '"'
LINES TERMINATED BY '\r\n';
*/
/*
OUTFILE csvfile_name: 輸出檔案名稱
FIELDS ENCLOSED BY: 欄位值圈取符號
TERMINATED BY: 欄位分隔符號
ESCAPED BY: 跳脫字元
LINES TERMINATED BY: 資料列結束符號
*/

-- 輸入 IGNORE 1 ROWS 忽略標題p477
/*
LOAD DATA INFILE 'd:/temp/emp4.csv'
INTO TABLE emp2
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(empno,ename,job,@mgr,hiredate,sal,@comm,deptno)
SET mgr = NULLIF(@mgr,''),
comm = NULLIF(@comm,'');
*/

-- MySQL上課補充上傳2.pdf
-- 方法3 用命令提示字元p27
-- 用path找mysqlpump檔案位置