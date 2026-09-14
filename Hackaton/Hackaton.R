library(tidyverse)

Viajesanuales<- read_csv("data/Viajesanuales.csv")

glimpse(Viajesanuales)

ggplot(Viajesanuales, aes(x = Año, y = `Total año`)) +
  geom_line() +
  geom_point()

ggplot(Viajesanuales, aes(x = Año, y = `Total año`)) +
  geom_line(linewidth = 1) +
  geom_point(size = 3) +
  labs(
    title = "Evolución del uso de bicicletas en CABA (2013-2024)",
    x = "Año",
    y = "Total anual"
  ) +
  theme_minimal()

Viajes_turno <- Viajesanuales |>
  pivot_longer(
    cols = c(Mañana, Tarde),
    names_to = "Turno",
    values_to = "Cantidad"
  )

View(Viajes_turno)

ggplot(
  Viajes_turno,
  aes(x = Año, y = Cantidad, color = Turno)
) +
  geom_line(linewidth = 1) +
  geom_point(size = 3) +
  labs(
    title = "Evolución del uso de bicicletas en CABA (2013-2024)",
    subtitle = "Comparación entre los turnos mañana y tarde",
    x = "Año",
    y = "Cantidad",
    color = "Turno"
  ) +
  theme_minimal()

Viajes_turno |>
  group_by(Turno) |>
  slice_max(Cantidad, n = 1)

ggplot(
  Viajes_turno,
  aes(x = Año, y = Cantidad, color = Turno)
) +
  geom_line(linewidth = 1) +
  geom_point(size = 3) +
  geom_vline(
    xintercept = 2020,
    linetype = "dashed"
  ) + scale_x_continuous(
    breaks = 2013:2024
  ) +
  labs(
    title = "El volumen de ciclistas alcanzó su máximo en 2020",
    subtitle = "Entre 2020 y 2024, el total registrado cayó aproximadamente un 50%",
    x = "Año",
    y = "Cantidad de ciclistas",
    color = "Turno",
    caption = "Fuente: Buenos Aires Data"
  ) +
  theme_minimal()

Viajes_turno <- Viajesanuales |>
  filter(Año <= 2023) |>
  pivot_longer(
    cols = c(Mañana, Tarde),
    names_to = "Turno",
    values_to = "Cantidad"
  )

ggplot(
  Viajes_turno,
  aes(x = Año, y = Cantidad, color = Turno)
) +
  geom_line(linewidth = 1) +
  geom_point(size = 3) +
  geom_vline(
    xintercept = 2020,
    linetype = "dashed"
  ) +
  scale_x_continuous(
    breaks = 2013:2023
  ) +
  labs(
    title = "El volumen de ciclistas alcanzó su máximo en 2020",
    subtitle = "Evolución del volumen de ciclistas en CABA entre 2013 y 2023",
    x = "Año",
    y = "Cantidad de ciclistas",
    color = "Turno",
    caption = "Fuente: Buenos Aires Data"
  ) +
  theme_minimal()