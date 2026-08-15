# Guía rápida de GitHub para el alumno

## ¿Para qué usamos este repositorio?

Este repositorio concentra los recursos oficiales del curso **R Y RSTUDIO PARA EL ANÁLISIS DE DATOS**. Aquí podrás consultar y descargar el manual, las bases y los scripts de cada sesión.

## Forma recomendada de trabajo

1. Entra al repositorio del curso.
2. Haz clic en **Code**.
3. Selecciona **Download ZIP**.
4. Descomprime el archivo.
5. Abre `R-Y-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS.Rproj`.
6. Abre el manual ubicado en `material/`.
7. Ejecuta primero `scripts/00_antes_de_iniciar_configuracion.R`.
8. Continúa con el script correspondiente a la sesión.

## Relación entre teoría y práctica

El **manual** explica conceptos y reglas. El **script** demuestra esos conceptos en RStudio.

Ejemplo:

- En el manual aprendes qué es un **objeto**.
- En el script lo compruebas creando objetos como:

```r
ingreso <- 2500
region <- "Lima"
formal <- TRUE
```

- En el manual aprendes que R distingue mayúsculas y minúsculas.
- En el script lo compruebas ejecutando:

```r
ingreso <- 1000
Ingreso <- 2000
INGRESO <- 3000

ingreso
Ingreso
INGRESO
```

## Regla importante

No trabajes modificando manualmente las bases originales. Las transformaciones deben quedar documentadas en un script para que puedan reproducirse.

## Si actualizamos el curso

Si ya descargaste una versión anterior, puedes volver a descargar el repositorio o, si trabajas con Git, ejecutar:

```bash
git pull
```
