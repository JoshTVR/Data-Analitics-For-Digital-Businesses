# **Documentación del Proceso ETL para la Tabla de Categorías (Package-02)**

## **Descripción general**

El paquete **02-stage-categoria.dtsx** corresponde al proceso ETL diseñado para la tabla **Categorías** del proyecto Northwind. En este documento se describe paso a paso el flujo, desde la extracción inicial de los datos hasta su transformación y posterior carga en la base intermedia. Además, se pone especial énfasis en la lógica utilizada para integrar, comparar y actualizar los registros, así como en las mejores prácticas para una migración eficiente y sin duplicados.

---

## Arquitectura General del Paquete (SSIS)

Este paquete utiliza la estructura estándar desarrollada en las prácticas de clase, lo que garantiza integridad de los datos y claridad en cada etapa. Los pasos principales del flujo son:

1. **Extracción de datos desde dos orígenes** (OLE DB Source)
2. **Conversión de tipos de datos** (Data Conversion)
3. **Ordenamiento de datos** (Sort, si es necesario para el Merge Join)
4. **Comparación con la tabla destino usando Join** (Merge Join)
5. **Filtrado de nuevos registros** (Conditional Split)
6. **Carga de datos en la tabla Stage** (OLE DB Destination)

![Arquitectura General Categorías](../../../Imgs/02-Package/02-Package-Arquitecture.png)

---

## 1. Extracción de datos (OLE DB Source)

### a) Conexión al origen Northwind

Se utiliza un **OLE DB Source** conectado a **Northwind** para extraer los registros actuales de categorías.
Aquí se configura la siguiente consulta SQL:

```sql
SELECT CategoryID, CategoryName
FROM Northwind.dbo.Categories;
```

- **¿Por qué usar una consulta específica?** Permite obtener únicamente los campos relevantes, lo que agiliza el proceso ETL, reduce el volumen de datos procesados y facilita el trabajo en las etapas posteriores.
- **Errores comunes:** Traer columnas innecesarias puede complicar la transformación y enlentecer el flujo.

![OLE DB Source Northwind](../../../Imgs/02-Package/02-Package-ole-db-source-northwind.png)

### b) Conexión al destino Stage_Northwind

El segundo **OLE DB Source** se conecta a la tabla `[categorias]` de **Stage_Northwind**, obteniendo el estado actual de la tabla destino.

- **¿Por qué?** Esto permite comparar los datos nuevos contra los ya existentes y así evitar duplicados.
- **Práctica recomendada:** Seleccionar siempre los mismos campos clave para la comparación.

![OLE DB Source Stage_Northwind](../../../Imgs/02-Package/02-Package-ole-db-source-stage-northwind.png)

---

## 2. Conversión de Tipos de Datos (Data Conversion)

El componente **Data Conversion** se emplea para ajustar los tipos de datos extraídos, asegurando que coincidan exactamente con la definición de la tabla de destino. Por ejemplo, es posible que se tenga que modificar el tipo o la longitud de `CategoryName` para evitar errores de inserción o pérdida de información.

- **¿Por qué?** Si el tipo no coincide exactamente, la inserción puede fallar o truncar datos.
- **Errores comunes:** No ajustar el tamaño de los strings puede cortar nombres largos o generar incompatibilidad.

![Data Conversion Transformation Editor](../../../Imgs/02-Package/02-Package-Data-Conversion-Transformation-Editor.png)

---

## 3. Ordenamiento de Datos (Sort, opcional pero recomendado)

Para que el componente **Merge Join** funcione correctamente, es imprescindible que ambos conjuntos de datos estén ordenados por la clave de unión, que en este caso suele ser `CategoryID`.

- **¿Por qué ordenar?** Es requisito del Merge Join en SSIS.
- **Recomendación:** Asegúrate de que ambas fuentes usen el mismo criterio de orden.

---

## 4. Comparación y Unión de Datos (Merge Join / Left Join)

