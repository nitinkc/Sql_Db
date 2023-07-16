-- My SQL query
SELECT c.customer_id, o.order_id, CONCAT(c.first_name, " ",c.last_name ," From ",c.city ) as nameCity 
FROM customers c left join orders o 
ON c.customer_id = o.customer_id
WHERE c.customer_id = 12345;


SELECT c.customer_id, o.order_id, CONCAT(c.first_name, " ",c.last_name ," From ",c.city ) as nameCity 
FROM orders o left join customers c 
ON c.customer_id = o.customer_id;
--------------------------------

-- Check Why the execution plan of both the queries are same

select et.sporting_event_id, et.sport_location_id, tph.purchased_by_id 
from ticket_purchase_hist tph join sporting_event_ticket et 
on tph.sporting_event_ticket_id  = et.id ;

select et.sporting_event_id, et.sport_location_id, tph.purchased_by_id 
from ticket_purchase_hist tph join sporting_event_ticket et 
on et.id  = tph.sporting_event_ticket_id;

--------------------------------
-- Performance

select count(*) from sporting_event_ticket;--2.771s

select count(1) from sporting_event_ticket;
