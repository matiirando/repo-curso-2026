# ==============================================================================
# ECON 520 - Ciencia de Datos para Economía y Negocios
# Tarea 06 - Paquete 'edgar'
# Alumno: Matias Rando
# ==============================================================================

library(edgar)
library(tidyverse)

# Definir variables
cik_apple <- "320193"
anio <- 2025
mi_contacto <- "Matias Rando 85RA47129353@campus.economicas.uba.ar"

# 1. Buscar una palabra específica ("revenue") adentro de los reportes 10-K
reportes <- searchFilings(cik.no = cik_apple, 
                          form.type = "10-K", 
                          filing.year = anio,
                          word.list = "revenue",  # <- Acá agregamos la palabra que faltaba
                          useragent = mi_contacto)

# Ver el resultado de la búsqueda en la consola
print(reportes)

# 2. Descargar los reportes completos a tu computadora
getFilings(cik.no = cik_apple, 
           form.type = "10-K", 
           filing.year = anio,
           useragent = mi_contacto)
