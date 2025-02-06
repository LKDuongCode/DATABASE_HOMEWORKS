#1
create table patients (
    patientID int primary key auto_increment,
    fullname varchar(100),
    dob date,
    gender varchar(10),
    phonenumber varchar(15)
);

create table doctors (
    doctorID int primary key auto_increment,
    fullname varchar(100),
    specialization varchar(50),
    phonenumber varchar(15),
    email varchar(100)
);

create table appointments (
    appointmentID int primary key auto_increment,
    patientID int,
	doctorID int,
    appointmentdate datetime,
    status varchar(20),
    foreign key (patientID) references patients(patientID),
	foreign key (doctorID) references doctors(doctorID)
);

create table medicalrecords (
    recordID int primary key auto_increment,
    patientID int,
    doctorID int,
    diagnosis text,
    treatmentplan text,
    foreign key (patientID) references patients(patientID),
    foreign key (doctorID) references doctors(doctorID)
);

#2
INSERT INTO patients (fullname, dob, gender, phonenumber)
VALUES
    ('Nguyen Van An', '1985-05-15', 'Nam', '0901234567'),
    ('Tran Thi Binh', '1990-09-12', 'Nu', '0912345678'),
    ('Pham Van Cuong', '1978-03-20', 'Nam', '0923456789'),
    ('Le Thi Dung', '2000-11-25', 'Nu', '0934567890'),
    ('Vo Van Em', '1982-07-08', 'Nam', '0945678901'),
    ('Hoang Thi Phuong', '1995-01-18', 'Nu', '0956789012'),
    ('Ngo Van Giang', '1988-12-30', 'Nam', '0967890123'),
    ('Dang Thi Hanh', '1992-06-10', 'Nu', '0978901234'),
    ('Bui Van Hoa', '1975-10-22', 'Nam', '0989012345');
    
INSERT INTO doctors (fullname, specialization, phonenumber, email)
VALUES
    ('Le Minh', 'Noi Tong Quat', '0908765432', 'leminh@hospital.vn'),
    ('Phan Huong', 'Nhi Khoa', '0918765432', 'phanhuong@hospital.vn'),
    ('Nguyen Tuan', 'Tim Mach', '0928765432', 'nguyentuan@hospital.vn'),
    ('Dang Quang', 'Than Kinh', '0938765432', 'dangquang@hospital.vn'),
    ('Hoang Dung', 'Da Lieu', '0948765432', 'hoangdung@hospital.vn'),
    ('Vu Hanh', 'Phu San', '0958765432', 'vuhanh@hospital.vn'),
    ('Tran An', 'Noi Tiet', '0968765432', 'tranan@hospital.vn'),
    ('Lam Phong', 'Ho Hap', '0978765432', 'lamphong@hospital.vn'),
    ('Pham Ha', 'Chan Thuong Chinh Hinh', '0988765432', 'phamha@hospital.vn');
    
INSERT INTO appointments (patientID, doctorID, appointmentdate, status)
VALUES
    (1, 2, '2025-01-20 09:00:00', 'Da Dat'),
    (3, 1, '2025-01-21 10:30:00', 'Da Dat'),
    (5, 3, '2025-01-22 08:00:00', 'Da Dat'),
    (2, 4, '2025-01-23 14:00:00', 'Da Dat'),
    (4, 5, '2025-01-24 11:00:00', 'Da Dat'),
    (6, 6, '2025-01-25 15:00:00', 'Da Dat'),
    (7, 7, '2025-01-26 16:30:00', 'Da Dat'),
    (8, 8, '2025-01-27 09:00:00', 'Da Dat'),
    (9, 9, '2025-01-28 10:00:00', 'Da Dat');

INSERT INTO medicalrecords (patientID, doctorID, diagnosis, treatmentplan)
VALUES
    (1, 2, 'Cam Cum', 'Nghi ngoi, uong nhieu nuoc, su dung paracetamol 500mg khi sot.'),
    (3, 1, 'Dau Dau Man Tinh', 'Kiem tra huyet ap dinh ky, giam cang thang, su dung thuoc giam dau khi can.'),
    (5, 3, 'Roi Loan Nhip Tim', 'Theo doi tim mach 1 tuan/lan, dung thuoc dieu hoa nhip tim.'),
    (2, 4, 'Dau Cot Song', 'Vat ly tri lieu, giam van dong manh.'),
    (4, 5, 'Viêm Da Tiep Xuc', 'Su dung kem boi da, tranh tiep xuc voi chat gay di ung.'),
    (6, 6, 'Thieu Mau', 'Tang cuong thuc pham giau sat, bo sung vitamin.'),
    (7, 7, 'Tieu Duong Type 2', 'Duy tri che do an lanh manh, kiem tra duong huyet thuong xuyen.'),
    (8, 8, 'Hen Suyen', 'Su dung thuoc xit hen hang ngay, tranh tiep xuc bui ban.'),
    (9, 9, 'Gay Xuong', 'Bo bot, kiem tra xuong dinh ky, vat ly tri lieu sau khi thao bot.');
    
#3
select p.fullname, d.fullname, a.appointmentdate, d.specialization, a.status from appointments a
join patients p on a.patientID = p.patientID
join doctors d on a.doctorID = d.doctorID
where a.appointmentdate between '2025-01-20' and '2025-01-25'
order by a.appointmentdate asc limit 3;

#4
select p.fullname,p.dob,d.fullname as doctorname,d.specialization,m.diagnosis from appointments a
join patients p on a.patientID = p.patientID
join doctors d on a.doctorID = d.doctorID
join medicalrecords m on p.patientID = m.patientID and d.doctorID = m.doctorID
where a.appointmentdate between '2025-01-20' and '2025-01-25'
order by a.appointmentdate asc limit 5;

#5
select p.fullname as patientname,p.dob,datediff(a.appointmentdate, p.dob) as ageatappointment,a.appointmentdate,max(m.recordID) as diagnosisrecordid, datediff(a.appointmentdate, (select max(m2.recordID) from medicalrecords m2 where m2.patientID = p.patientID)) as daysdifference from appointments as a
join patients as p on a.patientID = p.patientID
join medicalrecords as m on p.patientID = m.patientID
where a.appointmentdate in (
        select max(appointmentdate)
        from appointments
        where patientID = p.patientID
    )
group by p.patientID, a.appointmentdate
order by a.appointmentdate asc;
