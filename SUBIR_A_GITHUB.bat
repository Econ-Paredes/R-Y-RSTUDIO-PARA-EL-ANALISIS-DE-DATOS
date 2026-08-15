@echo off
setlocal
cd /d "%~dp0"
echo ================================================================
echo  R Y RSTUDIO PARA EL ANALISIS DE DATOS - PUBLICACION EN GITHUB
echo ================================================================
echo.
where git >nul 2>nul
if errorlevel 1 (
  echo ERROR: Git no esta instalado o no esta en el PATH.
  echo Instala Git for Windows y vuelve a ejecutar este archivo.
  pause
  exit /b 1
)

if exist .git (
  echo Repositorio Git local ya inicializado.
) else (
  git init
)

git branch -M main

git remote get-url origin >nul 2>nul
if errorlevel 1 (
  git remote add origin https://github.com/Econ-Paredes/R-Y-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS.git
) else (
  git remote set-url origin https://github.com/Econ-Paredes/R-Y-RSTUDIO-PARA-EL-ANALISIS-DE-DATOS.git
)

git add .
git commit -m "Publicar material inicial del curso R y RStudio"
if errorlevel 1 (
  echo.
  echo Si Git indico que no hay cambios para confirmar, continuaremos con el push.
)

echo.
echo Git puede abrir el navegador para autenticar tu cuenta de GitHub.
git push -u origin main
if errorlevel 1 (
  echo.
  echo No se pudo completar el push. Copia el mensaje de error y envialo en el chat.
  pause
  exit /b 1
)

echo.
echo ================================================================
echo  LISTO. MATERIAL PUBLICADO CORRECTAMENTE.
echo ================================================================
pause
