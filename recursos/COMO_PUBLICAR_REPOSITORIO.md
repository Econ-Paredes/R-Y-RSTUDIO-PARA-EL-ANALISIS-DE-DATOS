# Cómo publicar este paquete en GitHub

El repositorio remoto ya debe existir con este nombre:

`Econ-Paredes/R-Y-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS`

## Método recomendado en Windows

1. Instala **Git for Windows** si todavía no lo tienes.
2. Descomprime este paquete completo.
3. Dentro de la carpeta principal ejecuta `SUBIR_A_GITHUB.bat`.
4. Si GitHub solicita autenticación, acepta el inicio de sesión en el navegador.
5. Al terminar, actualiza la página del repositorio en GitHub.

El script inicializa Git, configura la rama `main`, conecta el remoto, confirma todos los archivos y los publica.

## Método manual

Desde una terminal abierta en esta carpeta:

```bash
git init
git branch -M main
git remote add origin https://github.com/Econ-Paredes/R-Y-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS.git
git add .
git commit -m "Publicar material inicial del curso R y RStudio"
git push -u origin main
```
