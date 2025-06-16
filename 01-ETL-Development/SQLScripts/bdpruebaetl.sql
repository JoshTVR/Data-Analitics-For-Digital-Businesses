
create database bdpruebaetl;
use bdpruebaetl

select top 0
p.ProductID,
p.ProductName,
c.CategoryID,
p.UnitPrice,
p.UnitsInStock,
(p.UnitPrice * p.UnitsInStock) as Importe
into tblprueba
from Northwind.dbo.Products as p
inner join
Northwind.dbo.Categories as c
on p.CategoryID = c.CategoryID;

select * from tblprueba;

Truncate table tblprueba;