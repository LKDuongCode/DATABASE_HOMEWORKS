#2
delete from appointments 
where AppointmentDate < curdate()
and DoctorID = (select DoctorID from doctors where FullName = 'Phan Huong');

select a.AppointmentID,p.FullName as PatientName,d.FullName as DoctorName,a.AppointmentDate,a.Status
from appointments as a
join patients as p on a.PatientID = p.PatientID
join doctors as d on a.DoctorID = d.DoctorID
order by a.AppointmentDate;

#3
update appointments as a
join patients as p on a.PatientID = p.PatientID
join doctors as d on a.DoctorID = d.DoctorID
set a.Status = 'Dang cho'
where a.AppointmentDate >= curdate()
and p.FullName = 'Nguyen Van An'
and d.FullName = 'Phan Huong';

select a.AppointmentID,p.FullName as PatientName,d.FullName as DoctorName,a.AppointmentDate,a.Status from appointments a
join patients as p on a.PatientID = p.PatientID
join doctors as d on a.DoctorID = d.DoctorID
order by a.AppointmentDate;

#4
select p.FullName as PatientName,d.FullName as DoctorName,a.AppointmentDate,m.Diagnosis from appointments as a
join patients as p on a.PatientID = p.PatientID
join doctors as d on a.DoctorID = d.DoctorID
left join medicalrecords m on a.PatientID = m.PatientID and a.DoctorID = m.DoctorID
where (a.PatientID, a.DoctorID)
in(
    select PatientID, DoctorID
    from appointments
    group by PatientID, DoctorID
    having count(AppointmentID) >= 2)
order by p.FullName, d.FullName, a.AppointmentDate;

#5
select concat('BỆNH NHÂN: ', p.FullName, ' - BÁC SĨ: ', d.FullName) as Info,a.AppointmentDate,coalesce(m.Diagnosis, 'Chưa có chẩn đoán') as Diagnosis,a.Status from appointments as a
join patients as p on a.PatientID = p.PatientID
join doctors as d on a.DoctorID = d.DoctorID
left join medicalrecords m on a.PatientID = m.PatientID and a.DoctorID = m.DoctorID
order by a.AppointmentDate asc;


#6
select  concat('BỆNH NHÂN: ', p.PatientName, ' - BÁC SĨ: ', d.DoctorName) as Info, a.AppointmentDate, year(a.AppointmentDate) as AppointmentYear,
case 
    when a.AppointmentDate >= curdate() then 'Tương lai' 
    else 'Đã qua' 
end as AppointmentStatus from Appointments a
join Patients p on a.PatientID = p.PatientID
join Doctors d on a.DoctorID = d.DoctorID
order by a.AppointmentDate asc;


