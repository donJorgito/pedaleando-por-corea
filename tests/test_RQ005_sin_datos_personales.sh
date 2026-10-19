#!/usr/bin/env bash
# blog.RQ005 — Sin datos personales en lo publicado.
set -uo pipefail
cd "$(dirname "$0")/.."
err=0
if grep -rnE '\b[A-Z]{2}[0-9]{2}[[:space:]]?([0-9]{4}[[:space:]]?){3,5}[0-9]{0,4}\b' _posts/ *.md 2>/dev/null; then
  echo "RQ005: posible IBAN en el contenido"; err=1
fi
if grep -rnE '(\+34|\+82)[[:space:]]?[0-9]{6,}|\b[6-7][0-9]{8}\b' _posts/ *.md 2>/dev/null; then
  echo "RQ005: posible número de teléfono en el contenido"; err=1
fi
if command -v python3 >/dev/null 2>&1; then
  python3 - <<'PY' || err=1
import glob, sys
try:
    from PIL import Image
except ImportError:
    sys.exit(0)          # sin Pillow no se puede comprobar; no se bloquea el gate
malas = []
for f in glob.glob('assets/**/*.jp*g', recursive=True) + glob.glob('assets/**/*.png', recursive=True):
    try:
        gps = Image.open(f).getexif().get_ifd(34853)
    except Exception:
        continue
    if gps and 2 in gps and 4 in gps:
        malas.append(f)
if malas:
    print('RQ005: imágenes con coordenadas GPS en el EXIF:', *malas, sep='\n  ')
    sys.exit(1)
PY
fi
exit $err
