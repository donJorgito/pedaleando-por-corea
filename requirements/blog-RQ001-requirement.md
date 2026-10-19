### blog.RQ001 - Una entrada por cada día del viaje

**Description:**

El sitio debe publicar una entrada independiente por cada jornada del viaje (24 jornadas), con fecha propia y URL permanente, de modo que cada día sea enlazable y citable por separado.

Junto a las entradas diarias, el sitio puede publicar **entradas temáticas** (presupuesto, alojamiento, la bici, la comida...). No corresponden a una jornada concreta, así que no llevan número de día; se fechan a partir del final del viaje, cuando ya se pueden escribir con todos los datos.

**Parent Requirement:** N/A

**Acceptance Criteria:**

- Todo fichero de `_posts/` encaja en uno de los dos patrones: diaria o temática.
- Cada entrada **diaria** sigue el patrón `AAAA-MM-DD-dia-NN-<titulo>.md` y su fecha cae dentro del rango del viaje.
- No hay dos entradas diarias con el mismo número de día.
- La serie está **completa**: existen las 24 jornadas, de la 1 a la 24, sin huecos ni días fuera de rango.
- Cada entrada **temática** sigue el patrón `AAAA-MM-DD-<titulo>.md` y su fecha no es anterior al inicio del viaje.
