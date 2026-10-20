### blog.RQ011 - El mapa de la ruta, en el propio sitio

**Description:**

La crónica cuenta la ruta en 24 entradas, pero lo que se entiende de un golpe
es **el dibujo**: los cinco carriles bici oficiales, el trazado que hicimos de
verdad, dónde están las 35 cabinas de certificación y dónde se durmió cada
noche. El sitio publica ese mapa **como una página propia**, servida por
GitHub Pages igual que el resto del blog, sin depender de ninguna máquina de
casa.

El mapa de trabajo con el que se construye vive **fuera** de este
repositorio, en el directorio privado del viaje, y está fechado: pistas por
día de calendario, hora exacta de cada sello, noche de cada alojamiento.
Nada de eso se publica. La página se genera con
`_tools/generar-mapa-publico.py`, que coge solo los datos geográficos y
traduce **todas** las fechas a «día N» de viaje.

La fecha de salida es el único dato que convierte un día de calendario en un
número de jornada, así que **no está escrita en ningún fichero del
repositorio**: se le pasa al generador a mano cada vez.

**Parent Requirement:** blog.RQ008

**Acceptance Criteria:**

- Existe la página `mapa.html`, con `permalink: /mapa/` y un `title`, de modo
  que el tema la enlaza en la cabecera del sitio.
- La página **no contiene ninguna fecha de calendario**: ni `AAAA-MM-DD`, ni
  `DD/MM`, ni «N de septiembre». Las jornadas se nombran «día N», las cabinas
  dicen el día y la hora a la que se sellaron, y los alojamientos la noche
  del día N.
- El generador **falla y no escribe nada** si se le cuela algo con forma de
  fecha en la salida, y recibe la fecha de salida del viaje por argumento y
  no desde un fichero versionado.
- El mapa no publica datos internos del proceso: ni la distancia entre la
  foto y la cabina, ni cuándo se guardó un punto en KakaoMap.
- La página es autónoma (ocupa la pantalla entera, sin la cabecera del tema)
  pero lleva **un enlace de vuelta al blog** con el `baseurl` delante, declara
  `viewport` y respeta el tema oscuro del sistema (`blog.RQ009`).
- Los nombres y precios de los alojamientos que aparecen son los mismos que
  ya publica la entrada de dónde dormir: el mapa no añade información
  personal de nadie (`blog.RQ005`).
