#### Định nghĩa và ví dụ minh họa của 3 ràng buộc: PRIMARY KEY, NOT NULL, FOREIGN KEY.
1. PRIMARY KEY
- Được hiểu là khóa chính, ràng buộc xác định cột hoặc nhóm cột có giá trị duy nhất, không trùng lặp.
- Ví dụ: 
```sql
CREATE TABLE demo (
    col1 INT,
    col2 CHAR(255),
    PRIMARY KEY (col1) CONSTRAINT pk_demo PRIMARY KEY
);
```
2.  NOT NULL
- Ràng buộc yêu cầu cột không được để trống.
- Ví dụ: 
```sql
CREATE TABLE demo (
    col1 INT PRIMARY KEY NOT NULL,
    col2 CHAR(255)
);

```

3.  FOREIGN KEY
- Ràng buộc xác định mối quan hệ giữa hai bảng.
- Ví dụ: 
```sql
CREATE TABLE demo (
    col1 INT PRIMARY KEY NOT NULL,
    col2 CHAR(255)
);

CREATE TABLE demo2 (
    col1 INT NOT NULL PRIMARY KEY,
    demoID INT,
    CONSTRAINT fk_demo FOREIGN KEY (demoID) REFERENCES demo(col1)
);
```


#### Sử dụng ràng buộc trong database vì:
- Tạo cấu trúc cơ sở dữ liệu tổ chức thông tin một cách hợp lý và dễ dàng truy vấn.

- Đảm bảo rằng dữ liệu được lưu trữ và xử lý một cách chính xác và có hệ thống.

