# `pedaleando-por-corea`

Blog del viaje en bicicleta **Seúl → Busan** por la ruta **국토종주 (Gukto
Jongju)**, en la última semana de septiembre y las dos primeras de octubre
de 2026. Publicado con Jekyll en GitHub Pages:
<https://donjorgito.github.io/pedaleando-por-corea/>

## Qué es esto

El sitio cuenta el viaje **día a día** y, en paralelo, responde a las preguntas
que se hace quien quiere prepararlo: dónde empieza la ruta de verdad, qué es el
pasaporte de las cabinas de certificación, cuánto cuesta alquilar y devolver la
bici, dónde se duerme, qué puertos duelen y cuántos kilómetros son en realidad.

Está escrito en **español** a propósito: casi toda la información sobre esta
ruta está en inglés o en coreano.

El material de partida (1.654 fotos con sus coordenadas, los PDF de las
reservas y el chat del grupo) se procesa fuera de este repositorio; aquí solo
vive lo publicable.

## Con qué está hecho

- **Jekyll** con el tema `minima`, construido por GitHub Pages.
- Plugins: `jekyll-feed` (RSS), `jekyll-sitemap` y `jekyll-seo-tag` — los dos
  últimos son los que hacen el sitio indexable (requisito `blog.RQ002`).
- Contenido en Markdown con front matter YAML.

## Cómo se publica y cómo se trabaja en local

Publicar es hacer `push` a `main`: el workflow `pages.yml` construye y despliega.

Para trabajar en local:

```bash
pre-commit install                 # instala el guardarraíl de commit
tests/run-all.sh                   # la batería de tests (uno por requisito)
pre-commit run --all-files         # obligatorio antes de cada push
```

## Dónde se configura cada cosa

| Dónde | Clave | Para qué |
| --- | --- | --- |
| `_config.yml` | `url` + `baseurl` | dirección pública del sitio |
| `_config.yml` | `plugins` | SEO e indexación |
| `_posts/*.md` | `title`, `date`, `description`, `tags` | metadatos de cada entrada |
| `mapa.html` | `permalink: /mapa/` | la página del mapa, que se genera y no se escribe a mano |

## Dependencias

El sitio es estático y las entradas no cargan nada de fuera. La única
excepción es la página del mapa (`/mapa/`), que en el navegador del lector
carga **Leaflet** desde `unpkg` y las teselas de **OpenTopoMap** y **Esri**:
un mapa sin teselas no es un mapa. Van pineadas por versión en la propia URL.

Las acciones de CI/CD están pineadas al SHA de 40 caracteres con el semver en
comentario.

## Versiones en uso

| Componente | Versión |
| --- | --- |
| `actions/checkout` | v7.0.1 |
| `actions/configure-pages` | v6.0.0 |
| `actions/jekyll-build-pages` | v1.0.13 |
| `actions/upload-pages-artifact` | v5.0.0 |
| `actions/deploy-pages` | v5.0.1 |
| `gitleaks/gitleaks-action` | v3.0.0 |
| `DavidAnson/markdownlint-cli2-action` | v24.2.0 |
| Leaflet (solo en `/mapa/`) | 1.9.4 |
| Runner | `ubuntu-24.04` |

## Documentación de apoyo

- `requirements/` — un fichero por requisito (`blog-RQxxx-requirement.md`).
- `tests/` — un test por requisito, con el `REQ-ID` en el nombre del fichero.
- `CONTRIBUTING.md` — cómo se contribuye, incluida la norma de uso de IA.
- `CHANGELOG.md` — historial de versiones.

## Lo que se revisa a mano

La **selección de fotos** de cada entrada es manual: las imágenes con personas
reconocibles las aprueba el autor antes de publicarse. El test `blog.RQ005`
comprueba automáticamente lo que sí es verificable — que no se cuelan IBAN,
teléfonos ni coordenadas GPS en el EXIF — pero no sustituye a esa revisión.

## Decisiones conscientes

Esto es un blog personal, y la disciplina que se le aplica —un requisito por
funcionalidad, un test por requisito, gates en CI, dependencias pineadas— es
más de la que necesita. Se mantiene porque ordena el trabajo y porque hace
que los errores salgan antes de publicarse, no después.

Dicho eso, hay tres cosas que se hacen a sabiendas:

1. **Las dependencias de `pre-commit` vienen de PyPI público**, con la versión
   pineada. No hay un espejo interno detrás, así que la garantía es el pineo,
   no el origen.
2. **Las acciones de GitHub se consumen del Marketplace público**, pineadas al
   SHA de 40 caracteres. Tampoco se replica aquí el código externo.
3. **No hay gestión de cambios formal**: ni inventario de activos ni registro
   de cambios. Para un blog de una persona, sobra.

## Autor

Jorge Lázaro Molina — [@donJorgito](https://github.com/donJorgito)
