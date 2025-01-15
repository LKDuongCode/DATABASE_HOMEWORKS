USE ss02;

CREATE TABLE employee (
	id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(250) NOT NULL,
	join_date DATE,
    salary DECIMAL(10,0) DEFAULT 5000
);
