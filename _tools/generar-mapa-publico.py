#!/usr/bin/env python3
"""Genera la página pública del mapa a partir del mapa de trabajo.

    _tools/generar-mapa-publico.py <mapa-de-trabajo.html> --inicio AAAA-MM-DD \
        [--salida mapa.html]

El mapa de trabajo vive fuera de este repositorio, en el directorio privado
del viaje, y está fechado: las pistas van por día de calendario, las cabinas
guardan la hora exacta en la que se pasó por ellas y los alojamientos la
noche. Nada de eso se publica (`blog.RQ008`), así que este script coge solo
los **datos geográficos** y traduce **todas** las fechas a «día N» del viaje.

La fecha de salida del viaje NO está escrita en ningún sitio de este
repositorio, y por eso se pasa a mano con `--inicio`: es el único dato que
convierte un día de calendario en un número de jornada, y escribirlo aquí
sería publicar el itinerario entero.

Al final comprueba la salida: si se le ha colado cualquier cosa con forma de
fecha, falla y no escribe nada.
"""
import argparse
import datetime
import io
import json
import os
import re
import sys

PATRON_D = re.compile(r"const D = (\{.*?\});\n", re.S)
# Lo que no puede aparecer en la página publicada.
PATRON_FECHA = re.compile(
    r"20[0-9]{2}-[01][0-9]-[0-3][0-9]"                 # AAAA-MM-DD
    r"|(?<![\d.])[0-3]?[0-9]/[01]?[0-9]/20[0-9]{2}"    # DD/MM/AAAA
    r"|(?<![\d.])[0-3]?[0-9]/[01]?[0-9](?![\d.])"      # DD/MM
    r"|[0-9]{1,2} de (?:enero|febrero|marzo|abril|mayo|junio|julio|agosto"
    r"|septiembre|octubre|noviembre|diciembre)")

CABECERA = """---
title: El mapa
permalink: /mapa/
description: >-
  El mapa de la ruta Seúl → Busan por el 국토종주: los cinco carriles bici
  oficiales, el trazado real que hicimos reconstruido con el GPS de las
  fotos, las cabinas de certificación y los alojamientos.
---
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8">
<title>El mapa · {{ site.title }}</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="color-scheme" content="light dark">
<meta name="description" content="{{ page.description | strip_newlines }}">
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css">
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<style>
  html, body { margin: 0; height: 100%;
    font: 14px/1.4 system-ui, -apple-system, sans-serif }
  #mapa { height: 100% }
  .leyenda { background: #fff; padding: 10px 12px; border-radius: 6px;
    box-shadow: 0 1px 6px rgba(0,0,0,.3); line-height: 1.8 }
  .leyenda b { display: block; margin-bottom: 4px }
  .muestra { display: inline-block; width: 22px; height: 4px;
    vertical-align: middle; margin-right: 6px }
  .pin { font-size: 18px; line-height: 18px; text-align: center }
  /* El enlace de vuelta: esta página no lleva la cabecera del blog, porque
     el mapa ocupa la pantalla entera. */
  .volver { position: absolute; top: 10px; right: 10px; z-index: 1000;
    background: rgba(255,255,255,.94); border: 1px solid #ccc;
    border-radius: 6px; padding: 6px 10px; text-decoration: none;
    color: #1a4f8a; font-weight: 600;
    box-shadow: 0 1px 4px rgba(0,0,0,.25) }
  .volver:hover { background: #f0f6ff }
  @media (prefers-color-scheme: dark) {
    .leyenda { background: #1d2228; color: #d9dde1 }
    .volver { background: rgba(29,34,40,.94); border-color: #3a444e;
      color: #7db4f5 }
    .volver:hover { background: #262d35 }
    .leaflet-control-layers, .leaflet-bar a {
      background: #1d2228; color: #d9dde1 }
    .leaflet-bar a { border-bottom-color: #3a444e }
  }
</style>
</head>
<body>
<div id="mapa"></div>
<a class="volver" href="{{ site.baseurl }}/">← Volver al blog</a>
<script>
"""

