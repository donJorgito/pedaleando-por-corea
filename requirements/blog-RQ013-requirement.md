### blog.RQ013 - Se puede saber si alguien lo lee, sin espiar a nadie

**Description:**

GitHub Pages sirve el sitio y **no cuenta nada**: no hay registro de accesos
al que asomarse, así que sin añadir algo no se puede saber si el blog lo leen
tres personas o trescientas. Hacen falta dos cosas distintas, y el sitio
prepara las dos:

1. **Cuánta gente entra y por dónde llega** — un contador de visitas. Se usa
   GoatCounter por lo que no hace: sin cookies, sin identificadores por
   persona y sin datos personales, con lo que la página no necesita aviso de
   consentimiento. Va en `_includes/analitica.html`.
2. **Qué busca la gente que llega de Google** — la propiedad del sitio en
   Search Console, que es lo único que da las búsquedas, las impresiones y el
   estado de indexación. Para eso Google exige acreditar que el sitio es
   nuestro, y la vía que no deja ficheros sueltos es la etiqueta
   `<meta name="google-site-verification">` que `jekyll-seo-tag` escribe a
   partir de `google_site_verification` en `_config.yml`.

Las dos piezas son **configurables y apagables**: el contador no carga nada
mientras su clave esté vacía, y ninguna de las dos mide nada en una
compilación local.

**Parent Requirement:** blog.RQ002

**Acceptance Criteria:**

- Existe `_includes/analitica.html` y el `<head>` del sitio lo incluye.
- El contador se carga **solo** si `jekyll.environment` es `production` **y**
  `site.analitica.goatcounter` tiene un valor: con la clave vacía el HTML
  publicado no pide nada a terceros.
- El script del contador está **pineado a una versión concreta** y lleva su
  hash `integrity` y `crossorigin`, para que el navegador se niegue a
  ejecutarlo si cambia.
- No se carga Google Analytics ni ningún contador que use cookies, ni queda
  en el repositorio el include del tema que lo haría.
- `_config.yml` declara `google_site_verification`, y el HTML generado lleva
  la etiqueta `meta` correspondiente.
