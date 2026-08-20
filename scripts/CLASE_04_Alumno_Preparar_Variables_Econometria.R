# ==============================================================================
# R Y RSTUDIO PARA EL ANÁLISIS DE DATOS
# CLASE_04 · SCRIPT PRÁCTICO DEL ALUMNO
# PREPARAR VARIABLES PARA ECONOMETRÍA · Transformaciones, panel y fórmulas
# GEM / Beps Smart Research
# ==============================================================================
# Este script acompaña la parte teórica del Manual Práctico del curso.
# Ejecuta los bloques en orden. Los comentarios identifican cada etapa y
# aclaran únicamente lo necesario para ejecutar y comprender el código.
# ==============================================================================

# ------------------------------------------------------------------------------
# 0. CARPETA DE TRABAJO DE ESTA CLASE
# ------------------------------------------------------------------------------
# Antes de cambiar cualquier ruta, revisa dónde está trabajando R.
getwd()

# En esta clase se trabajará desde una carpeta específica de la sesión.
# En Windows, dentro de R usa / en la ruta para evitar problemas con \.
ruta_clase <- "D:/MIGUEL PAREDES  M.2/Desktop/DOCENCIA/RSTUDIO/RY-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS/RECURSOS PARA EL ALUMNO/CLASE_04"

# IMPORTANTE PARA EL ALUMNO:
# Si guardaste el curso en otra ubicación, modifica SOLO la línea anterior.
# No cambies todas las rutas del script una por una.

# Comprueba que la carpeta exista antes de direccionar el trabajo.
dir.exists(ruta_clase)

if (!dir.exists(ruta_clase)) {
  stop(
    paste0(
      "No se encontró la carpeta de trabajo: ", ruta_clase,
      "\nModifica el objeto ruta_clase con la ubicación real en tu computadora."
    )
  )
}

# setwd() fija el directorio de trabajo para esta sesión.
setwd(ruta_clase)

# Comprueba que R quedó exactamente en la carpeta de la clase.
getwd()
list.files()

# En cada CLASE_XX conservamos los archivos de datos dentro de datos/.
# De este modo, el resto del script utiliza rutas relativas y legibles.
if (!dir.exists("datos")) {
  stop("No existe la subcarpeta 'datos' dentro de la carpeta de esta clase.")
}
list.files("datos")

# Secuencia de trabajo con el directorio:
# 1) revisar getwd(); 2) definir la carpeta; 3) usar setwd();
# 4) comprobar; 5) desde allí trabajar con rutas relativas.
# En proyectos más grandes, un archivo .Rproj permite automatizar esta lógica.

# ------------------------------------------------------------------------------
# 0.1 PAQUETE DE LA CLASE
# ------------------------------------------------------------------------------
if (!"tidyverse" %in% rownames(installed.packages())) install.packages("tidyverse")
library(tidyverse)


# ------------------------------------------------------------------------------
# 0.2 PREPARAR LA BASE DE TRABAJO DE ESTA CLASE
# ------------------------------------------------------------------------------
# Esta clase debe funcionar desde una sesión limpia. Reconstruimos
# una base analítica a partir del archivo bruto antes de transformar variables.

empleo <- read_csv(
  "datos/empleo_peru_bruto.csv",
  show_col_types = FALSE
)

base <- empleo |>
  distinct(id_persona, .keep_all = TRUE) |>
  mutate(
    region = str_to_title(str_trim(region)),
    edad = if_else(edad >= 18 & edad <= 80, edad, NA_real_),
    ingreso_mensual = if_else(
      is.na(ingreso_mensual) | ingreso_mensual <= 0,
      NA_real_,
      ingreso_mensual
    )
  )

# Comprobación rápida:
dim(base)
summary(base$ingreso_mensual)

# ------------------------------------------------------------------------------
# 1. TRANSFORMAR UNA VARIABLE REQUIERE UNA RAZÓN
# ------------------------------------------------------------------------------
# Primero inspecciona la variable original.
summary(base$ingreso_mensual)


# ------------------------------------------------------------------------------
# 2. LOGARITMOS
# ------------------------------------------------------------------------------
# log() solo es directamente utilizable con valores positivos.
base |>
  summarise(
    minimo_ingreso = min(ingreso_mensual, na.rm = TRUE),
    no_positivos = sum(ingreso_mensual <= 0, na.rm = TRUE)
  )

base <- base |>
  mutate(
    ln_ingreso = log(ingreso_mensual)
  )

summary(base$ln_ingreso)

# Compara gráficamente escalas.
ggplot(base, aes(x = ingreso_mensual)) + geom_histogram(bins = 20)
ggplot(base, aes(x = ln_ingreso)) + geom_histogram(bins = 20)

