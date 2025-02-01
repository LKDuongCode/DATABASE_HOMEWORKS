CREATE TABLE department (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) NOT NULL UNIQUE,
    address VARCHAR(50) NOT NULL
);

ALTER TABLE employee
ADD COLUMN department_id INT,
ADD CONSTRAINT fk_department FOREIGN KEY (department_id) 
REFERENCES department(department_id);

INSERT INTO department (department_id, department_name, address) VALUES
(1, 'Phòng Kế Toán', '123 Đường A'),
(2, 'Phòng Nhân Sự', '456 Đường B');

UPDATE employee
SET department_id = 1
WHERE employee_id IN ('E001', 'E006','E003');

UPDATE employee
SET department_id = 2
WHERE employee_id IN ('E002', 'E005','E004'); 

# sưr dụng on delete case để tạo khóa ngoại có tính xóa tự động khi dữ liệu liên kết bị xóa  
ALTER TABLE employee DROP FOREIGN KEY fk_department;
ALTER TABLE employee 
ADD CONSTRAINT fk_department 
FOREIGN KEY (department_id) REFERENCES department(department_id) ON DELETE CASCADE;
DELETE FROM department WHERE department_id = 3;

UPDATE department
SET department_name = 'Phòng hành chính'
WHERE department_id = 1;

SELECT e.employee_id, e.employee_name, d.department_name
FROM employee e
INNER JOIN department d ON e.department_id = d.department_id;


