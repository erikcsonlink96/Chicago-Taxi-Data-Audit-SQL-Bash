# 🚖 Chicago Taxi App: Data Audit & Log Analysis (SQL + Bash)

### 🎯 El Desafío (Contexto)
La plataforma de taxis de Chicago reportaba incidentes críticos: quejas de usuarios por falta de vehículos y sospechas de errores en el cálculo de tarifas. Mi misión en este proyecto fue actuar como analista técnico para encontrar la causa raíz (Root Cause Analysis) investigando los registros del servidor y la base de datos de la flota.

### 🛠️ Proceso y Herramientas

#### 1. Investigación de Logs (Bash / Linux CLI)
Utilicé la terminal de Linux para conectarme al servidor y filtrar miles de registros de diciembre de 2019:
- **Rastreo de IPs:** Identifiqué solicitudes de la red `233.201` para investigar posibles bloqueos o errores de red.
- **Segmentación de Errores:** Automaticé la extracción de registros para el 30/12/2019, separando los fallos en archivos independientes de errores **400 (Bad Request)** y **500 (Server Error)** para facilitar el diagnóstico del equipo de desarrollo.

#### 2. Auditoría de Base de Datos (PostgreSQL)
Realicé una auditoría profunda sobre una base de datos con más de 10,000 registros para validar la lógica de negocio:
- **Validación de Flota:** Confirmé mediante `COUNT(DISTINCT)` que la flota real era de **5,500 vehículos**, identificando una brecha frente a la demanda esperada.
- **Análisis de Suministro:** Detecté qué compañías operaban con menos de 100 vehículos usando filtros de agregación (`HAVING`).
- **Correlación Clima-Precio:** Implementé lógica condicional con **CASE** para clasificar el clima (Bad/Good). Esto permitió descubrir que las tarifas se veían afectadas incorrectamente durante tormentas o lluvia.
- **Cruce de Datos:** Ejecuté `INNER JOIN` entre tablas de viajes y clima para auditar el volumen de servicios en fechas críticas de noviembre.

### 🚀 Resultados (Impacto)
- **Causa Raíz Identificada:** Proporcioné evidencia técnica de que el algoritmo de precios fallaba bajo condiciones climáticas específicas, permitiendo su corrección.
- **Transparencia de Datos:** Entregué un reporte detallado de la flota activa, ayudando a la gerencia a entender por qué los usuarios no encontraban taxis disponibles.
- **Eficiencia en Debugging:** Al segmentar los logs del servidor, el equipo de Backend pudo priorizar la resolución de errores 500 de manera inmediata.

### 📂 Contenido del Repositorio
- `queries.sql`: Consultas de PostgreSQL para la auditoría de flota y precios.
- `log_analysis.sh`: Comandos de Bash utilizados para la minería de logs.

---
**💡 Aprendizaje clave:** Este proyecto me demostró que un QA Automation Engineer debe ser capaz de ir más allá de la interfaz de usuario. Saber consultar la base de datos y los logs me da la autonomía para reportar no solo "que" algo falla, sino "por qué" está fallando.
