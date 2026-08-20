# ==============================================================================
# R Y RSTUDIO PARA EL ANÁLISIS DE DATOS
# CLASE_02 · SCRIPT PRÁCTICO DEL ALUMNO
# DE ARCHIVO BRUTO A BASE ANALÍTICA · Importación, auditoría y limpieza
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
ruta_clase <- "D:/MIGUEL PAREDES  M.2/Desktop/DOCENCIA/RSTUDIO/RY-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS/RECURSOS PARA EL ALUMNO/CLASE_02"

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
# 0.1 PAQUETES DE LA CLASE
# ------------------------------------------------------------------------------
# Instalar no es lo mismo que cargar. Si ya están instalados, solo library().
paquetes <- c("tidyverse", "readxl", "haven")
faltantes <- paquetes[!paquetes %in% rownames(installed.packages())]
if (length(faltantes) > 0) install.packages(faltantes)

library(tidyverse)
library(readxl)
library(haven)

# ------------------------------------------------------------------------------
# 1. IMPORTAR NO ES "ABRIR": ES CREAR UN OBJETO EN MEMORIA
# ------------------------------------------------------------------------------
# El archivo original permanece en disco. R crea un objeto para trabajar con él.
empleo_csv <- read_csv(
  "datos/empleo_peru_bruto.csv",
  show_col_types = FALSE
)

# Confirma que ahora existe un objeto llamado empleo_csv.
class(empleo_csv)
dim(empleo_csv)

# ------------------------------------------------------------------------------
# 2. RUTAS RELATIVAS DENTRO DEL PROJECT
# ------------------------------------------------------------------------------
ruta_empleo <- "datos/empleo_peru_bruto.csv"
ruta_empleo
file.exists(ruta_empleo)

# La misma ruta funciona para cualquier alumno si todos conservan la estructura.

# ------------------------------------------------------------------------------
# 3. IMPORTAR CSV, EXCEL Y STATA
# ------------------------------------------------------------------------------
empleo_xlsx <- read_excel("datos/empleo_peru_bruto.xlsx")
empleo_dta  <- read_dta("datos/empleo_peru_bruto.dta")

# Comparación simple de dimensiones.
dim(empleo_csv)
dim(empleo_xlsx)
dim(empleo_dta)

# Compara nombres de variables.
names(empleo_csv)
names(empleo_xlsx)
names(empleo_dta)

# Para el resto de la sesión usaremos el CSV.
empleo <- empleo_csv

# ------------------------------------------------------------------------------
# 4. AUDITORÍA INICIAL: CONOCER ANTES DE TRANSFORMAR
# ------------------------------------------------------------------------------
head(empleo)
tail(empleo)
dim(empleo)
names(empleo)
glimpse(empleo)
summary(empleo)

# Faltantes por variable.
colSums(is.na(empleo))

# Categorías de variables de texto.
sort(unique(empleo$region))
sort(unique(empleo$sexo))
sort(unique(empleo$formal))
sort(unique(empleo$sector))


# ------------------------------------------------------------------------------
# 5. IDENTIFICADORES Y DUPLICADOS
# ------------------------------------------------------------------------------
# count() permite contar cuántas veces aparece cada id_persona.
duplicados_id <- empleo |>
  count(id_persona, name = "n") |>
  filter(n > 1)

duplicados_id

# Visualizamos las filas completas de IDs repetidos.
empleo |>
  filter(id_persona %in% duplicados_id$id_persona) |>
  arrange(id_persona)


# ------------------------------------------------------------------------------
# 6. TEXTO INCONSISTENTE Y ESTANDARIZACIÓN
# ------------------------------------------------------------------------------
sort(unique(empleo$region))

# Ensayo con una variable temporal.
region_prueba <- c("lima", "Lima ", "LIMA", "cusco")
region_prueba
str_trim(region_prueba)
str_to_title(str_trim(region_prueba))

# Importante: estandarizar texto evita que R trate "Lima" y "Lima " como categorías distintas.

# ------------------------------------------------------------------------------
# 7. EL PIPE |> : LEER UNA SECUENCIA DE TRANSFORMACIONES
# ------------------------------------------------------------------------------
# Sin pipe:
mean(empleo$ingreso_mensual, na.rm = TRUE)

