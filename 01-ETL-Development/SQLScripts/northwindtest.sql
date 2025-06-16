use Northwind

select
p.ProductID,
p.ProductName,
c.CategoryID,
p.UnitPrice,
p.UnitsInStock
from 
Products as p
inner join
Categories as c
on p.CategoryID = c.CategoryID;