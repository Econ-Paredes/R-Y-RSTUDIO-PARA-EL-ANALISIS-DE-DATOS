# SESIÓN 4 · PREPARAR VARIABLES PARA ECONOMETRÍA
library(tidyverse)

panel <- read_csv("datos/panel_regional_2022_2025.csv", show_col_types = FALSE)

# Comprobar estructura región-año
panel |> count(region, anio) |> filter(n > 1)

# Transformaciones
panel_modelo <- panel |>
  arrange(region, anio) |>
  group_by(region) |>
  mutate(
    ln_ingreso = log(ingreso_pc),
    inversion_lag = lag(inversion_pc),
    delta_pobreza = pobreza_pct - lag(pobreza_pct)
  ) |>
  ungroup()

# Inspección
head(panel_modelo, 12)

# Preguntas para el alumno
# ¿Por qué el primer año de cada región tiene NA en inversion_lag?
# ¿Qué representa delta_pobreza?
