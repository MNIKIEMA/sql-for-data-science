select * from film;

select distinct rental_rate from film
;

select rating, count(rating) from film
group by rating
;

select * from rental;

select rental_date, count(rental_date) as Total_rentals
from rental
group by rental_date
order by Total_rentals desc
;

select extract(YEAR from rental_date),
extract(MONTH from rental_date), count(rental_id) as Total_rentals
from rental
group by 1, 2
;

select extract(YEAR from rental_date),
extract(MONTH from rental_date), count(rental_id) as Total_rentals,
count(distinct customer_id) as unique_rental,
1.0 * count(rental_id)/count(distinct customer_id) as average
from rental
group by 1, 2
;

select email from customer
where first_name ='Gloria' and last_name = 'Cook'
;

select customer_id, rental_id, return_date
from rental
where customer_id in (1, 2)
order by return_date desc
;

SELECT first_name, last_name
FROM customer
WHERE first_name LIKE 'Rob%';

SELECT * from payment;

SELECT staff_id, COUNT(amount), SUM(amount)
FROM payment
GROUP BY staff_id
;

SELECT rating, ROUND(AVG(replacement_cost), 3)
FROM film
GROUP BY rating;

SELECT customer_id, SUM(amount)
from payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5
;

SELECT customer_id, COUNT(amount) 
from payment
GROUP BY customer_id
HAVING COUNT(customer_id) > 30
;

SELECT title, language_id, category_id
FROM film_category
INNER JOIN film ON film.film_id = film_category.category_id
;

SELECT film.title, category.name, language.name
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
JOIN language ON film.language_id = language.language_id
;

SELECT film.title, COUNT(rental.rental_id), SUM(payment.amount), SUM(payment.amount) as revenue
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY film.film_id
ORDER BY revenue DESC
LIMIT 10
;

SELECT film.title, COUNT(rental.rental_id), COUNT(rental.rental_id)*rental_rate as revenue
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY title, rental_rate
ORDER BY revenue DESC
LIMIT 10
;

SELECT store.store_id, COUNT(amount)
FROM payment
JOIN staff ON payment.staff_id = staff.staff_id
JOIN store ON staff.store_id = store.store_id
GROUP BY store.store_id
;

SELECT category.name, COUNT(film.film_id)
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
HAVING name IN ('Action', 'Comedy', 'Animation')
;

SELECT category.name, COUNT(rental.rental_id)
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
JOIN inventory ON inventory.film_id = film.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
GROUP BY category.name
HAVING name IN ('Action', 'Comedy', 'Animation')
;

SELECT customer.email, COUNT(rental.rental_id)
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.email
HAVING COUNT(rental.rental_id) >= 40
;