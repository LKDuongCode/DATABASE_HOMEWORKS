CREATE TABLE employee (
    employee_id CHAR(4) PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    dob DATE,
    sex BIT NOT NULL,
    base_salary INT NOT NULL CHECK (base_salary > 0),
    phone_number CHAR(11) NOT NULL UNIQUE
);

INSERT INTO employee (employee_id, employee_name, dob, sex, base_salary, phone_number) VALUES
('E001', 'Nguyễn Minh Nhật', '2004-12-11', 0, 4000000, '0987836473'),
('E002', 'Đồ Đức Long', '2004-01-12', 0, 3500000, '0982378673'),
('E003', 'Mai Tiến Linh', '2004-02-03', 0, 3500000, '0976734562'),
('E004', 'Nguyễn Ngọc Ánh', '2004-10-04', 1, 5000000, '0987352772'),
('E005', 'Phạm Minh Sơn', '2003-03-12', 0, 4000000, '0987236568'),
('E006', 'Nguyễn Ngọc Minh', '2003-11-11', 1, 5000000, '0928864736');

SELECT employee_id, employee_name, DAY(dob) AS birthday, phone_number FROM employee;

SET sql_safe_updates = 0;
UPDATE employee 
SET base_salary = base_salary + (base_salary * (10 / 100)) 
WHERE sex = 1;

DELETE FROM employee
WHERE YEAR(dob) = '2003';