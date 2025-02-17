use ss12;

#1
create table patients (
    patient_id int auto_increment primary key,
    name varchar(100) not null,
    dob date not null,
    gender enum('male', 'female') not null,
    phone varchar(15) unique
);

create table doctors (
    doctor_id int auto_increment primary key,
    name varchar(100) not null,
    specialization varchar(100) not null,
    phone varchar(15) unique,
    salary decimal(10, 2)
);

create table appointments (
    appointment_id int auto_increment primary key,
    patient_id int,
    doctor_id int,
    appointment_date datetime not null,
    status enum('scheduled', 'completed', 'cancelled') not null,
    foreign key (patient_id) references patients(patient_id),
    foreign key (doctor_id) references doctors(doctor_id)
);

create table prescriptions (
    prescription_id int auto_increment primary key,
    appointment_id int,
    medicine_name varchar(100) not null,
    dosage varchar(50) not null,
    duration varchar(50),
    notes varchar(255),
    foreign key (appointment_id) references appointments(appointment_id)
);

#2
create table patient_error_log (
    log_id int auto_increment primary key,
    patient_name varchar(100),
    phone_number varchar(15),
    error_message varchar(255),
    created_at timestamp default current_timestamp
);

#3
delimiter //
create trigger before_insert_patients
before insert on patients for each row
begin
    declare is_exists int;
    select count(*) into is_exists from patients where name = new.name and dob = new.dob;
    if is_exists > 0 then
        insert into patient_error_log (patient_name, phone_number, error_message)
        values (new.name, new.phone, 'is exists');
        signal sqlstate '45000' set message_text = 'patient already exists';
    end if;
end 
// delimiter ;

#4
insert into patients (name, dob, gender, phone) values ('john doe', '1990-01-01', 'male', '1234567890');
insert into patients (name, dob, gender, phone) values ('john doe', '1990-01-01', 'male', '0987654321');

#5
delimiter //
create trigger check_phone_number_format before insert on patients
for each row
begin
    if length(new.phone) != 10  then
        insert into patient_error_log (patient_name, phone_number, error_message)
        values (new.name, new.phone, 'ivalid phone');
        signal sqlstate '45000' set message_text = 'invalid phone';
    end if;
end 
// delimiter ;

#6
insert into patients (name, dob, gender, phone) values
('alice smith', '1985-06-15', 'female', '1234567895'),
('bob johnson', '1990-02-25', 'male', '2345678901'),
('carol williams', '1975-03-10', 'female', '3456789012'),
('dave brown', '1992-09-05', 'male', '4567890abc'),  -- số điện thoại không hợp lệ
('eve davis', '1980-12-30', 'female', '56789xyz'),    -- số điện thoại không hợp lệ
('eve', '1980-12-13', 'female', '56789');      -- số điện thoại không hợp lệ

#7
select * from patient_error_log;

#8
delimiter //
create procedure update_appointment_status(in appointment_id int, in new_status enum('scheduled', 'completed', 'cancelled'))
begin
    update appointments 
    set status = new_status 
    where appointment_id = appointment_id;
end 
// delimiter ;

#9
delimiter //
create trigger update_status_after_prescription_insert
after insert on prescriptions for each row
begin
    call update_appointment_status(new.appointment_id, 'completed');
end 
// delimiter ;

#10
insert into doctors (name, specialization, phone, salary) 
values ('dr. john smith', 'cardiology', '1234567890', 5000.00);
insert into doctors (name, specialization, phone, salary) 
values ('dr. alice brown', 'neurology', '0987654321', 6000.00);

insert into appointments (patient_id, doctor_id, appointment_date, status) 
values (1, 1, '2025-02-15 09:00:00', 'scheduled');
insert into appointments (patient_id, doctor_id, appointment_date, status) 
values (2, 2, '2025-02-16 10:00:00', 'scheduled');
insert into appointments (patient_id, doctor_id, appointment_date, status) 
values (3, 1, '2025-02-17 14:00:00', 'scheduled');

#11
select * from appointments;
insert into prescriptions (appointment_id, medicine_name, dosage, duration, notes) 
values (1, 'paracetamol', '500mg', '5 days', 'take one tablet every 6 hours');
select * from appointments;