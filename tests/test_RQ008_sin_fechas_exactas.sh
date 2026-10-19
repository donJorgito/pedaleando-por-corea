#!/usr/bin/env bash
# blog.RQ008 — El blog no publica las fechas exactas del viaje.
set -uo pipefail
cd "$(dirname "$0")/.."
err=0

# Este test no escribe en ningún sitio las fechas del viaje: serían justo el
# dato que el requisito prohíbe publicar, y el repositorio es público.

# 1. La URL no lleva fecha.
permalink=$(grep -E '^permalink:' _config.yml | head -1)
case "$permalink" in
  *:year*|*:month*|*:day*)
    echo "RQ008: el permalink mete la fecha en la URL -> $permalink"; err=1 ;;
esac

# 2. El layout de entrada no imprime la fecha. Minima la saca en un bloque
#    post-meta con un <time>; hay que sobrescribir el layout para quitarlo.
if [ ! -f _layouts/post.html ]; then
  echo "RQ008: falta _layouts/post.html; sin él, minima imprime la fecha"; err=1
else
  # Sin el comentario Liquid, que es justo donde se explica lo que no se hace.
  cuerpo=$(sed '/{%-* *comment/,/{%-* *endcomment/d' _layouts/post.html)
  for patron in 'post-meta' '<time'; do
    if printf '%s' "$cuerpo" | grep -q "$patron"; then
      echo "RQ008: _layouts/post.html imprime la fecha ($patron)"; err=1
    fi
  done
fi
for l in _layouts/*.html index.md; do
  [ -f "$l" ] || continue
  if grep -qE 'page\.date|p\.date *\| *date|post\.date' "$l"; then
    echo "RQ008: $(basename "$l") imprime una fecha de entrada"; err=1
  fi
done

# 3. Ninguna entrada se fecha con el día del viaje que cuenta.
#
#    Comprobarlo comparando contra el rango del viaje obligaría a escribir
#    aquí sus fechas, que es lo que no se publica. Hay una forma mejor: las
#    24 jornadas son 24 días DISTINTOS, así que si todas las entradas
#    diarias comparten una misma fecha de fichero, ninguna puede ser la de
#    su jornada. Y de paso impide reconstruir el itinerario desde el repo.
fechas=$(ls _posts/*-dia-[0-9][0-9]-*.md 2>/dev/null | xargs -n1 basename \
         | cut -c1-10 | sort -u)
distintas=$(printf '%s\n' "$fechas" | grep -c .)
if [ "$distintas" -ne 1 ]; then
  echo "RQ008: las entradas diarias llevan $distintas fechas distintas;" \
       "todas deben llevar la misma fecha de publicación:"
  printf '  %s\n' $fechas
  err=1
fi

# 4. El front matter coincide con el nombre del fichero. Si no, la fecha que
#    de verdad usan feed.xml y sitemap.xml se escapa por el front matter.
for f in _posts/*.md; do
  [ -f "$f" ] || continue
  base=$(basename "$f")
  fm=$(grep -E '^date:' "$f" | head -1 | awk '{print $2}')
  if [ -n "$fm" ] && [ "$fm" != "${base:0:10}" ]; then
    echo "RQ008: $base declara date: $fm, que no es la fecha de su nombre"
    err=1
  fi
done

# 5. El texto publicado no da fechas exactas. Se permite nombrar el mes
#    ("octubre de 2026") y las fechas que no son del itinerario, que van
#    listadas abajo como excepciones comprobadas una a una.
EXCEPCIONES='octubre de 1978'
for f in _posts/*.md index.md README.md; do
  [ -f "$f" ] || continue
  # La fecha de publicación del front matter la validan los puntos 3 y 4;
  # aquí se mira solo la prosa.
  hallado=$(grep -nE '[0-9]{1,2} de (septiembre|octubre)|[0-9]{1,2}/[0-9]{1,2}/20[0-9]{2}|20[0-9]{2}-(09|10)-[0-3][0-9]' "$f" \
            | grep -vE "$EXCEPCIONES" | grep -v 'post_url' \
            | grep -vE '^[0-9]+:date:' || true)
  if [ -n "$hallado" ]; then
    echo "RQ008: fecha exacta en $(basename "$f"):"
    printf '  %s\n' "$hallado"
    err=1
  fi
done

exit $err
