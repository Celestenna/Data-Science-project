--- data analysis
---
-- Select customer name together with each order the customer made
select c.CustomerName, o.*
from customers as c
join orders as o on c.CustomerID = o.CustomerID
order by OrderID asc;

-- data preprocessing/feature engineering/add new coloumn--
-- add a year column into order table
select orderdate, year(orderdate) as "Year"
from orders;

alter table orders
add column Year int not null;

update orders
set `Year` = year(orderdate);

alter table orders
add column Month_name varchar (20) not null;
drop month_name;


alter table orders
modify Month_name varchar(20) not null;

update orders
set `Month_name` = monthname(orderdate);


-- add day/dayname
alter table orders
add column Day int not null;

update orders
set `Day` = day(orderdate);

alter table orders
add column Day_name varchar(25) not null;

update orders
set `Day_name` = dayname(orderdate);

select*
from orders;

-- Select order id together with name of employee who handled the order.
select o.orderID, concat_ws(" ", e.FirstName, e.LastName) as "Employee Name"
from orders as o
join Employees as e on o.EmployeeID = e.EmployeeID;

-- Select customers who did not placed any order yet.
select c.CustomerName
from customers as c
left join orders as o on c.customerID= o.customerID
where o.OrderID is null;

-- Select order id together with the name of products
select o.orderID, p.ProductName
from order_details as o
join products as p on o.ProductID = p.ProductID
order by o.orderID asc;

-- Select products that no one bought
select p.ProductName, od.*
from products as p
left join order_details as od using (productID)
where od.OrderID is null; -- all products being bought

-- Select customer together with the products that h
select customerName, productName
from products as p
join order_details as od using (ProductID)
join orders as o using (orderID)
join customers as c using (customerID);

-- Select product names together with the name of corresponding category.

select ProductName, categoryName
from products as p
join categories as c using (categoryID);

-- Select orders together with the name of the shipping company
select ShipperName, OrderID
from orders as o
join shippers as s using (shipperID);


-- Select customers with id greater than 50 together with each order they made.

select c.CustomerID, OrderID
from customers as c
join orders as o using (customerID)
where c.CustomerID >50;

-- Select employees together with orders with order id greater than 10400

select concat(e.LastName, " ", e.FirstName) as "Employee Name"
from employees as e
join orders as o using (employeeID)
where o.orderID >10400; 
use amazing_store;

-- Select the most expensive product.
select *
from products
where price>100;

-- Select name and price of each product, sort the result by price in decreasing order
select productName, price
from products
order by price desc;

-- Select name of the cheapest product (only name) without using LIMIT and OFFSET
select productName
from products
where price = 2.5;

---
select country, count(*)
from customers
group by country
order by count(*)desc;
-- Select number of employees with LastName that starts with 'D'
select Lastname
from employees
where LastName like "%D%";
use amazing_store;

-- Select customer name together with the number of orders made by the corresponding
-- customer, sort the result by number of orders in decreasing order

select c.customerName, count(orderID)
from customers as c
join orders as o using (customerID)
group by o.customerID
order By count(orderID) desc;

-- 20 Add up the price of all products
select sum(price)
from products;
-- 21 . Select orderID together with the total price of that Order, order the result by total
-- price of order in increasing order.
select orderID, sum(price) as "total price"
from orders as o
join order_details as od using (orderID)
join products as p using (productID)
group by orderID
order by "total price" asc;
-- 22 Select customer who spend the most money
select customerName,sum(p.price), sum(od.quantity), sum(p.price * od.quantity) as "Total amount"
from customers as c
join orders as o using (customerID)
join order_details as od using (orderID)
join products as p using (productId)
group by orderID
order by sum(p.price * od.quantity)desc;



-- 25  Select shipper together with the total price of proceed orders
select ShipperName, sum(price) as "total price"
from  shippers as s
join orders as o using(shipperID)
join order_details as od using (orderID)
join products as p using (productID)
group by shipperID
order by "total price";

-- section B
-- 1 Total number of products 
select count(productID)
from products;

-- 1b Total Quantity Sold So far
select sum(Quantity) as "Tota Qty"
from order_details;

-- 2. Total Revenue So far.
select round(sum(p.Price * od.Quantity), 2) as "Total Revenue"
from products as p
inner join order_details as od using(productID);

-- 3. Total Products sold based on category.
select c.CategoryName, count(distinct ProductName) as "Total Products"
from products as p 
inner join categories as c using(categoryID)
group by CategoryID;

-- 4. Total Number of Purchase Transactions from customers.
select count(orderID) as "Total Orders"
from orders;

-- 5. Compare Orders made between 2022 – 2023
select year, count(orderId) as "Total orders"
from orders
group by year;

-- 6. What is total number of customers? Compare those that have made 
-- transaction and those that haven’t at all.

-- add a new to customer to store their order status
select count(CustomerID)
from customers
left join orders as o using(customerid);


alter table customers
add column status int;

select 
	 case
		when OrderID is null then 0
		else 1
     end as status
from customers
left join orders as o using(customerid);


-- 7. Who are the Top 5 customers with the highest purchase value?
select c.customerName, round(sum(p.price * od.quantity),2) as "Total Purchase"
from customers as c
inner join orders as o using(customerID)
inner join order_details as od using(orderid)
inner join products as p using(productid)
group by c.CustomerID
order by sum(p.price * od.quantity) desc
limit 5;

-- 8. Top 5 best-selling products.
select p.ProductName, round(sum(p.price * od.quantity),2) as "Total Purchase"
from order_details as od
inner join products as p using(productid)
group by p.ProductId
order by sum(p.price * od.quantity) desc
limit 5;

-- 9. What is the Transaction value per month?
select o.month_name, round(sum(p.price * od.quantity),2) as "Total Purchase"
from orders as o
inner join order_details as od using(orderid)
inner join products as p using(productid)
group by o.month_name
order by o.month;

-- 10. Best Selling Product Category?
select c.categoryName, round(sum(p.price * od.quantity),2) as "Total Purchase"
from categories as c
inner join products as p using(categoryid)
inner join order_details as od using(productid)
order by sum(p.price * od.quantity) desc;

-- 11. Buyers who have Transacted more than two times.
select c.customerName, count(o.orderid) as "No of Orders"
from customers as c
inner join orders as o using(customerid)
group by c.customerid
having count(o.orderid) > 2
order by count(o.orderid)
limit 5;

-- 12. Most Successful Employee.
select concat(e.lastname," ", e.firstname) as "Full Name", 
       round(sum(p.price * od.quantity),2) as "Total Purchase"
from employees as e
inner join orders as o using(employeeid)
inner join order_details as od using(orderid)
inner join products as p using(productid)
group by e.EmployeeID
order by round(sum(p.price * od.quantity),2)
limit 5;

-- 13. Most use Shipper.
select s.shipperName, count(o.orderid) as "Number of Orders"
from shippers as s
inner join orders as o using(shipperid)
group by s.ShipperID
order by count(o.orderid);

-- 14. Most use Supplier
select s.SupplierName, count(od.OrderID) as "Total Orders"
from suppliers as s
inner join products as p using(supplierid)
inner join order_details as od using(productid)
group by s.SupplierID
order by count(od.OrderID) desc
limit 5;

