------------------CONSULTAS-------------------

-- Busqueda de producto por nombre y categoria
SELECT productos.nombre, productos.precio, categorias.nombre AS categoria
FROM productos JOIN categorias ON productos.categoria_id = categorias.categoria_id
WHERE productos.nombre = 'Bidón 20L' OR categorias.nombre = 'Bidones';

-- Top N productos por venta
SELECT productos.nombre, SUM(detalles.cantidad) AS unidades_vendidas, SUM(detalles.total) AS recaudacion_iva_incluido
FROM detalles
JOIN productos ON detalles.producto_id = productos.producto_id
GROUP BY productos.producto_id, productos.nombre
ORDER BY recaudacion_iva_incluido DESC LIMIT 5;

-- Ventas por mes y por categoria
SELECT TO_CHAR(ordenes.fecha_orden, 'YYYY-MM') AS mes, categorias.nombre AS categoria, 
COUNT(detalles.detalle_id) AS items_vendidos, SUM(detalles.total) AS total_mes FROM ordenes
JOIN detalles ON ordenes.orden_id = detalles.orden_id
JOIN productos ON detalles.producto_id = productos.producto_id
JOIN categorias ON productos.categoria_id = categorias.categoria_id
GROUP BY mes, categoria
ORDER BY mes DESC;

-- Ticket promedio en rango de fecha
SELECT ROUND(AVG(monto_total), 0) AS ticket_promedio_clp
FROM ordenes
WHERE ordenes.fecha_orden BETWEEN '2026-01-01' AND '2026-12-31';

-- Stock bajo
SELECT productos.nombre, inventario.stock_actual, inventario.umbral_minimo FROM productos
JOIN inventario ON productos.producto_id = inventario.producto_id
WHERE inventario.stock_actual < 5;

-- Productos sin venta
SELECT productos.nombre, productos.sku FROM productos
LEFT JOIN detalles ON productos.producto_id = detalles.producto_id
WHERE detalles.detalle_id IS NULL;

-- Clientes frecuentes
SELECT clientes.nombre, clientes.apellido, clientes.rut_numero || '-' || clientes.rut_digito AS rut_completo, 
COUNT(ordenes.orden_id) AS cantidad_ordenes FROM clientes
JOIN ordenes ON clientes.rut_numero = ordenes.rut_numero AND clientes.rut_digito = ordenes.rut_digito
GROUP BY clientes.rut_numero, clientes.rut_digito, clientes.nombre, clientes.apellido
HAVING COUNT(ordenes.orden_id) >= 2;


-- Iva acumulado por mes
SELECT TO_CHAR(ordenes.fecha_orden, 'YYYY-MM') AS mes, SUM(detalles.iva) AS iva_debito_total FROM ordenes
JOIN detalles ON ordenes.orden_id = detalles.orden_id
GROUP BY TO_CHAR(ordenes.fecha_orden, 'YYYY-MM');


-----------------TRANSACCION MINIMA----------------------

BEGIN;

-- Crear la cabecera de la orden para un cliente existente
INSERT INTO ordenes (rut_numero, rut_digito, fecha_orden, monto_total) 
VALUES (12345678, '5', CURRENT_DATE, 0);

-- Insertar los productos en la tabla detalles
-- Usamos currval para obtener el ID de la orden que acabamos de crear arriba
INSERT INTO detalles (orden_id, producto_id, cantidad, precio_unitario)
VALUES (currval('ordenes_orden_id_seq'), 1, 3, 3000), -- 3 Bidones 20L
       (currval('ordenes_orden_id_seq'), 3, 1, 6500); -- 1 Dispensador Básico

-- Descontar stock en la tabla inventario
UPDATE inventario SET stock_actual = stock_actual - 3 WHERE producto_id = 1;
UPDATE inventario SET stock_actual = stock_actual - 1 WHERE producto_id = 3;

-- Calcular el monto_total de la orden sumando los subtotales generados
UPDATE ordenes 
SET monto_total = (SELECT SUM(total) FROM detalles WHERE orden_id = currval('ordenes_orden_id_seq'))
WHERE orden_id = currval('ordenes_orden_id_seq');

-- Registrar el pago asociado al primer detalle
INSERT INTO pagos (detalle_id, metodo_pago, fecha_pago)
VALUES (currval('detalles_detalle_id_seq'), 'Transferencia', CURRENT_TIMESTAMP);

COMMIT;
-- Si falla SQL hará ROLLBACK automático.

