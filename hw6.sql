CREATE TABLE book (
	book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

INSERT INTO book (title, price, stock)
VALUES
('To Kill a Mockingbird', 120.00, 10),
('1984', 90.00, 3),
('The Great Gatsby', 150.00, 20),
('Moby Dick', 200.00, 5),
('Pride and Prejudice', 50.00, 8);

SELECT * FROM book 
WHERE price > 100;

SET SQL_SAFE_UPDATES = 0; # tắt safe mode
DELETE FROM book WHERE title LIKE '%Price%'