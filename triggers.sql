USE `mydb`;

DROP TRIGGER IF EXISTS BeforeInsertCityCheckFK;
DROP TRIGGER IF EXISTS BeforeInsertGraduatedSecondarySchoolCheckFK;
DROP TRIGGER IF EXISTS BeforeInsertStudentCheckFK;
DROP TRIGGER IF EXISTS BeforeInsertStudentHasDebtCheckFK;
DROP TRIGGER IF EXISTS BeforeDeleteStudentCheckFK;
DROP TRIGGER IF EXISTS BeforeDeleteDebtCheckFK;
DROP TRIGGER IF EXISTS BeforeDeleteGroupCheckFK;
DROP TRIGGER IF EXISTS BeforeDeleteGraduatedSecondarySchoolCheckFK;
DROP TRIGGER IF EXISTS BeforeDeleteCityCheckFK;
DROP TRIGGER IF EXISTS BeforeDeleteRegionCheckFK;
DROP TRIGGER IF EXISTS BeforeUpdateStudentCheckFK;
DROP TRIGGER IF EXISTS BeforeUpdateDebtCheckFK;
DROP TRIGGER IF EXISTS BeforeUpdateGroupCheckFK;
DROP TRIGGER IF EXISTS BeforeUpdateGraduatedSecondarySchoolCheckFK;
DROP TRIGGER IF EXISTS BeforeUpdateCityCheckFK;
DROP TRIGGER IF EXISTS BeforeUpdateRegionCheckFK;
DROP TRIGGER IF EXISTS BeforeUpdateStudentCheckCode;
DROP TRIGGER IF EXISTS BeforeInsertStudentCheckCode;
DROP TRIGGER IF EXISTS BeforeInsertStudentCheckEmail;
DROP TRIGGER IF EXISTS BeforeUpdateStudentCheckEmail;
DROP TRIGGER IF EXISTS BeforeInsertRegionRestrict;
DROP TRIGGER IF EXISTS BeforeUpdateRegionRestrict;

