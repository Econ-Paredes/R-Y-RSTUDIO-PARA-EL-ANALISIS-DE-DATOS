# R Y RSTUDIO PARA EL ANÁLISIS DE DATOS
## Fundamentos para Econometría · GEM / Beps Smart Research

**Curso práctico intensivo:** 10 horas · 5 sesiones de 2 horas  
**Docente:** Mg. Miguel Jesús Armando Paredes Trujillo  
**Perfil:** Maestro en Ciencias Económicas y Economía Aplicada · Econometrista · Científico de Datos · Investigador Senior

Este repositorio es el **espacio oficial de trabajo del curso**. Aquí encontrarás el manual del estudiante, las bases de datos, los scripts prácticos de cada sesión y los recursos necesarios para avanzar en RStudio sin depender del envío individual de archivos.

## 1. Empieza aquí

### Opción recomendada · Descargar todo el curso
1. Pulsa el botón **Code**.
2. Selecciona **Download ZIP**.
3. Descomprime la carpeta en una ubicación sencilla de tu computadora.
4. Abre `R-Y-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS.Rproj` con RStudio.
5. Antes de iniciar la primera sesión ejecuta `scripts/00_antes_de_iniciar_configuracion.R`.

### Opción con Git
```bash
git clone https://github.com/Econ-Paredes/R-Y-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS.git
```

> **Buena práctica:** trabaja siempre desde el RStudio Project. Así las rutas del curso se mantienen relativas a la carpeta raíz y el proyecto puede moverse entre computadoras sin reescribir todas las direcciones de archivos.

## 2. Cómo se complementan el manual y los scripts

El curso está diseñado con dos recursos que se usan juntos:

- **Manual:** desarrolla definiciones, conceptos, lógica, reglas, buenas prácticas, notas, recomendaciones y ejercicios.
- **Scripts:** permiten comprobar cada concepto directamente en RStudio mediante código ejecutable, ejemplos y ensayos.

La secuencia recomendada es:

**Leer el concepto → ejecutar el ejemplo → observar el resultado → modificar el código → resolver el ejercicio.**

## 3. Estructura del repositorio

```text
R-Y-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS/
├── README.md
├── R-Y-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS.Rproj
├── datos/
│   ├── practica_vectores.csv
│   ├── empleo_peru_bruto.csv
│   ├── empleo_peru_bruto.xlsx
│   ├── empleo_peru_bruto.dta
│   ├── contexto_regional_2025.csv
│   ├── contexto_regional_2025.xlsx
│   └── panel_regional_2022_2025.csv
├── material/
│   └── Manual_Practico_R_RStudio_Analisis_Datos_GEM.pdf
├── scripts/
│   ├── 00_antes_de_iniciar_configuracion.R
│   ├── 01_sesion_pensar_en_R.R
│   ├── 02_sesion_archivo_bruto_a_base_analitica.R
│   ├── 03_sesion_convertir_datos_en_informacion.R
│   ├── 04_sesion_preparar_variables_para_econometria.R
│   ├── 05_sesion_del_dato_a_primera_regresion.R
│   └── README_SCRIPTS_ALUMNO.md
└── recursos/
    └── GUIA_GITHUB_ALUMNO.md
```

## 4. Ruta de aprendizaje

| Sesión | Enfoque | Trabajo práctico en R |
|---|---|---|
| Antes de iniciar | Entorno y buenas prácticas | Directorio, RStudio Project, scripts, comentarios, paquetes y ayuda |
| 1 | **Pensar en R** | Objetos, expresiones, funciones, case sensitive, tipos de datos, vectores, `NA` y `data.frame` |
| 2 | **Del archivo bruto a la base analítica** | Importación, inspección, auditoría, limpieza y transformación |
| 3 | **Convertir datos en información** | Descriptivos, agrupación, joins, tablas y gráficos |
| 4 | **Preparar variables para econometría** | Logs, dummies, términos cuadráticos, estructura de panel, rezagos y diferencias |
| 5 | **Del dato a una primera regresión** | Pipeline reproducible, fórmulas, `lm()`, coeficientes, valores ajustados y residuos |

## 5. Paquetes principales

Instala un paquete una sola vez:

```r
install.packages(c("tidyverse", "readxl", "haven"))
```

Cárgalo cada vez que inicies una nueva sesión de R:

```r
library(tidyverse)
library(readxl)
library(haven)
```

## 6. Regla de trabajo del curso

**Carpeta raíz → RStudio Project → R Script (.R) → paquetes → importación → auditoría/limpieza → análisis → exportación.**

Las bases originales deben conservarse sin modificaciones. Las transformaciones, tablas, gráficos y resultados se generan mediante código reproducible.

## 7. Manual del estudiante

El manual oficial está disponible en:

`material/Manual_Practico_R_RStudio_Analisis_Datos_GEM.pdf`

## 8. Scripts del estudiante

Empieza por:

`scripts/00_antes_de_iniciar_configuracion.R`

Luego utiliza el script correspondiente a cada sesión. Los archivos contienen comentarios que explican **qué se está demostrando, qué debes observar y qué debes modificar**.

## 9. Uso académico

Material académico de **GEM / Beps Smart Research** para uso formativo.
