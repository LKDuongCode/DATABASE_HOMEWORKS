create table tblPhong (
    PhongID int primary key auto_increment,
    Ten_Phong varchar(20),
    Trang_Thai tinyint
);

create table tblGhe (
    GheID int primary key auto_increment,
    PhongID int,
    So_Ghe varchar(10),
    foreign key (PhongID) references tblPhong(PhongID)
);

create table tblPhim (
    phimID int primary key auto_increment,
    Ten_Phim varchar(30),
    Loai_Phim varchar(25),
    Thoi_Gian int
);

create table tblVe (
    GheID int,
    PhimID int,
    Ngay_Chieu datetime,
    Trang_Thai varchar(20),
    primary key (GheID, PhimID, Ngay_Chieu),
    foreign key (GheID) references tblGhe(GheID),
    foreign key (PhimID) references tblPhim(phimID)
);

insert into tblPhim (Ten_Phim, Loai_Phim, Thoi_Gian) values
('Em bé Hà Nội', 'Tâm lý', 90),
('Nhiệm vụ bất khả thi', 'Hành động', 100),
('Dị nhân', 'Viễn tưởng', 90),
('Cuốn theo chiều gió', 'Tình cảm', 120);


insert into tblPhong (Ten_Phong, Trang_Thai) values
('Phòng chiếu 1', 1),
('Phòng chiếu 2', 1),
('Phòng chiếu 3', 0);

insert into tblGhe (PhongID, So_Ghe) values
(1, 'A3'),
(1, 'B5'),
(2, 'A7'),
(2, 'D1'),
(3, 'T2');

insert into tblVe (PhimID, GheID, Ngay_Chieu, Trang_Thai) values
(1, 1, '2008-10-20', 'Đã bán'),
(1, 3, '2008-11-20', 'Đã bán'),
(1, 4, '2008-12-23', 'Đã bán'),
(2, 1, '2009-02-14', 'Đã bán'),
(3, 1, '2009-02-14', 'Đã bán'),
(2, 5, '2009-03-08', 'Chưa bán'),
(2, 3, '2009-03-08', 'Chưa bán');

select Ten_Phim from tblPhim
where Thoi_Gian = (select max(Thoi_Gian) from tblPhim);
 
select Ten_Phim from tblPhim
where Thoi_Gian = (select min(Thoi_Gian) from tblPhim);

select So_Ghe from tblGhe
where So_Ghe like 'A%';
  
alter table tblPhong 
modify column Trang_Thai varchar(25);



select Ten_Phim from tblPhim
where length(Ten_Phim) > 15 and length(Ten_Phim) < 25;
 
create view tblRank as
select row_number() over (order by Ten_Phim) as STT, Ten_Phim, Thoi_Gian
from tblPhim;
 
alter table tblPhim 
add column Mo_ta nvarchar(100);

update tblPhim 
set Mo_ta = concat('Đây là bộ phim thể loại ', Loai_Phim);

update tblPhim 
set Mo_ta = replace(Mo_ta, 'bộ phim', 'film');
 
alter table tblGhe drop foreign key tblGhe_ibfk_1;
alter table tblVe drop foreign key tblVe_ibfk_1;
alter table tblVe drop foreign key tblVe_ibfk_2;

delete from tblGhe;

select Ngay_Chieu as 'Ngày chiếu ban đầu', date_add(Ngay_Chieu, interval 5000 minute) as 'Ngày chiếu cộng 5000 phút' from tblVe;
  
 