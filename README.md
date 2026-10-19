# `pedaleando-por-corea`

Blog del viaje en bicicleta **Seúl → Busan** por la ruta **국토종주 (Gukto
Jongju)**, en la última semana de septiembre y las dos primeras de octubre de 2026. Publicado con Jekyll
en GitHub Pages: <https://donjorgito.github.io/pedaleando-por-corea/>

## Introduction

El sitio cuenta el viaje **día a día** y, en paralelo, responde a las preguntas
que se hace quien quiere prepararlo: dónde empieza la ruta de verdad, qué es el
pasaporte de las cabinas de certificación, cuánto cuesta alquilar y devolver la
bici, dónde se duerme, qué puertos duelen y cuántos kilómetros son en realidad.

Está escrito en **español** a propósito: casi toda la información sobre esta
ruta está en inglés o en coreano.

El material de partida (1.654 fotos con sus coordenadas, los PDF de las
reservas y el chat del grupo) se procesa fuera de este repositorio; aquí solo
vive lo publicable.

## Framework or Coding Technology

- **Jekyll** con el tema `minima`, construido por GitHub Pages.
- Plugins: `jekyll-feed` (RSS), `jekyll-sitemap` y `jekyll-seo-tag` — los dos
  últimos son los que hacen el sitio indexable (requisito `blog.RQ002`).
- Contenido en Markdown con front matter YAML.

## Execution methods

Publicar es hacer `push` a `main`: el workflow `pages.yml` construye y despliega.

Para trabajar en local:

```bash
pre-commit install                 # instala el guardarraíl de commit
tests/run-all.sh                   # la batería de tests (uno por requisito)
pre-commit run --all-files         # obligatorio antes de cada push
```

## Variables

| Dónde | Clave | Para qué |
|---|---|---|
| `_config.yml` | `url` + `baseurl` | dirección pública del sitio |
| `_config.yml` | `plugins` | SEO e indexación |
| `_posts/*.md` | `title`, `date`, `description`, `tags` | metadatos de cada entrada |

## Dependencies

Ninguna dependencia en tiempo de ejecución: el sitio es estático. Las acciones
de CI/CD están pineadas al SHA de 40 caracteres con el semver en comentario.

## Tested Versions

| Componente | Versión |
|---|---|
| `actions/checkout` | v4.2.2 |
| `actions/jekyll-build-pages` | v1.0.13 |
| `actions/deploy-pages` | v4.0.5 |
| `gitleaks/gitleaks-action` | v2.3.7 |
| `DavidAnson/markdownlint-cli2-action` | v16.0.0 |
| Runner | `ubuntu-24.04` |

## Supporting Documents

- `requirements/` — un fichero por requisito (`blog-RQxxx-requirement.md`).
- `tests/` — un test por requisito, con el `REQ-ID` en el nombre del fichero.
- `CONTRIBUTING.md` — cómo se contribuye, incluida la norma de uso de IA.
- `CHANGELOG.md` — historial de versiones.

## Manual Verification (Exceptions Only)

La **selección de fotos** de cada entrada es manual: las imágenes con personas
reconocibles las aprueba el autor antes de publicarse. El test `blog.RQ005`
comprueba automáticamente lo que sí es verificable — que no se cuelan IBAN,
teléfonos ni coordenadas GPS en el EXIF — pero no sustituye a esa revisión.

## Deviations and Open Defects

Esto es un blog personal y la disciplina que se le aplica es más de la que
necesita. Se mantiene porque ordena el trabajo y porque los fallos salen
antes de publicar, no después. Decisiones conscientes:

1. **`.pre-commit-config.yaml`** mantiene la forma canónica (`repo: local`,
   nunca `repo: https://github.com/...`), pero las herramientas se instalan
   desde PyPI público con la versión pineada, de modo que la garantía la da
   el pineo y no el origen.
2. **Las acciones de GitHub** se consumen del Marketplace público (pineadas al
   SHA). El código externo tampoco se replica aquí: la garantía es, otra
   vez, el pineo.
3. **Sin gestión de cambios formal**: para un blog de una persona, sobra.

## Author Information

Jorge Lázaro Molina — [@donJorgito](https://github.com/donJorgito)
