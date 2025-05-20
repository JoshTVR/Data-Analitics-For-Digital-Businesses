use Northwind
-- Create la base de datos de Stage_Northwind
create database stage_northwind;

-- Crear la base de datos datamart Nortwind
create database datamart_nortwind

-- Entrar a la base de datos stage_northwind
use stage_northwind

create table categorias(
categoriaid int not null,
nombrecategoria varchar(15)
);

create table clientes(
clienteid char(5) not null,
compania varchar(40)not null,
ciudad varchar(15),
region varchar(15),
codigopostal char(10),
pais nvarchar(15)
);

create table empleado(
empleadoid int not null,
nombre varchar(20) not null,
apellido varchar(20) not null,
fechacontratacion date
);

create table producto(
producto_id int not null,
nombre_producto varchar(50) not null,
precio_unitario decimal(15,2)not null
);

create table proveedor(
proveedor_id int not null,
proveedor_nombre varchar(40) not null,
ciudad varchar(15),
region varchar(15),
pais varchar(15)
);

create table ventas(
cliente_id char(5) not null,
empleado_codigo int not null,
producto_codigo int not null,
ventas_orden datetime not null,
ventas_monto decimal(15,2) not null,
ventas_unidades int not null,
ventas_precio_unitario decimal(15,2) not null,
ventas_descuento decimal
);

use datamart_nortwind

create table dim_cliente(
cliente_skey int not null identity (1,1),
cliente_codigo_bkey char(5) not null,
cliente_compania varchar(40) not null,
cliente_ciudad varchar(15) not null,
cliente_region varchar(25) not null,
cliente_pais varchar(15) not null,
constraint pk_dimcliente
primary key(cliente_skey)
);

create table dim_empleado(
empleado_skey int not null identity(1,1),
empleado_codigo_bkey int not null,
empleado_nombre_completo varchar(100) not null,
constraint pk_dimempleado
primary key(empleado_skey)
);

create table dim_producto(
producto_skey int not null identity(1,1),
producto_codigo_bkey int not null,
producto_nombre varchar(80) not null,
producto_categoria_nombre varchar(15) not null,
constraint pk_dimproducto
primary key(producto_skey)
);

create table dim_tiempo(
tiempo_skey int not null identity(1,1),
tiempo_fecha_actual datetime not null,
tiempo_anio int not null,
tiempo_trimestre int not null,
tiempo_semana int not null,
tiempo_dia_de_anio int not null,
tiempo_dia_de_mes int not null,
tiempo_dia_semana int not null,
constraint pk_dimtiempo
primary key(tiempo_skey)
);


create table fact_ventas(
cliente_skey int not null,
empleado_skey int not null,
producto_skey int not null,
tiempo_skey int not null,
ventas_norden int not null,
ventas_monto decimal(15,2) not null,
ventas_unidades int not null,
ventas_punitario decimal(15,2) not null,
ventas_descuento decimal(15,2) not null,
constraint pk_fact_ventas
primary key(cliente_skey,empleado_skey,producto_skey,tiempo_skey),
constraint fk_fact_ventas_dimcliente
foreign key(cliente_skey)
references dim_cliente(cliente_skey),
constraint fk_fact_ventas_dimempleado
foreign key (empleado_skey)
references dim_empleado(empleado_skey),
constraint fk_fact_ventas_dimproducto
foreign key (producto_skey)
references dim_producto(producto_skey),
constraint fk_fact_ventas_dimtiempo
foreign key(tiempo_skey)
references dim_tiempo(tiempo_skey)
);