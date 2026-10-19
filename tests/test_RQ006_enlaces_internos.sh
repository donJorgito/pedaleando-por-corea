#!/usr/bin/env bash
# blog.RQ006 — Los enlaces internos funcionan.
set -uo pipefail
cd "$(dirname "$0")/.."
err=0
for f in _posts/*.md *.md; do
  [ -f "$f" ] || continue
  while IFS= read -r destino; do
    [ -n "$destino" ] || continue
    case "$destino" in
      http*|mailto:*|\#*) continue ;;
    esac
    ruta=${destino%%#*}
    ruta=${ruta#/}
    [ -n "$ruta" ] || continue
    if [ ! -e "$ruta" ] && [ ! -e "assets/$ruta" ]; then
      echo "RQ006: enlace interno roto en $(basename "$f"): $destino"; err=1
    fi
  done < <(grep -oE '\]\([^)]+\)' "$f" | sed -E 's/^\]\(//; s/\)$//')
done
exit $err
