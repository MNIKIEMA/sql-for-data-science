# Final projet with the dvdrental table

- US film's rating in the db

```sql
select distinct rating from film
;
```
- Rental rates in the db

```sql
select distinct rental_rate from film
;
```

- Count different rating and rating

```sql
select rating, count(rating) from film
group by rating
;
```



- Number of rental_date

```sql
select rental_date, count(rental_date) as Total_rentals
from rental
group by rental_date
order by Total_rentals desc
;
```

- `EXTRACT` usage : `EXTRACT()`

It can be use to extract year month etc
1, 2 tells sql that we are grouping by the first and the second after select

```sql
select extract(YEAR from rental_date),
extract(MONTH from rental_date), count(rental_id) as Total_rentals
from rental
group by 1, 2
;
```
To get more info:

```sql
select extract(YEAR from rental_date),
extract(MONTH from rental_date), count(rental_id) as Total_rentals,
count(distinct customer_id) as unique_rental,
1.0 * count(rental_id)/count(distinct customer_id) as average
from rental
group by 1, 2
;
```
- Where

```sql
select email from customer
where first_name ='Gloria' and last_name = 'Cook'
```

- `LIKE`
Select customer where the name contains `Rob`

```sql
select * from customer
where first_name like '%Rob%'
;
```

- `GROUP BY`
Select the amount of rentals per staff_id

```sql
SELECT staff_id, COUNT(amount), SUM(amount)
FROM payment
GROUP BY staff_id
;
```
Mean of remplacement by the rating

```sql
SELECT rating, AVG(replacement_cost)
FROM film
GROUP BY rating
;
```

The top five customer who rented the most

```sql
SELECT customer_id, SUM(amount)
from payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5
;
```

- `HAVING`
Make condition on virtual variable

Selecting client with more than 30 transaction

```sql
SELECT customer_id, COUNT(amount) 
from payment
GROUP BY customer_id
HAVING COUNT(customer_id) > 30
;
```
- Selecting the film with its category and language

```sql
SELECT film.title, category.name, language.name
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
JOIN language ON film.language_id = language.language_id
;
```
- display movie, number of rental and revenu

```sql
SELECT film.title, COUNT(rental.rental_id), COUNT(rental.rental_id)*rental_rate as revenue
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY title, rental_rate
ORDER BY revenue DESC
LIMIT 10
;
```

- stores that sells most

```sql
SELECT store.store_id, SUM(amount)
FROM payment
JOIN staff ON payment.staff_id = staff.staff_id
JOIN store ON staff.store_id = store.store_id
GROUP BY store.store_id
;
```

- display the number of film per category : Action, Comedy, Animation

```sql
SELECT category.name, COUNT(rental.rental_id)
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
JOIN inventory ON inventory.film_id = film.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
GROUP BY category.name
HAVING name IN ('Action', 'Comedy', 'Animation')
;
```

- email of customers that rent more than 40 films

```sql
SELECT customer.email, COUNT(rental.rental_id)
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.email
HAVING COUNT(rental.rental_id) >= 40
;
```