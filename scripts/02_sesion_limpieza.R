# SESIÓN 2 · DE ARCHIVO BRUTO A BASE ANALÍTICA
library(tidyverse)
library(readxl)
library(haven)

# Importación
empleo <- read_csv("datos/empleo_peru_bruto.csv", show_col_types = FALSE)
empleo_xlsx <- read_excel("datos/empleo_peru_bruto.xlsx")
empleo_dta <- read_dta("datos/empleo_peru_bruto.dta")

# Auditoría
head(empleo)
dim(empleo)
glimpse(empleo)
summary(empleo)
colSums(is.na(empleo))

# Duplicados
empleo |> count(id_persona) |> filter(n > 1)

# Categorías inconsistentes
sort(unique(empleo$region))

# Limpieza reproducible
empleo_limpio <- empleo |>
  distinct(id_persona, .keep_all = TRUE) |>
  mutate(
    region = str_to_title(str_trim(region)),
    edad = if_else(edad >= 18 & edad <= 80, edad, NA_real_),
    ingreso_mensual = if_else(ingreso_mensual > 0, ingreso_mensual, NA_real_)
  )

# Variables nuevas
empleo_limpio <- empleo_limpio |>
  mutate(
    ingreso_anual = ingreso_mensual * 12,
    ln_ingreso = log(ingreso_mensual),
    mujer = if_else(sexo == "Mujer", 1, 0),
    formal_dummy = if_else(formal == "Si", 1, 0)
  )

# EJERCICIO
# Comprueba que ya no existan identificadores duplicados.
