# Guía rápida: usar el material desde GitHub

No necesitas saber Git para llevar el curso.

## Método recomendado
1. Abre el repositorio del curso.
2. Pulsa **Code → Download ZIP**.
3. Descomprime la carpeta.
4. Evita trabajar directamente dentro del ZIP.
5. En RStudio crea un proyecto desde la carpeta descomprimida.
6. Ejecuta primero `scripts/00_configuracion.R`.

## Buenas prácticas
- No muevas los archivos de `datos/` durante el curso.
- No edites manualmente las bases brutas.
- Guarda tus scripts con nombres claros.
- Usa rutas relativas, por ejemplo `datos/empleo_peru_bruto.csv`.
- Si algo falla, ejecuta `getwd()` y `list.files()` para comprobar dónde estás trabajando.
