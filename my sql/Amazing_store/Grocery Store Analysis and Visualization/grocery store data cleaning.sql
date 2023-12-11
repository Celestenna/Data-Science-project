use amazing_store;
-- display all in categories
select*
from categories;
set sql_safe_updates=false;

-- check datatype
desc categories;

-- check customers
select *
from customers;

-- replace 'Ã¶' with 'o'
select CustomerName ,
case
when CustomerName like "%Ã¶%" then replace (CustomerName,'Ã¶','o')
else CustomerName
end as "clean name"
from customers;

update customers
set CustomerName = (select
case
when CustomerName like "%Ã¶%" then replace(CustomerName,'Ã¶','o')
when CustomerName like "%Ã-%" then replace(CustomerName,'Ã-','i')
else CustomerName
end);


