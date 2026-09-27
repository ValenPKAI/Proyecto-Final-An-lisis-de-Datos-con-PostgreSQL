-- ==========================================================
-- ANALISIS.SQL: Consultas analíticas y de negocio
-- ==========================================================

-- ----------------------------------------------------------
-- 1. Top 5 clientes por gasto total (GROUP BY + SUM)[cite: 27]
-- ----------------------------------------------------------
-- Justificación comercial: Identificamos el segmento de mayor valor (VIP) para focalizar 
-- campañas de retención exclusivas y evitar la fuga de nuestros compradores más rentables.
SELECT 
    c.id AS cliente_id,
    c.nombre,
    SUM(p.monto_total) AS gasto_total
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre
ORDER BY gasto_total DESC
LIMIT 5;

-- ----------------------------------------------------------
-- 2. Ventas totales por mes (Funciones de fecha)[cite: 27]
-- ----------------------------------------------------------
-- Justificación comercial: Evaluamos la evolución de la facturación mensual para detectar 
-- estacionalidades operativas y medir si las acciones comerciales impactan en el crecimiento de los ingresos.
SELECT 
    DATE_TRUNC('month', fecha_venta) AS mes,
    COUNT(id) AS total_pedidos,
    SUM(monto_total) AS ingresos_mensuales
FROM pedidos
GROUP BY mes
ORDER BY mes ASC;

-- ----------------------------------------------------------
-- 3. Los 3 productos menos vendidos (Baja Rotación)[cite: 27]
-- ----------------------------------------------------------
-- Justificación comercial: Detectamos inventario inmovilizado. El uso defensivo de LEFT JOIN 
-- combinado con COALESCE nos permite asegurar que los artículos sin ninguna venta aparezcan reflejados 
-- con 0 unidades en lugar de desaparecer del informe, optimizando las decisiones de reposición.
SELECT 
    pr.id,
    pr.nombre_producto,
    pr.categoria,
    COALESCE(SUM(p.cantidad), 0) AS unidades_vendidas
FROM productos pr
LEFT JOIN pedidos p ON pr.id = p.producto_id
GROUP BY pr.id, pr.nombre_producto, pr.categoria
ORDER BY unidades_vendidas ASC
LIMIT 3;

-- ----------------------------------------------------------
-- 4. Ranking de pedidos por categoría (Window Function: RANK())[cite: 27]
-- ----------------------------------------------------------
-- Justificación comercial: Analizamos el comportamiento de compra particionando por categoría de producto. 
-- Esto permite identificar los tickets más destacados dentro de cada rubro de forma aislada, 
-- evitando que las categorías de mayor precio nominal opacuen el éxito comercial de las más accesibles.
SELECT 
    p.id AS pedido_id,
    pr.nombre_producto,
    pr.categoria,
    p.monto_total,
    RANK() OVER (PARTITION BY pr.categoria ORDER BY p.monto_total DESC) AS ranking_en_categoria
FROM pedidos p
JOIN productos pr ON p.producto_id = pr.id;
