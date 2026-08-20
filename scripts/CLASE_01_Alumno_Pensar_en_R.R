# ==============================================================================
# R Y RSTUDIO PARA EL ANÁLISIS DE DATOS
# CLASE_01 · SCRIPT PRÁCTICO DEL ALUMNO
# PENSAR EN R · Entorno, objetos, funciones, tipos, vectores, NA y data frames
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
ruta_clase <- "D:/MIGUEL PAREDES  M.2/Desktop/DOCENCIA/RSTUDIO/RY-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS/RECURSOS PARA EL ALUMNO/CLASE_01"

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
# 0.1 PAQUETES: INSTALAR UNA VEZ, CARGAR CUANDO SE NECESITAN
# ------------------------------------------------------------------------------
# Un paquete amplía las funciones disponibles en R.
# install.packages() instala; library() carga el paquete en la sesión actual.
paquetes_curso <- c("tidyverse", "readxl", "haven")
paquetes_faltantes <- paquetes_curso[
  !paquetes_curso %in% rownames(installed.packages())
]

paquetes_faltantes

# Solo se instalarán paquetes que realmente falten.
if (length(paquetes_faltantes) > 0) {
  install.packages(paquetes_faltantes)
}

# En esta primera sesión cargamos tidyverse para tener disponible read_csv()
# en el ejercicio de cierre; readxl y haven se usarán desde la clase 2.
library(tidyverse)

# ------------------------------------------------------------------------------
# 0.2 COMENTARIOS: DOCUMENTAR LA INTENCIÓN DEL CÓDIGO
# ------------------------------------------------------------------------------
# Todo lo escrito después de # es un comentario y R no lo ejecuta.
# Un buen comentario explica una finalidad o decisión, no repite el comando.

# Ejemplo débil:
# multiplicar por 12
# ingreso_anual <- ingreso_mensual * 12

# Ejemplo mejor:
# Convertir ingreso mensual a ingreso anual para construir el indicador anual.
ingreso_mensual_ejemplo <- 2500
ingreso_anual_ejemplo <- ingreso_mensual_ejemplo * 12
ingreso_anual_ejemplo

# ------------------------------------------------------------------------------
# 0.3 AYUDA DENTRO DE R
# ------------------------------------------------------------------------------
# Consulta la documentación de una función cuando necesites revisar sus argumentos.
# ?mean
args(mean)
# example(mean)

# ------------------------------------------------------------------------------
# 1. LA LÓGICA BÁSICA DE PROGRAMACIÓN: ENTRADA -> TRANSFORMACIÓN -> SALIDA
# ------------------------------------------------------------------------------
# En R normalmente:
# 1) entra un dato u objeto,
# 2) una función u operación lo transforma,
# 3) se obtiene un nuevo resultado.

# ENTRADA
ventas <- c(1200, 1450, 1800, 2100)

# TRANSFORMACIÓN
ventas_con_igv <- ventas * 1.18

# SALIDA
ventas_con_igv


# ------------------------------------------------------------------------------
# 2. DATO, OBJETO, EXPRESIÓN, FUNCIÓN, SCRIPT Y RESULTADO
# ------------------------------------------------------------------------------
# DATO: información concreta. Puede ser número, texto o condición lógica.
35
"Lima"
TRUE

# OBJETO: estructura que R mantiene en memoria y a la que damos un nombre.
edad <- 35
region <- "Lima"
formal <- TRUE

edad
region
formal

# EXPRESIÓN: instrucción que R interpreta y evalúa.
edad + 5
edad >= 18

# FUNCIÓN: operación reutilizable que recibe argumentos y devuelve un resultado.
mean(c(1200, 1500, 1800))
round(3.14159, digits = 2)

# SCRIPT: este mismo archivo .R es un script.
# Su valor está en conservar instrucciones, comentarios y orden de ejecución.

# RESULTADO: el producto de una operación puede volver a guardarse como objeto.
promedio_ingreso <- mean(c(1200, 1500, 1800))
promedio_ingreso


