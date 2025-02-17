use ss12;

# 2
delimiter //
create procedure getdoctordetails(in input_doctor_id int)
begin
    select d.name , d.specialization, count(a.patient_id) as total_patients, coalesce(sum(pr.dosage * d.salary), 0) as total_revenue, count(pr.medicine_name) as total_medicines_prescribed from doctors d
    left join appointments a on d.doctor_id = a.doctor_id
    left join prescriptions pr on a.appointment_id = pr.appointment_id
    where d.doctor_id = input_doctor_id
    group by d.doctor_id, d.name;
end 
// delimiter ;

# 3
create table cancellation_logs (
    log_id int auto_increment primary key,
    appointment_id int not null,
    log_message varchar(255) not null,
    log_date datetime not null,
    foreign key (appointment_id) references appointments(appointment_id)
);

# 4
create table appointment_logs (
    log_id int auto_increment primary key,
    appointment_id int not null,
    log_message varchar(255) not null,
    log_date datetime not null,
    foreign key (appointment_id) references appointments(appointment_id)
);

# 5
delimiter //
create trigger after_delete_appointment
after delete on appointments for each row
begin
    delete from prescriptions where appointment_id = old.appointment_id;
    if old.status = 'cancelled' then
        insert into cancellation_logs (appointment_id, log_message, log_date)
        values (old.appointment_id, 'cancelled appointment was deleted', now());
    end if;
    if old.status = 'completed' then
        insert into appointment_logs (appointment_id, log_message, log_date)
        values (old.appointment_id, 'completed appointment was deleted', now());
    end if;
end
// delimiter ;

# 6
create view fullrevenuereport as
select d.doctor_id, d.name, count(a.appointment_id) as total_appointments, count(distinct a.patient_id) as total_patients, sum(p.medicine_name is not null) as total_medicines, coalesce(sum(pr.dosage * d.salary), 0) as total_revenue from doctors d
left join appointments a on d.doctor_id = a.doctor_id
left join prescriptions pr on a.appointment_id = pr.appointment_id
group by d.doctor_id, d.name;

# 7
call getdoctordetails(2);

# 8
delete from appointments where appointment_id = 3;
delete from appointments where appointment_id = 2;

# 9
select * from fullrevenuereport;