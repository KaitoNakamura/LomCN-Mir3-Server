/* Create Database (Schema) lomcn_m3_account */

CREATE SCHEMA `lomcn_m3_account` DEFAULT CHARACTER SET utf8;


/* Create Table m3_account */

DROP TABLE IF EXISTS `m3_account`;

CREATE TABLE `lomcn_m3_account`.`m3_account` (
  `FL_UserID` INT NOT NULL AUTO_INCREMENT,
  `FL_UserName` VARCHAR(100) NOT NULL,
  `FL_UserPassword` VARCHAR(32) NOT NULL,
  `FL_Backup_Password` VARCHAR(170) NULL,
  `FL_PassFailCount` INT NULL DEFAULT 0,
  `FL_UserEMail` VARCHAR(80) NOT NULL,
  `FL_TempBan` TINYINT(2) NULL DEFAULT 0,
  `FL_PermBan` TINYINT(2) NULL DEFAULT 0,
  `FL_Deleted` TINYINT(2) NULL DEFAULT 0,
  `FL_TempBan_Start` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `FL_LastLogin` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `FL_DeletedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `FL_MakeDateTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`FL_UserID`),
  UNIQUE INDEX `FL_UserName_UNIQUE` (`FL_UserName` ASC),
  UNIQUE INDEX `FL_UserEMail_UNIQUE` (`FL_UserEMail` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'M3 Account DB';

/* Add first Test User */
INSERT INTO `lomcn_m3_account`.`m3_account`(`FL_UserName`,`FL_UserPassword`,`FL_Backup_Password`,`FL_UserEMail`) VALUES ('Test','0CBC6611F5540BD0809A388DC95A615B','BackUp','Test@test.de');


/* Add DB Server Functions */

USE `lomcn_m3_account`;
DROP function IF EXISTS `check_login`;

DELIMITER $$
USE `lomcn_m3_account`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `check_login`(user_name varchar(100), user_password varchar(32)) RETURNS int(11)
BEGIN
  DECLARE Success int;
  DECLARE SuccessName int;
  DECLARE SuccessEMail int;
  
  SELECT COUNT(`FL_UserName`)  INTO SuccessName  FROM `m3_account` WHERE `FL_UserName`=user_name;
  SELECT COUNT(`FL_UserEMail`) INTO SuccessEMail FROM `m3_account` WHERE `FL_UserEMail`=user_name; 
  
  IF (SuccessName = 1) THEN
    SELECT COUNT(`FL_UserName`)  INTO Success FROM `m3_account` WHERE `FL_UserPassword` = user_password AND `FL_UserName` = user_name;
	IF (Success = 1) THEN
      UPDATE `m3_account` SET `FL_LastLogin`=SYSDATE() WHERE `FL_UserName`=user_name  OR `FL_UserEMail`=user_name; 
      RETURN 0;
    ELSE
      UPDATE `m3_account` SET `FL_PassFailCount`=`FL_PassFailCount` + 1 WHERE `FL_UserName`=user_name; 
      RETURN 1;
    END IF;
  ELSEIF (SuccessEMail = 1) THEN
	SELECT COUNT(`FL_UserEMail`)  INTO Success FROM `m3_account` WHERE `FL_UserPassword` = user_password AND `FL_UserEMail` = user_name;
    IF (Success = 1) THEN
      UPDATE `m3_account` SET `FL_LastLogin`=SYSDATE() WHERE `FL_UserName`=user_name  OR `FL_UserEMail`=user_name;		   
      RETURN 0;
	ELSE
	  UPDATE `m3_account` SET `FL_PassFailCount`=`FL_PassFailCount` + 1 WHERE `FL_UserEMail`=user_name; 
      RETURN 2;
	END IF;
  END IF;
  RETURN 3;
END$$

DELIMITER ;



USE `lomcn_m3_account`;
DROP function IF EXISTS `check_new_email`;

DELIMITER $$
USE `lomcn_m3_account`$$
CREATE FUNCTION `check_new_email` (user_email varchar(80))
RETURNS INTEGER
BEGIN
DECLARE Success int;
SELECT 
    COUNT(`FL_UserEMail`)
INTO Success FROM
    `m3_account`
WHERE
    `FL_UserEMail` = user_email;
  IF (Success = 1) THEN
    RETURN 1;
  ELSE
    RETURN 0;
  END IF;
END$$

DELIMITER ;


USE `lomcn_m3_account`;
DROP function IF EXISTS `check_new_username`;

DELIMITER $$
USE `lomcn_m3_account`$$
CREATE FUNCTION `check_new_username` (user_name varchar(100))
RETURNS INTEGER
BEGIN
DECLARE Success int;
SELECT 
    COUNT(`FL_UserName`)
INTO Success FROM
    `m3_account`
WHERE
    `FL_UserName` = user_name;
  IF (Success = 1) THEN
    RETURN 1;
  ELSE
    RETURN 0;
  END IF;
END$$

DELIMITER ;

/* Check Functions */

USE `lomcn_m3_account`;
DROP function IF EXISTS `m3_sys_get_account_count`;

DELIMITER $$
USE `lomcn_m3_account`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `m3_sys_get_account_count`() RETURNS int(11)
BEGIN
DECLARE Success int;
SELECT 
    COUNT(*)
INTO Success FROM
    `m3_account`
WHERE
    `FL_Deleted` = 0;    
    RETURN Success;
END$$

DELIMITER ;

USE `lomcn_m3_account`;
DROP function IF EXISTS `m3_sys_get_deleted_account_count`;

DELIMITER $$
USE `lomcn_m3_account`$$
CREATE FUNCTION `m3_sys_get_deleted_account_count` ()
RETURNS INTEGER
BEGIN
DECLARE Success int;
SELECT 
    COUNT(*)
INTO Success FROM
    `m3_account`
WHERE
    `FL_Deleted` = 1;
    
RETURN Success;
END$$

DELIMITER ;


USE `lomcn_m3_account`;
DROP function IF EXISTS `m3_sys_overall_account_count`;

DELIMITER $$
USE `lomcn_m3_account`$$
CREATE FUNCTION `m3_sys_overall_account_count` ()
RETURNS INTEGER
BEGIN
DECLARE Success int;
SELECT 
    COUNT(*)
INTO Success FROM
    `m3_account`;
    
RETURN Success;
END$$

DELIMITER ;


USE `lomcn_m3_account`;
DROP function IF EXISTS `create_new_account`;

DELIMITER $$
USE `lomcn_m3_account`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `create_new_account`(user_name varchar(100), user_password varchar(32), user_backup_pw varchar(170), user_email varchar(80)) RETURNS int(11)
BEGIN
DECLARE SuccessMail int;
DECLARE SuccessName int;
SELECT 
    COUNT(`FL_UserName`)
INTO SuccessName FROM
    `m3_account`
WHERE
    `FL_UserName` = user_name;
SELECT 
    COUNT(`FL_UserEMail`)
INTO SuccessMail FROM
    `m3_account`
WHERE
    `FL_UserEMail` = user_email;

  IF (SuccessMail = 0 and SuccessName = 0) THEN
    INSERT INTO `m3_account` (`FL_UserName`,`FL_UserPassword`, `FL_Backup_Password`, `FL_UserEMail`) VALUES (user_name, user_password, user_backup_pw, user_email);
    RETURN 0;
  ELSE
    RETURN 1;
  END IF;
END$$

DELIMITER ;




