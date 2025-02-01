USE ss03;

CREATE TABLE student2 (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL UNIQUE,
    age INT NOT NULL CHECK(age > 0)

);

INSERT INTO student2 (student_name, email, age) 

VALUES ('Nguyen Van A', 'nguyenvana@example.com', 22), 

('Le Thi B', 'lethib@example.com', 20), 

('Tran Van C', 'tranvanc@example.com', 23), 

('Pham Thi D', 'phamthid@example.com', 21);


UPDATE student2 
SET email = 'newemail@example.com'
WHERE student_id = 3;