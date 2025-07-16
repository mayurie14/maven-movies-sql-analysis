/* 
1. we need a list of all staff members, including their first and last names,
 email addresses,and the store identification number where they work.
 */
 select
    first_name,
    last_name,
    email,
    store_id
from staff;


/*
2.we will need seperate counts of inventory items held at each of your two states
*/
select
	store_id,
	count(inventory_id) as inventory_items
from inventory
	group by
store_id;


/*
3.we will need a counts of active customers for each of your stores. sepetately.
*/
select
	store_id,
   count(customer_id) as active_customers
from customer
where active = 1
	group by
store_id;
	
    
/*
4.in order to asses the liability of a data breach, we will need you to provide 
a count of all customer email addresses stored in database.
*/
select
	count(email) as email_address
from customer;


/*
5.We are interested in how diverse your film offering is as a means of understanding
 how likely you are to keep customers engaged in the future. please provide a count
 of unique film titles you have in inventory at each store and then provide a count
 of unique categories of films you provide.
*/
select
	store_id,
    count(distinct film_id) as unique_film
from inventory
	group by store_id;
    
select 
	count(distinct name) as unique_categories
from category;
	
    
/*
6.we would like to understand the replacement cost of your films. please provide
the replacement cost for the film that is least expensive to replace, the most
expensive to replace, and the average of all films you carry.
*/
select
	min(replacement_cost) as least_expensive,
	max(replacement_cost) as most_expensive,
	avg(replacement_cost) as average_replacement_cost
from film;
    
    
/*
7.we are interested in having you put payment monitoring systems and maximum 
payment processing restrictions in place in order to minimize the future risk
of fraud by your staff. please provide the average payment you process, as
well as the maximum payment you have processed.
*/
select
	max(amount) as maximum_payment,
    avg(amount) as average_payment
from payment;


/*
we would like to better understand what your customer base looks like. please
provide a list of all customer identification values, with a count of rentals they
have made all-time, with your highest volume customers at top of the list.
*/
select
	customer_id,
    count(rental_id) as number_of_rental
from rental
	group by customer_id
order by count(rental_id) desc;

	