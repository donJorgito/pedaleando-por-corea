#!/usr/bin/env bash
# blog.RQ013 — Se puede saber si alguien lo lee, sin espiar a nadie.
set -uo pipefail
cd "$(dirname "$0")/.."
err=0

# 1. El include existe y el <head> lo llama.
if [ ! -s _includes/analitica.html ]; then
  echo "RQ013: falta _includes/analitica.html"; err=1
fi
if ! grep -q 'include analitica.html' _includes/head.html; then
  echo "RQ013: el <head> no incluye analitica.html"; err=1
fi

# A partir de aquí se mira el include SIN sus comentarios Liquid: el porqué de
# cada cosa está explicado ahí dentro y nombra lo que el test prohíbe.
cuerpo=$(sed '/{%-* *comment/,/{%-* *endcomment/d' _includes/analitica.html 2>/dev/null)

# 2. Dos condiciones para cargar: producción y clave puesta. La segunda es la
#    que permite publicar sin medir nada.
for patron in "jekyll.environment == 'production'" 'site.analitica.goatcounter'; do
  if ! printf '%s' "$cuerpo" | grep -qF "$patron"; then
    echo "RQ013: analitica.html no comprueba $patron"; err=1
  fi
done

# 3. El script de terceros va pineado a una versión concreta y con su hash.
if ! printf '%s' "$cuerpo" | grep -qE 'src="https://gc\.zgo\.at/count\.v[0-9]+\.js"'; then
  echo "RQ013: el contador no apunta a una versión pineada de count.js"; err=1
fi
for patron in 'integrity="sha384-' 'crossorigin="anonymous"'; do
  if ! printf '%s' "$cuerpo" | grep -qF "$patron"; then
    echo "RQ013: al script del contador le falta $patron"; err=1
  fi
done

# 4. Nada de contadores con cookies. Se mira el sitio publicable, sin los
#    comentarios Liquid (que sí los nombran para explicar por qué no están).
for f in _includes/*.html _layouts/*.html index.md mapa.html; do
  [ -f "$f" ] || continue
  limpio=$(sed '/{%-* *comment/,/{%-* *endcomment/d' "$f")
  if printf '%s' "$limpio" | grep -qiE 'google-analytics|googletagmanager|gtag\(|site\.google_analytics'; then
    echo "RQ013: $f carga analítica con cookies"; err=1
  fi
done

# 5. La propiedad de Search Console se acredita desde la configuración.
if ! grep -qE '^google_site_verification: *[A-Za-z0-9_-]{20,}' _config.yml; then
  echo "RQ013: _config.yml no declara google_site_verification"; err=1
fi

exit $err
