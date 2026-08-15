# SESIÓN 5 · DEL DATO BRUTO A UNA PRIMERA REGRESIÓN
library(tidyverse)

empleo <- read_csv("datos/empleo_peru_bruto.csv", show_col_types = FALSE)

base_modelo <- empleo |>
  distinct(id_persona, .keep_all = TRUE) |>
  mutate(
    region = str_to_title(str_trim(region)),
    edad = if_else(edad >= 18 & edad <= 80, edad, NA_real_),
    ingreso_mensual = if_else(ingreso_mensual > 0, ingreso_mensual, NA_real_),
    ln_ingreso = log(ingreso_mensual),
    experiencia2 = experiencia_anios^2,
    sexo = factor(sexo),
    formal = factor(formal)
  ) |>
  drop_na(ln_ingreso, educacion_anios, experiencia_anios, sexo, formal)

# Modelo didáctico
modelo <- lm(
  ln_ingreso ~ educacion_anios + experiencia_anios + experiencia2 + sexo + formal,
  data = base_modelo
)
summary(modelo)
coef(modelo)
residuals(modelo)
fitted(modelo)

# Diagnóstico visual introductorio
par(mfrow = c(2, 2))
plot(modelo)
par(mfrow = c(1, 1))

# Nota: esta sesión es un puente hacia Econometría con R.
# La interpretación inferencial completa corresponde al curso siguiente.
