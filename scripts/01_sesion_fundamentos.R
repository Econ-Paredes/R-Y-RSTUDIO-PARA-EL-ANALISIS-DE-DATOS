# SESIÓN 1 · PENSAR EN R
# Objetos, vectores, data frames y valores faltantes

# Objetos
x <- 10
y <- 25
x + y

# Tipos
edad <- 35
region <- "Lima"
formal <- TRUE
class(edad); class(region); class(formal)

# Vectores
ingreso <- c(1250, 1800, 2300, 950, 3200, 2700, 1600, 4100, NA)
length(ingreso)
ingreso[ingreso > 2000]
sum(is.na(ingreso))
mean(ingreso, na.rm = TRUE)

# Data frame
trabajadores <- data.frame(
  id = 1:8,
  sexo = c("Mujer","Hombre","Hombre","Mujer","Mujer","Hombre","Mujer","Hombre"),
  edad = c(22,28,35,41,30,50,26,38),
  educacion = c(12,16,14,11,18,12,16,14),
  ingreso = c(1250,1800,2300,950,3200,2700,1600,4100)
)

head(trabajadores)
dim(trabajadores)
str(trabajadores)
summary(trabajadores)

# EJERCICIO
# 1. Calcula el ingreso promedio de las mujeres.
# 2. Identifica la observación con mayor ingreso.
# 3. Crea ingreso_anual = ingreso * 12.
