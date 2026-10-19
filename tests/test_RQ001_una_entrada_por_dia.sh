#!/usr/bin/env bash
# blog.RQ001 — Una entrada por cada día del viaje (+ entradas temáticas).
set -uo pipefail
cd "$(dirname "$0")/.."
err=0
# Toda entrada, diaria o temática, se fecha con su fecha de PUBLICACIÓN, que
# es posterior al viaje: el itinerario exacto no se publica (blog.RQ008).
FIN_DEL_VIAJE=2026-10-19

n=$(find _posts -name '*.md' | wc -l | tr -d ' ')
[ "$n" -ge 1 ] || { echo "RQ001: no hay ninguna entrada en _posts/"; err=1; }

for f in _posts/*.md; do
  base=$(basename "$f")
  fecha=${base:0:10}
  if printf '%s' "$base" | grep -qE '^20[0-9]{2}-[01][0-9]-[0-3][0-9]-(dia-[0-9]{2}-)?.+\.md$'; then
    if [[ ! "$fecha" > "$FIN_DEL_VIAJE" ]]; then
      echo "RQ001: $base se fecha el $fecha, no después del viaje" \
           "(la fecha del fichero es la de publicación)"
      err=1
    fi
  else
    echo "RQ001: nombre fuera de patrón (AAAA-MM-DD-dia-NN-titulo.md" \
         "o AAAA-MM-DD-titulo.md): $base"
    err=1
  fi
done

numeros=$(ls _posts/*-dia-[0-9][0-9]-*.md 2>/dev/null \
          | sed -E 's/.*-dia-([0-9]{2})-.*/\1/' | sed 's/^0//' | sort -n)

dups=$(printf '%s\n' "$numeros" | uniq -d)
[ -z "$dups" ] || { echo "RQ001: número de día repetido: $dups"; err=1; }

# El viaje son 24 jornadas: la serie tiene que estar completa, sin huecos.
TOTAL=24
for n in $(seq 1 "$TOTAL"); do
  printf '%s\n' "$numeros" | grep -qx "$n" \
    || { echo "RQ001: falta la entrada del día $n"; err=1; }
done
sobran=$(printf '%s\n' "$numeros" | awk -v t="$TOTAL" '$1>t')
[ -z "$sobran" ] || { echo "RQ001: día fuera del viaje (1..$TOTAL): $sobran"; err=1; }

exit $err
