-- Lab 6 - Really Interesting Queries
-- Ben DelGiorno
-- CMPT308L


-- Q1-Get the name and city of customers who live in a city where the most number of products are made.	
select c.name, c.city
from customers c
where c.city in (select p.city
                  from products p
                  group by p.city
                  order by count(*) desc
                  limit 1
                  );



-- Q2-Get the name and city of customers who live in any city where the	most number of products are made.	
select c.name, c.city
from customers c
where c.city in (select p1.city
                  from products p1
                  group by p1.city
                  having count(*) = (select count(*)
                                      from products p2
                                      group by p2.city
                                      order by count(*) desc
                                      limit 1
                                      )
                  );


-- Q3-List the products whose priceUSD is above the average priceUSD.	
select name, avg(priceUSD)
from products
group by name, priceUSD
having priceUSD > (select avg(priceUSD)
                    from products);
                    
                    
-- Q4-Show the customer name, pid ordered, and the dollars for all customer orders, sorted by dollars from high to low.	
select c.name, o.pid, o.dollars
from customers c inner join orders o on c.cid = o.cid
order by o.pid asc,
          o.dollars desc;


-- Q5-Show all customer names (in order) and their total ordered, and nothing more. Use coalesce to avoid showing NULLs.	
select c.name, c.city, coalesce(sum(o.qty), 0) as "Total Ordered"
from customers c left outer join orders o on c.cid = o.cid
group by c.name, c.city
order by c.name asc;

-- Q6-Show the names of all customers who bought products from agents based in New
-- York along with the names of the products they ordered, and the names of the agents	
-- who sold it to them.	
select c.name, p.name, a.name
from orders o inner join customers c on o.cid = c.cid
               inner join products p on o.pid = p.pid
               inner join agents a on o.aid = a.aid
where a.city = 'New York';


-- Q7-Write a query to check the accuracy of the dollars column in the Orders table. This	
-- means calculating Orders.dollars from other data in other tables and then comparing	
-- those values to the values in Orders.dollars
select (o.qty * p.priceUSD) * (1 - (c.discount/100)) as "Accurate Calculated Total", o.dollars
from orders o,
     products p,
     customers c
where o.pid = p.pid
  and c.cid = o.cid
