### blog.RQ009 - Respeta el tema oscuro y deja elegirlo

**Description:**

Buena parte de las visitas llegan de noche y desde el teléfono, con el sistema
en tema oscuro. Un fondo blanco a pantalla completa es lo que hace que se
cierre la pestaña. El sitio debe **adaptarse a la preferencia del sistema
operativo o del navegador** y, además, permitir **forzar** claro u oscuro desde
la propia página, recordando la elección entre visitas.

La preferencia del sistema manda mientras el lector no elija nada: no se
impone un tema por defecto distinto del suyo.

**Parent Requirement:** blog.RQ004

**Acceptance Criteria:**

- La hoja de estilo propia define una paleta oscura bajo
  `@media (prefers-color-scheme: dark)`, de modo que un visitante con el
  sistema en oscuro la recibe **sin tocar nada y sin JavaScript**.
- El `<head>` declara `<meta name="color-scheme">` con los dos esquemas, para
  que el navegador tiña también barras de desplazamiento y controles.
- Existe un control visible en la página para cambiar de tema, y la elección
  se guarda en el navegador (`localStorage`) y se aplica **antes del primer
  pintado**, sin destello blanco.
- Si el lector no ha elegido nada, se sigue la preferencia del sistema; la
  elección manual la sobrescribe en las dos direcciones.
- El control es accesible: es un `<button>`, con `aria-pressed` o equivalente,
  y utilizable con el teclado.
