### blog.RQ012 - Un enlace compartido se ve como una tarjeta con foto

**Description:**

La mayoría de la gente va a llegar aquí porque alguien le manda el enlace por
WhatsApp, Telegram o un mensaje directo de Instagram. Esas aplicaciones no
muestran la URL: muestran una tarjeta con título, resumen y **una imagen**.
Sin imagen la tarjeta sale como una línea de texto gris y casi nadie la pulsa,
así que la foto de previsualización es parte de que el blog se lea, no
decoración.

El sitio declara una imagen de previsualización para todas sus páginas, y cada
entrada puede poner la suya.

La imagen vive en `assets/img/tarjeta-social.jpg` y se saca de una foto **ya
publicada** —la de los tres con la bandera en el kilómetro 0— recortada a la
proporción que piden las tarjetas (1200 × 630). Se parte de una foto publicada
y no del original a propósito: la publicada ya pasó por
`_tools/preparar-foto.sh`, o sea sin EXIF, sin coordenadas y con quien
apareciera de fondo difuminado. El recorte es:

```bash
magick assets/img/dia-08-la-bandera-en-el-kilometro-0.jpg \
  -auto-orient -strip -crop 1500x788+0+40 +repage -resize 1200x \
  -quality 80 assets/img/tarjeta-social.jpg
```

**Parent Requirement:** blog.RQ002

**Acceptance Criteria:**

- Existe `assets/img/tarjeta-social.jpg`, mide **1200 × 630** y no lleva
  metadatos EXIF.
- `_config.yml` declara esa imagen con su `width`, `height` y `alt` por
  `defaults`, de modo que `jekyll-seo-tag` la emite como `og:image` en todas
  las páginas. Se declara en `defaults` y no como clave suelta del sitio
  porque `jekyll-seo-tag` 2.8 solo lee `page.image`.
- El `alt` describe la foto, igual que cualquier otra imagen del sitio
  (`blog.RQ010`).
- Una entrada puede declarar su propia `image:` en el front matter y esa gana
  sobre la del sitio.
