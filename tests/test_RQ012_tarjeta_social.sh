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

# 4. Cada entrada de día declara SU tarjeta, y esa tarjeta existe, mide
#    1200x630 y la usa alguien. Las entradas por temas no llevan foto, así que
#    se quedan con la del sitio: no se les exige.
if command -v python3 >/dev/null 2>&1; then
  python3 - <<'PY' || err=1
import glob, os, re, sys
try:
    from PIL import Image
except ImportError:
    sys.exit(0)          # sin Pillow no se puede comprobar; no se bloquea el gate

fallos, usadas = [], set()
for f in sorted(glob.glob('_posts/*-dia-[0-9][0-9]-*.md')):
    fm = open(f, encoding='utf-8').read().split('---\n')[1]
    m = re.search(r'^image:\s*$\n((?:^[ \t]+.*$\n)+)', fm, re.M)
    base = os.path.basename(f)
    if not m:
        fallos.append(f'{base} no declara su propia tarjeta')
        continue
    campos = dict(re.findall(r'^\s+(\w+):\s*"?([^"\n]*)"?\s*$', m.group(1), re.M))
    ruta = (campos.get('path') or '').lstrip('/')
    if not ruta.startswith('assets/img/tarjetas/'):
        fallos.append(f'{base} apunta a {ruta or "nada"}, que no es una tarjeta')
        continue
    if not os.path.exists(ruta):
        fallos.append(f'{base} apunta a {ruta}, que no existe')
        continue
    usadas.add(os.path.basename(ruta))
    ancho, alto = Image.open(ruta).size
    if (ancho, alto) != (1200, 630):
        fallos.append(f'{ruta} mide {ancho}x{alto} y la tarjeta es 1200x630')
    if len(campos.get('alt', '')) < 20:
        fallos.append(f'{base} no describe su tarjeta en el alt')

for t in sorted(os.listdir('assets/img/tarjetas')):
    if t != '.gitkeep' and t not in usadas:
        fallos.append(f'assets/img/tarjetas/{t} no lo usa ninguna entrada')

for x in fallos:
    print(f'RQ012: {x}')
sys.exit(1 if fallos else 0)
PY
fi

exit $err
