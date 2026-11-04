#!/usr/bin/env bash
# Hace la tarjeta de previsualización de una entrada (blog.RQ012) a partir de
# una foto YA publicada en assets/img/.
#
#   _tools/preparar-tarjeta.sh <nombre-de-la-foto.jpg>
#
# Sale en assets/img/tarjetas/<mismo-nombre>, midiendo 1200x630.
#
# Por qué 1200x630 y no la foto a pelo: WhatsApp, Telegram y X recortan la
# imagen de la tarjeta a esa proporción (1,91:1). El 88% de las fotos del
# viaje son verticales de móvil, así que servirlas tal cual significa que el
# recorte se queda con una banda del centro — un torso, media bici, el suelo.
#
# Cómo se resuelve el vertical: la foto se mete entera, escalada a la altura
# de la tarjeta, y el hueco de los lados se rellena con la MISMA foto ampliada
# y desenfocada. Es lo que hacen los vídeos verticales y funciona: la foto se
# ve completa y la tarjeta tiene el tamaño que esperan las aplicaciones.
#
# Se parte de la foto publicada y no del original porque la publicada ya pasó
# por `preparar-foto.sh`: sin EXIF, sin coordenadas y con quien saliera de
# fondo difuminado (blog.RQ005).
set -euo pipefail

cd "$(dirname "$0")/.."

foto="${1:?uso: _tools/preparar-tarjeta.sh <nombre-de-la-foto.jpg>}"
origen="assets/img/$foto"
destino="assets/img/tarjetas/$foto"

[ -f "$origen" ] || { echo "no existe $origen" >&2; exit 1; }
mkdir -p assets/img/tarjetas

magick "$origen" -auto-orient -strip \
  \( +clone -resize 1200x630^ -gravity center -extent 1200x630 \
     -blur 0x24 -brightness-contrast -12x-6 \) \
  +swap \
  \( -clone 1 -resize x630 \) -delete 1 \
  -gravity center -composite \
  -resize 1200x630 -quality 82 "$destino"

magick identify -format 'hecha %f %wx%h\n' "$destino"
