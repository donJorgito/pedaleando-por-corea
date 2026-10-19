### blog.RQ007 - El diario se lee en orden, del primer día al último

**Description:**

Un diario de viaje se lee hacia delante. El orden inverso que traen por defecto los blogs —la entrada más reciente arriba— obliga al lector a empezar por el final, y en una crónica de 24 jornadas eso la hace prácticamente ilegible.

La portada debe listar las entradas diarias **en orden ascendente de día**, y cada entrada diaria debe enlazar con la **anterior** y con la **siguiente**, para poder recorrer el viaje entero sin volver al índice.

**Parent Requirement:** blog.RQ001

**Acceptance Criteria:**

- Cada entrada diaria declara en su front matter el número de jornada (`dia`) y usa el layout que pinta la navegación.
- Los números de día son únicos y empiezan en 1.
- La portada ordena las entradas diarias por `dia` ascendente, no por fecha descendente.
- El layout de las entradas diarias genera enlaces `rel="prev"` y `rel="next"` hacia el día anterior y el siguiente, cuando existen.
- Las entradas temáticas quedan fuera de esa cadena: no tienen número de día y se listan aparte.
