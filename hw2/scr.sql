CREATE DATABASE hw2;
#tạo các thực thể 
USE hw2;
CREATE TABLE provider (
	p_id INT PRIMARY KEY AUTO_INCREMENT,
    p_name CHAR(255)
);

CREATE TABLE address (
	a_id INT PRIMARY KEY AUTO_INCREMENT,
    p_id INT,
	FOREIGN KEY (p_id) REFERENCES provider(p_id),
	city VARCHAR(255)
);

CREATE TABLE material (
	m_id INT PRIMARY KEY AUTO_INCREMENT,
    m_quantity INT,
    m_prcie INT
);


CREATE TABLE bill (
	b_id INT PRIMARY KEY AUTO_INCREMENT,
    p_id INT,
	FOREIGN KEY (p_id) REFERENCES provider(p_id),
	m_id INT,
	FOREIGN KEY (m_id) REFERENCES material(m_id),
    m_quantity INT,
    m_prcie INT
);

