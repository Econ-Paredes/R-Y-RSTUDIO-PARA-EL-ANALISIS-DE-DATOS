# ==============================================================================
# R Y RSTUDIO PARA EL ANÁLISIS DE DATOS
# CLASE_03 · SCRIPT PRÁCTICO DEL ALUMNO
# CONVERTIR DATOS EN INFORMACIÓN · Descriptivos, joins, gráficos y correlación
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
ruta_clase <- "D:/MIGUEL PAREDES  M.2/Desktop/DOCENCIA/RSTUDIO/RY-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS/RECURSOS PARA EL ALUMNO/CLASE_03"

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
# 0.2 RECONSTRUIR LA BASE ANALÍTICA DE ESTA CLASE
# ------------------------------------------------------------------------------
# BUENA PRÁCTICA:
# Cada script de clase debe poder ejecutarse desde una sesión limpia.
# Por eso NO dependemos de que el objeto empleo_limpio siga en memoria desde
# la CLASE_02. Volvemos a partir del archivo bruto y reproducimos las reglas.

empleo <- read_csv(
  "datos/empleo_peru_bruto.csv",
  show_col_types = FALSE
)

empleo_limpio <- empleo |>
  distinct(id_persona, .keep_all = TRUE) |>
  mutate(
    region = str_to_title(str_trim(region)),
    edad = if_else(edad >= 18 & edad <= 80, edad, NA_real_),
    ingreso_mensual = if_else(
      is.na(ingreso_mensual) | ingreso_mensual <= 0,
      NA_real_,
      ingreso_mensual
    ),
    ingreso_anual = ingreso_mensual * 12,
    ln_ingreso = log(ingreso_mensual),
    mujer = if_else(sexo == "Mujer", 1, 0),
    formal_dummy = if_else(formal == "Si", 1, 0)
  )

# Comprobación rápida antes de iniciar los descriptivos.
dim(empleo_limpio)
colSums(is.na(empleo_limpio))

# ------------------------------------------------------------------------------
# 1. ¿POR QUÉ DESCRIBIR ANTES DE MODELAR?
# ------------------------------------------------------------------------------
# Una media o un gráfico puede revelar faltantes, extremos, asimetrías o grupos.
summary(empleo_limpio)

# ------------------------------------------------------------------------------
# 2. ESTADÍSTICOS DESCRIPTIVOS ESENCIALES
# ------------------------------------------------------------------------------
mean(empleo_limpio$ingreso_mensual, na.rm = TRUE)
median(empleo_limpio$ingreso_mensual, na.rm = TRUE)
sd(empleo_limpio$ingreso_mensual, na.rm = TRUE)
var(empleo_limpio$ingreso_mensual, na.rm = TRUE)
min(empleo_limpio$ingreso_mensual, na.rm = TRUE)
max(empleo_limpio$ingreso_mensual, na.rm = TRUE)
quantile(empleo_limpio$ingreso_mensual, na.rm = TRUE)

# Una tabla resumen en un solo objeto.
resumen_ingreso <- empleo_limpio |>
  summarise(
    n = n(),
    validos = sum(!is.na(ingreso_mensual)),
    media = mean(ingreso_mensual, na.rm = TRUE),
    mediana = median(ingreso_mensual, na.rm = TRUE),
    desviacion = sd(ingreso_mensual, na.rm = TRUE),
    minimo = min(ingreso_mensual, na.rm = TRUE),
    maximo = max(ingreso_mensual, na.rm = TRUE)
  )

resumen_ingreso

# ------------------------------------------------------------------------------
# 3. FRECUENCIAS Y PROPORCIONES
# ------------------------------------------------------------------------------
table(empleo_limpio$sexo)
prop.table(table(empleo_limpio$sexo))

# Con dplyr queda fácil guardar la tabla.
frecuencia_sector <- empleo_limpio |>
  count(sector, name = "n") |>
  mutate(porcentaje = 100 * n / sum(n)) |>
  arrange(desc(n))

frecuencia_sector

# ------------------------------------------------------------------------------
# 4. group_by() + summarise(): DE MICRODATOS A INDICADORES
# ------------------------------------------------------------------------------
# group_by() define grupos; summarise() reduce cada grupo a indicadores.
resumen_region <- empleo_limpio |>
  group_by(region) |>
  summarise(
    n = n(),
    ingreso_promedio = mean(ingreso_mensual, na.rm = TRUE),
    educacion_promedio = mean(educacion_anios, na.rm = TRUE),
    experiencia_promedio = mean(experiencia_anios, na.rm = TRUE),
    tasa_formalidad = mean(formal == "Si", na.rm = TRUE) * 100,
    .groups = "drop"
  ) |>
  arrange(desc(ingreso_promedio))

