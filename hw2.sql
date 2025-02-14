use ss11;
#2
create index idx_phone on customers(phonenumber);
explain analyze select * from customers where phonenumber = '0901234567';

#3
create index idx_employee_salary on employees(employeeid,salary);
explain analyze select * from employees where branchid = 1 and salary > 20000000;

#4
create unique index idx_customer_account on accounts(customerid,acountid);

#5
show index from customers;
show index from employees;
show index from accounts;

#6
drop index idx_phone on customers;
drop index idx_employee_salary on employees;
drop index idx_customer_account on accounts;