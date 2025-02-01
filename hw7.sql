USE ss03;
CREATE TABLE student7 (
	student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    dob DATE NOT NULL ,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    gpa DECIMAL(3,2) CHECK(gpa >= 0 AND gpa <= 4)
);

INSERT INTO student7 (student_name, email, dob, gender, gpa)
VALUES
('Nguyen Van A', 'nguyenvana@example.com', '2000-05-15', 'Male', 3.50),
('Tran Thi B', 'tranthib@example.com', '1999-08-22', 'Female', 3.80),
('Le Van C', 'levanc@example.com', '2001-01-10', 'Male', 2.70),
('Pham Thi D', 'phamthid@example.com', '1998-12-05', 'Female', 3.00),
('Hoang Van E', 'hoangvane@example.com', '2000-03-18', 'Male', 3.60),
('Do Thi F', 'dothif@example.com', '2001-07-25', 'Female', 4.00),
('Vo Van G', 'vovang@example.com', '2000-11-30', 'Male', 3.20),
('Nguyen Thi H', 'nguyenthih@example.com', '1999-09-15', 'Female', 2.90),
('Bui Van I', 'buivani@example.com', '2002-02-28', 'Male', 3.40),
('Tran Thi J', 'tranthij@example.com', '2001-06-12', 'Female', 3.75);


# gpa > 3.0 và = nữ
SELECT * FROM student7
WHERE gpa > 3 AND gender = "Female";

# gpa cao nhất sau 2000
SELECT * FROM student7
WHERE YEAR(dob) > 2000 ORDER BY gpa DESC LIMIT 1;

# lấy trùng ngày sinh với id 1
SELECT * FROM student7
WHERE dob = (SELECT dob FROM student7 WHERE student_id = 1 LIMIT 1);

# +0.5 gpa cho <2.5gpa nhưng không > 4
SET SQL_SAFE_UPDATES = 0; # tắt safe mode
UPDATE student7 SET gpa = CASE
	WHEN gpa + 0.5 > 4 THEN 4
	ELSE gpa + 0.5
END
WHERE gpa < 2.5;

# if email có test => gender = other
UPDATE student7 SET gender = "Other"
WHERE email LIKE "%test%";

#xóa sv có dob sớm nhất 
SET @min_dob = (SELECT MIN(dob) FROM student7);
DELETE FROM student7 WHERE dob = @min_dob;

#tính tuổi tất cả sinh viên dựa trên ngày sinh
SELECT 
    student_name ,
    TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS age
FROM 
    student7;


