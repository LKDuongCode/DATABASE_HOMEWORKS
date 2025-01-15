USE ss02;

CREATE TABLE bill_detail (
    bill_id INT,
    product_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (bill_id) REFERENCES bill(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);
SELECT * FROM bill;
SELECT * FROM product;