resumen_region

# Otro ejemplo: perfil por sexo y formalidad.
perfil_laboral <- empleo_limpio |>
  group_by(sexo, formal) |>
  summarise(
    n = n(),
    ingreso_promedio = mean(ingreso_mensual, na.rm = TRUE),
    educacion_promedio = mean(educacion_anios, na.rm = TRUE),
    .groups = "drop"
  )

perfil_laboral

# ------------------------------------------------------------------------------
# 5. LLAVES Y JOINS: UNIR INFORMACIÓN SIN PERDER CONTROL
# ------------------------------------------------------------------------------
contexto <- read_csv(
  "datos/contexto_regional_2025.csv",
  show_col_types = FALSE
)

head(contexto)

# Diagnóstico: ¿qué regiones del resumen no encuentran pareja en contexto?
anti_join(resumen_region, contexto, by = "region")

# Diagnóstico inverso: ¿qué regiones de contexto no aparecen en el resumen?
anti_join(contexto, resumen_region, by = "region")

# Unión principal.
base_regional <- resumen_region |>
  left_join(contexto, by = "region")

base_regional

# Revisa dimensiones antes y después del join.
dim(resumen_region)
dim(base_regional)

# ------------------------------------------------------------------------------
# 6. VISUALIZACIÓN CON ggplot2: DATOS + ESTÉTICA + GEOMETRÍA
# ------------------------------------------------------------------------------
# HISTOGRAMA: forma de una variable numérica.
ggplot(empleo_limpio, aes(x = ingreso_mensual)) +
  geom_histogram(bins = 20)

# BOXPLOT: distribución comparada entre grupos.
ggplot(empleo_limpio, aes(x = sexo, y = ingreso_mensual)) +
  geom_boxplot()

# DISPERSIÓN: relación visual entre dos variables numéricas.
ggplot(empleo_limpio, aes(x = educacion_anios, y = ingreso_mensual)) +
  geom_point()

# DISPERSIÓN + línea lineal descriptiva.
ggplot(empleo_limpio, aes(x = educacion_anios, y = ingreso_mensual)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

# BARRAS: frecuencia por categoría.
ggplot(empleo_limpio, aes(x = sector)) +
  geom_bar()

# ------------------------------------------------------------------------------
# 7. CORRELACIÓN: DIRECCIÓN E INTENSIDAD LINEAL
# ------------------------------------------------------------------------------
cor(
  empleo_limpio$educacion_anios,
  empleo_limpio$ingreso_mensual,
  use = "complete.obs"
)

# Matriz de correlaciones de tres variables.
vars_cor <- empleo_limpio |>
  select(ingreso_mensual, educacion_anios, experiencia_anios)

cor(vars_cor, use = "complete.obs")

# Regla: correlación no implica causalidad.

# ------------------------------------------------------------------------------
# 8. CONTEXTO REGIONAL: GRÁFICO DE EJEMPLO
# ------------------------------------------------------------------------------
ggplot(base_regional, aes(x = pobreza_pct, y = ingreso_promedio)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

# ------------------------------------------------------------------------------
# 9. EXPORTAR TABLAS Y GRÁFICOS
# ------------------------------------------------------------------------------
dir.create("resultados", showWarnings = FALSE)
dir.create("graficos", showWarnings = FALSE)

write_csv(resumen_region, "resultados/resumen_region.csv")
write_csv(base_regional, "resultados/base_regional.csv")

# Para guardar el último gráfico ejecutado puedes usar ggsave().
# ggsave("graficos/relacion_pobreza_ingreso.png", width = 8, height = 5)

# ------------------------------------------------------------------------------
# 10. EJERCICIOS DE LA SESIÓN 3
# ------------------------------------------------------------------------------
# EJERCICIO A
# Calcula ingreso promedio y educación promedio por region y sexo.
# Ordena el resultado desde el mayor ingreso promedio.

# EJERCICIO B
# Crea una tabla de frecuencias de formal y calcula porcentajes.

# EJERCICIO C
# Construye un gráfico ingreso_mensual vs experiencia_anios y añade una línea lm.

# RETO
# Antes de hacer left_join(), usa anti_join() y explica en un comentario qué revela.

# Escribe tus soluciones debajo:


# FIN CLASE 03
