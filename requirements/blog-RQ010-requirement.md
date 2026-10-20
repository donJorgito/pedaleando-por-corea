### blog.RQ010 - Fotos del viaje, con pie y accesibles

**Description:**

Una crónica de viaje sin fotos se lee a medias. Las entradas llevan
fotografías propias del viaje, y se publican con las mismas reglas que el
texto: **sin metadatos**, **sin fechas** y **sin datos de nadie**.

Toda foto entra por el include `_includes/foto.html`, que es lo que garantiza
que ninguna se publique sin descripción alternativa ni sin reservar su hueco
en la página. Las imágenes se preparan con `_tools/preparar-foto.sh`.

Sobre quién sale: las fotos son de los tres que hicieron el viaje y salen a
cara descubierta porque así lo ha decidido el autor. **Las personas que
aparecen de fondo sin haberlo elegido —en un restaurante, en un mercado, en
un andén— se difuminan.**

**Parent Requirement:** blog.RQ005

**Acceptance Criteria:**

- Las imágenes viven en `assets/img/` y **ningún nombre de fichero contiene
  una fecha**, que reconstruiría el itinerario (`blog.RQ008`).
- Las imágenes **no llevan EXIF**: lo comprueba `blog.RQ005` buscando
  coordenadas GPS, y `_tools/preparar-foto.sh` las quita todas con `-strip`.
- Toda foto se inserta con `{% include foto.html %}` y **siempre** con los
  cuatro parámetros obligatorios: `src`, `alt`, `ancho` y `alto`.
- El `alt` **describe la imagen**, no la nombra: tiene al menos 20
  caracteres. Es lo que lee quien usa un lector de pantalla.
- `ancho` y `alto` son los píxeles reales del fichero, para que el navegador
  reserve el hueco y el texto no salte al cargar.
- El include emite `loading="lazy"`: una entrada con ocho fotos no puede
  costar ocho descargas antes de poder leer la primera línea.
- No hay imágenes huérfanas: todo fichero de `assets/img/` está referenciado
  por alguna entrada.
