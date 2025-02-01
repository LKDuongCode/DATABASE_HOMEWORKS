CREATE DATABASE ss03;
USE ss03;


CREATE TABLE student (
    student_id INT PRIMARY KEY NOT NULL,
    student_name VARCHAR(255) NOT NULL,
    age INT NOT NULL CHECK(age >= 18),
    gender VARCHAR(10) NOT NULL CHECK(gender IN ('Male', 'Female', 'Other')),
    registration_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO student (student_id, student_name, age, gender, registration_date)
VALUES
(1, 'Nguyễn Văn A', 20, 'Male', '2025-01-01 10:00:00'),
(2, 'Trần Thị B', 22, 'Female', '2025-01-02 11:00:00'),
(3, 'Lê Minh C', 19, 'Male', '2025-01-03 12:00:00'),
(4, 'Phan Thị D', 21, 'Female', '2025-01-04 13:00:00'),
(5, 'Hoàng Văn E', 23, 'Male', '2025-01-05 14:00:00');