CUERPO = """const mapa = L.map('mapa').setView([36.5, 127.8], 7);

// Proveedores de teselas, probados uno a uno en el navegador:
//  - tile.openstreetmap.org -> 403 (rechaza el Referer)
//  - CARTO basemaps -> responden 200 con la marca "API KEY REQUIRED" encima
//  - OpenTopoMap y Esri -> funcionan limpios
const fondos = {
  'Relieve (OpenTopoMap)': L.tileLayer(
    'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
    {maxZoom: 17, subdomains: 'abc',
     attribution: '&copy; OpenStreetMap, &copy; OpenTopoMap'}),
  'Callejero (Esri)': L.tileLayer(
    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
    {maxZoom: 19, attribution: '&copy; Esri'}),
  'Satélite (Esri)': L.tileLayer(
    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
    {maxZoom: 19, attribution: '&copy; Esri'}),
};
fondos['Relieve (OpenTopoMap)'].addTo(mapa);

const colores = {Ara: '#8e44ad', Han: '#2980b9', Namhangang: '#16a085',
                 Saejae: '#d35400', Nakdonggang: '#c0392b'};

const capaOficial = L.layerGroup();
for (const [nombre, pts] of Object.entries(D.oficial)) {
  L.polyline(pts, {color: colores[nombre] || '#555', weight: 3, opacity: .75})
    .bindTooltip('Carril bici oficial: ' + nombre).addTo(capaOficial);
}
capaOficial.addTo(mapa);

// El trazado real, reconstruido con las coordenadas de las fotos de cada
// jornada. Por eso tiene saltos: donde no hubo foto, no hay punto.
const capaTrack = L.layerGroup();
for (const [dia, pts] of Object.entries(D.track)) {
  L.polyline(pts, {color: '#111', weight: 2, dashArray: '4 4', opacity: .8})
    .bindTooltip('Nuestro recorrido, ' + dia).addTo(capaTrack);
}
capaTrack.addTo(mapa);

const icono = (emoji, color) => L.divIcon({html:
  `<div class="pin" style="background:${color};border-radius:50%;width:22px;height:22px;
   border:2px solid #fff;box-shadow:0 1px 4px rgba(0,0,0,.4)">${emoji}</div>`,
  className: '', iconSize: [22, 22], iconAnchor: [11, 11]});

const capaCabinas = L.layerGroup();
D.cabinas.forEach(c => {
  const visitada = !!c.cuando;
  L.marker([c.lat, c.lon], {icon: icono(visitada ? '🛂' : '·',
      visitada ? '#e67e22' : '#bbb')})
   .bindPopup(`<b>Cabina de certificación</b><br>${c.nombre}<br>` +
     (visitada ? `La sellamos el <b>${c.cuando}</b>`
               : 'Sin foto nuestra cerca'))
   .addTo(capaCabinas);
});
capaCabinas.addTo(mapa);

const capaCamas = L.layerGroup();
D.alojamientos.forEach(a => {
  L.marker([a.lat, a.lon], {icon: icono('🛏️', '#2c3e50')})
   .bindPopup(`<b>Alojamiento</b><br>${a.nombre}<br>Noche del <b>${a.noche}</b>` +
     (a.krw ? `<br>${a.krw} wones` : ''))
   .addTo(capaCamas);
});
capaCamas.addTo(mapa);

const capaKakao = L.layerGroup();
const emojiKakao = {cabina: '🛂', alojamiento: '🛏️', bicis: '🔧', otro: '⭐'};
(D.kakao || []).forEach(k => {
  L.marker([k.lat, k.lon], {icon: icono(emojiKakao[k.tipo] || '⭐', '#16a085')})
   .bindPopup(`<b>Punto guardado en KakaoMap</b><br>${k.nombre}<br><i>${k.tipo}</i>`)
   .addTo(capaKakao);
});
capaKakao.addTo(mapa);

L.control.layers(fondos, {
  'Carriles bici oficiales': capaOficial,
  'Nuestro recorrido (según las fotos)': capaTrack,
  'Cabinas de certificación': capaCabinas,
  'Alojamientos': capaCamas,
  'Puntos guardados en KakaoMap': capaKakao
}, {collapsed: true}).addTo(mapa);

const leyenda = L.control({position: 'bottomleft'});
leyenda.onAdd = () => {
  const d = L.DomUtil.create('div', 'leyenda');
  const visitadas = D.cabinas.filter(c => c.cuando).length;
  d.innerHTML = `<b>Pedaleando por Corea · Seúl → Busan</b>` +
    Object.entries(colores).map(([n, c]) =>
      `<span class="muestra" style="background:${c}"></span>${n}<br>`).join('') +
    `<span class="muestra" style="background:#111"></span>Nuestro recorrido<br>` +
    `🛂 ${visitadas} de ${D.cabinas.length} cabinas con foto nuestra<br>` +
    `🛏️ ${D.alojamientos.length} alojamientos`;
  return d;
};
leyenda.addTo(mapa);

const todo = [];
Object.values(D.track).forEach(pts => todo.push(...pts));
if (todo.length) mapa.fitBounds(L.latLngBounds(todo).pad(0.05));
</script>
</body>
</html>
"""


