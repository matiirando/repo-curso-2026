# ==============================================================================
# ECON 520 - Ciencia de Datos para Economía y Negocios
# Tarea 02 - R Base (Programación y Estructuras de Datos)
# Alumno: Matias Rando
# Base analizada: 'longley' (Indicadores macroeconómicos)
# ==============================================================================

# 1. Cargar y explorar la base de datos
data(longley)
datos <- longley

# Inspección rápida
head(datos)
str(datos)
summary(datos)


# 2. Tipos de datos y operadores
# Extraemos valores del primer registro (1947)
anio_inicio <- as.integer(datos$Year[1])     # Integer
desempleo_inicial <- datos$Unemployed[1]     # Numeric
nombre_var <- "Unemployed"                  # Character
es_serie_anual <- TRUE                      # Logical

# Verificamos los tipos en la consola
class(anio_inicio)
class(desempleo_inicial)
class(nombre_var)
class(es_serie_anual)

# Mensaje concatenado con paste()
mensaje <- paste("Analizando la variable:", nombre_var)
print(mensaje)

# Operador lógico: Años con desempleo > 300 y empleo > 65
filtro_crisis <- (datos$Unemployed > 300) & (datos$Employed > 65)
cat("Cantidad de años que cumplen la condición:", sum(filtro_crisis), "\n")


# 3. Estructuras de Datos: Vectores, Factores, Matrices y Listas

# Vector numérico
desempleo_vec <- datos$Unemployed
media_desempleo <- mean(desempleo_vec)

# Factor ordinal (Categorización del PNB / GNP)
nivel_gnp <- ifelse(datos$GNP > mean(datos$GNP), "Alto", "Bajo")
gnp_factor <- factor(nivel_gnp, levels = c("Bajo", "Alto"), ordered = TRUE)
print(gnp_factor)

# Matriz 2x2 con métricas de resumen
matriz_stats <- matrix(
  c(mean(datos$GNP), sd(datos$GNP),
    mean(datos$Unemployed), sd(datos$Unemployed)),
  nrow = 2,
  byrow = TRUE,
  dimnames = list(c("GNP", "Unemployed"), c("Media", "Desvio"))
)
print(matriz_stats)


# 4. Control de Flujo: Condicionales y Bucles

# If...Else sobre el último año registrado
ultimo_desempleo <- tail(datos$Unemployed, 1)

if (ultimo_desempleo > 400) {
  estado_empleo <- "Alerta: Desempleo en niveles altos"
} else {
  estado_empleo <- "Nivel de desempleo bajo control"
}
print(estado_empleo)

# Bucle For: Cálculo de la variación porcentual interanual del GNP
variacion_gnp <- numeric(nrow(datos))

for (i in 2:nrow(datos)) {
  variacion_gnp[i] <- ((datos$GNP[i] - datos$GNP[i - 1]) / datos$GNP[i - 1]) * 100
}
datos$Crecimiento_GNP <- variacion_gnp

# Bucle While: Buscar el primer año donde el empleo alcanzó el umbral de 65
indice <- 1
while (indice <= nrow(datos)) {
  if (datos$Employed[indice] >= 65) {
    cat("Umbral de 65 alcanzado en la fila:", indice, "\n")
    break
  }
  indice <- indice + 1
}

# Lista heterogénea final
resultado_final <- list(
  tabla_datos = datos,
  matriz_resumen = matriz_stats,
  factor_categoria = gnp_factor
)
