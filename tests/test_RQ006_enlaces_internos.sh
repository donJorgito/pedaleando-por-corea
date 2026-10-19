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
      *post_url*)
        # Enlace Liquid entre entradas: {% post_url NOMBRE-SIN-EXTENSION %}.
        # Dos comprobaciones, y la segunda es la que duele:
        #   1) que la entrada referenciada exista;
        #   2) que lleve delante {{ site.baseurl }}. post_url devuelve la URL
        #      SIN el baseurl, así que en un sitio de proyecto
        #      (usuario.github.io/repo) el enlace sale roto y el build NO
        #      avisa. Nos pasó con los seis enlaces del blog.
        slug=$(printf '%s' "$destino" \
               | sed -E 's/.*post_url[[:space:]]+([^[:space:]%}]+).*/\1/')
        if [ ! -f "_posts/$slug.md" ]; then
          echo "RQ006: post_url a una entrada inexistente en $(basename "$f"): $slug"
          err=1
        fi
        case "$destino" in
          *site.baseurl*) ;;
          *) echo "RQ006: post_url sin {{ site.baseurl }} delante en $(basename "$f"): $slug"
             err=1 ;;
        esac
        continue ;;
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
