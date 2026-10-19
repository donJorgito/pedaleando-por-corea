# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2026-10-19

### Added

- Estructura del sitio en Jekyll para GitHub Pages, indexable (sitemap, SEO
  tags y RSS).
- Primera entrada del diario: día 1 en bici, de Seúl al kilómetro 0.
- Seis requisitos en `requirements/` con su test correspondiente en `tests/`,
  con trazabilidad 1:1 por nombre de fichero.
- Pipeline de CI con tres gates: escaneo de secretos, linting de Markdown y
  batería de tests. Acciones pineadas al SHA.
- Guardarraíl local `.pre-commit-config.yaml` en forma `repo: local`.
