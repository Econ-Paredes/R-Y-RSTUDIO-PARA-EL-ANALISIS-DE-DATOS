# ==============================================================================
# R Y RSTUDIO PARA EL ANÁLISIS DE DATOS
# CLASE_05 · SCRIPT PRÁCTICO DEL ALUMNO
# DEL DATO A UNA PRIMERA REGRESIÓN · Pipeline reproducible y lm()
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
ruta_clase <- "D:/MIGUEL PAREDES  M.2/Desktop/DOCENCIA/RSTUDIO/RY-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS/RECURSOS PARA EL ALUMNO/CLASE_05"

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
# 1. EL PIPELINE COMPLETO: EL ANÁLISIS DEBE PODER RECONSTRUIRSE
# ------------------------------------------------------------------------------
# PASO 1: importar.
empleo <- read_csv("datos/empleo_peru_bruto.csv", show_col_types = FALSE)

# PASO 2: auditar brevemente.
dim(empleo)
colSums(is.na(empleo))
empleo |> count(id_persona) |> filter(n > 1)

# PASO 3: limpiar y construir variables.
base_modelo <- empleo |>
  distinct(id_persona, .keep_all = TRUE) |>
  mutate(
    region = str_to_title(str_trim(region)),
    edad = if_else(edad >= 18 & edad <= 80, edad, NA_real_),
    ingreso_mensual = if_else(
      is.na(ingreso_mensual) | ingreso_mensual <= 0,
      NA_real_,
      ingreso_mensual
    ),
    ln_ingreso = log(ingreso_mensual),
    experiencia2 = experiencia_anios^2,
    sexo_factor = relevel(factor(sexo), ref = "Hombre"),
    formal_factor = relevel(factor(formal), ref = "No")
  )

# PASO 4: describir.
base_modelo |>
  summarise(
    n = n(),
    ingreso_promedio = mean(ingreso_mensual, na.rm = TRUE),
    educacion_promedio = mean(educacion_anios, na.rm = TRUE)
  )

# ------------------------------------------------------------------------------
# 2. ¿QUÉ HACE lm()?
# ------------------------------------------------------------------------------
# lm() estima un modelo lineal. Aquí lo usamos como puente hacia econometría.
modelo_simple <- lm(
  ln_ingreso ~ educacion_anios,
  data = base_modelo
)

modelo_simple
summary(modelo_simple)

# La parte izquierda de ~ es la variable dependiente.
# La parte derecha contiene la(s) variable(s) explicativa(s).

# ------------------------------------------------------------------------------
# 3. REGRESIÓN MÚLTIPLE: LA FÓRMULA CRECE, LA LÓGICA SE MANTIENE
# ------------------------------------------------------------------------------
modelo_multiple <- lm(
  ln_ingreso ~ educacion_anios + experiencia_anios + experiencia2 +
    sexo_factor + formal_factor,
  data = base_modelo
)

summary(modelo_multiple)


# ------------------------------------------------------------------------------
# 4. EL MODELO TAMBIÉN ES UN OBJETO
# ------------------------------------------------------------------------------
class(modelo_multiple)

# Coeficientes estimados.
coef(modelo_multiple)

# Valores ajustados.
head(fitted(modelo_multiple))

# Residuos.
head(residuals(modelo_multiple))

# Número de observaciones realmente utilizadas por el modelo.
nobs(modelo_multiple)

# Nombres de componentes internos del objeto.
names(modelo_multiple)

# ------------------------------------------------------------------------------
# 5. PREDICCIÓN DIDÁCTICA
# ------------------------------------------------------------------------------
# newdata debe contener las variables y niveles compatibles con el modelo.
nueva_persona <- data.frame(
  educacion_anios = 16,
  experiencia_anios = 8,
  experiencia2 = 8^2,
  sexo_factor = factor("Mujer", levels = levels(base_modelo$sexo_factor)),
  formal_factor = factor("Si", levels = levels(base_modelo$formal_factor))
)

pred_ln <- predict(modelo_multiple, newdata = nueva_persona)
pred_ln

# El modelo usa ln_ingreso; exponenciamos solo para volver a la escala aproximada de ingreso.
exp(pred_ln)

# ------------------------------------------------------------------------------
# 6. DIAGNÓSTICO VISUAL INTRODUCTORIO
# ------------------------------------------------------------------------------
# En RStudio los gráficos aparecen en la pestaña Plots.
par(mfrow = c(2, 2))
plot(modelo_multiple)
par(mfrow = c(1, 1))

# En un curso posterior de econometría se estudiará formalmente qué diagnostica cada gráfico.

# ------------------------------------------------------------------------------
# 7. EXPORTAR RESULTADOS
# ------------------------------------------------------------------------------
dir.create("datos_procesados", showWarnings = FALSE)
dir.create("resultados", showWarnings = FALSE)

# Base analítica final.
write_csv(base_modelo, "datos_procesados/base_modelo.csv")

# Tabla sencilla de coeficientes sin paquetes adicionales.
tabla_coeficientes <- data.frame(
  termino = names(coef(modelo_multiple)),
  estimacion = unname(coef(modelo_multiple))
)

tabla_coeficientes
write_csv(tabla_coeficientes, "resultados/coeficientes_modelo.csv")

# ------------------------------------------------------------------------------
# 8. MINI PROYECTO INTEGRADOR
# ------------------------------------------------------------------------------
# Objetivo didáctico:
# reconstruir un flujo completo desde datos brutos hasta una primera regresión.
#
# TAREAS:
# 1. Abre el proyecto del curso.
# 2. Confirma getwd() y file.exists("datos/empleo_peru_bruto.csv").
# 3. Importa empleo_peru_bruto.csv.
# 4. Revisa dimensiones, nombres, faltantes, categorías y duplicados.
# 5. Conserva una base original y crea otra base limpia mediante código.
# 6. Estandariza region y trata edad/ingreso no plausibles según las reglas del curso.
# 7. Crea ln_ingreso, experiencia2, sexo_factor y formal_factor.
# 8. Construye una tabla descriptiva por region.
# 9. Construye al menos dos gráficos útiles.
# 10. Estima modelo_simple y modelo_multiple.
# 11. Identifica variable dependiente y explicativas.
# 12. Consulta coef(), residuals(), fitted(), nobs() y summary().
# 13. Exporta la base procesada y una tabla de coeficientes.
# 14. Revisa que todo pueda ejecutarse desde arriba hacia abajo en una sesión limpia.

# ------------------------------------------------------------------------------
# 9. COMPROBACIONES FINALES DE REPRODUCIBILIDAD
# ------------------------------------------------------------------------------
stopifnot(exists("base_modelo"))
stopifnot(inherits(modelo_multiple, "lm"))
stopifnot(file.exists("datos_procesados/base_modelo.csv"))
stopifnot(file.exists("resultados/coeficientes_modelo.csv"))

cat("\nSesión 5 completada: pipeline, modelo y exportación ejecutados.\n")

# FIN CLASE 05
