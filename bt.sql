#1
select MaSV, HoSV, TenSV, HocBong from dmsv order by MaSv asc;

#2
select MaSV, HoSv, TenSV, Phai, NgaySinh from dmsv order by 
case
	when Phai = 'Nam' then 1
    when Phai = 'Nữ' then 2
    else 3
end ;

#3
select HoSv, TenSV, NgaySinh, HocBong from dmsv
order by NgaySinh asc;

select HoSv, TenSV, NgaySinh, HocBong from dmsv
order by HocBong desc;

#4
select MaMH, TenMH, SoTiet from dmmh where TenMH like 'T%';

#5
select HoSv, TenSV, NgaySinh, Phai from dmsv where TenSV like '%I';

#6
select MaKhoa, TenKhoa from dmkhoa where mid(TenKhoa,2,1) = 'N';

#7
select * from dmsv where HoSV like '%Thị%';

#8
select MaSV, HoSV, MaKhoa, HocBong  from dmsv where HocBong > 100000 order by MaKhoa desc;

#9
select HoSV, TenSV, MaKhoa, NoiSinh, HocBong from dmsv
where HocBong >= 150000 and NoiSinh = 'Hà Nội';

#10
select dmsv.MaSV, dmsv.MaKhoa, dmsv.Phai from dmsv
join dmkhoa on dmsv.MaKhoa = dmkhoa.MaKhoa
where dmkhoa.TenKhoa in ('Anh Văn','Vật Lý');

#11
select MaSV, NgaySinh, NoiSinh, HocBong from dmsv where NgaySinh >= '1991-01-01' and NgaySinh <= '1992=06-05';

#12
select MaSV, NgaySinh, Phai, MaKhoa from dmsv where HocBong >= 80000 and HocBong <= 150000;

#13
select MaMH, TenMH, SoTiet from dmmh where SoTiet > 30 and SoTiet < 45;

#14 
select sv.MaSV, sv.HoSV, sv.TenSV, k.TenKhoa, sv.Phai from dmsv as sv
join dmkhoa as k on sv.MaKhoa = k.MaKhoa
where Phai = 'Nam';

#15
select * from dmsv where TenSV like '%N%' and Phai = 'Nữ';

#16
select HoSV, TenSV, NoiSinh, NgaySinh from dmsv where NoiSinh = 'Hà Nội' and month(NgaySinh) = 2;

#17
select HoSV, TenSV, (year(curdate()) - year(NgaySinh)) as Tuoi, HocBong from dmsv
where (year(curdate()) - year(NgaySinh)) ;

#18
select sv.HoSV, sv.TenSv, (year(curdate()) - year(sv.NgaySinh)) as Tuoi, k.TenKhoa from dmsv as sv
join dmkhoa as k on k.MaKhoa = sv.MaKhoa
where (year(curdate()) - year(sv.NgaySinh)) >=20 and (year(curdate()) - year(sv.NgaySinh)) <= 25;

#19
select HoSV, Phai, NgaySinh 
from dmsv 
where NgaySinh >= '1990-03-01' and NgaySinh <= '1990-05-31';

#20
select maSV, phai, maKhoa, 
case 
	when hocBong > 500000 then 'học bổng cao' 
	else 'mức trung bình' 
end as mucHocBong
from dmsv;

#21
select count(*) as tong from dmsv;

#22
select count(*) as tong, sum(case when Phai = 'Nữ' then 1 else 0 end) as tongSvNu from dmsv;

#23
select 
    k.TenKhoa,
    count(s.MaSV) as tong
from dmsv as s
join dmkhoa as k on k.MaKhoa = s.MaKhoa
group by k.TenKhoa;

#24
select 
	m.TenMH,
    count(s.MaSV) as tong
from ketqua as k
join dmsv as s on s.MaSV = k.MaSV
join dmmh as m on m.MaMH = k.MaMH
group by m.TenMH;

#25
select 
	s.TenSV,
    count(k.MaMH) as tongMH
from ketqua as k
join dmsv as s on s.MaSV = k.MaSV
group by s.TenSV;

#26
select 
	k.TenKhoa,
    sum(s.HocBong) as tongHB
from dmsv as s
join dmkhoa as k on s.MaKhoa = k.MaKhoa
group by k.TenKhoa;

#27
select 
	k.TenKhoa,
	max(s.HocBong) as HBcaoNhat
from dmsv as s
join dmkhoa as k on s.MaKhoa = k.MaKhoa
group by k.TenKhoa;

#28
select 
    k.TenKhoa,
    sum(case when s.Phai = 'Nam' then 1 else 0 end) as nam,
    sum(case when s.Phai = 'Nữ' then 1 else 0 end) as nu
from dmsv as s
join dmkhoa as k on s.MaKhoa = k.MaKhoa
group by k.TenKhoa;

#29
select
year(curdate()) - year(NgaySinh) as tuoi,
count(*) as sv
from dmsv group by year(curdate()) - year(NgaySinh)
order by tuoi;

#30
select 
    year(ngaysinh) as namsinh,
    count(*) as sv
from dmsv
where 
    year(curdate()) - year(ngaysinh) >= 18 
    and year(curdate()) - year(ngaysinh) <= 23
group by year(ngaysinh)
having count(*) = 2;

#31
select 
    noisinh,
    count(*) as sv
from dmsv
where 
    year(curdate()) - year(ngaysinh) >= 18 
    and year(curdate()) - year(ngaysinh) <= 23
group by noisinh
having count(*) > 2;

#37
select 
    k.TenKhoa,
    count(*) as sv
from dmsv as s
join dmkhoa as k on k.MaKhoa = s.MaKhoa
where s.HocBong >= 200000 and s.HocBong <= 300000
group by k.TenKhoa
having count(*) >= 2;

#39
select * from dmsv where HocBong = (select max(HocBong) from dmsv);


