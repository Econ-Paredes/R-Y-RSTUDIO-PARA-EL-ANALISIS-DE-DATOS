# R Y RSTUDIO PARA EL ANÁLISIS DE DATOS
## Fundamentos para Econometría · GEM / Beps Smart Research

**Curso práctico intensivo:** 10 horas · 5 sesiones de 2 horas  
**Docente:** Mg. Miguel Jesús Armando Paredes Trujillo  
Maestro en Ciencias Económicas y Economía Aplicada · Econometrista · Científico de Datos · Investigador Senior

Este repositorio reúne el **manual del estudiante, bases de práctica y scripts de trabajo** del curso. El objetivo es que cada participante disponga de una única fuente oficial y actualizada del material, sin depender del envío individual de archivos.

> **Importante:** las bases incluidas son simuladas con fines pedagógicos y no representan estadísticas oficiales del Perú.

## Inicio rápido

### Descargar todo el curso
1. Pulsa **Code**.
2. Selecciona **Download ZIP**.
3. Descomprime la carpeta en una ubicación sencilla.
4. Abre `Curso_R_GEM.Rproj` con RStudio.
5. Ejecuta primero `scripts/00_configuracion.R`.

### Clonar con Git
```bash
git clone https://github.com/Econ-Paredes/R-Y-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS.git
```

## Estructura

```text
R-Y-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS/
├── README.md
├── Curso_R_GEM.Rproj
├── material/
│   └── Manual_Alumno_R_RStudio_10h_GEM.pdf
├── datos/
│   ├── practica_vectores.csv
│   ├── empleo_peru_bruto.csv
│   ├── empleo_peru_bruto.xlsx
│   ├── empleo_peru_bruto.dta
│   ├── contexto_regional_2025.csv
│   ├── contexto_regional_2025.xlsx
│   └── panel_regional_2022_2025.csv
├── scripts/
│   ├── 00_configuracion.R
│   ├── 01_sesion_fundamentos.R
│   ├── 02_sesion_limpieza.R
│   ├── 03_sesion_descriptiva.R
│   ├── 04_sesion_variables_econometricas.R
│   └── 05_sesion_regresion.R
└── recursos/
    └── GUIA_GITHUB_ALUMNO.md
```

## Ruta de aprendizaje

| Sesión | Núcleo práctico | Producto esperado |
|---|---|---|
| 1 | Entorno, organización, objetos, vectores, `data.frame` y `NA` | Primer script y base creada en R |
| 2 | Importación, auditoría, limpieza y transformación | Base depurada para análisis |
| 3 | Estadística descriptiva, agrupación, joins y visualización | Tabla regional y gráficos |
| 4 | Variables econométricas y estructura de panel | Base lista para modelamiento |
| 5 | Pipeline reproducible e introducción a `lm()` | Mini proyecto integrado |

## Paquetes utilizados

```r
install.packages(c("tidyverse", "readxl", "haven"))
```

Luego, en cada sesión:

```r
library(tidyverse)
library(readxl)
library(haven)
```

## Regla de trabajo

**Carpeta raíz → RStudio Project → R Script (.R) → paquetes → importación → auditoría/limpieza → análisis → exportación.**

Las bases originales se conservan sin modificar. Los datos procesados, tablas, gráficos y resultados deben generarse mediante código reproducible.

## Manual del estudiante

`material/Manual_Alumno_R_RStudio_10h_GEM.pdf`

## Uso académico

Material académico para uso formativo de **GEM / Beps Smart Research**. No redistribuir comercialmente sin autorización.
