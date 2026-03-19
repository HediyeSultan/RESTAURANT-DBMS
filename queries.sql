
-- 
-- Fetches comprehensive order data including customer names and billing details.
---
select orders.orderid, customer.cst_name, bill.billno, bill.order_price,bill.payment_type 
from orders
inner join customer on orders.customerid= customer.customerid
inner join bill on orders.orderid = bill.orderid;

--
--Lists orders with assigned waiters and formatted dates using TO_CHAR.
--
SELECT orders.orderID, orders.waiterID, bill.order_detail, TO_CHAR(orders.order_date, 'DD-MM-YY') AS "Date taken"
FROM Orders
JOIN Bill ON Orders.orderID = Bill.orderID;

--
--Finds the highest price paid via 'card' to analyze high-value digital transactions.
--
select max(order_price),payment_type 
from bill
where payment_type = 'card'
group by payment_type;

--
--Calculates the total quantity sold for each item to monitor stock demand.
--
select item_name, sum(quantity) as total_quantity
from item
group by item_name;


-- 
--  Filters menu items specifically for "Burger" variants using the LIKE operator.
--
select itemid, item_name, item_price
from item
where item_name like '%Burger%';

--
--Identifies all customers and their associated bills, including those without a bill. (left join)
--
SELECT Customer.cst_name, Bill.billNo, Bill.order_price
FROM Customer
LEFT JOIN Bill ON Customer.customerID = Bill.customerID;

--
-- Objective: Maps orders to all waiters to ensure even distribution of work shifts.(right join)
--
SELECT Orders.orderID, Waiter.waiterID, Waiter.shift
FROM Orders
RIGHT JOIN Waiter ON Orders.waiterID = Waiter.waiterID;

--
-- Displays a complete relationship map between customers and their orders. (full join)
----------------------------------------------------------
SELECT Customer.cst_name, Orders.orderID, Orders.no_of_items
FROM Customer
FULL OUTER JOIN Orders ON Customer.customerID = Orders.customerID;

--
--Lists menu items with a price higher than $10.00 for menu tier analysis.
--
select item_name, item_price
from item
where item_price>10.00;

--
-- Objective: Identifies staff members assigned to the night shift for scheduling purposes.
--
select waiterID,shift 
from waiter
where shift='night';

--
-- Analyzes customer orders while specifically excluding all dessert items.
--
select c.cst_name AS customer_name, o.orderid, b.order_price
from customer c
join orders o on c.customerid=o.customerid
join bill b on o.orderid = b.orderid 
where b.order_detail not like '%Waffles%'
and b.order_detail not like '%Tiramisu%'
and b.order_detail not like '%Profiterol%'
and b.order_detail not like '%Baklava%';

---
-- Objective: Identifies staff members sharing the same salary bracket for internal equity checks. (subquery)
--
select upper(staff_name) As staffs, salary 
from staff
where salary IN (select salary
                 from staff
                 group by salary
                 having count(staffId)>1 
                 );

--
-- Highlights the cheapest items per category with price truncation and formatting.
--
select itemNo, lower(item_name) as Cheapest_Options, 
to_char(item_price, '999$') as price, trunc(item_price) as turncate_price 
from item
where (itemNo, item_price) IN (select itemNo, min(item_price)
                  from item
                  group by itemNo);
