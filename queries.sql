-- ############################################################################
-- PROYECTO: Auditoría de Datos - Chicago Taxi App
-- OBJETIVO: Identificar fallos lógicos en el cálculo de tarifas y flota.
-- TECNOLOGÍA: PostgreSQL
-- ############################################################################

-- ----------------------------------------------------------------------------
-- 1. VALIDACIÓN DE FLOTA TOTAL
-- Objetivo: Verificar si el número de vehículos activos coincide con el plan de demanda.
-- ----------------------------------------------------------------------------
SELECT 
    COUNT(DISTINCT vehicle_id) AS total_cars 
FROM 
    cabs;


-- ----------------------------------------------------------------------------
-- 2. ANÁLISIS DE SUMINISTRO POR COMPAÑÍA
-- Objetivo: Identificar compañías con déficit de vehículos (menos de 100 unidades).
-- Demuestra uso de: GROUP BY y filtrado con HAVING.
-- ----------------------------------------------------------------------------
SELECT 
    company_name, 
    COUNT(vehicle_id) AS cnt
FROM 
    cabs
GROUP BY 
    company_name
HAVING 
    COUNT(vehicle_id) < 100
ORDER BY 
    cnt DESC;


-- ----------------------------------------------------------------------------
-- 3. CLASIFICACIÓN CLIMÁTICA PARA ANÁLISIS DE TARIFAS
-- Objetivo: Segmentar datos meteorológicos para investigar picos de precios.
-- Demuestra uso de: Operador CASE y filtrado de texto con LIKE.
-- ----------------------------------------------------------------------------
SELECT 
    ts,
    CASE
        WHEN description LIKE '%rain%' OR description LIKE '%storm%' THEN 'Bad'
        ELSE 'Good'
    END AS weather_conditions
FROM 
    weather_records
WHERE 
    ts >= '2017-11-05 00:00:00' 
    AND ts < '2017-11-06 00:00:00';


-- ----------------------------------------------------------------------------
-- 4. AUDITORÍA DE VIAJES VS. GANANCIAS REPORTADAS
-- Objetivo: Obtener el volumen de viajes real por compañía en fechas críticas.
-- Demuestra uso de: INNER JOIN, Agregaciones y Condiciones temporales.
-- ----------------------------------------------------------------------------
SELECT 
    cabs.company_name, 
    COUNT(trips.trip_id) AS trips_amount
FROM 
    cabs
INNER JOIN 
    trips ON cabs.cab_id = trips.cab_id
WHERE 
    trips.start_ts >= '2017-11-15 00:00:00' 
    AND trips.start_ts < '2017-11-17 00:00:00'
GROUP BY 
    cabs.company_name
ORDER BY 
    trips_amount DESC;
