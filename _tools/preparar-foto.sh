#!/usr/bin/env bash
# Prepara una foto del viaje para publicarla: la reescala, le quita TODOS los
# metadatos y la deja en assets/img/ con el nombre que se le pase.
#
#   _tools/preparar-foto.sh <origen> <dia-NN-nombre-corto> [recorte] [difuminar]
#
# El tercer argumento es un recorte opcional en la sintaxis de ImageMagick
# (AnchoxAlto+X+Y), que se aplica ANTES de reescalar.
#
# El cuarto es una lista de caras a difuminar, `cx,cy,rx,ry` separadas por
# punto y coma, medidas en píxeles sobre la imagen ya reescalada. Es para la
# gente que aparece de fondo sin haber dado permiso: en un restaurante o en
# un mercado no se puede hacer una foto sin que salga alguien más, y eso no
# convierte a quien cenaba en la mesa de al lado en parte de la crónica.
# Se difumina con una máscara elíptica con los bordes suavizados, no con un
# rectángulo: un recuadro borroso canta más que la propia cara.
#
# Por qué cada paso:
#   -auto-orient  aplica la rotación del EXIF antes de borrarlo, o la foto
#                 sale tumbada en el navegador.
#   -strip        quita el EXIF entero. Las fotos del viaje llevan
#                 coordenadas GPS y hora exacta: las dos cosas que este
#                 repositorio no publica (blog.RQ005, blog.RQ008).
#   -resize       1500 px de lado mayor. Suficiente para pantalla grande y
#                 muy por debajo del límite de 2 MB del hook de pre-commit.
#   -quality 78   el punto donde una foto de viaje deja de mejorar a la vista.
#
# Imprime la línea de `include` lista para pegar en la entrada, con el
# tamaño real ya calculado (evita el salto de maquetación al cargar).
set -euo pipefail

if [ "$#" -lt 2 ]; then
  sed -n '2,8p' "$0" >&2
  exit 2
fi

origen=$1
nombre=$2
recorte=${3:-}
difuminar=${4:-}

case "$nombre" in
  *20[0-9][0-9]*)
    echo "El nombre no puede llevar una fecha: se publicaría el itinerario" >&2
    echo "(blog.RQ008). Usa algo como dia-08-cabina-kilometro-0." >&2
    exit 2 ;;
esac

raiz=$(cd "$(dirname "$0")/.." && pwd)
destino="$raiz/assets/img/$nombre.jpg"

args=(magick "$origen" -auto-orient)
[ -n "$recorte" ] && args+=(-crop "$recorte" +repage)
args+=(-strip -resize '1500x1500>' -quality 78 "$destino")
"${args[@]}"

if [ -n "$difuminar" ]; then
  # Se difumina después de reescalar: así las coordenadas se miden sobre la
  # imagen que se publica y no hay que convertirlas a mano.
  medidas=$(magick identify -format '%wx%h' "$destino")
  elipses=""
  IFS=';' read -r -a caras <<<"$difuminar"
  for cara in "${caras[@]}"; do
    IFS=',' read -r cx cy rx ry <<<"$cara"
    elipses="$elipses ellipse $cx,$cy $rx,$ry 0,360"
  done
  # Una copia borrosa a la que se le pone como transparencia la máscara de
  # las elipses, y se superpone. Hacerlo al revés (pasar la máscara como
  # tercera imagen de -composite) difumina la foto entera: sin canal alfa,
  # ImageMagick no la toma por máscara.
  magick "$destino" \
    \( +clone -blur 0x20 \
       \( -size "$medidas" xc:black -fill white -draw "$elipses" -blur 0x14 \) \
       -alpha off -compose CopyOpacity -composite \) \
    -compose Over -composite -quality 78 "$destino"
fi

leer=$(magick identify -format '%w %h' "$destino")
ancho=${leer% *}
alto=${leer#* }

printf '{%% include foto.html src="%s.jpg" ancho="%s" alto="%s" alt="" pie="" %%}\n' \
  "$nombre" "$ancho" "$alto"
