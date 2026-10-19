#!/usr/bin/env bash
# blog.RQ004 — Legible en el móvil.
set -uo pipefail
cd "$(dirname "$0")/.."
err=0
tema=$(grep -E '^theme:' _config.yml | awk '{print $2}')
if [ -z "$tema" ]; then
  grep -rqi 'name="viewport"' _layouts/ 2>/dev/null \
    || { echo "RQ004: sin tema declarado y sin meta viewport en _layouts/"; err=1; }
fi
if grep -rnE '(max-)?width:[[:space:]]*[0-9]{3,}px' assets/*.css assets/**/*.css 2>/dev/null | grep -v 'max-width'; then
  echo "RQ004: hay un ancho fijo en píxeles en el CSS propio"; err=1
fi
exit $err
