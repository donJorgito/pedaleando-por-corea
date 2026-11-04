### blog.RQ014 - Las historias del viaje se enlazan desde el sitio

**Description:**

Parte del viaje está grabada en vídeo y vive en las **historias destacadas de
Instagram** («Corea a piñón!»), que es donde se ven las cosas que una foto no
cuenta: el carril bici en movimiento, el agua, las cuestas. El blog las
enlaza en vez de ignorarlas, y lo hace en dos sitios con propósitos
distintos: el álbum concreto en la portada, y el perfil en el pie de todas
las páginas.

Se enlaza, no se incrusta. Un `iframe` de Instagram mete cookies y scripts de
terceros en todas las páginas, y eso es justo lo que `blog.RQ013` evita.

Instagram pide cuenta para abrir una historia destacada, así que la portada lo
advierte y ofrece el perfil como alternativa: quien no tenga Instagram no se
queda mirando una pantalla de login sin saber por qué.

**Parent Requirement:** N/A

**Acceptance Criteria:**

- La portada enlaza el álbum de historias destacadas del viaje y **dice** que
  Instagram pide cuenta para verlo.
- `_config.yml` declara `instagram_username`, con lo que el tema pone el
  enlace al perfil en el pie de todas las páginas.
- No se incrusta ningún `iframe` ni script de Instagram en el sitio.
- Los enlaces son externos y absolutos: no pasan por la comprobación de
  `baseurl` de `blog.RQ006`, que es solo para los internos.
