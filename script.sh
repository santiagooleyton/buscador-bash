#!/bin/bash

# === MÓDULO 1: Validación de argumentos ===
# (Integrante 1)

# === MÓDULO 2: Motor de búsqueda ===
# (Integrante 2)

# === MÓDULO 3: Formato y conteo de ocurrencias ===
# (Integrante 3)
#
# # === MÓDULO 1: Validación de argumentos ===
if [ $# -ne 2 ]; then
  echo "Uso incorrecto. Uso: $0 \"palabra o frase\" /ruta/a/carpeta"
  exit 1
fi
palabra="$1"
ruta="$2"
if [ ! -d "$ruta" ]; then
  echo "Error: '$ruta' no existe o no es un directorio válido."
  exit 1
fi

# === MÓDULO 2: Motor de búsqueda ===
archivos=$(grep -rlIF -- "$palabra" "$ruta" 2>/dev/null)

# === MÓDULO 3: Formato y conteo de ocurrencias ===
if [ -z "$archivos" ]; then
  echo "No se encontró \"$palabra\" en $ruta"
  exit 0
fi
echo "Resultados para \"$palabra\" en $ruta:"
echo "--------------------------------------------------------"
printf "%-45s %s\n" "ARCHIVO" "FRECUENCIA"
while IFS= read -r archivo; do
  veces=$(grep -oF -- "$palabra" "$archivo" | wc -l)
  printf "%-45s %d\n" "$archivo" "$veces"
done <<< "$archivos"
