# ==============================================================================
# ECON 520 - Ciencia de Datos para Economía y Negocios
# Tarea 04 - Transformación de Datos y Joins (Capítulos 3 y 19)
# Alumno: Matias Rando
# Dataset: nycflights13 (vuelos)
# ==============================================================================

# 1. Cargar librerías y datos
library(tidyverse)
library(nycflights13)

# Carga de datos de vuelos
data(flights)
data(planes)
data(airlines)
data(airports)
data(weather)

# ------------------------------------------------------------------------------
# Capítulo 3: Transformación de Datos (dplyr)
# ------------------------------------------------------------------------------

# Filtrar vuelos con retrasos o destinos específicos (filter)
vuelos_retrasados <- flights %>% 
  filter(dep_delay > 120 | arr_delay > 120)

# Ordenar por retraso de salida (arrange)
vuelos_ordenados <- flights %>% 
  arrange(desc(dep_delay))

# Seleccionar columnas principales (select)
vuelos_resumen <- flights %>% 
  select(year, month, day, carrier, flight, dep_delay, arr_delay, distance)

# Crear variables calculadas: velocidad en mph y tiempo ganado (mutate)
vuelos_metricas <- flights %>% 
  mutate(
    ganancia_tiempo = dep_delay - arr_delay,
    velocidad_mph = (distance / air_time) * 60
  )

# Resumen estadístico agrupado por aerolínea (group_by + summarize)
resumen_aerolineas <- flights %>% 
  group_by(carrier) %>% 
  summarize(
    promedio_retraso = mean(dep_delay, na.rm = TRUE),
    total_vuelos = n()
  )

# ------------------------------------------------------------------------------
# Capítulo 19.2.4 Exercises: Keys (Claves)
# ------------------------------------------------------------------------------

# Identificar la clave primaria en 'planes' (tailnum identifica de forma única)
planes %>% 
  count(tailnum) %>% 
  filter(n > 1)

# ------------------------------------------------------------------------------
# Capítulo 19.3.4 Exercises: Basic Joins
# ------------------------------------------------------------------------------

# 1. Unir vuelos con nombres completos de aerolíneas
vuelos_con_aerolinea <- flights %>% 
  left_join(airlines, by = "carrier")

# 2. Unir vuelos con información del modelo de avión
vuelos_con_aviones <- flights %>% 
  left_join(planes, by = "tailnum", suffix = c("_vuelo", "_avion"))

# 3. Unir condiciones meteorológicas en el momento del despegue
vuelos_con_clima <- flights %>% 
  left_join(weather, by = c("year", "month", "day", "hour", "origin"))