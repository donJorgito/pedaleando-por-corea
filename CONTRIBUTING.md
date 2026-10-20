# Contributing to `pedaleando-por-corea`

Este documento es la fuente de verdad sobre cómo se trabaja en este
repositorio. Cualquier otra guía (incluido `CLAUDE.md`) está subordinada a él y
no puede contradecirlo.

## Getting Started

```bash
git clone git@github.com:donJorgito/pedaleando-por-corea.git
cd pedaleando-por-corea
pre-commit install
```

Herramientas necesarias, con versión fijada:

```bash
pip install --user pre-commit==4.0.1 pre-commit-hooks==5.0.0
brew install gitleaks        # o la release pineada que corresponda
```

## Development Standards

- **Conventional Commits** obligatorios: `feat:`, `fix:`, `docs:`, `chore:`,
  `refactor:`, `test:`. El historial se lee y se versiona a partir de ahí.
- **Una entrada por día de viaje**, en `_posts/`, con el nombre
  `AAAA-MM-DD-dia-NN-titulo-corto.md`.
- Front matter completo siempre: `title`, `date`, `description`, `tags`.
- Nada de datos personales en lo publicado: ni IBAN, ni teléfonos, ni
  localizadores de reserva, ni fotos con coordenadas GPS en el EXIF.
- Las imágenes van a `assets/img/`, reescaladas y **sin metadatos**. No se
  copian a mano: las prepara `_tools/preparar-foto.sh`, que reescala, quita
  el EXIF entero, difumina a quien aparezca de fondo sin haberlo elegido y
  escribe la línea de `include` con el tamaño ya medido. El nombre del
  fichero no puede llevar fecha. Las reglas, en `blog.RQ010`.
- Las versiones se pinean siempre; nunca `latest` ni `@v4` suelto.

## Testing

Un test por requisito, con el identificador en el nombre del fichero
(`tests/test_RQ001_*.sh` ↔ `requirements/blog-RQ001-requirement.md`). Si añades
un requisito, añades su test: la matriz de trazabilidad es la propia lista de
ficheros.

```bash
tests/run-all.sh
```

Falla uno, falla el gate: no hay umbral de tolerancia.

## Review Process

`main` está protegida. Los cambios entran por Pull Request y deben pasar los
tres gates (secret scanning, linting y tests) antes del merge. El propietario
del código es [@donJorgito](https://github.com/donJorgito), según `CODEOWNERS`.

## Automation Bots

Dependabot vigila las versiones de las acciones de GitHub. Sus PR pasan por los
mismos gates que cualquier otro cambio.

## AI-Assisted Development

El contenido y el código de este repositorio se escriben con ayuda de IA
(Claude). Las normas:

- El material generado por IA **pasa exactamente los mismos gates** que el
  escrito a mano. No hay vía rápida.
- Todo commit asistido por IA se **atribuye explícitamente** con el trailer
  `Co-Authored-By:` en el mensaje.
- La IA no inventa datos del viaje. Fechas, kilómetros, precios y nombres de
  sitios salen de las fuentes: las coordenadas y horas de las fotos, los PDF de
  las reservas y el chat del grupo. Lo que no se pueda sostener con una de esas
  fuentes, no se publica — y si se publica una estimación, se dice que lo es.

### Project-Specific AI Standards

Es una crónica personal: la voz es de quien hizo el viaje. La IA redacta y
ordena, pero el texto lo valida el autor antes de publicarse.
