#2 
select concat(p.fullname, ' (', year(a.appointmentdate) - year(p.dob), ') - ', d.fullname) as patient_doctor_info,a.appointmentdate, m.diagnosis from appointments as a
join patients as p on a.patientID = p.patientID
join doctors as d on a.doctorID = d.doctorID
left join medicalrecords as m on a.patientID = m.patientID and a.doctorID = m.doctorID
order by a.appointmentdate asc;

#3
select p.fullname as patientname, year(a.appointmentdate) - year(p.dob) as ageatappointment, a.appointmentdate,
case 
	when (year(a.appointmentdate) - year(p.dob)) > 50 then 'nguy cơ cao'
	when (year(a.appointmentdate) - year(p.dob)) between 30 and 50 then 'nguy cơ trung bình'
	else 'nguy cơ thấp'
end as risklevel
from appointments as a
join patients as p on a.patientID = p.patientID
order by a.appointmentdate asc;

#4
delete a from appointments as a
join patients as p on a.patientID = p.patientID
join doctors as d on a.doctorID = d.doctorID
where (year(a.appointmentdate) - year(p.dob)) > 30 and d.specialization in ('noi tong quat', 'chan thuong chinh hinh');

select p.fullname as patientname,d.specialization as specialization, year(a.appointmentdate) - year(p.dob) as ageatappointment from appointments a
join patients p on a.patientID = p.patientID
join doctors d on a.doctorID = d.doctorID
order by ageatappointment asc;
