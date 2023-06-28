select * from film;

select title  from film;

select title, release_year from film;

select distinct rating from film;

select amount * 95 from payment;

select return_date - rental_date from rental;

select title, release_year from film
where release_year >= 2000;

select first_name, last_name, active from staff
where active = true;

select first_name, last_name from staff
where active = true;

select first_name, last_name from staff
where active = true and not store_id = 1;

select title, rental_rate, replacement_cost from film
where rental_rate <= 0.99 and replacement_cost <= 9.99;

select title, length, rental_rate, replacement_cost from film
where rental_rate <= 0.99 and replacement_cost <= 9.99 or length < 50;

select title, description, rating from film
where rating in ('R', 'NC-17');

select title, description, rating from film
where rating not in ('G', 'PG');

select title, rental_rate from film
where rental_rate between 0.99 and 3;

select title, rental_rate from film
where rental_rate not between 0.99 and 3;

select title, description from film
where description like '%Scientist%';

select actor_id, first_name, last_name from actor
where last_name like '%gen%';

select actor_id, first_name, last_name from actor
where last_name like '%gen';

select title, rental_rate from film
order by rental_rate;

select title, rental_rate from film
order by rental_rate desc;

select title, length, rental_rate from film
order by length desc, rental_rate ASC;

select actor_id, first_name, last_name from actor
where last_name like '%li%'
order by last_name, first_name;

select title, length, rental_rate from film
order by length desc, rental_rate asc 
limit 5;

--
--

select max(rental_rate) from film;

select min(rental_rate) from film;

select max(rental_rate), min(rental_rate) from film;

select avg(rental_rate) from film;

select count(distinct first_name) from actor; 

select count(first_name) from actor; 

select count(*) from actor;

select sum(amount), avg(amount) from payment
where staff_id = 1;

select title, length from film
where length >= (select avg(length) from film);

select title, rental_rate from film
where rental_rate < (select max(rental_rate) from film)
order by rental_rate desc;

select last_name, count(*) from actor
group by last_name
order by count(*) desc; 

select rating, count(title) from film
group by rating
order by count(title) desc;

select staff_id, max(amount) from payment
group by staff_id 
order by max(amount) desc;

select staff_id, customer_id, avg(amount) from payment
group by staff_id, customer_id
order by avg(amount) desc;

select rating, avg(length) from film
where release_year = 2006
group by rating;

select last_name, count(*)  from actor
group by last_name
having count(*) > 1
order by count(*) desc;

select title, sum(rental_duration) from film
where title like '%Super%'
group by title 
having sum(rental_duration) > 5;

select title, sum(rental_duration) from film
group by title 
having sum(rental_duration) > 5 and where title like '%Super%';

--
-- join

select first_name, last_name, address from staff s
left join address a on s.address_id = a.address_id;

select s.last_name, count(amount) from payment p 
left join staff s on p.staff_id = s.staff_id 
group by s.last_name;

select title, count(actor_id) actor_q from film f 
join film_actor fa on f.film_id = fa.film_id
group by title
order by actor_q desc;

select first_name, last_name, address from staff s
left join address on s.address_id = address.address_id;

