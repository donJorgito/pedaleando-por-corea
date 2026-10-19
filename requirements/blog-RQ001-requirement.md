### blog.RQ001 - Una entrada por cada día del viaje

**Description:**

El sitio debe publicar una entrada independiente por cada una de las **24 jornadas** del viaje, con URL permanente, de modo que cada día sea enlazable y citable por separado.

Las jornadas se identifican por **su número** —de `dia-01` a `dia-24`—, no por su fecha de calendario: las fechas exactas del viaje no se publican (ver `blog.RQ008`). La fecha del nombre de fichero es la de **publicación**, que es lo que Jekyll necesita para ordenar y lo que anuncia el `feed.xml`.

Junto a las entradas diarias, el sitio puede publicar **entradas temáticas** (presupuesto, alojamiento, la bici, la comida...). No corresponden a una jornada concreta, así que no llevan número de día.

**Parent Requirement:** N/A

**Acceptance Criteria:**

- Todo fichero de `_posts/` encaja en uno de los dos patrones: diaria o temática.
- Cada entrada **diaria** sigue el patrón `AAAA-MM-DD-dia-NN-<titulo>.md`, donde la fecha es la de publicación y es **posterior al viaje**.
- No hay dos entradas diarias con el mismo número de día.
- La serie está **completa**: existen las 24 jornadas, de la 1 a la 24, sin huecos ni números fuera de rango.
- Cada entrada **temática** sigue el patrón `AAAA-MM-DD-<titulo>.md` y también se fecha después del viaje, cuando ya se puede escribir con todos los datos.
