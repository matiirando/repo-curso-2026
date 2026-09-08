install.packages(c("tidyverse", "palmerpenguins", "ggthemes"))
# ==============================================================================
# ECON 520 - Ciencia de Datos para Economía y Negocios
# Tarea 03 - Viz con tidyverse y ggplot2 (Capítulo 1)
# Alumno: Matias Rando
# Base utilizada: 'palmerpenguins'
# ==============================================================================

# 1. Carga de librerías
library(ggthemes)
library(tidyverse)
library(palmerpenguins)

# Vista previa de los datos
penguins
glimpse(penguins)

# ------------------------------------------------------------------------------
# Construcción paso a paso del gráfico principal
# ------------------------------------------------------------------------------

# Gráfico con estética completa y paleta apta para daltonismo
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", 
    y = "Body mass (g)",
    color = "Species", 
    shape = "Species"
  ) +
  scale_color_colorblind()

# ------------------------------------------------------------------------------
# Ejercicios resueltos (Capítulo 1)
# ------------------------------------------------------------------------------

# Ejercicio 1: Filas y columnas del dataset
dim(penguins) # 344 filas, 8 columnas

# Ejercicio 2: Descripción de bill_depth_mm
?penguins # Profundidad del pico en milímetros (medida vertical)

# Ejercicio 3: Scatterplot de bill_length_mm vs bill_depth_mm por especie
ggplot(
  data = penguins, 
  mapping = aes(x = bill_length_mm, y = bill_depth_mm, color = species)
) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

# Ejercicio 4: Gráfico de species vs bill_depth_mm (Boxplot y Densidad)
ggplot(data = penguins, mapping = aes(x = species, y = bill_depth_mm)) +
  geom_boxplot()

ggplot(penguins, aes(x = body_mass_g, color = species)) +
  geom_density(linewidth = 0.75)

# Ejercicio 5: Requisito de geom_point()
# Exige mapear dos variables continuas en los ejes x e y.

# Ejercicio 6: Eliminación silenciosa de valores faltantes (NA)
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(na.rm = TRUE)

# Ejercicio 7: Agregar nota al pie (caption)
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(na.rm = TRUE) +
  labs(caption = "Data come from the palmerpenguins package.")

# Ejercicio 8: Mapear color localmente a una variable continua
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = bill_depth_mm)) +
  geom_smooth()

# Ejercicio 9: Tendencia por grupos (Isla)
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE)

# Ejercicio 10: Comparación de herencia de datos
# Ambos gráficos son idénticos porque geom_point() y geom_smooth() heredan los argumentos de ggplot()


# ------------------------------------------------------------------------------
# Ejercicios resueltos (Sección 1.4.3)
# ------------------------------------------------------------------------------

# Ejercicio 1: Gráfico de barras horizontal asignando species al eje Y
ggplot(penguins, aes(y = species)) +
  geom_bar()
# Respuesta: El gráfico queda orientado horizontalmente en lugar de vertical.

# Ejercicio 2: Diferencia entre color y fill en gráficos de barras
ggplot(penguins, aes(x = species)) + geom_bar(color = "red")
ggplot(penguins, aes(x = species)) + geom_bar(fill = "red")
# Respuesta: 'color' cambia solo el borde de las barras, mientras que 'fill'
# rellena el interior. Para barras, 'fill' es más útil.

# Ejercicio 3: ¿Qué hace el argumento 'bins' en geom_histogram()?
# Respuesta: Define la cantidad total de intervalos/barras en los que se divide 
# el rango de la variable continua.

# Ejercicio 4: Histograma de la variable 'carat' en el dataset 'diamonds'
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.01)
# Respuesta: Un binwidth pequeño (como 0.01) revela picos en valores redondos 
# de quilates (0.3, 0.5, 0.7, 1.0, etc.), reflejando patrones comerciales.

# ------------------------------------------------------------------------------
# Sección 1.5.5 Exercises
# ------------------------------------------------------------------------------

# Ejercicio 1: Variables categóricas y numéricas en 'mpg'
?mpg
glimpse(mpg)
# Categóricas: manufacturer, model, trans, drv, fl, class
# Numéricas: displ, year, cyl, cty, hwy

# Ejercicio 2: Mapeo de variables continuas vs categóricas a estéticas
ggplot(mpg, aes(x = displ, y = hwy, color = cty)) + geom_point()
ggplot(mpg, aes(x = displ, y = hwy, size = cty)) + geom_point()
ggplot(mpg, aes(x = displ, y = hwy, color = cty, size = cty)) + geom_point()
# Nota: mapear una variable continua a 'shape' genera error en ggplot2.

# Ejercicio 3: Mapear variable continua a 'linewidth'
ggplot(mpg, aes(x = displ, y = hwy, linewidth = cty)) + geom_point()
# Respuesta: 'linewidth' afecta líneas, no puntos.

# Ejercicio 4: Mapear la misma variable a múltiples estéticas
ggplot(mpg, aes(x = displ, y = hwy, color = cty, size = cty)) + geom_point()
# Respuesta: Combina las estéticas en la visualización y en la leyenda.

# Ejercicio 5: Scatterplot de bill_depth_mm vs bill_length_mm con color y facet por species
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point() +
  facet_wrap(~species)

# Ejercicio 6: Corrección de dos leyendas separadas (igualar nombres en labs)
ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm,
    color = species, shape = species
  )
) +
  geom_point() +
  labs(color = "Species", shape = "Species") # Ambos deben coincidir para unificar la leyenda

# Ejercicio 7: Gráficos de barras apiladas proporcionales (position = "fill")
# Gráfico A: Proporción de especies en cada isla
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

# Gráfico B: Proporción de distribución de cada especie por isla
ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill")