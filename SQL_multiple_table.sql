use sakila;

-- 1. Write a query to display for each store its store ID, city, and country.
SELECT st.store_id, a.city, a.country
FROM store st
JOIN address a ON st.address_id = a.address_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT st.store_id, SUM(p.amount) AS total_business
FROM store st
JOIN staff s ON st.store_id = s.store_id
JOIN payment p ON s.staff_id = p.staff_id
GROUP BY st.store_id;

-- 3. What is the average running time of films by category?
SELECT c.name AS category, AVG(f.length) AS average_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- 4. Which film categories are longest?
SELECT c.name AS category, MAX(f.length) AS max_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY max_running_time DESC;

-- 5. Display the most frequently rented movies in descending order.
SELECT f.title AS film_title, COUNT(*) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC;

-- 6. List the top five genres in gross revenue in descending order.
SELECT c.name AS genre, SUM(p.amount) AS gross_revenue
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title AS film_title, COUNT(*) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1
GROUP BY f.title;