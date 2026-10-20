#!/usr/bin/env bash
# blog.RQ009 — Respeta el tema oscuro del sistema y deja elegirlo.
set -uo pipefail
cd "$(dirname "$0")/.."
err=0

css=assets/main.scss
head=_includes/head.html

# 1. Paleta oscura por preferencia del sistema, sin JavaScript de por medio.
if ! grep -q 'prefers-color-scheme: *dark' "$css" 2>/dev/null; then
  echo "RQ009: $css no define paleta para prefers-color-scheme: dark"; err=1
fi

# 2. El navegador tiene que saber que hay dos esquemas (scrollbars, controles).
if ! grep -qE 'name="color-scheme"' "$head" 2>/dev/null; then
  echo "RQ009: falta <meta name=\"color-scheme\"> en $head"; err=1
fi

# 3. La elección manual: se guarda, y se aplica antes del primer pintado.
#    Que el script vaya en el <head> es justo lo que evita el destello blanco;
#    si se moviera al final del <body>, este test deja de pasar.
if [ ! -f "$head" ]; then
  echo "RQ009: falta $head; sin él no hay dónde poner el conmutador"; err=1
else
  for patron in 'localStorage' 'data-tema' '<script'; do
    grep -q "$patron" "$head" \
      || { echo "RQ009: $head no contiene $patron"; err=1; }
  done
  # El <head> propio sigue siendo un <head> de minima utilizable.
  grep -q 'name="viewport"' "$head" \
    || { echo "RQ009: $head perdió el meta viewport (rompe RQ004)"; err=1; }
  grep -q 'assets/main.css' "$head" \
    || { echo "RQ009: $head no enlaza la hoja de estilo"; err=1; }
fi

# 4. El conmutador es un botón de verdad, no un enlace ni un div.
if ! grep -qE "createElement\(['\"]button['\"]\)" "$head" 2>/dev/null; then
  echo "RQ009: el conmutador no se crea como <button> (accesibilidad)"; err=1
fi
if ! grep -q 'aria-pressed' "$head" 2>/dev/null; then
  echo "RQ009: el conmutador no declara aria-pressed"; err=1
fi

# 5. Los dos sentidos del forzado tienen estilos, no solo el oscuro: si solo
#    existiera [data-tema="oscuro"], quien tenga el sistema en oscuro no
#    podría volver a claro.
for sel in 'data-tema="oscuro"' 'data-tema="claro"'; do
  grep -q "$sel" "$css" \
    || { echo "RQ009: $css no estiliza [$sel]"; err=1; }
done

exit $err
