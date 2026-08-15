# ==============================================================================
# R Y RSTUDIO PARA EL ANÁLISIS DE DATOS
# SCRIPT 00 · ANTES DE INICIAR: ENTORNO, CARPETA, PROJECT Y PAQUETES
# GEM / Beps Smart Research
# ==============================================================================
# Este archivo acompaña la sección "ANTES DE INICIAR" del manual.
# Su finalidad es comprobar empíricamente cómo R identifica el lugar de trabajo,
# cómo encuentra archivos y cómo se preparan los paquetes que usaremos.
#
# REGLA DEL CURSO:
# Carpeta raíz -> RStudio Project -> R Script -> datos -> análisis -> resultados.
# ==============================================================================

# ------------------------------------------------------------------------------
# 0.1 ¿DÓNDE ESTÁ TRABAJANDO R AHORA?
# ------------------------------------------------------------------------------
# getwd() significa "get working directory": devuelve el directorio de trabajo.
# Antes de cambiar una ruta, primero debes saber cuál es la ruta actual.
getwd()

# list.files() muestra los archivos y carpetas visibles desde ese directorio.
list.files()

# Prueba adicional: ¿R puede ver la carpeta "datos"?
file.exists("datos")

# Si devuelve TRUE, la estructura del proyecto está siendo reconocida.
# Si devuelve FALSE, revisa si abriste el archivo .Rproj desde la carpeta raíz.

# ------------------------------------------------------------------------------
# 0.2 DIRECCIONAR MANUALMENTE UNA CARPETA CON setwd()
# ------------------------------------------------------------------------------
# setwd() significa "set working directory": establece el directorio de trabajo.
# Se enseña para comprender la lógica de las rutas. En este curso preferimos
# después trabajar con un RStudio Project y rutas relativas.
#
# EJEMPLO WINDOWS - NO EJECUTES ESTA LÍNEA SIN CAMBIAR LA RUTA:
# setwd("D:/Curso_R_GEM")
#
# Después de usar setwd(), comprueba siempre:
# getwd()
# list.files()

# NOTA: en R se recomienda usar / en las rutas. Ejemplo:
# "D:/Documentos/Curso_R_GEM"
# Evita escribir una sola barra invertida como "D:\Curso" sin escaparla.

# ------------------------------------------------------------------------------
# 0.3 RUTAS ABSOLUTAS Y RUTAS RELATIVAS
# ------------------------------------------------------------------------------
# Ruta absoluta: contiene toda la ubicación del archivo en una computadora.
# Ejemplo conceptual:
# "D:/Curso_R_GEM/datos/empleo_peru_bruto.csv"
#
# Ruta relativa: parte de la carpeta raíz del proyecto.
# Ejemplo real del curso:
ruta_csv <- "datos/empleo_peru_bruto.csv"
ruta_csv
file.exists(ruta_csv)

# Buena práctica: una ruta relativa hace que el proyecto sea más portable.

# ------------------------------------------------------------------------------
# 0.4 COMENTARIOS: EL CÓDIGO DEBE EXPLICAR SU INTENCIÓN
# ------------------------------------------------------------------------------
# Todo lo que aparece después de # en una línea es un comentario.
# R no ejecuta los comentarios.

# Este objeto representa una tasa porcentual de ejemplo
# y no solo un número aislado.
tasa_ejemplo <- 2.5

tasa_ejemplo

# Prueba: escribe una línea completa precedida por # y ejecútala.
# 100 + 50
# No aparecerá ningún resultado porque R ignora esa línea.

# ------------------------------------------------------------------------------
# 0.5 PAQUETES: INSTALAR UNA VEZ, CARGAR EN CADA SESIÓN
# ------------------------------------------------------------------------------
# install.packages() descarga e instala paquetes en la computadora.
# library() carga un paquete ya instalado en la sesión actual.

paquetes_curso <- c("tidyverse", "readxl", "haven")

# Detectamos cuáles faltan antes de instalar.
paquetes_faltantes <- paquetes_curso[
  !paquetes_curso %in% rownames(installed.packages())
]

paquetes_faltantes

# Instala únicamente si realmente falta alguno.
if (length(paquetes_faltantes) > 0) {
  install.packages(paquetes_faltantes)
}

# Carga los paquetes que usaremos desde la sesión 2.
library(tidyverse)
library(readxl)
library(haven)

# ------------------------------------------------------------------------------
# 0.6 AYUDA DENTRO DE R
# ------------------------------------------------------------------------------
# El signo ? abre la documentación de una función.
# Ejecuta de uno en uno en RStudio:
# ?mean
# ?read.csv
# ?lm

# args() muestra los argumentos principales de una función.
args(mean)

# example() ejecuta ejemplos incluidos en la documentación.
# example(mean)

# ------------------------------------------------------------------------------
# 0.7 COMPROBACIÓN FINAL DEL ENTORNO
# ------------------------------------------------------------------------------
cat("Directorio actual:\n")
print(getwd())

cat("\n¿Existe la carpeta datos?\n")
print(file.exists("datos"))

cat("\nArchivos disponibles en datos/:\n")
if (dir.exists("datos")) print(list.files("datos"))

# FIN DEL SCRIPT 00
