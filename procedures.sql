USE `mydb`;

DROP PROCEDURE IF EXISTS InsertIntoGroup;
DROP PROCEDURE IF EXISTS PacketInsert;
DROP PROCEDURE IF EXISTS TableCopy;

DELIMITER //
CREATE PROCEDURE InsertIntoGroup(IN name varchar(45), IN number INT, IN enrolment_year VARCHAR(45))
BEGIN
    INSERT INTO `group`(`name`, `number`, `enrollment_year`) 
    VALUES (name, number, enrolment_year);
END
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE PacketInsert()
BEGIN
    DECLARE num1 INT;
    DECLARE num2 INT;
    DECLARE num3 INT;
    DECLARE num4 INT;
    DECLARE num5 INT;
    DECLARE num6 INT;
    DECLARE num7 INT;
    DECLARE num8 INT;
    DECLARE num9 INT;
    DECLARE num10 INT;
    DECLARE x INT;
    
    SET x = 1;
	
    CREATE TABLE `lookup` (`id` INT NOT NULL AUTO_INCREMENT, `num` INT NOT NULL, PRIMARY KEY (`num`));

    loop_label: LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label;
		END  IF;
		INSERT INTO `lookup` (`id`, `num`) VALUES (x, rand() * 100) ON DUPLICATE KEY UPDATE `num` = rand() * 100;
        SET x = x + 1;
    END LOOP;

    SET x = 1;

	loop_label: 
    LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label;
		END  IF;
		INSERT INTO `debt` (`name`) VALUES (CONCAT('Noname', (SELECT `num` FROM `lookup` WHERE `id` = x)));
        SET x = x + 1;
    END LOOP;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE TableCopy()
BEGIN
	DECLARE done int DEFAULT false;
	DECLARE student_name VARCHAR(45);
	DECLARE student_cursor CURSOR FOR SELECT DISTINCT `first_name` FROM `student`;
    OPEN student_cursor;
	DROP TABLE IF EXISTS `student_copy`;
    SET @temp_query=CONCAT("CREATE TABLE `student_copy` (`id` INT AUTO_INCREMENT NOT NULL PRIMARY KEY);");
	PREPARE myquery FROM @temp_query;
	EXECUTE myquery;
	DEALLOCATE PREPARE myquery;
    label: 
    LOOP
		FETCH FROM student_cursor INTO student_name;
		IF done=true THEN LEAVE label;
		END IF;
		SET @temp_query=CONCAT("ALTER TABLE `student_copy` ADD ", student_name, " VARCHAR(45);");
		PREPARE myquery FROM @temp_query;
		EXECUTE myquery;
		DEALLOCATE PREPARE myquery;
	END LOOP;
    CLOSE student_cursor;
END;
//
