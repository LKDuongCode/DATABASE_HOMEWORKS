CREATE TABLE employee1 (
	employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    department VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2) NOT NULL CHECK(salary > 0)
);

INSERT INTO employee1 (student_name, email, department, salary) 
VALUES 
('Nguyen Van A', 'nguyenvana@example.com', 'Sales', 50000.00), 
('Le Thi B', 'lethib@example.com', 'IT', 60000.00), 
('Tran Van C', 'tranvanc@example.com', 'HR', 45000.00), 
('Pham Thi D', 'phamthid@example.com', 'Marketing', 55000.00);

SELECT * FROM employee1
WHERE department = "Sales";

SET SQL_SAFE_UPDATES = 0; # tắt safe mode
UPDATE employee1
SET salary = (salary * (10 / 100)) + salary
WHERE department = 'Marketing';