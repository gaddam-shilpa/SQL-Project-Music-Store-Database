USE music_store;

select * from album;
select * from artist;
select * from customer;
select * from employee;
select * from genre;
select * from invoice;
select * from invoice_line;
select * from media_type;
select * from playlist;
select * from playlist_track;
select * from track;

/*	Question Set 1 - Easy */

/* Q1: Who is the senior most employee based on job title? */

SELECT title, first_name, last_name
FROM employee
ORDER BY levels DESC 
LIMIT 1;

/* Q2: Which countries have the most Invoices? */

-- Solution 1
WITH cte AS (
SELECT COUNT(invoice_id) AS num_of_invoices_per_country, billing_country
FROM invoice
GROUP BY billing_country
ORDER BY num_of_invoices_per_country DESC),

cte1 AS(
SELECT *, RANK() OVER(ORDER BY num_of_invoices_per_country DESC) AS rank1
FROM cte)

SELECT billing_country
FROM cte1
WHERE rank1 = 1;
-- Optimized code

-- Solution 2
WITH ranked_country AS(
SELECT COUNT(invoice_id), billing_country,
	RANK() OVER(ORDER BY COUNT(invoice_id) DESC) AS rank1
FROM invoice
GROUP BY billing_country)

SELECT billing_country
FROM ranked_country
WHERE rank1 = 1;


/* Q3: What are top 3 values of total invoice? */

SELECT DISTINCT total
FROM invoice
LIMIT 3;

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

SELECT billing_city, SUM(total) AS tot
FROM invoice
GROUP BY billing_city 
ORDER BY tot DESC
LIMIT 1;

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

-- Solution 1
SELECT DISTINCT c.customer_id, c.first_name, c.last_name, SUM(i.total) OVER(PARTITION BY c.customer_id) AS total_amnt_spent
FROM customer c
INNER JOIN invoice i
ON c.customer_id = i.customer_id
ORDER BY total_amnt_spent DESC ;

-- Solution 2
SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total_amnt_spent
FROM customer c
INNER JOIN invoice i
ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_amnt_spent DESC ;

/* Question Set 2 - Moderate */

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

-- Solution 1
SELECT DISTINCT c.email, c.first_name, c.last_name, g.name
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name LIKE 'Rock'
ORDER BY c.email;

-- Solution 2
SELECT DISTINCT email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;

/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT a.artist_id,a.name, COUNT(t.track_id) AS num_of_track
FROM artist a
JOIN album al ON a.artist_id = al.artist_id
JOIN track t ON t.album_id = al.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name LIKE 'Rock' 
GROUP BY a.artist_id, a.name
ORDER BY num_of_track DESC
LIMIT 10;

/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */


SELECT name, milliseconds
FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track)
ORDER BY milliseconds DESC;

/* Question Set 3 - Advance */

/* Q1: Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent */

SELECT c.first_name, c.last_name, a.name, SUM(il.unit_price*il.quantity) AS amnt_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN album al ON al.album_id = t.album_id
JOIN artist a ON a.artist_id = al.artist_id
GROUP BY c.first_name, c.last_name, a.name
ORDER BY amnt_spent DESC;


/* Q2: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres. */

WITH cte AS (
SELECT COUNT(il.quantity) AS purchases, c.country, g.genre_id, g.name,
		RANK() OVER(PARTITION BY country ORDER BY COUNT(il.quantity) DESC) AS rnk1
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN genre g ON g.genre_id = t.genre_id 
GROUP BY 2,3,4
ORDER BY 2 ASC, 1 DESC
)
SELECT purchases, country, name
FROM cte
WHERE rnk1 = 1;


/* Q3: Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */


WITH cte AS(
SELECT c.country, c.first_name, c.last_name, SUM(i.total) AS amt_spnt,
		rank() OVER(PARTITION BY c.country ORDER BY SUM(i.total) DESC) as positions
FROM Customer c
JOIN Invoice i ON c.customer_id = i.customer_id
GROUP BY c.country, c.first_name, c.last_name)

SELECT country, first_name, last_name, amt_spnt
FROM cte
WHERE positions = 1;











