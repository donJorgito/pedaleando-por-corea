#!/usr/bin/env bash
# blog.RQ010 — Fotos del viaje, con pie y accesibles.
set -uo pipefail
cd "$(dirname "$0")/.."
err=0

inc=_includes/foto.html

# 1. El include, que es lo que hace que estas reglas valgan para todas.
if [ ! -f "$inc" ]; then
  echo "RQ010: falta $inc"; err=1
else
  for patron in 'loading="lazy"' 'width=' 'height=' 'include.alt'; do
    grep -q "$patron" "$inc" \
      || { echo "RQ010: $inc no emite $patron"; err=1; }
  done
fi

# 2. Cada uso del include lleva los cuatro parámetros obligatorios, con un
#    alt que describa de verdad y un tamaño que sea un número.
usos=0
for f in _posts/*.md; do
  [ -f "$f" ] || continue
  while IFS= read -r linea; do
    usos=$((usos + 1))
    src=$(printf '%s' "$linea" | sed -n 's/.*src="\([^"]*\)".*/\1/p')
    alt=$(printf '%s' "$linea" | sed -n 's/.*alt="\([^"]*\)".*/\1/p')
    ancho=$(printf '%s' "$linea" | sed -n 's/.*ancho="\([^"]*\)".*/\1/p')
    alto=$(printf '%s' "$linea" | sed -n 's/.*alto="\([^"]*\)".*/\1/p')
    donde="$(basename "$f")"

    if [ -z "$src" ]; then
      echo "RQ010: include sin src en $donde"; err=1; continue
    fi
    [ -f "assets/img/$src" ] \
      || { echo "RQ010: $donde apunta a assets/img/$src, que no existe"; err=1; }
    if [ "${#alt}" -lt 20 ]; then
      echo "RQ010: alt ausente o demasiado corto para $src en $donde"; err=1
    fi
    case "$ancho" in
      ''|*[!0-9]*) echo "RQ010: ancho no numérico para $src en $donde"; err=1 ;;
    esac
    case "$alto" in
      ''|*[!0-9]*) echo "RQ010: alto no numérico para $src en $donde"; err=1 ;;
    esac
  done < <(grep -o '{% include foto\.html [^%]*%}' "$f")
done

# 3. Los ficheros: sin fechas en el nombre y sin huérfanos.
for img in assets/img/*; do
  [ -f "$img" ] || continue
  base=$(basename "$img")
  [ "$base" = ".gitkeep" ] && continue
  case "$base" in
    *20[0-9][0-9]*)
      echo "RQ010: $base lleva una fecha en el nombre (blog.RQ008)"; err=1 ;;
  esac
  grep -rq "src=\"$base\"" _posts/ \
    || { echo "RQ010: $base no lo usa ninguna entrada"; err=1; }
done

# 4. Que el gate no pase por no haber mirado nada: si hay imágenes, tienen
#    que estar usadas con el include, no con un <img> a pelo.
if grep -rqE '<img [^>]*src="[^"]*assets/img' _posts/ 2>/dev/null; then
  echo "RQ010: hay un <img> suelto en una entrada; usa el include"; err=1
fi

echo "RQ010: $usos foto(s) comprobadas" >&2
exit $err
