# ============================================================
# SESIÓN 0 · CONFIGURACIÓN DEL ENTORNO
# GEM / Beps Smart Research
# ============================================================

# 1. Comprueba dónde estás trabajando
getwd()
list.files()

# 2. Instala paquetes SOLO si todavía no los tienes
paquetes <- c("tidyverse", "readxl", "haven")
faltantes <- paquetes[!paquetes %in% rownames(installed.packages())]
if (length(faltantes) > 0) install.packages(faltantes)

# 3. Carga paquetes en la sesión actual
library(tidyverse)
library(readxl)
library(haven)

# 4. Verifica que la carpeta de datos sea visible
list.files("datos")

# Si la instrucción anterior falla, revisa que hayas abierto RStudio
# desde la carpeta raíz del curso o desde un RStudio Project.
