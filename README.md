# Proyecto Capstone: Análisis Exploratorio de Datos (EDA) en PostgreSQL

## Descripción del problema de negocio
Este proyecto simula el análisis de operaciones comerciales de una plataforma de comercio electrónico. El objetivo principal es transformar datos transaccionales brutos en inteligencia de negocio accionable, respondiendo preguntas clave vinculadas a la rentabilidad de clientes, la estacionalidad de la facturación, la rotación de inventario y la jerarquía de ventas por categoría[cite: 22, 27].

## Archivos del repositorio
* `estructura.sql`: Scripts de creación de la base de datos `capstone_project`, definición de tablas relacionales con tipos estrictos (`DATE`, `NUMERIC`) y carga inicial de datos[cite: 22, 27].
* `analisis.sql`: Consultas orientadas a resolver las preguntas de negocio, debidamente comentadas con justificaciones comerciales y manejo defensivo de nulos[cite: 22, 27].
* `README.md`: Documentación formal del proyecto, hallazgos interpretados y guía de ejecución[cite: 22, 27].

## Limpieza y decisiones de calidad
* **Tipos de datos estrictos:** Se implementaron tipos de datos nativos adecuados (`NUMERIC(10,2)` para importes monetarios y `DATE` para marcas temporales de ventas) para prevenir errores de cálculo y asegurar la integridad analítica[cite: 23, 27].
* **Gestión de valores nulos:** Se aplicó la función `COALESCE` en la consulta de baja rotación de productos (Pregunta 3)[cite: 27]. Mediante el uso de un `LEFT JOIN`, garantizamos que los productos del catálogo que registran cero transacciones se muestren explícitamente con `0` unidades vendidas en lugar de ser omitidos del reporte.

## Hallazgos principales
1. **Concentración del Gasto (Top Clientes):** Se detectó que el volumen de facturación recae fuertemente en los principales compradores de la categoría de tecnología. *Acción sugerida:* Diseñar programas de fidelización exclusivos para este segmento VIP.
2. **Estacionalidad Mensual:** Los datos revelan variaciones en el flujo de caja entre los primeros meses del año, permitiendo anticipar los períodos de menor demanda para programar campañas de estímulo comercial.
3. **Control de Stock Inmovilizado:** El análisis de los productos con menor rotación expuso artículos sin demanda en el período analizado. *Acción sugerida:* Evaluar ajustes de precios o estrategias de liquidación para liberar capital de trabajo retenido en inventario.

## Pasos para ejecutar el código
1. Inicia tu cliente de PostgreSQL de preferencia (como pgAdmin, DBeaver o la terminal `psql`)[cite: 33].
2. Crea y conéctate a la base de datos obligatoria del proyecto:
   ```sql
   CREATE DATABASE capstone_project;
   \c capstone_project
