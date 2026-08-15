# SESIÓN 3 · CONVERTIR DATOS EN INFORMACIÓN
library(tidyverse)

empleo <- read_csv("datos/empleo_peru_bruto.csv", show_col_types = FALSE)
empleo_limpio <- empleo |>
  distinct(id_persona, .keep_all = TRUE) |>
  mutate(
    region = str_to_title(str_trim(region)),
    edad = if_else(edad >= 18 & edad <= 80, edad, NA_real_),
    ingreso_mensual = if_else(ingreso_mensual > 0, ingreso_mensual, NA_real_)
  )

# Descriptivos
mean(empleo_limpio$ingreso_mensual, na.rm = TRUE)
median(empleo_limpio$ingreso_mensual, na.rm = TRUE)
sd(empleo_limpio$ingreso_mensual, na.rm = TRUE)

# Resumen regional
resumen_region <- empleo_limpio |>
  group_by(region) |>
  summarise(
    n = n(),
    ingreso_promedio = mean(ingreso_mensual, na.rm = TRUE),
    educacion_promedio = mean(educacion_anios, na.rm = TRUE),
    formalidad_pct = mean(formal == "Si", na.rm = TRUE) * 100,
    .groups = "drop"
  )

contexto <- read_csv("datos/contexto_regional_2025.csv", show_col_types = FALSE)
base_regional <- resumen_region |> left_join(contexto, by = "region")

# Diagnóstico del join
anti_join(resumen_region, contexto, by = "region")

# Gráfico
ggplot(empleo_limpio, aes(x = educacion_anios, y = ingreso_mensual)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)
