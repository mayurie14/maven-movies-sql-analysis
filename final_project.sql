/*1.My partner and i want to come by each of the stores in person and meet the managers.
please send over the manager's name at each store, with the full address of each property
(street address, district, city, and country please)*/
SELECT
	 staff.first_name as manager_first_name,
     staff.last_name as manager_last_name,
     address.address,
     address.district,
     city.city,
     country.country
FROM store
	left join staff on store.manager_staff_id = staff.staff_id
    left join address on store.address_id = address.address_id
    left join city on address.city_id = city.city_id
    left join country on city.country_id = country.country_id
    ;
    
    
/*2.I would like to get a better understanding of all of the inventory that would come along
with the business. please pull together a list of each inventory item you have shoked,
including the store_id number, the inventory_id, the name of the film, film's rating, its
rental rate and replacement cost.*/
SELECT
	inventory.store_id,
	inventory.inventory_id,
	film.title,
    film.rating,
    film.rental_rate,
    film.replacement_cost
FROM inventory
	left join film
    on inventory.film_id = film.film_id
    ;
    
    
/*3.From the same list of films you just pulled, please roll the data up and provide a 
summary level overview of your inventory. we would like to know how many items you have
with each rating at each store.*/
SELECT
	inventory.store_id,
	film.rating,
    count(inventory_id) as inventory_items
FROM inventory
	left join film
    on inventory.film_id = film.film_id
group by inventory.store_id,
	film.rating
    ;
    
    
/*4.Similarly, we want to understand how diversified the inventory is in terms of replcement
cost. we want to see how big of hit it would be if a certain category of film became unpopular
at a certain store. we would like to see the number of films, as well as the average replacement
cost, and total rplacement cost, sliced by store and film category.*/
SELECT
	store_id,
    category.name as category,
    count(inventory_id) as films,
    avg(film.replacement_cost) as average_replacement_cost,
    sum(film.replacement_cost) as_total_replacement_cost
FROM inventory
	left join film
		on inventory.film_id = film.film_id
	left join film_category
		on film.film_id = film_category.film_id
	left join category
		on category.category_id = film_category.category_id
GROUP BY
	store_id,
    category.name
order by 
	sum(film.replacement_cost) desc
;


/*5.We want to make sure you folks have a good handle on who your customers are. please provide a
list of all customer name, which store they go to, whether or not they are currently active, and
their full addresses-street address, city, and country.*/
SELECT
	customer.first_name,
    customer.last_name,
    customer.store_id,
    customer.active,
    address.address,
    city.city,
    country.country
FROM customer
	left join address on customer.address_id = address.address_id
    left join city on address.city_id = city.city_id
    left join country on city.country_id = country.country_id
    ;
    
    
/*6.We would like to understad how much your customer are spending with you, also to know who your
most valuable customer are. please pull together a list of customer names, their total lifetime
rentals, and the sum of all payments you have collected from them. it would be great to see this
ordered on total lifetime value, with the most valuable customers at top of list.*/
SELECT
	customer.first_name,
    customer.last_name,
    count(rental.rental_id) as total_rentals,
    sum(payment.amount)as total_payment_amount
FROM customer
	left join rental on customer.customer_id = rental.customer_id
    left join payment on rental.rental_id = payment.rental_id
GROUP BY
	customer.first_name,
    customer.last_name
ORDER BY
	sum(payment.amount) desc
    ;
    
    
/*7.My partner and i would like to get to know your board of advisors and any current investors.
could you please provide a list of advisor and investor names in one table? could you please note
whether they are an investor or an advisor, and for the investors, it would be good to incude
which company they work with.*/
SELECT
	'investor' as type,
    first_name,
    last_name,
    company_name
FROM investor
UNION
SELECT
	'advisor' as type,
    first_name,
    last_name,
    null	
FROM advisor;


/*8.We're interested in how well you have covered the most-awarded actors. of all the actors
with three types of awards, for what % of them do we carry a film? and how about for actors 
with two types of awards? same questions. finally, how about actors with just one award*/
SELECT  
  CASE   
    WHEN actor_award.awards = 'Emmy, Oscar, Tony' THEN '3 awards'   
    WHEN actor_award.awards IN ('Emmy, Oscar', 'Emmy, tony', 'Oscar, Tony') THEN '2 awards'   
    ELSE '1 award'   
  END AS number_of_awards,   

  AVG(CASE WHEN actor_award.actor_id IS NULL THEN 0 ELSE 1 END) AS pct_w_one_film

FROM actor_award

GROUP BY  
  CASE   
    WHEN actor_award.awards = 'Emmy, Oscar, Tony' THEN '3 awards'   
    WHEN actor_award.awards IN ('Emmy, Oscar', 'Emmy, tony', 'Oscar, Tony') THEN '2 awards'   
    ELSE '1 award'   
  END;
	
    
    
    