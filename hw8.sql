CREATE TABLE score (
	id VARCHAR(20),
    score INT
);

/*
- thiếu pk ở id
- id cần được thêm tự động
- id và score không được để trống
- score thiếu check từ 0 đến 10
*/

CREATE TABLE score (
    id VARCHAR(20) PRIMARY KEY NOT NULL,
    score INT NOT NULL CHECK (score >= 0 AND score <= 10)
);