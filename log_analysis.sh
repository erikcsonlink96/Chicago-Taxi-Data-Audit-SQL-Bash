#!/bin/bash

# ############################################################################
# PROYECTO: Análisis de Logs en Servidor Remoto - Chicago Taxi
# OBJETIVO: Identificar picos de errores y segmentar registros por código HTTP.
# HERRAMIENTA: Bash / Linux CLI
# ############################################################################

# 1. BÚSQUEDA DE SOLICITUDES POR IP ESPECÍFICA
# Objetivo: Localizar registros de la red 233.201 para investigar bloqueos.
grep "233.201" logs/2019/12/*


# 2. GESTIÓN DE DIRECTORIOS PARA INVESTIGACIÓN DE BUGS
# Objetivo: Crear una estructura organizada para el equipo de desarrollo.
mkdir bug1
mkdir bug1/events


# 3. EXTRACCIÓN DE LOGS POR FECHA ESPECÍFICA
# Objetivo: Aislar todas las solicitudes del 30 de diciembre de 2019.
grep "30/12/2019" logs/2019/12/* > bug1/main.txt


# 4. CLASIFICACIÓN DE ERRORES HTTP (400 vs 500)
# Objetivo: Separar errores de cliente y servidor para análisis de causa raíz.

# Filtrar errores 400 (Bad Request)
grep " 400 " bug1/main.txt > bug1/events/400.txt

# Filtrar errores 500 (Internal Server Error)
grep " 500 " bug1/main.txt > bug1/events/500.txt
