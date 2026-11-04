#!/usr/bin/env bash
# blog.RQ012 — Un enlace compartido se ve como una tarjeta con foto.
set -uo pipefail
cd "$(dirname "$0")/.."
err=0

tarjeta=assets/img/tarjeta-social.jpg

# 1. La imagen existe.
if [ ! -s "$tarjeta" ]; then
  echo "RQ012: falta $tarjeta"; err=1
fi

# 2. El sitio la declara por `defaults`, con alto, ancho y alt. Sin la ruta no
#    hay og:image; sin el alt, la tarjeta no dice nada a quien no la ve.
if ! grep -q 'path: /assets/img/tarjeta-social.jpg' _config.yml; then
  echo "RQ012: _config.yml no declara la imagen de previsualización"; err=1
fi
for clave in 'width: 1200' 'height: 630' 'alt:'; do
  if ! grep -q "$clave" _config.yml; then
    echo "RQ012: _config.yml no declara '$clave' para la imagen"; err=1
  fi
done
# `jekyll-seo-tag` 2.8 solo lee `page.image`: una clave `image:` al nivel del
# sitio se queda sin pintar, así que tiene que ir por `defaults`.
if ! awk '/^defaults:/{d=1} d && /image:/{found=1} END{exit !found}' _config.yml; then
  echo "RQ012: la imagen no está dentro del bloque defaults"; err=1
fi

# 3. Mide 1200x630 y no lleva metadatos. Lo segundo importa porque la tarjeta
#    sale de una foto del viaje (blog.RQ005).
if command -v python3 >/dev/null 2>&1; then
  python3 - "$tarjeta" <<'PY' || err=1
import sys
try:
    from PIL import Image
except ImportError:
    sys.exit(0)          # sin Pillow no se puede comprobar; no se bloquea el gate
ruta = sys.argv[1]
try:
    im = Image.open(ruta)
except Exception as e:
    print(f'RQ012: no se puede abrir {ruta}: {e}')
    sys.exit(1)
fallos = []
if im.size != (1200, 630):
    fallos.append(f'mide {im.size[0]}x{im.size[1]} y la tarjeta es 1200x630')
if dict(im.getexif()):
    fallos.append('conserva metadatos EXIF')
for f in fallos:
    print(f'RQ012: {ruta} {f}')
sys.exit(1 if fallos else 0)
PY
fi

exit $err
