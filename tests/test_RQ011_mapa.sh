#!/usr/bin/env bash
# blog.RQ011 — El mapa de la ruta, en el propio sitio y sin fechas.
set -uo pipefail
cd "$(dirname "$0")/.."
err=0

mapa=mapa.html
gen=_tools/generar-mapa-publico.py

if [ ! -f "$mapa" ]; then
  echo "RQ011: falta $mapa"; exit 1
fi

# 1. Es una página de Jekyll enlazable, no un fichero suelto.
for patron in '^title:' '^permalink: /mapa/' '^description:'; do
  grep -qE "$patron" "$mapa" \
    || { echo "RQ011: $mapa no declara $patron en el front matter"; err=1; }
done

# 2. Autónoma, pero no un callejón sin salida: enlace de vuelta con baseurl,
#    viewport y tema oscuro (blog.RQ004, blog.RQ009).
grep -q 'site.baseurl' "$mapa" \
  || { echo "RQ011: el enlace de vuelta al blog no lleva el baseurl"; err=1; }
grep -q 'name="viewport"' "$mapa" \
  || { echo "RQ011: $mapa no declara viewport"; err=1; }
grep -qE 'prefers-color-scheme: *dark' "$mapa" \
  || { echo "RQ011: $mapa no respeta el tema oscuro"; err=1; }

# 3. Lo que de verdad importa: ni una fecha de calendario. El itinerario no
#    se publica (blog.RQ008) y un mapa es la forma más fácil de publicarlo
#    sin darse cuenta.
fechas=$(grep -oE '20[0-9]{2}-[01][0-9]-[0-3][0-9]|[0-9]{1,2} de (enero|febrero|marzo|abril|mayo|junio|julio|agosto|septiembre|octubre|noviembre|diciembre)' \
         "$mapa" | sort -u || true)
if [ -n "$fechas" ]; then
  echo "RQ011: hay fechas en $mapa:"; printf '  %s\n' $fechas; err=1
fi

# 4. Las jornadas van numeradas, que es la prueba de que la traducción se
#    hizo (y no de que no había fechas que traducir).
grep -q 'día 1' "$mapa" \
  || { echo "RQ011: $mapa no nombra las jornadas como «día N»"; err=1; }

# 5. Datos internos del proceso que no se publican.
for campo in '"dist"' '"guardado"'; do
  if grep -q "$campo" "$mapa"; then
    echo "RQ011: $mapa publica el campo interno $campo"; err=1
  fi
done

# 6. El generador existe, es ejecutable y no lleva la fecha de salida dentro.
if [ ! -x "$gen" ]; then
  echo "RQ011: falta $gen o no es ejecutable"; err=1
else
  grep -q 'inicio' "$gen" \
    || { echo "RQ011: $gen no pide la fecha de salida por argumento"; err=1; }
  # Ni la fecha de salida, ni un ejemplo con fecha de verdad en un
  # comentario: «01/10 -> día 11» publica el itinerario igual de bien que
  # una tabla de fechas.
  if grep -qE '20[0-9]{2}-[01][0-9]-[0-3][0-9]|[0-3]?[0-9]/[01]?[0-9]( |")' \
       "$gen"; then
    echo "RQ011: $gen lleva una fecha escrita dentro:"
    grep -nE '20[0-9]{2}-[01][0-9]-[0-3][0-9]|[0-3]?[0-9]/[01]?[0-9]( |")' \
      "$gen" | sed 's/^/  /'
    err=1
  fi
fi

exit $err
