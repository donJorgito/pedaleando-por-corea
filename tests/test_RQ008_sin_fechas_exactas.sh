#!/usr/bin/env bash
# blog.RQ008 — El blog no publica las fechas exactas del viaje.
set -uo pipefail
cd "$(dirname "$0")/.."
err=0

VIAJE_DE=2026-10-19
VIAJE_A=2026-10-19

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

# 3. Ni el nombre del fichero ni el front matter llevan una fecha del viaje.
for f in _posts/*.md; do
  [ -f "$f" ] || continue
  base=$(basename "$f")
  fecha=${base:0:10}
  if [[ ! "$fecha" < "$VIAJE_DE" && ! "$fecha" > "$VIAJE_A" ]]; then
    echo "RQ008: $base se fecha dentro del viaje; usa la fecha de publicación"
    err=1
  fi
  fm=$(grep -E '^date:' "$f" | head -1 | awk '{print $2}')
  if [ -n "$fm" ] && [[ ! "$fm" < "$VIAJE_DE" && ! "$fm" > "$VIAJE_A" ]]; then
    echo "RQ008: $base declara date: $fm, dentro del viaje"; err=1
  fi
done

# 4. El texto publicado no da fechas exactas. Se permite nombrar el mes
#    ("octubre de 2026") y las fechas que no son del itinerario, que van
#    listadas abajo como excepciones comprobadas una a una.
EXCEPCIONES='octubre de 1978'
for f in _posts/*.md index.md README.md; do
  [ -f "$f" ] || continue
  # La fecha de publicación del front matter y los {% post_url %} ya los
  # valida el punto 3; aquí se mira solo la prosa.
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
