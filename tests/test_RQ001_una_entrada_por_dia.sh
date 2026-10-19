#!/usr/bin/env bash
# blog.RQ001 — Una entrada por cada día del viaje.
set -uo pipefail
cd "$(dirname "$0")/.."
err=0
n=$(find _posts -name '*.md' | wc -l | tr -d ' ')
[ "$n" -ge 1 ] || { echo "RQ001: no hay ninguna entrada en _posts/"; err=1; }
for f in _posts/*.md; do
  base=$(basename "$f")
  if ! printf '%s' "$base" | grep -qE '^20[0-9]{2}-[01][0-9]-[0-3][0-9]-dia-[0-9]{2}-.+\.md$'; then
    echo "RQ001: nombre fuera de patrón AAAA-MM-DD-dia-NN-titulo.md: $base"; err=1; continue
  fi
  fecha=${base:0:10}
  if [[ "$fecha" < "2026-10-19" || "$fecha" > "2026-10-19" ]]; then
    echo "RQ001: fecha fuera del viaje (el periodo de publicacion): $base"; err=1
  fi
done
dups=$(ls _posts/*.md 2>/dev/null | sed -E 's/.*-dia-([0-9]{2})-.*/\1/' | sort | uniq -d)
[ -z "$dups" ] || { echo "RQ001: número de día repetido: $dups"; err=1; }
exit $err
