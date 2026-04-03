Markdown

# Módulo 3 - E-commerce

Este proyecto contiene el diseño e implementación de una base de datos para un e-commerce, incluyendo el modelo Entidad-Relación (ER), el esquema de tablas (DDL), la carga de datos iniciales (Seed) y consultas de negocio (KPIs).

## Estructura del Proyecto

```text
/ecommerce-db-m3
|---/docs
│    |--- er.png         -- Diagrama Entidad-Relación
|---/sql
│    |---schema.sql      -- Definicion de tablas, claves y restricciones
│    |--- seed.sql       -- Datos de prueba para el catalogo y clientes
│    |---queries.sql     -- KPIs y transaccion de venta
|---README.md            -- Instrucciones y documentacion

## Tablas principales

- **categorias**   :clasificacion de productos
- **productos**    :informacion de cada producto
- **inventario**   :stock actual y umbral minimo
- **clientes**     :datos de clientes con RUT como clave primaria compuesta
- **ordenes**      :ordenes realizadas por clientes
- **detalles**     :items de cada orden, con calculo automatico de subtotal, IVA y total
- **pagos**        :registro de pagos asociados a detalles

## Restricciones esenciales

- **NOT NULL**  :en campos obligatorios
- **UNIQUE**    :en sku y email
- **CHECK**     :en precio > 0 y cantidad > 0

## Indices utiles

- **idx_productos_nombre**      :busqueda rapida por nombre de producto
- **idx_productos_categoria**   :filtrado por categoria
- **idx_clientes_email**        :consultas por email de cliente
- **idx_ordenes_fecha**         :reportes por fecha de orden

## Resultados de las consultas

- Top Ventas         : identifica que el Bidón 20L es el producto con mayor rotación
- Stock Bajo         : genera alertas automáticas cuando los Dispensadores bajan de 5 unidades
- Clientes Frecuentes: filtra usuarios con 3 o más compras (fidelización)
- Ventas Mensuales   : reporte agrupado por mes y categoria para analisis de estacionalidad

## Transaccion de Venta

- Registra la Cabecera de la Orden vinculada al RUT del cliente
- Inserta los Detalles, donde el sistema calcula automaticamente el Subtotal, IVA y Total
- Descuenta el Stock del inventario fisico
- Actualiza el Monto Total de la orden sumando los valores finales de los detalles insertados

## Repositorio GitHub

https://github.com/andreaaparrac-ctrl/ecommerce-db-m3

