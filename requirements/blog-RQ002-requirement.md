### blog.RQ002 - El sitio es indexable por buscadores

**Description:**

El objetivo del sitio es que alguien que busque información sobre la ruta en bicicleta por Corea lo encuentre. Por tanto el contenido debe ser rastreable e indexable, con sitemap y metadatos de SEO.

**Parent Requirement:** N/A

**Acceptance Criteria:**

- `_config.yml` carga los plugins `jekyll-sitemap` y `jekyll-seo-tag`.
- No existe ningún `robots.txt` que prohíba el rastreo ni etiquetas `noindex` en el contenido.
- Cada entrada declara `description`, que es lo que el buscador muestra como resumen.
