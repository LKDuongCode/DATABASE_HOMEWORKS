use sakila;

#2
create view view_long_action_movies as
select * from film_category fc
join film f on f.film_id = fc.film_id
join category c on c.category_id = fc.category_id
where c.name = 'Action' and f.length > 100;

#3
create view view_texas_customers as
select c.customer_id, count(r.rental_id) as count_rental from customer c
join rental r on r.customer_id = c.customer_id
join address a on a.address_id = c.address_id
where a.district = 'Texas'
group by r.customer_id
having count(r.rental_id) > 0;


#4
create view view_high_value_staff as
select sum(p.amount) as total_pay, s.username from staff s
join payment p on p.staff_id = s.staff_id
group by s.username
having  sum(p.amount) > 100;

#5
create fulltext index idx_film_title_description on film (title, description);

#6
create index idx_rental_inventory_id on  rental (inventory_id) using hash;

#7
select * from view_long_action_movies where match (title, description) against ( 'War' in natural language mode);

#8
delimiter //
create procedure GetRentalByInventory (in in_inventory_id int)
begin
	select * from rental where inventory_id = in_inventory_id;
end
// delimiter ;
call GetRentalByInventory (1);

#9
drop view if exists view_long_action_movies;
drop view if exists view_high_value_staff;
drop index  idx_film_title_description on film;
drop index  idx_rental_inventory_id on rental;
drop procedure GetRentalByInventory;