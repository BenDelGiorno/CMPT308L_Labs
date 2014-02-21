-- Ben DelGiorno
-- Lab 5: SQL Queries - The Three-quel
-- CMPT308L


-- Q1-Get the cities of agents booking an	order	for customer Basics. This time use joins, No subqueries.
select a.city
from agents a, 
      orders o,
      customers c
where a.aid = o.aid
  and o.cid = c.cid
  and c.name = 'Basics'
group by a.city;

-- Q2-Get the pids of products ordered through any agent who makes at least one order for	a customer in Kyoto. Use joins this	time;	no subqueries.	
select pid
from orders o,
      agents a,
      customers c
where o.aid = a.aid
  and o.cid = c.cid
  and c.city = 'Kyoto'
group by pid;
  

-- Q3-Get the names of customers who have never placed an order. Use a subquery.	
select name
from customers c
where c.cid not in (select o.cid
                      from orders o 
                     );


-- Q4-Get the names of customers who have	never	placed an order. Use an	outer	join.	
select c.name
from customers c left outer join orders o on c.cid = o.cid
where o.cid is null;


-- Q5-Get the names of customers who placed at	least	one order through	an agent in	their	city,	along	with	those	agent(s) names.	
select c.name, a.name
from customers c, agents a, orders o
where c.city = a.city
  and  c.cid = o.cid
  and  a.aid = o.aid
group by c.name, a.name;


-- Q6-Get the names of customers and agents in the same city, along with the name of the city,	regardless of whether or not the customer	has ever placed an order with	that agent.	
select c.name, a.name
from customers c, agents a
where c.city = a.city;


-- Q7-Get the name and city of customers who live in	the city where the least number of products are	made.
select c.name, c.city
from customers c
where c.city in (select p.city
                  from products p
                  group by p.city
                  order by count(*) asc
                  limit 1
                );