# ------------------------------------------------------------------------------
# 3. R DISTINGUE MAYÚSCULAS Y MINÚSCULAS (CASE SENSITIVE)
# ------------------------------------------------------------------------------
# Estos tres nombres son distintos para R.
ingreso <- 1000
Ingreso <- 2000
INGRESO <- 3000

ingreso
Ingreso
INGRESO

# Compruébalo también con exists():
exists("ingreso")
exists("Ingreso")
exists("INGRESO")

# Ensayo: crea objeto <- 1 y luego intenta escribir Objeto.
# ¿R los reconoce como el mismo nombre?

# ------------------------------------------------------------------------------
# 4. ASIGNACIÓN: EL OPERADOR <-
# ------------------------------------------------------------------------------
# <- se lee "asignar a".
x <- 10
y <- 25

x
y
x + y

# Buena práctica: usa nombres que expliquen la información almacenada.
ingreso_mensual <- 2500
experiencia_anios <- 7

# Evita nombres ambiguos como a, b, dato1 cuando el análisis real puede crecer.

# ------------------------------------------------------------------------------
# 5. NOMBRES DE OBJETOS: REGLAS BÁSICAS
# ------------------------------------------------------------------------------
# Buenos nombres:
precio_neto <- 15.50
ventas_2026 <- 120000
region_origen <- "Cusco"

# Ejemplos que NO debes ejecutar porque generan error de sintaxis:
# 2026_ventas <- 100
# ingreso mensual <- 2500

# Recomendación: usa snake_case.
ingreso_familiar_pc <- 980.5

# ------------------------------------------------------------------------------
# 6. SÍMBOLOS Y OPERADORES QUE DEBES RECONOCER
# ------------------------------------------------------------------------------
# Aritmética
10 + 5
10 - 5
10 * 5
10 / 5
10^2

# Comparaciones: devuelven TRUE o FALSE.
edad == 35
edad != 35
edad > 30
edad <= 40

# Operadores lógicos.
formal & edad >= 18
formal | edad < 18
!formal

# Nota crítica:
# = o <- se usan para asignar en ciertos contextos.
# == se usa para comparar igualdad.

# ------------------------------------------------------------------------------
# 7. OPERACIONES Y FUNCIONES
# ------------------------------------------------------------------------------
# Una función se reconoce porque usa paréntesis.
sqrt(144)
log(100)
round(3.14159, digits = 3)

# La función puede recibir uno o varios argumentos.
round(x = 3.14159, digits = 2)

# Revisa la ayuda y los argumentos:
args(round)

# ------------------------------------------------------------------------------
# 8. TIPOS DE DATOS BÁSICOS
# ------------------------------------------------------------------------------
numero <- 1250.50
entero <- 25L
texto <- "Arequipa"
logico <- FALSE
categoria <- factor(c("Bajo", "Medio", "Alto"))
fecha <- as.Date("2026-08-14")

class(numero)
class(entero)
class(texto)
class(logico)
class(categoria)
class(fecha)

# typeof() permite inspeccionar una representación más interna.
typeof(numero)
typeof(texto)
typeof(logico)

# Conversión explícita de tipos.
as.character(numero)
as.numeric("1500")

# ------------------------------------------------------------------------------
# 9. VECTORES: UNA COLUMNA DE VALORES
# ------------------------------------------------------------------------------
ingreso <- c(1250, 1800, 2300, 950, 3200, 2700, 1600, 4100, NA)

ingreso
length(ingreso)
class(ingreso)

# Selección por posición.
ingreso[1]
ingreso[2:5]
ingreso[c(1, 3, 5)]

# Excluir una posición.
ingreso[-1]

# ------------------------------------------------------------------------------
# 10. CONDICIONES LÓGICAS: LA BASE DE LOS FILTROS
# ------------------------------------------------------------------------------
condicion_mayor_2000 <- ingreso > 2000
condicion_mayor_2000

# Usamos la condición dentro de [] para conservar los TRUE.
ingreso[ingreso > 2000]

# Combinación de condiciones.
ingreso[ingreso >= 1500 & ingreso <= 3000]

# Observa que NA puede propagarse porque no conocemos si cumple la condición.

# ------------------------------------------------------------------------------
# 11. NA: DATO FALTANTE
# ------------------------------------------------------------------------------
is.na(ingreso)
sum(is.na(ingreso))

