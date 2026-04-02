Markdown

# Módulo 3 - E-commerce

Este proyecto contiene el diseño e implementación de una base de datos para un e-commerce, incluyendo el modelo Entidad-Relación (ER), el esquema de tablas (DDL), la carga de datos iniciales (Seed) y consultas de negocio (KPIs).

## Estructura del Proyecto

/ecommerce-db-m3
|---/docs
│    |--- er.png         -- Diagrama Entidad-Relación
|---/sql
│    |---schema.sql      -- Definición de tablas, claves y restricciones
│    |--- seed.sql       -- Datos de prueba para el catálogo y clientes
│    |---queries.sql     -- KPIs y transacción de venta
|---README.md            -- Instrucciones y documentación

## Tablas principales
- **categorias**   :clasificación de productos
- **productos**    :información de cada producto
- **inventario**   :stock actual y umbral mínimo
- **clientes**     :datos de clientes con RUT como clave primaria compuesta
- **ordenes**      :órdenes realizadas por clientes
- **detalles**     :ítems de cada orden, con cálculo automático de subtotal, IVA y total
- **pagos**        :registro de pagos asociados a detalles

## Restricciones esenciales
- **NOT NULL**  :en campos obligatorios
- **UNIQUE**    :en sku y email
- **CHECK**     :en precio > 0 y cantidad > 0

## Índices útiles
- **idx_productos_nombre**      :búsqueda rápida por nombre de producto
- **idx_productos_categoria**   :filtrado por categoría
- **idx_clientes_email**        :consultas por email de cliente
- **idx_ordenes_fecha**         :reportes por fecha de orden