#!/usr/bin/env bash
# blog.RQ003 — Metadatos completos en cada entrada.
set -uo pipefail
cd "$(dirname "$0")/.."
err=0
for f in _posts/*.md; do
  fm=$(awk 'NR==1 && /^---/{p=1; next} p && /^---/{exit} p' "$f")
  for campo in title date description tags; do
    printf '%s' "$fm" | grep -qE "^${campo}:[[:space:]]*\S" \
      || { echo "RQ003: falta o está vacío '$campo' en $(basename "$f")"; err=1; }
  done
done
exit $err