# Este promedio devuelve NA porque existe al menos un dato faltante.
mean(ingreso)

# na.rm = TRUE indica que la función debe retirar los NA para ese cálculo.
mean(ingreso, na.rm = TRUE)
median(ingreso, na.rm = TRUE)
max(ingreso, na.rm = TRUE)

# Regla: NA no es cero. No reemplaces un NA por 0 sin justificación analítica.

# ------------------------------------------------------------------------------
# 12. DATA FRAME: LA ESTRUCTURA CENTRAL DEL ANÁLISIS
# ------------------------------------------------------------------------------
trabajadores <- data.frame(
  id = 1:8,
  sexo = c("Mujer", "Hombre", "Hombre", "Mujer", "Mujer", "Hombre", "Mujer", "Hombre"),
  edad = c(22, 28, 35, 41, 30, 50, 26, 38),
  educacion = c(12, 16, 14, 11, 18, 12, 16, 14),
  ingreso = c(1250, 1800, 2300, 950, 3200, 2700, 1600, 4100)
)

trabajadores
head(trabajadores)
dim(trabajadores)
nrow(trabajadores)
ncol(trabajadores)
names(trabajadores)
str(trabajadores)
summary(trabajadores)

# View(trabajadores)  # Descomenta en RStudio para abrir el visor tabular.

# ------------------------------------------------------------------------------
# 13. SELECCIÓN DE FILAS Y COLUMNAS
# ------------------------------------------------------------------------------
# Una columna por nombre.
trabajadores$ingreso
trabajadores[["ingreso"]]

# Filas y columnas mediante [fila, columna].
trabajadores[1, ]
trabajadores[, 2]
trabajadores[1:3, c("sexo", "ingreso")]

# Filtro lógico de filas.
trabajadores[trabajadores$ingreso > 2000, ]
trabajadores[trabajadores$sexo == "Mujer", ]

# ------------------------------------------------------------------------------
# 14. MATRICES: PUENTE CONCEPTUAL HACIA ECONOMETRÍA
# ------------------------------------------------------------------------------
X <- matrix(c(1, 1, 1, 2, 4, 6), nrow = 3, ncol = 2)
y <- matrix(c(10, 20, 30), ncol = 1)

X
y

dim(X)
t(X)

# Multiplicación matricial: %*%
t(X) %*% X

# ------------------------------------------------------------------------------
# 15. EJERCICIOS GUIADOS DE LA SESIÓN 1
# ------------------------------------------------------------------------------
# EJERCICIO A
# 1. Calcula media, mediana, mínimo y máximo de ingreso ignorando NA.
# 2. Cuenta cuántos ingresos son mayores a 2000.
# 3. Explica por qué mean(ingreso) devuelve NA.

# Escribe tu código debajo:


# EJERCICIO B
# Con trabajadores:
# 1. Obtén solo las mujeres.
# 2. Calcula su ingreso promedio.
# 3. Crea una nueva columna ingreso_anual = ingreso * 12.
# 4. Identifica la fila del ingreso máximo.

# Escribe tu código debajo:


# RETO DE CIERRE
# Crea tres objetos que representen:
# - una variable numérica,
# - una variable de texto,
# - una condición lógica.
# Luego consulta class() y typeof() para cada uno.

# FIN SESIÓN 1


# ------------------------------------------------------------------------------
# 16. PUENTE CON UN ARCHIVO REAL DE LA CLASE
# ------------------------------------------------------------------------------
# Hasta ahora construimos vectores directamente. Ahora comprobamos que una
# columna importada desde un CSV también puede convertirse en un vector de R.
practica_vectores <- read_csv("datos/practica_vectores.csv", show_col_types = FALSE)

head(practica_vectores)
class(practica_vectores)

ingreso_archivo <- practica_vectores$ingreso
class(ingreso_archivo)
length(ingreso_archivo)
mean(ingreso_archivo, na.rm = TRUE)

# Observa la relación conceptual:
# archivo CSV -> data frame -> columna -> vector -> función -> resultado.

# FIN CLASE 01
