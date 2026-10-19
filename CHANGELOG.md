# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Entrada temática con el presupuesto real del viaje, a partir de las cuentas
  compartidas del grupo: totales por concepto, media por persona y día, y
  precios sueltos (bicis, hoteles de etapa, cenas, transportes).

### Changed

- `blog.RQ001` admite ahora entradas **temáticas** (`AAAA-MM-DD-<titulo>.md`)
  además de las diarias; su test distingue los dos patrones.
- El coste del pasaporte del ciclista en la entrada del día 1 pasa de «unos
  4.000 wones» a la cifra exacta del recibo.

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
