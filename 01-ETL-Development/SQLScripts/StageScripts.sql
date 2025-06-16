use stage_northwind

select CustomerID, 
CompanyName, 
isnull(city, 'SC') as City, 
isnull(region,'SR') as region, 
PostalCode, 
Country
from Northwind.dbo.Customers;


select * from stage_northwind.dbo.clientes


Select c.CustomerID, e.EmployeeID, p.ProductID, o.OrderDate, 
(od.Quantity * od.UnitPrice) as Monto, od.Quantity, od.UnitPrice, od.Discount
from Northwind.dbo.Customers as C
Inner join Northwind.dbo.Orders as O
On c.CustomerID = o.CustomerID
inner join Northwind.dbo.Employees as e
on e.EmployeeID = o.EmployeeID
inner join Northwind.dbo.[Order Details] as od
on o.OrderID = od.OrderID
inner join Northwind.dbo.Products as p
on od.ProductID = p.ProductID;


select * from stage_northwind.dbo.ventas

select ProductID, 
ProductName, 
UnitPrice, 
CategoryID 
from 
Northwind.dbo.Products;

select * from stage_northwind.dbo.producto



SELECT SupplierID, 
CompanyName, 
City, 
isnull(Region, 'SR') as region, 
Country
from Northwind.dbo.Suppliers;

select * from stage_northwind.dbo.proveedor


SELECT Distinct(OrderDate),
        YEAR(OrderDate) AS Anio,
        DATEPART(QUARTER,OrderDate) as Trimestre,
        DATEPART(MONTH,OrderDate) as Mes,
        DATEPART(WEEK,OrderDate) as Semana,
        DATEPART(DAYOFYEAR,OrderDate) as DiaDeAnio,
        DATEPART(DAY,OrderDate) as DiaDeMes,
        DATEPART(WEEKDAY,OrderDate-1) as DiaDeSemana
        FROM Northwind.DBO.Orders; 
go




select * from stage_northwind.dbo.Stage_Tiempo;
select * from stage_northwind.dbo.categorias;
select * from stage_northwind.dbo.clientes;
select * from stage_northwind.dbo.empleado;
select * from stage_northwind.dbo.producto;
select * from stage_northwind.dbo.proveedor;
select * from stage_northwind.dbo.ventas;




truncate table [dbo].[proveedor];





