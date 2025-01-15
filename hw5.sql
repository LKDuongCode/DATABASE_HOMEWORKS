USE ss02;

CREATE TABLE customer (
	id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(250),
    phone_number VARCHAR(250) NOT NULL
);

CREATE TABLE bill (
	id INT PRIMARY KEY AUTO_INCREMENT ,
    customer_id INT NOT NULL,
	create_at DATE,
	FOREIGN KEY (customer_id) REFERENCES customer(id)
);