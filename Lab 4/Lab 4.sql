-- Ben DelGiorno
-- Lab 4 - SQL Queries - The Sequel
-- CMPT308L


-- Q1-Get the cities of agents booking an order for customer �Basics�.
select city
from agents
where aid in (select aid
              from orders
              where cid in (select cid
                            from customers
                            where name = 'Basics')
              );


-- Q2-Get the	pids of products ordered through any agent who makes at least one order for a customer in Kyoto. (This is not the same as asking for pids of products ordered by a customer in Kyoto.)
select distinct pid
from orders
where aid in (select aid
              from agents 
              where cid in (select cid
                             from customers
                             where city = 'Kyoto')
               );
               

-- Q3-Find the cids and names of customers who never placed an order through agent a03.	
select cid, name
from customers
where cid not in (select cid 
                   from orders
                   where aid in (select aid
                                  from agents
                                  where name = 'Brown')
                   );
            
               
-- Q4-Get the	cids and names of customers	who ordered both product p01 and p07.	
select cid, name
from customers
where cid in (select distinct cid
               from orders
               where pid = 'p01' and cid in (select cid 
                                              from orders
                                              where pid = 'p07')
              );


-- Q5-Get the	pids of products ordered by any customers	who ever placed an order through agent a03.
select pid
from products
where pid in (select pid
              from orders
              where aid = 'a03');
            

-- Q6-Get the	names and discounts of all customers who place orders through agents in Dallas or Duluth.	
select name, discount
from customers
where cid in (select cid
              from orders
              where aid in (select aid
                            from agents
                            where city in ('Dallas', 'Duluth')
                            )
              );


-- Q7-Find all customers who have the same discount as that of any customers in Dallas or Kyoto.
select *
from customers
where discount in (select discount
                    from customers
                    where city in ('Dallas', 'Kyoto')
                   );
