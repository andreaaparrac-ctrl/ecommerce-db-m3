CREATE TABLE categorias (
categoria_id SERIAL PRIMARY KEY,
nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE productos (
producto_id SERIAL PRIMARY KEY,
categoria_id INT,
nombre VARCHAR(150) NOT NULL,
precio INT NOT NULL CHECK (precio > 0),
sku VARCHAR(50) UNIQUE NOT NULL,
FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id) ON DELETE SET NULL
);

CREATE TABLE inventario (
producto_id INT, 
stock_actual INT NOT NULL CHECK (stock_actual >= 0),
umbral_minimo INT DEFAULT 5,
FOREIGN KEY (producto_id) REFERENCES productos(producto_id) ON DELETE SET NULL
);

CREATE TABLE clientes (
rut_numero INT NOT NULL,
rut_digito CHAR(1) NOT NULL,
email VARCHAR(150) NOT NULL UNIQUE,
nombre VARCHAR(100) NOT NULL,
apellido VARCHAR(100) NOT NULL,
PRIMARY KEY (rut_numero, rut_digito)
);

CREATE TABLE ordenes (
orden_id SERIAL PRIMARY KEY,
rut_numero INT NOT NULL,
rut_digito CHAR(1) NOT NULL,
fecha_orden DATE NOT NULL,
monto_total INT DEFAULT 0,
FOREIGN KEY (rut_numero, rut_digito) REFERENCES clientes(rut_numero, rut_digito)
);

CREATE TABLE detalles (
detalle_id SERIAL PRIMARY KEY,
orden_id INT,
producto_id INT, 
cantidad INT NOT NULL CHECK (cantidad > 0),
precio_unitario INT NOT NULL CHECK (precio_unitario > 0),
subtotal INT GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,
iva INT GENERATED ALWAYS AS ((cantidad*precio_unitario)*0.19) STORED,
total INT GENERATED ALWAYS AS ((cantidad * precio_unitario)+((cantidad * precio_unitario)*0.19))STORED,
FOREIGN KEY (orden_id) REFERENCES ordenes(orden_id) ON DELETE SET NULL,
FOREIGN KEY (producto_id) REFERENCES productos(producto_id) ON DELETE SET NULL
);

CREATE TABLE pagos (
pago_id SERIAL PRIMARY KEY,
detalle_id INT,
metodo_pago VARCHAR(50),
fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (detalle_id) REFERENCES detalles(detalle_id) ON DELETE SET NULL
);

CREATE INDEX idx_productos_nombre ON productos(nombre);
CREATE INDEX idx_productos_categoria ON productos(categoria_id);
CREATE INDEX idx_clientes_email ON clientes(email);
CREATE INDEX idx_ordenes_fecha ON ordenes(fecha_orden);
