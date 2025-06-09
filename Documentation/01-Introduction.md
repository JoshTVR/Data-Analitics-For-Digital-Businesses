# Proyecto ETL Northwind: Transformación y Análisis de Datos para Negocios Digitales

## Contexto del Proyecto

Este proyecto se desarrolló como parte de la asignatura **Analítica de Datos para Negocios Digitales**, con el objetivo principal de aprender y aplicar los procesos **ETL (Extract, Transform, Load)**. Estos procesos son esenciales en el ámbito digital, ya que permiten integrar, limpiar y transformar grandes volúmenes de datos en información confiable, facilitando decisiones estratégicas rápidas y acertadas. Utilizamos la base de datos **Northwind**, reconocida por su estructura clara y orientada a negocios, para ejemplificar distintos conceptos y técnicas analíticas.

## Herramientas y Entorno Tecnológico

Para llevar a cabo este proyecto, se utilizaron las siguientes herramientas:

- **Visual Studio 2022**: Entorno integrado de desarrollo (IDE).
- **SQL Server Integration Services (SSIS)**: Extensión específica de Microsoft que proporciona herramientas avanzadas para realizar operaciones ETL, específicamente:

  - Extracción de datos
  - Transformación de datos
  - Carga de datos

## Organización del Proyecto

El proyecto fue estructurado en carpetas específicas para cada fase del proceso ETL, facilitando así la gestión efectiva del flujo de trabajo:

- **Stage_Northwind**: Contiene la base intermedia que almacena temporalmente los datos extraídos para su posterior transformación.
- **Datamart_Northwind**: Almacena la base final con un modelo dimensional optimizado para análisis profundos y generación ágil de reportes.
- **ETLNortWind.sln**: Solución integral que alberga todos los paquetes ETL utilizados durante el proyecto, permitiendo la gestión completa del proceso de datos.

## Flujo Detallado del Proceso ETL

### Extracción

- Se obtuvieron datos desde la base original **Northwind**.

### Transformación (Stage_Northwind)

- Los datos extraídos fueron almacenados en tablas temporales para su limpieza y transformación, generando así una estructura intermedia más accesible.

**Paquetes ETL específicos:**

- Empleado
- Categoría
- Cliente
- Ventas
- Producto
- Proveedor
- Tiempo
- Limpieza del Stage

### Carga (Datamart_Northwind)

- Tras la transformación, los datos fueron cargados en un modelo dimensional definitivo (base de datos **Datamart_Northwind**).

**Paquetes ETL específicos:**

- Cliente
- Empleado
- Producto
- Tiempo
- Fact Ventas
- Carga Master Datamart
- Limpieza Dimensiones

## Objetivos y Aplicaciones Empresariales

El propósito central del proyecto es demostrar claramente cómo transformar datos en información útil mediante técnicas analíticas avanzadas. Este enfoque facilita considerablemente la toma de decisiones en contextos empresariales digitales. Algunos ejemplos concretos de aplicaciones incluyen:

- Gestión eficiente de inventarios.
- Análisis detallado y predictivo de ventas.
- Mejora en la gestión y fidelización de clientes.
- Desarrollo de estrategias de marketing segmentado.
- Identificación temprana de tendencias de consumo.

En documentos posteriores, cada paquete ETL se abordará de manera detallada, explicando los procesos específicos involucrados.

## Base de Datos Northwind Original

La base de datos **Northwind** cuenta con diversas tablas interrelacionadas que permiten gestionar información esencial para la operación empresarial diaria, tales como:

- Customers (Clientes)
- Employees (Empleados)
- Orders (Pedidos)
- Products (Productos)
- Suppliers (Proveedores)
- Categories (Categorías)
- Order Details (Detalles de pedidos)

## Creación de Nuevas Bases de Datos

Para llevar a cabo correctamente el proceso ETL, se crearon dos bases de datos nuevas:

### Stage_Northwind (Base Intermedia de Transformación)

La base **Stage_Northwind** es una etapa crucial en el proceso ETL, diseñada para almacenar temporalmente los datos extraídos de la fuente original. Su función principal es permitir la limpieza, validación y transformación inicial antes de que los datos sean transferidos a la base definitiva. Esto garantiza que los datos que llegan al destino final estén correctamente estructurados y libres de errores o inconsistencias.

**Tablas creadas:**

- **Categorías**: Clasificación de productos para análisis segmentado.
- **Clientes**: Información básica sobre clientes para análisis de mercado.
- **Empleado**: Datos de los empleados relevantes para gestión interna y desempeño.
- **Producto**: Detalles de productos para análisis de inventario y ventas.
- **Proveedor**: Información de proveedores para evaluar rendimiento y gestión logística.
- **Ventas**: Registros detallados de transacciones para análisis financiero y comercial.
- **Stage_Tiempo**: Tabla especializada para facilitar análisis temporales detallados, permitiendo evaluar patrones y tendencias a lo largo del tiempo.

### Datamart_Northwind (Base Dimensional Definitiva para Analítica Avanzada)

La base **Datamart_Northwind** se estructura siguiendo el modelo dimensional (modelo estrella) para facilitar análisis eficientes y ágiles, generación rápida de informes, y soporte en decisiones estratégicas avanzadas. Su estructura permite la rápida agregación, filtrado y segmentación de los datos.

**Tablas creadas:**

- **Dimensiones**:

  - **dim_cliente**: Atributos detallados de clientes para segmentación avanzada.
  - **dim_empleado**: Datos consolidados sobre empleados para evaluar productividad y desempeño.
  - **dim_producto**: Información descriptiva y categórica de productos para análisis de ventas y tendencias.
  - **dim_tiempo**: Tabla que permite el análisis histórico y comparativo en diferentes intervalos de tiempo (días, semanas, meses, años).

- **Hechos**:

  - **fact_ventas**: Tabla central que registra métricas cuantitativas críticas relacionadas con las ventas, tales como ingresos totales, unidades vendidas y descuentos aplicados, conectando todas las dimensiones y permitiendo análisis multidimensionales profundos.

## Modelo Dimensional (Modelo Estrella)

La base **Datamart_Northwind** adopta una estructura dimensional conocida como **modelo estrella**, ideal para análisis y generación de informes ágiles en contextos empresariales. Este modelo consta principalmente de dos tipos de tablas:

- **Tablas Dimensionales**: Estas tablas almacenan atributos descriptivos que permiten segmentar, filtrar y categorizar los datos fácilmente. Ejemplos comunes son clientes, productos, empleados y fechas. Las dimensiones proporcionan contexto, facilitando consultas rápidas y específicas como análisis de ventas por región, por categoría de producto o por período temporal.

- **Tabla de Hechos**: Es la tabla central del modelo estrella y contiene métricas cuantitativas clave para el negocio, tales como ingresos, unidades vendidas, costos o márgenes de beneficio. La tabla de hechos está diseñada para almacenar datos detallados y relevantes para el análisis, relacionados directamente con las dimensiones mediante claves foráneas, permitiendo así un análisis profundo y multifacético.

La base **Datamart_Northwind** adopta una estructura clara compuesta por:

- **Tablas Dimensionales**: Contienen atributos descriptivos para análisis sencillos y ágiles.
- **Tabla de Hechos**: Contiene métricas cuantitativas relevantes (por ejemplo, ventas totales, unidades vendidas) asociadas a las dimensiones establecidas.
