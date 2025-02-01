use ss04;

CREATE TABLE category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    c_name VARCHAR(255) NOT NULL,
    c_description TEXT,
    c_status BIT NOT NULL
);

CREATE TABLE film (
    film_id INT PRIMARY KEY AUTO_INCREMENT,
    f_name VARCHAR(255),
    content TEXT NOT NULL,
    duration TIME NOT NULL,
    director VARCHAR(50),
    release_date DATE NOT NULL
);

CREATE TABLE category_film (
    category_id INT,
    film_id INT,
    FOREIGN KEY (category_id) REFERENCES category(category_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);

ALTER TABLE film ADD COLUMN f_status TINYINT DEFAULT 1;
ALTER TABLE category DROP COLUMN c_status;

#kiểm tra tên khóa ngoại cần xóa 
SELECT 
    CONSTRAINT_NAME, 
    TABLE_NAME 
FROM 
    information_schema.KEY_COLUMN_USAGE 
WHERE 
    TABLE_NAME = 'category_film' AND 
    TABLE_SCHEMA = 'ss04';

ALTER TABLE category_film DROP FOREIGN KEY category_film_ibfk_2;
ALTER TABLE category_film DROP FOREIGN KEY category_film_ibfk_1;

