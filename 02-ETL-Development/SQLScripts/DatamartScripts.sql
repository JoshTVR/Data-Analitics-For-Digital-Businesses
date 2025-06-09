

select * from datamart_nortwind.dbo.dim_cliente

select * from stage_northwind.dbo.clientes

UPDATE Clientes
SET Pais = 'Mexico'
WHERE clienteid = 'ALFKD';

SELECT se.empleadoid, 
CONCAT(se.nombre,' ',se.apellido) as 'NombreCompleto'
FROM 
stage_northwind.dbo.empleado as se;


select * from datamart_nortwind.dbo.dim_empleado
select * from stage_northwind.dbo.producto

Select 
sp.producto_id,
sp.nombre_producto, 
sc.nombrecategoria 
from stage_northwind.dbo.categorias as sc
inner join stage_northwind.dbo.producto as sp
on sp.categoria_id = sc.categoriaid

select * from datamart_nortwind.dbo.dim_producto;


select Tiempo_FechaActual, Tiempo_Anio, Tiempo_Trimestre, Tiempo_Mes, Tiempo_Semana, Tiempo_DiaDeAnio, Tiempo_DiaDeMes, Tiempo_DiaDeSemana
from stage_northwind.dbo.Stage_Tiempo;

select * from datamart_nortwind.dbo.dim_tiempo


select dc.cliente_skey, de.empleado_SKey, dp.producto_SKey, dt.tiempo_SKey,  (1) AS norden,
sv.ventas_orden, sv.ventas_monto, sv.ventas_unidades, sv.ventas_precio_unitario, ventas_descuento
from stage_northwind.dbo.ventas as sv
inner join datamart_nortwind.dbo.dim_cliente as dc
on sv.cliente_id = dc.cliente_codigo_bkey
inner join datamart_nortwind.dbo.dim_empleado as de
on sv.empleado_codigo = de.empleado_codigo_bkey
inner join datamart_nortwind.dbo.dim_producto as dp
on sv.producto_codigo = dp.producto_codigo_bkey
inner join datamart_nortwind.dbo.dim_tiempo as dt
on sv.ventas_orden = dt.tiempo_fecha_actual;

select * from datamart_nortwind.dbo.fact_ventas

truncate table [dbo].[fact_ventas];

DELETE FROM [dbo].[dim_cliente];
GO
DBCC CHECKIDENT ('dim_cliente',RESEED,0);
GO

DELETE FROM [dbo].[dim_empleado];
GO
DBCC CHECKIDENT ('dim_empleado',RESEED,0);
GO

DELETE FROM [dbo].[dim_producto];
GO
DBCC CHECKIDENT ('dim_producto',RESEED,0);
GO

DELETE FROM [dbo].[dim_tiempo];
GO
DBCC CHECKIDENT ('dim_tiempo',RESEED,0);
GO

select * from datamart_nortwind.dbo.dim_cliente
select * from datamart_nortwind.dbo.dim_empleado
select * from datamart_nortwind.dbo.dim_producto
select * from datamart_nortwind.dbo.dim_tiempo
select * from datamart_nortwind.dbo.fact_ventas