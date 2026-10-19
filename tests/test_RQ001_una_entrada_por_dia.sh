#!/usr/bin/env bash
# blog.RQ001 — Una entrada por cada día del viaje (+ entradas temáticas).
set -uo pipefail
cd "$(dirname "$0")/.."
err=0
VIAJE_DE=2026-10-19
VIAJE_A=2026-10-19

n=$(find _posts -name '*.md' | wc -l | tr -d ' ')
[ "$n" -ge 1 ] || { echo "RQ001: no hay ninguna entrada en _posts/"; err=1; }

for f in _posts/*.md; do
  base=$(basename "$f")
  fecha=${base:0:10}
  if printf '%s' "$base" | grep -qE '^20[0-9]{2}-[01][0-9]-[0-3][0-9]-dia-[0-9]{2}-.+\.md$'; then
    # entrada diaria: la fecha es la del día que cuenta
    if [[ "$fecha" < "$VIAJE_DE" || "$fecha" > "$VIAJE_A" ]]; then
      echo "RQ001: entrada diaria fuera del viaje ($VIAJE_DE..$VIAJE_A): $base"; err=1
    fi
  elif printf '%s' "$base" | grep -qE '^20[0-9]{2}-[01][0-9]-[0-3][0-9]-.+\.md$'; then
    # entrada temática: se escribe con el viaje ya hecho
    if [[ "$fecha" < "$VIAJE_DE" ]]; then
      echo "RQ001: entrada temática anterior al viaje: $base"; err=1
    fi
  else
    echo "RQ001: nombre fuera de patrón (AAAA-MM-DD-dia-NN-titulo.md" \
         "o AAAA-MM-DD-titulo.md): $base"
    err=1
  fi
done

dups=$(ls _posts/*-dia-[0-9][0-9]-*.md 2>/dev/null \
       | sed -E 's/.*-dia-([0-9]{2})-.*/\1/' | sort | uniq -d)
[ -z "$dups" ] || { echo "RQ001: número de día repetido: $dups"; err=1; }
exit $err
