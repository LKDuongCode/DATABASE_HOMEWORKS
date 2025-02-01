CREATE DATABASE ss04;
#tạo các thực thể 
USE ss04;
CREATE TABLE Computer_room (
	room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_name CHAR(255) ,
    manager_name VARCHAR(255)
);

CREATE TABLE Subjects (
	sub_id INT PRIMARY KEY AUTO_INCREMENT,
    sub_name VARCHAR(255),
    sub_duration VARCHAR(255)
);

CREATE TABLE Registration  (
    room_id INT,
    sub_id INT,
	FOREIGN KEY (room_id) REFERENCES Computer_room(room_id),
	FOREIGN KEY (sub_id) REFERENCES Subjects(sub_id),
    registration_date DATE
);

CREATE TABLE Computer (
	com_id INT PRIMARY KEY AUTO_INCREMENT,
    room_id INT,
    FOREIGN KEY (room_id) REFERENCES Computer_room(room_id),
    com_CPU VARCHAR(255),
    com_RAM VARCHAR(255),
    com_capacity VARCHAR(255)
);

DROP TABLE Computer_room, Subjects, Registration, Computer;
