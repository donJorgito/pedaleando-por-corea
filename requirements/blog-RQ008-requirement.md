### blog.RQ008 - El blog no publica las fechas exactas del viaje

**Description:**

El blog cuenta un viaje real de tres personas que estuvieron fuera de casa durante tres semanas seguidas. Publicar el calendario exacto —qué día concreto se estuvo en cada sitio y, por tanto, qué días la casa estuvo vacía— es información personal que no aporta nada al lector y que no se puede retirar una vez indexada.

El viaje se sitúa por **periodo aproximado** («la última semana de septiembre y las dos primeras de octubre de 2026») y se organiza por **número de jornada** («día 11 de 24»), nunca por fecha de calendario. Esto no resta utilidad: quien prepara la ruta necesita saber la época del año —por el clima y por los precios— y el orden de las etapas, no el día del mes.

La restricción aplica a todo lo que el sitio publica: el texto, las URL, lo que imprime la plantilla, el `feed.xml` y el `sitemap.xml`.

**Parent Requirement:** N/A

**Acceptance Criteria:**

- Ninguna URL del sitio contiene la fecha: el `permalink` de `_config.yml` no usa `:year`, `:month` ni `:day`.
- Ninguna página imprime la fecha de publicación de una entrada. El layout `post` del tema se sobrescribe localmente para no sacar el bloque `post-meta` con el `<time>`.
- Ninguna entrada se fecha con el día del viaje que cuenta. La comprobación no puede consistir en comparar contra el calendario del viaje, porque eso obligaría a escribirlo en el repositorio, que es público: se verifica exigiendo que **las 24 entradas diarias compartan una misma fecha de fichero**. Siendo 24 jornadas distintas, ninguna puede entonces ser la suya, y el itinerario no se puede reconstruir.
- El campo `date:` del front matter coincide con la fecha del nombre de fichero, que es la de **publicación**. Es la fecha que acaban anunciando `feed.xml` y `sitemap.xml`.
- El texto de las entradas, de la portada y del `README` no da ninguna fecha de día concreto: ni «<día> de septiembre», ni «<día>/<mes>/2026», ni equivalentes. Sí puede nombrar el mes o el periodo.
- La fecha de un hecho histórico o de una consulta externa (por ejemplo, «el túnel se descubrió en octubre de 1978» o «precios consultados en octubre de 2026») queda fuera de esta restricción: no es el itinerario.
