INSERT INTO categorias (nombre) VALUES 
('Bidones'), 
('Packs'), 
('Accesorios');

INSERT INTO productos (categoria_id, nombre, precio, sku) VALUES 
(1, 'Bidón 20L', 3000, 'AGUA-20L'),
(2, 'Pack Botellas 500ml', 3000, 'PACK-500'),
(3, 'Dispensador Básico', 6500, 'ACC-001');

INSERT INTO inventario (producto_id, stock_actual) VALUES 
(1, 50), 
(2, 30), 
(3, 2);

INSERT INTO clientes (rut_numero, rut_digito, email, nombre, apellido) VALUES 
(12345678, '5', 'juan@correo.cl', 'John', 'Pera'),
(87654321, 'K', 'ana@correo.cl', 'Ana', 'Soto');

INSERT INTO ordenes (rut_numero, rut_digito, fecha_orden, monto_total) VALUES 
(87654321, 'K', '2026-02-01', 6500),
(12345678, '5', '2026-02-25', 3000),
(12345678, '5', '2026-03-15', 3000),
(12345678, '5', '2026-03-25', 3000),
(87654321, 'K', '2026-03-25', 3000);

INSERT INTO detalles (orden_id, producto_id, cantidad, precio_unitario) VALUES 
(1, 3, 1, 6500),
(2, 1, 1, 3000),
(3, 1, 1, 3000),
(4, 1, 1, 3000),
(5, 1, 1, 3000);
