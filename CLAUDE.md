# Instrucciones para Claude en este repositorio

`CONTRIBUTING.md` es la fuente de verdad. Este fichero solo añade contexto; si
algo aquí contradice a `CONTRIBUTING.md`, manda `CONTRIBUTING.md`.

## Qué es esto

El blog de un viaje en bicicleta de Seúl a Busan (septiembre-octubre de 2026).
El objetivo doble: contar la experiencia y que alguien que busque información
real sobre la ruta la encuentre.

## Reglas al escribir aquí

- **No inventes datos.** Kilómetros, horas, precios y nombres salen de las
  fuentes del proyecto (fotos con GPS, PDF de reservas, chat del grupo). Si una
  cifra es una estimación, dilo en el texto.
- Cada entrada mezcla **relato y utilidad**: lo que pasó ese día y lo que le
  sirve a quien lo prepare.
- Español, segunda persona cuando te diriges al lector, primera del plural para
  el relato.
- Atribuye tus commits con `Co-Authored-By:`.
- Antes de cada push: `pre-commit run --all-files` y `tests/run-all.sh`.
