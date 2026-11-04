#!/usr/bin/env bash
# blog.RQ014 — Las historias del viaje se enlazan desde el sitio.
set -uo pipefail
cd "$(dirname "$0")/.."
err=0

# 1. La portada enlaza el álbum de historias destacadas.
if ! grep -q 'instagram.com/stories/highlights/' index.md; then
  echo "RQ014: la portada no enlaza las historias destacadas"; err=1
fi

# 2. Y advierte de que hace falta cuenta. El enlace a secas manda a quien no
#    tiene Instagram a una pantalla de login sin explicación.
if ! grep -qiE 'pide tener cuenta|hace falta (tener )?cuenta|requiere cuenta' index.md; then
  echo "RQ014: la portada no avisa de que Instagram pide cuenta"; err=1
fi

# 3. El perfil, en el pie de todas las páginas, que es lo que hace el tema con
#    esta clave.
if ! grep -qE '^instagram_username: *[A-Za-z0-9_.]+' _config.yml; then
  echo "RQ014: _config.yml no declara instagram_username"; err=1
fi

# 4. Enlazado, no incrustado: ni iframe ni script de Instagram (blog.RQ013).
for f in _includes/*.html _layouts/*.html index.md mapa.html _posts/*.md; do
  [ -f "$f" ] || continue
  limpio=$(sed '/{%-* *comment/,/{%-* *endcomment/d' "$f")
  if printf '%s' "$limpio" | grep -qiE '<iframe[^>]*instagram|instagram\.com/embed|platform\.instagram\.com'; then
    echo "RQ014: $f incrusta contenido de Instagram en vez de enlazarlo"; err=1
  fi
done

exit $err
