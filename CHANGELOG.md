# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Aviso de vigencia destacado al principio de la entrada del presupuesto:
  los precios son de septiembre-octubre de 2026 y hay que leerlos como orden
  de magnitud, no como tarifa.
- Referencia de precios de bótox en España (150-350 € por zona, 300-450 € el
  tercio superior) para que los 110 € de Seúl signifiquen algo, con fuentes.
- Siete entradas diarias nuevas, del día 1 al 7: los dos días de viaje hasta
  Corea, la llegada a Seúl y los cuatro días de la capital (centro histórico,
  mercados, Suwon y la DMZ).
- Entrada temática con el presupuesto real del viaje, a partir de las cuentas
  compartidas del grupo: totales por concepto, media por persona y día, y
  precios sueltos (bicis, hoteles de etapa, cenas, transportes).
- Apartado nuevo sobre el premio del final: el certificado `국토종주 인증서` que
  expide K-water en el centro de certificación del Nakdong y la medalla
  (12.000 wones cada una).
- Apartado sobre el tratamiento de medicina estética en Seúl (110 € por
  cuatro zonas), un precio real difícil de encontrar documentado.
- Apartado sobre las compras del final (Olive Young, Daiso) y el truco del
  equipaje facturado: ir solo con mochila a la ida deja libre el bulto de
  bodega para volver con una maleta comprada allí por 10.000 wones.
- Las dos cenas «de capricho» de Busan — la barbacoa de celebración y el
  marisco de la lonja — dejan de mencionarse de pasada y pasan a tener sus
  cifras.
- La entrada del presupuesto incorpora el gasto individual en tiendas 24 h
  (CU, GS25, 7-Eleven), que no estaba en las cuentas compartidas y pesa 10-20 €
  por persona y día, más un apartado propio para la lavandería —lavadora Y secadora,
  gratis con solo pedirlas, pero con 30 min de lavado y 45 de secado y la
  máquina compartida, así que hay que estar con la alarma— y un
  presupuesto final realista de 2.300 € por cabeza.

### Changed

- Todas las acciones de CI/CD suben de versión mayor en un único lote, para
  que `upload-pages-artifact` y `deploy-pages` no queden descompasadas:
  `checkout` v7.0.1, `upload-pages-artifact` v5.0.0, `deploy-pages` v5.0.1,
  `gitleaks-action` v3.0.0 y `markdownlint-cli2-action` v24.2.0.
- Las tablas de Markdown pasan a tener los pipes espaciados de forma
  consistente, para cumplir `MD060`, la regla nueva de markdownlint 0.41.
- Apartado nuevo con lo que incluye el alquiler (casco, portaequipajes, luces
  LED recargables y candado de contraseña) y lo único que hubo que llevar de
  casa: pulpos y soporte de móvil. Se corrige que llevaran alforjas: iban con
  la mochila atada al portaequipajes.
- Los importes de alojamiento se aclaran: casi todas las noches fueron **dos
  habitaciones dobles**, no una triple, así que los precios por noche son de
  las dos juntas.
- El apartado de navegación del día 3 recupera el motivo legal, ya verificado
  y fechado: Corea aprobó la exportación cartográfica en febrero de 2026 pero
  Google Maps seguía sin navegación durante el viaje.
- El tercer túnel de la DMZ recupera sus cifras, ya verificadas: octubre de
  1978, 44 km de Seúl, 1.635 m y sección de 2 × 2 m.
- Las entradas diarias se numeran por **día de viaje** (01-24), no por etapa
  en bici: la primera jornada sobre la bici pasa de `dia-01` a `dia-08`, que
  es el día del viaje que le corresponde. Evita la colisión de numeración con
  los días de Seúl previos.
- La devolución de las bicis deja de contarse como un sobresalto: el taller
  avisa al alquilar de que el pago es en efectivo, y así se llevó preparado.
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
