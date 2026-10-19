#!/usr/bin/env bash
# blog.RQ007 — El diario se lee en orden, del primer día al último.
set -uo pipefail
cd "$(dirname "$0")/.."
err=0

# 1. Cada entrada diaria declara su número de jornada y el layout que navega.
for f in _posts/*-dia-[0-9][0-9]-*.md; do
  [ -f "$f" ] || continue
  base=$(basename "$f")
  del_nombre=$((10#$(printf '%s' "$base" | sed -E 's/.*-dia-([0-9]{2})-.*/\1/')))
  cabecera=$(sed -n '1,/^---$/!d;p' "$f" | sed -n '2,$p')
  del_frontmatter=$(printf '%s' "$cabecera" | grep -E '^dia:' | awk '{print $2}')
  layout=$(printf '%s' "$cabecera" | grep -E '^layout:' | awk '{print $2}')

  if [ -z "$del_frontmatter" ]; then
    echo "RQ007: $base no declara 'dia:' en el front matter"; err=1
  elif [ "$del_frontmatter" != "$del_nombre" ]; then
    echo "RQ007: $base dice dia:$del_frontmatter pero el fichero es el $del_nombre"; err=1
  fi
  if [ "$layout" != "dia" ]; then
    echo "RQ007: $base usa layout '$layout'; las diarias necesitan 'dia'"; err=1
  fi
done

# 2. Los números de día son únicos y arrancan en 1.
numeros=$(grep -hE '^dia:' _posts/*-dia-[0-9][0-9]-*.md 2>/dev/null | awk '{print $2}' | sort -n)
repes=$(printf '%s\n' "$numeros" | uniq -d)
[ -z "$repes" ] || { echo "RQ007: número de día repetido: $repes"; err=1; }
primero=$(printf '%s\n' "$numeros" | head -1)
[ "$primero" = "1" ] || { echo "RQ007: la serie no empieza en el día 1 (empieza en $primero)"; err=1; }

# 3. La portada ordena por día ascendente, no por fecha descendente.
grep -q 'sort: *"dia"' index.md \
  || { echo "RQ007: index.md no ordena las entradas por 'dia' ascendente"; err=1; }
grep -qE '^layout: *home' index.md \
  && { echo "RQ007: index.md usa 'layout: home', que lista del más reciente al más antiguo"; err=1; }

# 4. El layout de las diarias genera los enlaces anterior/siguiente.
[ -f _layouts/dia.html ] || { echo "RQ007: falta _layouts/dia.html"; err=1; }
if [ -f _layouts/dia.html ]; then
  for rel in prev next; do
    grep -q "rel=\"$rel\"" _layouts/dia.html \
      || { echo "RQ007: _layouts/dia.html no genera el enlace rel=\"$rel\""; err=1; }
  done
fi

# 5. Las temáticas quedan fuera de la cadena: sin número de día.
for f in _posts/*.md; do
  base=$(basename "$f")
  printf '%s' "$base" | grep -qE '^20[0-9]{2}-[01][0-9]-[0-3][0-9]-dia-[0-9]{2}-' && continue
  if grep -qE '^dia:' "$f"; then
    echo "RQ007: la entrada temática $base no debería declarar 'dia:'"; err=1
  fi
done

exit $err
