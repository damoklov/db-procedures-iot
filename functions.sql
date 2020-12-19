USE `mydb`;

DROP FUNCTION IF EXISTS FindMaxStudentBirthDate;
DROP FUNCTION IF EXISTS FindCityOfEachStudent;

DELIMITER //
CREATE FUNCTION FindMaxStudentBirthDate()
RETURNS DATETIME
BEGIN
	RETURN (SELECT MAX(`birth_date`) FROM `student`);
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION FindCityOfEachStudent(studentID INT)
RETURNS VARCHAR(45)
BEGIN
	RETURN (SELECT name FROM `city` WHERE id = studentID);
END //
DELIMITER ;


SELECT id, first_name
FROM `student`
WHERE birth_date = FindMaxStudentBirthDate();

SELECT id, first_name, last_name, FindCityOfEachStudent(city_id) AS city FROM `student`;
SELECT MAX(`birth_date`) FROM `student`;