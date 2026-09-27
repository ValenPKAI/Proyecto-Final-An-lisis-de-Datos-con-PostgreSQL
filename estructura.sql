-- ==========================================================
-- ESTRUCTURA.SQL: Creación de base de datos, tablas y carga
-- ==========================================================

-- Configuración de la base de datos obligatoria para el proyecto
-- (Ejecutar CREATE DATABASE previamente si tu entorno lo requiere)
-- CREATE DATABASE capstone_project;
-- \c capstone_project

-- Eliminación previa para garantizar idempotencia y evitar errores de reejecución
DROP TABLE IF EXISTS pedidos CASCADE;
DROP TABLE IF EXISTS productos CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;

-- 1. Tabla de Clientes
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    pais VARCHAR(50) DEFAULT 'Argentina'
);

-- 2. Tabla de Productos (Utiliza NUMERIC para importes precisos)[cite: 27]
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(150) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    precio NUMERIC(10, 2) NOT NULL CHECK (precio >= 0)
);

-- 3. Tabla de Pedidos (Utiliza DATE para fechas y restricciones de validación)[cite: 26, 27]
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES clientes(id),
    producto_id INT REFERENCES productos(id),
    cantidad INT NOT NULL CHECK (cantidad > 0),
    fecha_venta DATE NOT NULL,
    monto_total NUMERIC(10, 2) NOT NULL CHECK (monto_total >= 0)
);

-- ==========================================================
-- INSERCIÓN DE DATOS DE PRUEBA
-- ==========================================================

INSERT INTO clientes (nombre, email, pais) VALUES
('Valentino Pocai', 'valen@email.com', 'Argentina'),
('Belén Gomez', 'belen@email.com', 'Argentina'),
('Carlos Perez', 'carlos@email.com', 'Chile'),
('Ana Lopez', 'ana@email.com', 'Uruguay'),
('Lucia Mendez', 'lucia@email.com', 'Argentina');

INSERT INTO productos (nombre_producto, categoria, precio) VALUES
('Camisa Slim Fit', 'Indumentaria', 25.50),
('Notebook Gamer', 'Tecnología', 1200.00),
('Auriculares Bluetooth', 'Tecnología', 45.00),
('Zapatillas Urbanas', 'Calzado', 80.00),
('Mochila Impermeable', 'Accesorios', 35.00),
('Smartwatch Deportivo', 'Tecnología', 150.00); -- Producto creado para probar baja rotación (cero ventas)

INSERT INTO pedidos (cliente_id, producto_id, cantidad, fecha_venta, monto_total) VALUES
(1, 2, 1, '2026-01-15', 1200.00),
(1, 3, 2, '2026-01-20', 90.00),
(2, 1, 3, '2026-02-10', 76.50),
(3, 4, 1, '2026-02-18', 80.00),
(4, 5, 2, '2026-03-05', 70.00),
(5, 3, 1, '2026-03-12', 45.00),
(2, 5, 1, '2026-03-25', 35.00),
(1, 4, 1, '2026-04-02', 80.00);
