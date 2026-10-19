#!/usr/bin/env bash
# blog.RQ002 — El sitio es indexable por buscadores.
set -uo pipefail
cd "$(dirname "$0")/.."
err=0
grep -q 'jekyll-sitemap' _config.yml || { echo "RQ002: falta el plugin jekyll-sitemap"; err=1; }
grep -q 'jekyll-seo-tag' _config.yml || { echo "RQ002: falta el plugin jekyll-seo-tag"; err=1; }
if [ -f robots.txt ] && grep -qiE '^[[:space:]]*Disallow:[[:space:]]*/[[:space:]]*$' robots.txt; then
  echo "RQ002: robots.txt prohíbe el rastreo completo"; err=1
fi
if grep -rliE 'name=["'"'"']robots["'"'"'][^>]*noindex' --include='*.md' --include='*.html' . >/dev/null 2>&1; then
  echo "RQ002: hay contenido marcado como noindex"; err=1
fi
exit $err
