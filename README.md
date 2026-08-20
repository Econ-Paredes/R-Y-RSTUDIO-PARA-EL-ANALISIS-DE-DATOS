# R Y RSTUDIO PARA EL ANÁLISIS DE DATOS
## Fundamentos para Econometría · GEM / Beps Smart Research

**Curso práctico intensivo:** 10 horas · 5 sesiones de 2 horas  
**Docente:** Mg. Miguel Jesús Armando Paredes Trujillo  
Maestro en Ciencias Económicas y Economía Aplicada · Econometrista · Científico de Datos · Investigador Senior

Este repositorio reúne el **manual práctico, las bases de trabajo y los scripts del alumno por clase**. La finalidad es que cada participante disponga de una fuente única y ordenada para reproducir en RStudio cada ejercicio desarrollado durante el curso.

## Inicio rápido

1. Pulsa **Code** → **Download ZIP**.
2. Descomprime el repositorio en una carpeta de trabajo.
3. Abre `R-Y-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS.Rproj` con RStudio.
4. Revisa el manual en `material/Manual_Practico_R_RStudio_Analisis_Datos_GEM.pdf`.
5. Trabaja los scripts de `scripts/` en orden, desde `CLASE_01` hasta `CLASE_05`.

## Scripts del alumno

```text
scripts/
├── CLASE_01_Alumno_Pensar_en_R.R
├── CLASE_02_Alumno_Base_Analitica.R
├── CLASE_03_Alumno_Datos_en_Informacion.R
├── CLASE_04_Alumno_Preparar_Variables_Econometria.R
└── CLASE_05_Alumno_Primera_Regresion.R
```

Cada script corresponde a una sesión de 2 horas y contiene únicamente **código, comentarios técnicos necesarios y ejercicios del alumno**. Las ideas fuerza, preguntas de control, respuestas esperadas, errores intencionales y orientaciones de conducción pertenecen al material privado del docente y no forman parte de este repositorio.

## Ruta de aprendizaje

| Clase | Núcleo práctico | Producto esperado |
|---|---|---|
| 01 | Entorno, directorio de trabajo, lógica de R, objetos, operadores, funciones, vectores, `NA` y data frames | Primer script reproducible |
| 02 | Importación, auditoría, limpieza y transformación con `dplyr` | Base analítica depurada |
| 03 | Estadística descriptiva, agrupación, joins, gráficos y correlación | Indicadores y visualizaciones |
| 04 | Logaritmos, dummies, términos cuadráticos, factores, panel, rezagos y fórmulas | Variables preparadas para econometría |
| 05 | Pipeline reproducible e introducción a `lm()` | Primera regresión y proyecto integrador |

## Estructura general

```text
R-Y-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS/
├── README.md
├── R-Y-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS.Rproj
├── datos/
├── material/
│   └── Manual_Practico_R_RStudio_Analisis_Datos_GEM.pdf
├── scripts/
│   ├── CLASE_01_Alumno_Pensar_en_R.R
│   ├── CLASE_02_Alumno_Base_Analitica.R
│   ├── CLASE_03_Alumno_Datos_en_Informacion.R
│   ├── CLASE_04_Alumno_Preparar_Variables_Econometria.R
│   └── CLASE_05_Alumno_Primera_Regresion.R
└── recursos/
```

## Regla de trabajo

**Verificar ubicación → definir carpeta de la clase → comprobar ruta → establecer directorio → trabajar con rutas relativas → importar → auditar → transformar → analizar → exportar.**

Las bases originales se conservan sin modificar. Los productos derivados deben poder regenerarse mediante código reproducible.

## Manual práctico

`material/Manual_Practico_R_RStudio_Analisis_Datos_GEM.pdf`

## Uso académico

Material académico para uso formativo de **GEM / Beps Smart Research**. No redistribuir comercialmente sin autorización.