# Con pipe para una secuencia legible:
empleo |>
  filter(sexo == "Mujer") |>
  summarise(ingreso_promedio = mean(ingreso_mensual, na.rm = TRUE))

# Se lee: "toma empleo, luego filtra mujeres, luego resume el ingreso promedio".

# ------------------------------------------------------------------------------
# 8. VERBOS FUNDAMENTALES DE dplyr
# ------------------------------------------------------------------------------
# select(): escoger columnas.
empleo |>
  select(id_persona, region, sexo, ingreso_mensual) |>
  head()

# filter(): escoger filas.
empleo |>
  filter(edad >= 30, ingreso_mensual > 2000) |>
  head()

# arrange(): ordenar filas.
empleo |>
  arrange(desc(ingreso_mensual)) |>
  head(10)

# mutate(): crear o transformar variables.
empleo |>
  mutate(ingreso_anual = ingreso_mensual * 12) |>
  select(id_persona, ingreso_mensual, ingreso_anual) |>
  head()

# rename(): cambiar nombres sin alterar los valores.
empleo |>
  rename(educacion = educacion_anios) |>
  names()

# distinct(): conservar observaciones únicas según una llave.
empleo |>
  distinct(id_persona, .keep_all = TRUE) |>
  nrow()

# ------------------------------------------------------------------------------
# 9. DEFINIR REGLAS DE CALIDAD ANTES DE LIMPIAR
# ------------------------------------------------------------------------------
# Comprobamos valores problemáticos deliberadamente.
empleo |>
  filter(edad < 18 | edad > 80)

empleo |>
  filter(!is.na(ingreso_mensual), ingreso_mensual <= 0)

# No se borra todavía: primero identificamos la regla, luego transformamos.

# ------------------------------------------------------------------------------
# 10. LIMPIEZA REPRODUCIBLE
# ------------------------------------------------------------------------------
# Conservamos empleo intacto y generamos otro objeto: empleo_limpio.
empleo_limpio <- empleo |>
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

# Auditoría después de limpiar.
dim(empleo_limpio)
sort(unique(empleo_limpio$region))
colSums(is.na(empleo_limpio))

# Comprobación de duplicados después de distinct().
empleo_limpio |>
  count(id_persona) |>
  filter(n > 1)

# ------------------------------------------------------------------------------
# 11. CREAR VARIABLES PARA EL ANÁLISIS
# ------------------------------------------------------------------------------
empleo_limpio <- empleo_limpio |>
  mutate(
    ingreso_anual = ingreso_mensual * 12,
    ln_ingreso = log(ingreso_mensual),
    mujer = if_else(sexo == "Mujer", 1, 0),
    formal_dummy = if_else(formal == "Si", 1, 0)
  )

empleo_limpio |>
  select(
    id_persona, sexo, ingreso_mensual, ingreso_anual,
    ln_ingreso, mujer, formal_dummy
  ) |>
  head()

# ------------------------------------------------------------------------------
# 12. GUARDAR UNA BASE PROCESADA SIN TOCAR LA BASE ORIGINAL
# ------------------------------------------------------------------------------
dir.create("datos_procesados", showWarnings = FALSE)

write_csv(
  empleo_limpio,
  "datos_procesados/empleo_limpio.csv"
)

file.exists("datos_procesados/empleo_limpio.csv")

# ------------------------------------------------------------------------------
# 13. EJERCICIOS DE LA SESIÓN 2
# ------------------------------------------------------------------------------
# EJERCICIO A
# 1. Identifica cuántos NA existen en cada variable.
# 2. Identifica los IDs duplicados.
# 3. Muestra todas las formas originales en las que aparece "Lima".

# EJERCICIO B
# Crea un objeto llamado empleo_seleccion con solo:
# id_persona, region, sexo, educacion_anios, ingreso_mensual y formal.
# Luego conserva solo personas con ingreso_mensual positivo.

# EJERCICIO C
# Crea una variable educacion_alta que sea 1 cuando educacion_anios >= 16 y 0 en caso contrario.

# Escribe tus soluciones debajo:


# FIN CLASE 02
