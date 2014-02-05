--Ben DelGiorno
--Lab 3 Getting Started with SQL Queries
--CMPT308L


-- Q1-List the name of agents named Smith.
select name, city
from agents
where name = 'Smith';


-- Q2-List pid, name, and quantity of products costing more than US$1.25.
select pid, name, quantity
from products
where priceUSD > 1.25;


-- Q3-List the ordno and aid of all orders.
select ordno, aid
from orders;


-- Q4-List the names and cities of customers in Dallas.
select name, city
from customers
where city = 'Dallas';


-- Q5-List the names of agents not in New York and not in Newark.
select name
from agents
where city != 'New York' 
  and city != 'Newark';


-- Q6-List all data for products not in New York or Newark that cost USD$1 or more.
select *
from products
where city != 'New York' 
  and city != 'Newark' 
  and priceUSD > 1;


-- Q7-List all data for orders in January or March.
select *
from orders
where mon = 'jan'
   or mon = 'mar';


-- Q8-List all data for orders in February less than USD$100.
select *
from orders
where mon = 'feb'
  and dollars < 100;


-- Q9-List all orders from the customer whose cid is c001.
select *
from orders
where cid = 'c001';