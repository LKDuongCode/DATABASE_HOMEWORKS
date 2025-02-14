use sakila;

#3
create view view_film_category as
select f.film_id, f.title , c.name as category_name  from film_category fc
join film f on fc.film_id = f.film_id
join category c on c.category_id = fc.category_id;

#4
create view view_high_value_customers as
select c.Customer_Id, c.First_Name, c.Last_Name, sum(p.amount) as total_payment from customer c
join payment p on c.customer_id = p.customer_id
group by  c.Customer_Id, c.First_Name, c.Last_Name;

#5
create index idx_rental_rental_date on rental(rental_date);
explain analyze select * from rental where rental_date = '2005-06-14';

#6
delimiter //
create procedure CountCustomerRentals (in in_customerid int, out rental_count int)
begin
	select count(r.rental_id) as total into rental_count from customer c
    join rental r on r.customer_id = c.customer_id
    where c.customer_id = in_customerid
    group by c.customer_id;
end
// delimiter ;

set @rental_count = 0;
call CountCustomerRentals (1,@rental_count);
select @rental_count;

#7
delimiter //
create procedure GetCustomerEmail (in in_customerid int)
begin
	select email from customer where customer_id = in_customerid;
end
// delimiter ;
call GetCustomerEmail (1);

#8
drop view if exists view_film_category;
drop view if exists view_high_value_customers;
drop procedure if exists CountCustomerRentals;
drop procedure if exists GetCustomerEmail;