DELIMITER //
CREATE TRIGGER BeforeInsertCityCheckFK
BEFORE INSERT
ON `city` FOR EACH ROW
BEGIN
	IF (new.region_id NOT IN (SELECT id FROM `region`))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Insert: foreign key failure";
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeInsertGraduatedSecondarySchoolCheckFK
BEFORE INSERT
ON `school` FOR EACH ROW
BEGIN
	IF (new.name NOT IN (SELECT name FROM `city`))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Insert: foreign key failure";
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeInsertStudentCheckFK
BEFORE INSERT
ON `student` FOR EACH ROW
BEGIN
	IF (
		new.city_id NOT IN (SELECT id FROM `city`) 
		OR new.group_id NOT IN (SELECT id FROM `group`)
		OR new.school_id NOT IN (SELECT id FROM `school`)
    )
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Insert: foreign key failure";
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeInsertStudentHasDebtCheckFK
BEFORE INSERT
ON `student_debt` FOR EACH ROW
BEGIN
	IF (
		new.student_id NOT IN (SELECT id FROM `student`) 
		OR new.debt_id NOT IN (SELECT id FROM `debt`)
    )
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Insert: foreign key failure";
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeDeleteStudentCheckFK
BEFORE DELETE
ON `student` FOR EACH ROW
BEGIN
	IF (old.id IN (SELECT student_id FROM `student_debt`))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Delete: foreign key failure";
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeDeleteDebtCheckFK
BEFORE DELETE
ON `debt` FOR EACH ROW
BEGIN
	IF (old.id IN (SELECT debt_id FROM `student_debt`))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Delete: foreign key failure";
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeDeleteGroupCheckFK
BEFORE DELETE
ON `group` FOR EACH ROW
BEGIN
	IF (old.id IN (SELECT group_id FROM `student`))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Delete: foreign key failure";
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeDeleteGraduatedSecondarySchoolCheckFK
BEFORE DELETE
ON `school` FOR EACH ROW
BEGIN
	IF (old.id IN (SELECT school_id FROM `student`))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Delete: foreign key failure";
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeDeleteCityCheckFK
BEFORE DELETE
ON `city` FOR EACH ROW
BEGIN
	IF (
		old.id IN (SELECT city_id FROM `student`) 
		OR old.id IN (SELECT city_id FROM `school`)
    )
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Delete: foreign key failure";
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeDeleteRegionCheckFK
BEFORE DELETE
ON `region` FOR EACH ROW
BEGIN
	IF (old.id IN (SELECT region_id FROM `city`))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Delete: foreign key failure";
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeUpdateStudentCheckFK
BEFORE UPDATE
ON `student` FOR EACH ROW
BEGIN
	IF (old.id != new.id AND old.id IN (SELECT student_id FROM `student_debt`))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Update: foreign key failure";
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeUpdateDebtCheckFK
BEFORE UPDATE
ON `debt` FOR EACH ROW
BEGIN
	IF (old.id != new.id AND old.id IN (SELECT debt_id FROM `student_debt`))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Update: foreign key failure";
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeUpdateGroupCheckFK
BEFORE UPDATE
ON `group` FOR EACH ROW
BEGIN
	IF (old.id != new.id AND old.id IN (SELECT group_id FROM `student`))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Update: foreign key failure";
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeUpdateGraduatedSecondarySchoolCheckFK
BEFORE UPDATE
ON `school` FOR EACH ROW
BEGIN
	IF (old.id != new.id AND old.id IN (SELECT school_id FROM `student`))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Update: foreign key failure";
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeUpdateCityCheckFK
BEFORE UPDATE
ON `city` FOR EACH ROW
BEGIN
	IF (old.name != new.name 
        AND (
			old.id IN (SELECT city_id FROM `student`) 
			OR old.id IN (SELECT city_id FROM `school`)
		)
    )
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Update: foreign key failure";
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeUpdateRegionCheckFK
BEFORE UPDATE
ON `region` FOR EACH ROW
BEGIN
	IF (old.id != new.id AND old.id IN (SELECT region_id FROM `city`))
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Update: foreign key failure";
	END IF;
END //
DELIMITER ;

-- Check for student code pattern

DELIMITER //
CREATE TRIGGER BeforeInsertStudentCheckCode
BEFORE INSERT
ON `student` FOR EACH ROW
BEGIN
	IF (new.student_card NOT RLIKE "^[A-DF-KM-RT-Z][0-68-9]{8}$")
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Student: code does not match the pattern";
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeUpdateStudentCheckCode
BEFORE UPDATE
ON `student` FOR EACH ROW
FOLLOWS BeforeUpdateStudentCheckFK
BEGIN
	IF (new.student_card NOT RLIKE "^[A-DF-KM-RT-Z][0-68-9]{8}$")
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Student: code does not match the pattern";
	END IF;
END //
DELIMITER ;

-- Check pattern for email of student

DELIMITER //
CREATE TRIGGER BeforeInsertStudentCheckEmail
BEFORE INSERT
ON `student` FOR EACH ROW
FOLLOWS BeforeInsertStudentCheckFK
BEGIN
	IF (new.email RLIKE "\w+@\w+?\.ua")
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Student: email does not match the pattern";
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeUpdateStudentCheckEmail
BEFORE UPDATE
ON `student` FOR EACH ROW
FOLLOWS BeforeUpdateStudentCheckFK
BEGIN
	IF (new.email RLIKE "\w+@\w+?\.ua")
	THEN SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Student: email does not match the pattern";
	END IF;
END //
DELIMITER ;

-- Restrict updates for Region table

DELIMITER //
CREATE TRIGGER BeforeInsertRegionRestrict
BEFORE INSERT
ON `region` FOR EACH ROW
BEGIN
	SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Region: insertions restricted";
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeUpdateRegionRestrict
BEFORE UPDATE
ON `region` FOR EACH ROW
BEGIN
	SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "CHECK error for Region: updates restricted";
END //
DELIMITER ;