El componente **Merge Join** se utiliza aquí con un **Left Outer Join** para comparar los registros extraídos de Northwind contra los de Stage y así identificar cuáles son nuevos.

**Motivo:** El objetivo principal es insertar únicamente las nuevas categorías, evitando así duplicados en la base de datos intermedia.
**Aplicación práctica:** La utilización del Left Join facilita la identificación de registros presentes en Northwind pero ausentes en Stage, lo que permite enfocarse en la carga incremental.

- **Errores comunes:** No ordenar las fuentes, o mapear mal los campos clave.

![Merge Join Transformation Editor](../../../Imgs/02-Package/02-Package-Merge-Join-Transformation-Editor.png)

---

## 5. Filtrado de Nuevos Registros (Conditional Split)

Se emplea **Conditional Split** para filtrar solo las categorías nuevas, es decir, donde el campo clave `categoriaid` en Stage es NULL.

- **Ejemplo de condición:**
  `ISNULL(Stage_categoriaid)`
  (Sugerencia: Especificar el prefijo o el origen ayuda a evitar confusiones si hay nombres repetidos entre fuentes.)
- **¿Por qué?** Para no sobrescribir categorías existentes y solo insertar las que realmente son nuevas.
- **Tip:** Documenta la lógica de cada split para facilitar el mantenimiento futuro.

![Conditional Split Transformation Editor](../../../Imgs/02-Package/02-Package-Conditional-Split-Transformation-Editor.png)

---

## 6. Carga de Datos en Stage (OLE DB Destination)

Las nuevas categorías se cargan en la tabla `[categorias]` de **Stage_Northwind** usando un **OLE DB Destination**.

**Mapeo de columnas:** Es fundamental revisar que cada columna del flujo de datos esté correctamente alineada con la columna correspondiente en la tabla de destino.
**Validación:** Antes de realizar cargas masivas, se recomienda ejecutar pruebas con un subconjunto reducido de registros para verificar que la inserción es correcta y evitar errores mayores.

![OLE DB Destination Editor](../../../Imgs/02-Package/02-Package-OLE-DB-Destination-Editor.png)

## ![OLE DB Destination Mapping](../../../Imgs/02-Package/02-Package-OLE-DB-Destination-Mapping.png)

## 7. Flujo Completo

El **Data Flow** de este paquete en SSIS muestra todos los componentes conectados, facilitando la comprensión del proceso.

![Resumen Flujo Completo](../../../Imgs/02-Package/02-Package-Arquitecture.png)

---

## Buenas Prácticas y Observaciones

- **Control de errores:** Usa las salidas de error de los componentes (especialmente Data Conversion y Merge Join) para capturar datos problemáticos.
- **Documenta tus flujos:** Escribe comentarios o notas en los componentes de SSIS.
- **Reutilización:** Esta estructura de paquete puede adaptarse fácilmente para cualquier dimensión que requiera una lógica de actualización incremental.
- **Pruebas incrementales:** Antes de ejecutar el paquete a gran escala, valida el flujo y la lógica con un grupo pequeño de datos para detectar posibles problemas a tiempo.

---

## Consideraciones Didácticas y Experiencia de Aprendizaje

- **Conversión de tipos:** Te ayudará a comprender los problemas típicos de integración de datos entre sistemas distintos.
- **Left Join vs Inner Join:** Comprender las diferencias y usos de cada tipo de join es fundamental, ya que permite definir si el objetivo es detectar nuevos registros, actualizar existentes o realizar eliminaciones lógicas.
- **Uso de Conditional Split:** Es clave para realizar cargas incrementales, evitando sobrescribir o duplicar datos.

---

## **Resumen Técnico**

El paquete **02-stage-categoria.dtsx** ilustra la lógica de integración incremental y controlada aplicada a la dimensión de categorías. Es un modelo útil para automatizar la migración y actualización de datos esenciales, asegurando la calidad de la información y evitando la duplicidad de registros.

---