def dia_de(fecha, inicio):
    """Número de jornada del viaje para una fecha de calendario."""
    return (fecha - inicio).days + 1


def etiqueta(fecha, inicio):
    n = dia_de(fecha, inicio)
    return "día %d" % n if 1 <= n <= 24 else "antes de salir"


def traduce(datos, inicio):
    """Sustituye toda fecha de calendario por el día del viaje."""
    salida = {"oficial": datos["oficial"]}

    salida["track"] = {}
    for clave, puntos in datos["track"].items():
        fecha = datetime.date(*[int(x) for x in clave.split("-")])
        salida["track"]["día %d" % dia_de(fecha, inicio)] = puntos

    salida["cabinas"] = []
    for c in datos["cabinas"]:
        c = dict(c)
        c.pop("dist", None)            # distancia foto-cabina: dato interno
        if c.get("cuando"):
            # "DD/MM HH:MM" -> "día N, a las HH:MM"
            dm, hora = c["cuando"].split(" ")
            d, m = [int(x) for x in dm.split("/")]
            fecha = datetime.date(inicio.year, m, d)
            c["cuando"] = "%s, a las %s" % (etiqueta(fecha, inicio), hora)
        salida["cabinas"].append(c)

    salida["alojamientos"] = []
    for a in datos["alojamientos"]:
        a = dict(a)
        fecha = datetime.date(*[int(x) for x in a["noche"].split("-")])
        a["noche"] = etiqueta(fecha, inicio)
        salida["alojamientos"].append(a)

    salida["kakao"] = []
    for k in datos.get("kakao", []):
        k = dict(k)
        k.pop("guardado", None)        # cuándo se guardó: no aporta y fecha
        salida["kakao"].append(k)

    return salida


def main():
    p = argparse.ArgumentParser()
    p.add_argument("origen", help="mapa de trabajo (HTML con const D = {...})")
    p.add_argument("--inicio", required=True,
                   help="fecha de salida del viaje, AAAA-MM-DD. No se "
                        "guarda en ningún fichero de este repositorio")
    p.add_argument("--salida", default="mapa.html")
    args = p.parse_args()

    inicio = datetime.date(*[int(x) for x in args.inicio.split("-")])
    fuente = io.open(args.origen, encoding="utf-8").read()
    m = PATRON_D.search(fuente)
    if not m:
        sys.exit("no encuentro 'const D = {...};' en %s" % args.origen)

    datos = traduce(json.loads(m.group(1)), inicio)
    pagina = (CABECERA
              + "const D = " + json.dumps(datos, ensure_ascii=False) + ";\n"
              + CUERPO)

    colado = PATRON_FECHA.search(pagina)
    if colado:
        sys.exit("se ha colado algo con forma de fecha (%r): no escribo nada"
                 % colado.group(0))

    raiz = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    destino = os.path.join(raiz, args.salida)
    io.open(destino, "w", encoding="utf-8").write(pagina)
    print("escrito %s (%d KB, %d jornadas, %d cabinas, %d alojamientos)" % (
        args.salida, len(pagina) // 1024, len(datos["track"]),
        len(datos["cabinas"]), len(datos["alojamientos"])))


if __name__ == "__main__":
    main()
