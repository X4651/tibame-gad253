-- 建立預存程序 p417
DELIMITER //
CREATE PROCEDURE GetMemberDpt10()
BEGIN
SELECT empno, ename, deptno
FROM empGetMemberDpt10
WHERE deptno = 10;
END//
DELIMITER ;
-- -----------------------------------------------
-- 使用
CALL GetMemberDpt10;
-- ================================================
-- IN參數範例
DELIMITER //
CREATE PROCEDURE GetMemberByDpt(
IN pdeptno INT
)
BEGIN
SELECT empno, ename, deptno
FROM emp
WHERE deptno = pdeptno;
END//
DELIMITER ;
-- -----------------------------------------------
-- 使用IN參數 ()內多少回傳多少
CALL GetMemberByDpt(20);
-- ================================================
-- OUT參數範例 回傳筆數
DELIMITER //
CREATE PROCEDURE GetMemCountByDpt(
IN pdeptno INT,
OUT pmcount INT
)
BEGIN
SELECT count(*) INTO pmcount
FROM emp
WHERE deptno = pdeptno;
END//
DELIMITER ;
-- -----------------------------------------------
-- 使用OUT參數 部門編號為30的有幾筆，用@total去接
CALL GetMemCountByDpt(30,@total);
-- ================================================
-- INOUT參數範例
DELIMITER //
CREATE PROCEDURE SetCounter(
INOUT counter INT,
IN inc INT
)
BEGIN
SET counter = counter + inc;
END//
DELIMITER ;
-- -----------------------------------------------
-- 使用INOUT參數 設定@counter起始值為1
SET @counter = 1;

-- 1+1變2 再存起來然後回傳
CALL SetCounter(@counter,1);

-- 2+5變7 再存起來然後回傳
CALL SetCounter(@counter,5);
-- ================================================
-- WHILE可能不執行 REPEAT一定會執行一次
-- LEAVE = 其他語言的BREAK
-- ================================================
-- 預存函數 能多次使用 不像程序跑完就沒了 p440
DELIMITER //
CREATE FUNCTION Myfun1(par1 DATE)
RETURNS CHAR(40) DETERMINISTIC
BEGIN
    DECLARE DD1 CHAR(40);
    DECLARE DD2 CHAR(20) DEFAULT '一二三四五六日';
    SET DD1 = CONCAT(YEAR(par1), '年', MONTH(par1), '月',
                     DAY(par1), '日 星期', SUBSTRING(DD2, WEEKDAY(par1) + 1, 1));
    RETURN DD1;
END//
DELIMITER ;
-- -----------------------------------------------
-- 使用
SELECT Myfun1(CURDATE());
-- ================================================
-- 觸發器 跟著表格
CREATE TRIGGER before_employee_update
BEFORE UPDATE ON emp
FOR EACH ROW
INSERT INTO employees_audit
SET action = 'Update',
employeeNumber = OLD.empno,
empname = OLD.ename,
changedat = NOW();