# ------------------------------------------------------------------------------
# 3. VARIABLES DUMMY
# ------------------------------------------------------------------------------
# Una dummy toma típicamente 1 si se cumple una condición y 0 si no.
base <- base |>
  mutate(
    mujer = if_else(sexo == "Mujer", 1, 0),
    formal_dummy = if_else(formal == "Si", 1, 0),
    educacion_alta = if_else(educacion_anios >= 16, 1, 0)
  )

# Comprueba la codificación.
table(base$sexo, base$mujer)
table(base$formal, base$formal_dummy)

# ------------------------------------------------------------------------------
# 4. TÉRMINOS CUADRÁTICOS
# ------------------------------------------------------------------------------
# Se utilizan cuando una relación puede ser no lineal.
base <- base |>
  mutate(
    experiencia2 = experiencia_anios^2
  )

base |>
  select(experiencia_anios, experiencia2) |>
  head()

# ------------------------------------------------------------------------------
# 5. FACTORES Y CATEGORÍA DE REFERENCIA
# ------------------------------------------------------------------------------
base <- base |>
  mutate(
    sexo_factor = factor(sexo),
    formal_factor = factor(formal),
    sector_factor = factor(sector)
  )

levels(base$sexo_factor)
levels(base$formal_factor)
levels(base$sector_factor)

# Elegimos explícitamente una categoría de referencia.
base$sexo_factor <- relevel(base$sexo_factor, ref = "Hombre")
base$formal_factor <- relevel(base$formal_factor, ref = "No")

levels(base$sexo_factor)
levels(base$formal_factor)

# ------------------------------------------------------------------------------
# 6. INTERACCIONES: CUANDO UNA RELACIÓN DEPENDE DE OTRA VARIABLE
# ------------------------------------------------------------------------------
# Creamos una interacción explícita como variable para observar su lógica.
base <- base |>
  mutate(
    educacion_mujer = educacion_anios * mujer
  )

base |>
  select(educacion_anios, mujer, educacion_mujer) |>
  head(10)

# En una fórmula de modelo, x * z incluye x, z y la interacción x:z.
formula_interaccion <- ln_ingreso ~ educacion_anios * sexo_factor
formula_interaccion

# ------------------------------------------------------------------------------
# 7. ¿QUÉ ES UNA BASE DE PANEL?
# ------------------------------------------------------------------------------
panel <- read_csv(
  "datos/panel_regional_2022_2025.csv",
  show_col_types = FALSE
)

head(panel)
dim(panel)

# En este panel una fila se identifica por region + anio.
panel |>
  count(region, anio) |>
  filter(n > 1)

# ¿Cuántos periodos tiene cada región?
panel |>
  count(region, name = "periodos") |>
  arrange(periodos)

# ------------------------------------------------------------------------------
# 8. ORDEN, REZAGOS Y DIFERENCIAS
# ------------------------------------------------------------------------------
# Un rezago solo tiene sentido si el panel está correctamente ordenado.
panel_transformado <- panel |>
  arrange(region, anio) |>
  group_by(region) |>
  mutate(
    inversion_lag1 = lag(inversion_publica_pc),
    pobreza_lag1 = lag(pobreza_pct),
    delta_pobreza = pobreza_pct - lag(pobreza_pct),
    delta_ingreso = ingreso_pc - lag(ingreso_pc)
  ) |>
  ungroup()

panel_transformado |>
  filter(region == "Lima") |>
  select(
    region, anio, pobreza_pct, pobreza_lag1, delta_pobreza,
    ingreso_pc, delta_ingreso
  )


# ------------------------------------------------------------------------------
# 9. FÓRMULAS DE MODELO EN R
# ------------------------------------------------------------------------------
# La sintaxis y ~ x se lee: modelar y como función de x.
f1 <- ln_ingreso ~ educacion_anios
f2 <- ln_ingreso ~ educacion_anios + experiencia_anios
f3 <- ln_ingreso ~ educacion_anios + experiencia_anios + experiencia2 + sexo_factor
f4 <- ln_ingreso ~ educacion_anios * sexo_factor

f1
f2
f3
f4

# I() permite introducir una operación aritmética dentro de la fórmula.
f5 <- ln_ingreso ~ educacion_anios + experiencia_anios + I(experiencia_anios^2)
f5

# ------------------------------------------------------------------------------
# 10. EJERCICIOS DE LA SESIÓN 4
# ------------------------------------------------------------------------------
# EJERCICIO A
# En base crea:
# - ln_ingreso,
# - experiencia2,
# - mujer,
# - formal_dummy.
# Comprueba su estructura con select() + head().

# EJERCICIO B
# En panel_transformado comprueba que el primer año de cada región tenga NA en lag().

# EJERCICIO C
# Escribe una fórmula con ln_ingreso como dependiente y como explicativas:
# educacion_anios, experiencia_anios, experiencia2, sexo_factor y formal_factor.

# RETO
# Explica en un comentario por qué calcular lag(inversion_publica_pc) sin agrupar por region
# podría mezclar el último año de una región con el primer año de la siguiente.

# Escribe tus respuestas debajo:


# FIN CLASE 04
