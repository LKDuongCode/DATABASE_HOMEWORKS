create database compare_engine;
use compare_engine;


CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(255) NOT NULL
);

CREATE TABLE employees_innodb (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id) 
);


CREATE TABLE employees_myisam (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(190) UNIQUE NOT NULL,
    department_id INT NOT NULL
) ENGINE = MyISAM;

INSERT INTO departments (department_name) VALUES
('Human Resources'),
('Finance'),
('Marketing'),
('Sales'),
('Information Technology');

INSERT INTO employees_myisam (name, email, department_id) VALUES
('Fiona Green', 'fiona.green@example.com', 1),
('George Black', 'george.black@example.com', 1),
('Hannah White', 'hannah.white@example.com', 2),
('Ian Gray', 'ian.gray@example.com', 3),
('Jane Doe', 'jane.doe@example.com', 2);


INSERT INTO employees_innodb (name, email, department_id) VALUES
('Alice Smith', 'alice.smith@example.com', 1),
('Bob Johnson', 'bob.johnson@example.com', 1),
('Charlie Brown', 'charlie.brown@example.com', 2),
('Diana Prince', 'diana.prince@example.com', 3),
('Ethan Hunt', 'ethan.hunt@example.com', 2);

#1 Hỗ trợ transaction-------------------------------------------------------------
/*
InnoDB có hỗ trợ, cho phép ROLLBACK.
MyISAM không hỗ trợ, lệnh ROLLBACK không có tác dụng.
*/

-- innodb
DELIMITER //
CREATE PROCEDURE sp_check_rollback ()
BEGIN
	START TRANSACTION;
	INSERT INTO employees_innodb (name, email, department_id) 
	VALUES ('Nguyễn Văn A', 'nguyenvana@example.com', 1);
	ROLLBACK;  -- Hủy thao tác, dữ liệu không được lưu
END;
// 
DELIMITER ;

CALL sp_check_rollback();
SELECT * FROM employees_innodb; -- Kết quả không có dòng nào được thêm



-- myisam
DELIMITER //
CREATE PROCEDURE sp_check_rollback2 ()
BEGIN
	START TRANSACTION;
	INSERT INTO employees_myisam (name, email, department_id) 
	VALUES ('Nguyễn Văn A', 'nguyenvana@example.com', 1);
	ROLLBACK;  -- Không có tác dụng
    SHOW WARNINGS; -- Hiển thị cảnh báo rằng ROLLBACK không được hỗ trợ
END;
// 
DELIMITER ;

CALL sp_check_rollback2();
SELECT * FROM employees_myisam; -- Dữ liệu vẫn được thêm


#2 So sánh cơ chế khóa 
/*
InnoDB dùng Row-Level Locking (chỉ khóa dòng bị ảnh hưởng).
MyISAM dùng Table-Level Locking (khóa toàn bộ bảng).
*/

-- innodb
START TRANSACTION;
-- window 1
UPDATE employees_innodb SET name = 'Nguyễn Văn B' WHERE employee_id = 4;
-- KHÔNG COMMIT GIỮ NGUYÊN TRANSACTION

-- window 2
UPDATE employees_innodb SET name = 'Nguyễn Văn C' WHERE employee_id = 5;
-- Nếu chạy thành công ngay lập tức -> InnoDB chỉ khóa dòng 4, không khóa toàn bảng




-- myIsam ;
-- window 1
START TRANSACTION;
UPDATE employees_myisam SET name = 'Nguyễn Văn g' WHERE employee_id = 1;
-- KHÔNG COMMIT GIỮ TRANSACTION MỞ


-- mở một cửa sổ khác và chạy 
UPDATE employees_myisam SET name = 'Nguyễn Văn H' WHERE employee_id = 2;
-- Nếu lệnh này bị treo (waiting), chứng tỏ MyISAM đã khóa toàn bảng



#3 InnoDB hỗ trợ khóa ngoại trong khi myisam thì ngược lại. Xem trên phần tạo bảng .--------------------------
-- Thêm nhân viên hợp lệ trong InnoDB (vì `department_id = 1` tồn tại)
INSERT INTO employees_innodb (name, email, department_id) 
VALUES ('Nguyễn Văn A', 'nguyenvana@example.com', 1);

-- Thử thêm nhân viên với `department_id` không tồn tại (sẽ báo lỗi)
INSERT INTO employees_innodb (name, email, department_id) 
VALUES ('Nguyễn Văn B', 'nguyenvanb@example.com', 99);
-- Lỗi: `Cannot add or update a child row: a foreign key constraint fails`

-- Thử tương tự với MyISAM (sẽ không có lỗi)
INSERT INTO employees_myisam (name, email, department_id) 
VALUES ('Nguyễn Văn C', 'nguyenvanc@example.com', 99);
-- Không báo lỗi vì MyISAM không kiểm tra `FOREIGN KEY`

#4 So sánh tốc độ truy vấn 
EXPLAIN ANALYZE SELECT * FROM employees_innodb WHERE department_id = 2; -- chậm hơn 0.09
EXPLAIN ANALYZE SELECT * FROM employees_myisam WHERE department_id = 2; -- 0.03







