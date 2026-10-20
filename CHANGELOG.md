# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- **Segunda tanda de fotos** (`blog.RQ010`), **23 más**: el avión y el salto
  largo, el robot Taekwon V, Bukchon, Changdeokgung con sus 잡상 y su 책가도,
  el cambio de guardia de Gyeongbokgung, el 거북선 de 충무공이야기, Gwangjang,
  la Starfield Library, la muralla de Hwaseong, el papelito con los dos
  asadores de Suwon, la Torre N y el día de la DMZ entero —Gamaksan, la
  locomotora de Jangdan, las cintas de la alambrada, las letras del tercer
  túnel y la sala inmersiva de 통일촌—.

  Cada foto se ha revisado a tamaño completo antes de publicarla, y de ahí
  salieron tres decisiones: el cambio de guardia **se recortó** para dejar
  fuera a los veinte espectadores de la primera fila (y a los ocho que
  quedaban dentro del recorte se les difuminó la cara); en Gwangjang se
  difuminaron **once caras** de quien comía al lado; y en dos fotos de la DMZ
  se difuminó **la tarjeta de la excursión**, que llevaba a la vista un
  nombre y un número de teléfono (`blog.RQ005`).

- **El blog tiene fotos** (`blog.RQ010`). Primera tanda, **24**: la salida
  delante del ayuntamiento, la puerta de embarque, la primera cena, y sobre
  todo **las cabinas de certificación** —diecisiete, de las treinta y cinco
  de la ruta— cruzando el GPS de cada foto con las coordenadas de cada
  cabina y quedándose con las que están a menos de 40 metros. Más el hito de
  la meta con sus 633 km.

  Con su andamiaje, que es lo que permite seguir añadiendo sin pensárselo:
  `_includes/foto.html` (un `figure` con pie en Markdown, `loading="lazy"` y
  el tamaño declarado para que el texto no salte al cargar) y
  `_tools/preparar-foto.sh`, que reescala, **quita el EXIF entero** —las
  fotos del viaje llevan coordenadas y hora exacta, las dos cosas que este
  repositorio no publica— y escribe la línea de `include` ya medida.

  Y una decisión que vale para todas las que vengan: los tres del viaje
  salen a cara descubierta, pero **la gente que aparece de fondo sin haberlo
  elegido se difumina** — con una máscara elíptica suavizada, no con un
  recuadro borroso, que canta más que la propia cara. En un asador o en un
  mercado no se puede hacer una foto sin que salga alguien más, y eso no
  convierte a quien cenaba en la mesa de al lado en parte de la crónica.

- **Tema oscuro** (`blog.RQ009`). El sitio respeta el `prefers-color-scheme`
  del sistema operativo o del navegador —sin JavaScript, solo con la media
  query— y añade un botón fijo abajo a la derecha para forzar claro u oscuro,
  con la elección guardada en `localStorage` y aplicada antes del primer
  pintado, de modo que no hay destello blanco al cargar. La preferencia del
  sistema manda mientras el lector no elija nada.

  Minima 2.5 compila sus colores regla a regla y **no tiene el gancho
  `custom-head.html`** de las versiones 3.x, así que ha habido que
  sobrescribir `_includes/head.html` entero —con una nota en el propio
  fichero: es lo primero que hay que revisar si cambia la versión del tema— y
  escribir la paleta oscura como sobrescritura explícita de las reglas de
  minima que pintan, en un mixin que se aplica por media query y por atributo
  `data-tema`.

- El día 23 cuenta el **«왕가의 산책»**, el pase de la corte de Joseon en la
  terminal 1 de Incheon: quién es cada personaje —el 홍곤룡포 del rey con su
  dragón de cinco garras frente al del príncipe heredero, que tiene cuatro;
  las 여령; el 위장; los dos quitasoles, 홍양산 y 청양산—, que es gratis, que
  hay dos pases al día (11:00 y 14:00) y que está **pasado el control de
  pasaportes**, que es el dato que decide si llegas a verlo o no.

- El día 22 cuenta **la casa-santuario del último alojamiento**: la dueña y su
  hermana son fans de **이찬원 (Lee Chan-won)**, el pasillo está forrado de
  pósteres, vitrinas y un traje de escenario enmarcado, y les hizo
  suscribirse a su canal, les hizo las fotos y les regaló un álbum a cada
  uno. Con el dato que da la vuelta a la anécdota: **no es K-pop, es trot**
  —el género popular coreano—, y el cantante se hizo famoso quedando séptimo
  en *Mr. Trot* en 2020. El nombre salió del propio cartel del club de fans
  que aparece en la foto.

- **Los sitios donde se cenó empiezan a tener nombre y enlace a Naver Map.**
  Esta tanda cubre:
  - Día 6: **진미통닭**, en la calle del pollo frito de Suwon (정조로800번길
    21), con su carta de pollo entero y las dos bandejas, frita y 양념.
  - Día 8: **정다운식당** (희우정로 27, Mapo), con el **영양버섯솥밥** de
    cuatro setas que se recordaba sin nombre.
  - Día 9: **목구멍 여주점** (여양로233번길 5-26) y su lema, *«숙성이고
    나발이고 좋은 고기가 맛있습니다»*.
  - Día 11: **명문가마솥식당** (호계길 4, Mungyeong), el comedor de pueblo
    del 갈비탕, con la aclaración de que el caldo era 갈비탕 y no *gomtang*.
  - Y enlace de Naver Map en los que ya estaban nombrados: el asador del
    día 3, Tosokchon el día 5, Poem el día 7, los mercados de Seomun
    (día 14) y Bupyeong (día 19), el Poem de Busan el día 20 y los dos del
    día 22. El del día 19 además tiene nombre por primera vez:
    **부평깡통시장**, que el post dejaba en «el mercado nocturno».

  Quedan sin identificar las cenas de los días 13, 15 y 18: las fotos no
  dejan ver ningún rótulo y el GPS no se acerca lo suficiente a un solo
  candidato. Se prefiere dejarlas sin nombre antes que acertar por
  probabilidad.

- El día 7 se cuenta **en el orden en que pasó**. **Imjingak no fue la última
  parada: fue la de mediodía**, a las 12:12, y allí están la locomotora
  acribillada de la estación de Jangdan y las cintas de la alambrada. La
  última parada, a las 16:15, fue **통일촌 (Tongilchon)**, el pueblo agrícola
  que está dentro de la zona de control civil, con su sala inmersiva. Y se
  añaden la cena en Myeongdong y el bingsu en **포엠 (Poem)**, 명동4길 13 —
  que resulta ser la casa madre del Poem de Busan del día 20, enlazados
  ahora el uno con el otro.

- El día 9 cuenta **cómo se perdió el grupo** entre la cabina del museo de
  Yangpyeong y la de la presa de Ipo: el «nos vemos en el camino», los 17 km
  de desvío, la ronda de llamadas y por qué hubo que seguir hasta Yeoju de
  noche (en Ipo no hay nada). Reconstruido con las horas del chat del grupo
  y el GPS de las fotos, y con las dos lecciones que deja.

- El día 3 cuenta **dónde fue la primera cena**: **다올 숯불구이 명동점
  (DAOL)**, 명동8길 8-11, un asador de carbón de Myeongdong elegido en el bus
  desde el aeropuerto. Qué se pidió —tiras de ternera, panceta, los banchan,
  el ssamjang, el ajo crudo, cerveza Terra— y el rango de precios de su
  carta, que explica los 107.000 wones. Identificado por el enlace de Naver
  Map que circuló por el grupo, que resuelve a esa ficha exacta.

- El día 5 se reordena a como pasó y se completa:
  - **Tongin** pasa a tener sección propia, con el picoteo de las 11:46.
  - **토속촌 (Tosokchon)**, el asador de pollos con la cola en la puerta por
    el que pasaron de largo, y lo que les dijo un español que salía. Se deja
    escrito que la mención a la guía Michelin **no se sostiene**: el sitio no
    figura en ella.
  - **Deoksugung** y el chaparrón que les mandó al metro, que faltaban.
  - **Gwangjang** se amplía con lo que se comió de verdad: 순대, 떡볶이,
    돼지껍데기 y 어묵 con su caldo, además del bindaetteok y el mayak gimbap
    que ya estaban.

- El día 22 pasa de ser solo el del KTX a contar el día entero: la cita de
  **bótox** en una clínica de Myeongdong (12:48), la comida en el **명동교자
  본점** —퇴계로 129, en la guía Michelin de Seúl, carta de cuatro platos,
  kalguksu 12.000 y mandu 13.000 wones, kimchi de ajo y fideos de balde— y la
  última cena en dos tiempos: **mandus callejeros** a las 18:57 y **barbacoa
  coreana en 조박사등갈비** (퇴계로16길 8) a las 19:30, un sitio de barrio sin
  un solo turista dentro, con la carta y el **후식** de 누룽지탕 o 잔치국수.
  Los dos restaurantes se localizaron cruzando el GPS de las fotos con Naver
  Map: 8 m y 7 m de error respectivamente.

- El día 20 añade el **bingsu de té en 포엠 (Poem)** —명동포엠 부산직영점,
  해안산책길 10—, justo en el arranque del sendero de Huinnyeoul: 10,68 € para
  dos, y qué es un bingsu.

- El día 24 cuenta el **almuerzo del camino**: el restaurante **Marino**, en
  Honrubia (Cuenca), a pie de A-3, con un plato combinado de huevo, patatas,
  panceta, morcilla y chorizo a la parrilla —la versión española de la
  barbacoa coreana— más palmera de chocolate y café. Los **55,50 €** son de
  esa comida, no de transporte. Localizado por el GPS de la foto, a unos 22 m
  de la ficha del restaurante.

- El día 20 cita el **갈치 (galchi), el pez sable frito**, que venía en el
  pescaíto frito de Jagalchi y estaba en temporada: 28.000 wones para tres, y
  mejor bocado que el marisco caro.

- **La gente que nos encontramos**, que es lo que de verdad se cuenta después:
  - Día 12: el **cocinero de la barbacoa** tenía un amigo español y se acercó
    a contarnos que la mejor carne de su vida fue un **chuletón de vaca
    gallega comido en Valencia**. Nos invitó a **dos trozos de lo que él
    decía que era la mejor vaca de Corea** — dos piezas gruesas y veteadas,
    nada que ver con la falda fina que habíamos pedido.
  - Día 16: a mediodía, en un **CU** de la ruta, el dependiente **hablaba algo
    de español** y acabó **invitando a café recién hecho a los tres**, con
    leche fresca para cortarlo.
  - Día 10: en el bunsik de Mokhaeng-dong **se asombraron de que fuéramos
    españoles**; por allí no pasan turistas.
  - Día 18: el té del día de la llegada a Busan fue en un **Mixue**. Se
    explica qué es la cadena, con los datos verificados en su ficha: china,
    de 1997, helado y tés, **59.823 locales** a cierre de 2025, la mayor del
    mundo por número de tiendas.

- `blog.RQ008` detecta ahora las fechas escritas en la forma **«del N al
  N»**, sin nombre de mes. Así se habían colado las noches de Seúl en las
  entradas de los días 1 y 3, que el patrón anterior no veía. Las dos
  corregidas. El ejemplo se escribe con N y no con los números reales: un
  requisito de privacidad no puede documentarse citando el dato que
  protege.
- El día 17 cuenta dos cosas que faltaban: **The Terrazzo fue el segundo y
  último hotel al que se llegó sin reserva** —enlazado desde la entrada de
  alojamiento, que hasta ahora solo nombraba el primero— y el buffet tiene
  nombre: **다담뜰한식뷔페 양산점** (물금읍 가촌로 171), **12.000 wones por
  adulto**, que por tres son los 36.000 wones del apunte. Allí se probó el
  **식혜**, el agua dulce de arroz; el resto de platos ya se venían comiendo
  desde el primer día. Localizado por el GPS de la foto de la cena, a unos
  siete metros de la ficha de Naver Map.
- `blog.RQ008` nuevo, con su test: comprueba las seis vías por las que se
  escapaba una fecha —permalink, layout, portada, nombre de fichero, front
  matter y prosa—. Verificado en negativo: las ocho comprobaciones fallan al
  reintroducir cada fuga.

- El día 16 identifica la **«cena picosita»**: era **닭갈비** en el
  **복면닭갈비** (천주로 1069, Buk-myeon, Changwon), un restaurante con **un
  solo plato en la carta**. Dos raciones de 17.000 wones —cada una pensada
  para dos personas— dan los 34.000 del apunte. Se añade qué es el dakgalbi,
  la tabla con la conversación real por traductor con la camarera y el aviso
  de que el picante no se puede ajustar. Verificado cruzando el GPS de la
  foto del plato (35,3464 N / 128,6070 E) con la ficha de Naver Map, el
  horario 11:00–20:30 y el precio de su carta.
- Entrada temática nueva: **dónde dormir en el 국토종주**. El método de buscar
  alojamiento el mismo día, por qué Booking no tiene oferta en los pueblos
  pequeños, por qué KakaoMap la muestra pero exige cuenta de KakaoTalk para
  reservar, y cómo se consigue habitación presentándose en la puerta.
- Llegar sin reserva pasó **dos veces en once etapas**, no «varias», y lo que
  dan al registrarte es **una tarjeta**, no una llave.
- El día 15 cuenta la cena de barbacoa de hanwoo y, sobre todo, que su hotel
  fue **el primero al que llegaron sin reserva**: había sitio, y poco después
  el hotel se llenó. Enlazado desde la entrada de alojamiento, que añade el
  consejo de llegar con luz.
- El día 11 corrige las manzanas: se compraron en el mercadillo de 문경 사과
  pero se comieron más adelante, en una tienda 24 h, con noodles instantáneos,
  huevos, rábano encurtido y sándwiches, antes del baño de pies.
- El día 10 cuenta la cena que faltaba: el bunsik **황금분식** al otro lado
  del río, en Mokhaeng-dong, con la comanda exacta y los precios leídos de la
  foto de su carta: 26.500 wones de comida para tres, 17 €. Y el apunte de
  que el agua en Corea siempre es gratis. Enlace directo a su ficha de Naver
  Map, ya verificada, y dirección oficial (행정11길 40).
  Antes el texto especulaba con que habían cenado en una tienda 24 h.
- El día 8 aclara que el certificado final **no se recoge en la oficina de
  Incheon** sino en otra parecida en Busan, y añade la comida en un CU entre
  las dos esclusas del canal Ara.
- **El diario queda completo**: días 19 a 24, de Busan al regreso a casa.
  Haedong Yonggungsa y Gwangalli, Gamcheon y la lonja de Jagalchi con los
  drones de Gwangalli, el día flojo, el KTX de vuelta, la última mañana y el
  balance final.
- `blog.RQ001` comprueba ahora que **no falte ninguna de las 24 jornadas**.
- Días 15 a 18, hasta la meta: Dodongseowon y su espectáculo nocturno, el
  truco de cambiar de orilla en Haman, la víspera en Yangsan y el día final
  con el certificado, la devolución de las bicis y Haeundae.
- Días 12, 13 y 14: el museo de la bicicleta de Sangju y el paso al Nakdong,
  la llegada a Daegu, y el día de descanso con Haeinsa y el mercado de Seomun.
- Tres etapas nuevas en bici: día 9 (Seúl → Yeoju por la vía verde), día 10
  (Yeoju → Chungju por el Namhangang) y día 11 (Chungju → Mungyeong, con
  Ihwaryeong y el baño de pies termal).
- El día 8 distingue la **cabina** (la caseta roja donde sellas tú mismo) del
  **centro de certificación** (la oficina de al lado donde se emite el
  pasaporte), que el texto confundía.
- El canal Ara queda **a la izquierda** en el sentido de la marcha, no a la
  derecha, y el día se cierra con la barbacoa coreana cerca del alojamiento.
- Se quita la talla de las bicicletas de la entrada del día 8: es un dato
  personal de los tres y no aporta nada al relato.
- El día 4 incorpora el espectáculo nocturno que faltaba: la fuente del
  puente de Banpo (달빛무지개분수) sobre el río Han y las islas de Sebitseom.
- El día 5 incorpora la **Starfield Library** (별마당 도서관) del COEX, que se
  había quedado fuera: estanterías de trece metros, entrada gratuita y enlace
  a la página oficial.
- La comida casera del día 4 se sitúa en una callejuela de Insadong, con
  enlace a Naver Map del barrio. No se nombra el restaurante porque no se
  pudo identificar: el GPS de la foto cae en un portal sin restaurantes y el
  más cercano no encaja ni con el interior ni con el menú único.
- El día 4 cuenta la comida casera de menú único que se habían quedado en una
  línea suelta: 29.700 wones los tres, en su sitio cronológico (antes de
  Bukchon) y con la comparación con la merienda, que costó un 26 % más.
- El día 3 explica cuál de las dos aplicaciones de mapas usar para qué:
  Naver Map a pie, KakaoMap en bici, y por qué conviene registrar cuenta en
  las dos (los favoritos).
- El día 3 compara las tres formas de bajar de Incheon al centro (metro
  ~4.900 wones/persona, bus 17.000, Uber 48.000-60.000 el trayecto) y explica
  por qué cogimos el bus pese a no ser la opción sensata.
- `blog.RQ006` valida también los enlaces Liquid `post_url` entre entradas.
- La portada lista las jornadas **en orden, del día 1 en adelante**, en vez
  del orden inverso que trae el tema por defecto, y separa las entradas
  temáticas en su propia sección.
- Cada entrada diaria enlaza con la **anterior** y la **siguiente**, para
  poder leer el viaje entero sin volver al índice.
- Requisito `blog.RQ007` y su test para que ese orden y esa navegación no se
  puedan romper sin que salte CI.
- Gate 5 de CI: **se construye el sitio en cada PR**. Hasta ahora un error de
  Liquid o de SCSS solo habría aparecido al desplegar, porque `pages.yml`
  solo corre en `main`.
- Las tiendas 24 h **no tienen baño**; en cambio la ruta tiene servicios
  públicos continuamente, que es el dato que de verdad sirve en bici.
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

- `actions/configure-pages` sube a v6.0.0. La tabla de versiones del
  `README` se actualiza con ella.

- Quedaban dos referencias numeradas al estándar corporativo, una en
  `pages.yml` y otra en `_config.yml`, que el primer barrido no vio porque
  citaban la norma por su número sin nombrarla. Los comentarios explican
  ahora el porqué en vez de remitir a una regla. Como con las fechas: el
  apunte no reproduce el texto retirado, que si no se queda publicado en el
  sitio donde se cuenta que se ha quitado.

- **Fuera del repositorio toda referencia al estándar corporativo y a la
  empresa.** Aparecían en el `README`, en `CODEOWNERS`, en
  `.pre-commit-config.yaml`, en `.markdownlint.yml`, en `tests/run-all.sh`,
  en `dependabot.yml` y en `ci.yml`. Las prácticas se quedan —un requisito
  por funcionalidad, un test por requisito, gates en CI, dependencias
  pineadas al SHA—; lo que desaparece es de dónde salen. Los encabezados del
  `README`, que eran los de una plantilla corporativa en inglés, pasan a
  castellano como el resto del repositorio.

### Fixed

- **El día 2 llevaba dos fechas escritas.** «Salimos de España el día 22 por
  la mañana y aterrizamos el día 23 por la tarde» fija el calendario del
  viaje entero, que es exactamente lo que `blog.RQ008` no publica. Ahora dice
  lo mismo sin números: «por la mañana» y «a la tarde del día siguiente».

- **La primera cena del viaje no fue donde decía el día 3: fue donde la
  última.** El post daba 다올 숯불구이 명동점, que era solo una de las fichas
  de Naver que se pasaron por el grupo en el bus del aeropuerto. La foto de
  esa cena tiene el **mismo tablón de precios, la misma parrilla y la misma
  pared de azulejos firmados** que la del día 22, y su GPS cae a **7 metros**
  del otro: las dos cenas fueron en **조박사등갈비**. Corregido en el día 3,
  con lo que de verdad se pidió (등갈비, costilla de cerdo) y su carta real,
  y contado en los dos posts, que ahora se enlazan: diecinueve días y mil
  doscientos kilómetros entre una cena y otra, en la misma mesa, sin
  habérselo propuesto.

  De paso, la hora: no se cenó «a las nueve pasadas». La foto es de las
  **20:11** y la cuenta se pagó a las **20:53**.

- **En el aeropuerto no había figuras: había actores.** El día 23 describía
  el Korean Traditional Culture Center «con figuras a tamaño real vestidas de
  hanbok», y lo que hay en las fotos es la corte de Joseon representada por
  **personas**, con uno de los tres metido en la fila posándose con ellas.
  Confirmado en las fotos de las 14:15 y en la ficha oficial del
  espectáculo, que dice justamente eso: que hacerse la foto con los
  intérpretes es parte del acto.

- **KakaoMap en bus y metro no es un hueco en la tabla.** La comparativa del
  día 3 dejaba la casilla vacía, como si no sirviera; va solo un poco por
  detrás de Naver Map y se puede usar perfectamente.

- **El último trayecto en coche eran unos 450 km, no 245.** El día 24 daba
  245 km de Madrid a Pilar de la Horadada; por carretera son unos 450, cerca
  de cinco horas, los mismos que la ida que ya contaba bien el día 1.

- **Los 55,50 € del día 24 no eran transporte, eran la comida.** Es el
  almuerzo en el restaurante Marino de Honrubia, 18,50 € por cabeza.

- **La hora del aeropuerto del día 23 era la de la última foto, no la de la
  llegada.** Estuvieron en Incheon desde las 11:59, con horas de margen para
  facturar las maletas nuevas, no desde las 14:35. Y con el tiempo de sobra
  hay dos cosas que contar que faltaban: los robots de las terminales y el
  Korean Traditional Culture Center.

- **En el día 24 no se repostó al final, y los 79 € son de los dos
  trayectos.** Era la gasolina de la ida y de la vuelta juntas, unos 900 km;
  el depósito venía lleno de antes. También se ajusta la hora de llegada a
  casa, que no fue a las ocho.

- **Los 55,50 € del Marino estaban contados como transporte en la tabla de
  presupuesto.** Al ser comida, cambian dos filas: transporte baja a 287,71 €
  y comida sube a 892,79 €. El total del viaje no se mueve.

- **El día 22 no explicaba por qué el tren hace menos kilómetros que la
  bici.** Ahora da los dos números: 387 km de línea de alta velocidad (442 la
  clásica) frente a los 633 del carril bici, que va siguiendo los ríos.

- **Las maletas eran dos, y la de ruedas no era de Daiso.** En Daiso se
  compró una normal, sin ruedas, por 5.000 wones; la de ruedas salió de un
  puesto de los 지하상가, las galerías subterráneas del metro de Seúl, por
  10.000. Corregido en la entrada del día 22 y en la de presupuesto, que
  atribuían las dos cosas a Daiso.

- **La maleta se compró el día 22 en Myeongdong, no el 21 en Busan.** Estaba
  contada en los dos sitios; el apunte de gastos la fecha ya en Seúl, así que
  se queda solo en el día 22.

- **El gasto de cosmética fue de dos días, no de uno.** Los cerca de 300 €
  por cabeza se repartieron entre el día de tiendas en Busan y el día
  siguiente en Myeongdong. Corregido en la entrada del día 21 y en la de
  presupuesto.

- **El bótox fue el último día completo en Corea**, no el penúltimo, y la
  entrada de ese día lo cuenta ahora con su hora; la de presupuesto solo
  llevaba la cifra.

- **El encabezado del día 1 seguía dando la distancia vieja.** El cuerpo del
  texto ya decía unos 450 km, pero el `##` de esa sección no se tocó en la
  corrección anterior. Corregir un dato en la prosa y dejarlo en el título es
  dejarlo publicado.

- El dependiente del CU del día 16 no invitó «a un café»: invitó a **café
  recién hecho a los tres**, y además sacó **leche fresca** por si alguno lo
  quería cortado. La redacción anterior se leía como si el café hubiera sido
  uno solo para tres.

- **Pilar de la Horadada a Madrid son unos 450 km, no 382.** Los 382 eran la
  distancia **en línea recta** entre las dos ciudades, que no es la que se
  conduce. Corregido en los tres sitios de la entrada del día 1.

- La lavandería de Busan fueron **4.000 wones el lavado y 4.000 el secado**,
  no 5.000 y 3.000. Los dos apuntes de Settle Up repartían calderilla entre
  los hermanos; el precio de las máquinas era el mismo. El total, 8.000
  wones, no cambia.

- **El blog ya no publica las fechas exactas del viaje.** Estar tres semanas
  fuera de casa en unos días concretos es un dato personal que no aporta nada
  al lector y que, una vez indexado, no se retira. El viaje se sitúa ahora por
  periodo —«la última semana de septiembre y las dos primeras de octubre de
  2026»— y se organiza por número de jornada, que es lo que de verdad sirve
  para preparar la ruta. En concreto:
  - Las URL pierden la fecha: `/dia-16-la-orilla.../` en vez de
    `/AAAA/MM/DD/dia-16-la-orilla.../`. **Las URL antiguas dejan de
    funcionar**, que es justo lo que se busca.
  - Se sobrescribe el layout `post` de minima para que no imprima la fecha
    bajo el título.
  - Las 24 entradas diarias se renombran y se refechan con su fecha de
    publicación, de modo que ni el nombre del fichero, ni el `feed.xml`, ni
    el `sitemap.xml` delaten el itinerario.
  - La portada ya no muestra el `dd/mm` de cada jornada.
  - `blog.RQ001` pasa a exigir lo contrario que antes: la fecha del fichero
    tiene que ser **posterior** al viaje, no caer dentro.

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

- **El cocinero de la carne era del día 12, no del día 15.** Y la historia es
  mejor de lo que se habia contado, porque está escrita: hay captura de la
  traducción que nos pasó por el móvil, y se cita entera. El corte que regaló
  era **안창살 (anchangsal)**, que él presenta como el más caro de Corea, y lo
  que recordaba de España era **carne madurada** en un restaurante cerca del
  aeropuerto de Valencia. El asador de Gumi, en 원평동, tiene cámaras de
  maduración a la vista. Se retira del día 15 la versión equivocada.
- **El té de Mixue era del día 18, no del día 3.** «El día de la llegada» era
  la llegada a Busan, no a Corea. La foto lo fija: 14:45, al lado del Angel
  Hotel, un **흑당밀크티** tamaño L con perlas, trece minutos después de la
  foto donde se lee el rótulo del hotel.
- **El día 21 no fue un «día tonto»**: fue **el día de las tiendas**, dedicado
  a Daiso, Olive Young y la cosmética coreana. Reescrito y renombrado — las
  nueve fotos del día, el mínimo del viaje, se explican porque estuvieron
  dentro de las tiendas. Se incorpora el detalle logístico: a la ida solo
  mochila, a la vuelta una maleta de Daiso de 10.000 wones para traer las
  compras.

- **Los seis enlaces internos entre entradas estaban rotos.** `{% raw %}{% post_url %}{% endraw %}`
  devuelve la URL sin el `baseurl`, y en un sitio de proyecto eso da un 404.
  Ahora todos llevan `{{ site.baseurl }}` delante.
- `blog.RQ006` comprueba que todo `post_url` lleve el `baseurl`, y el gate de
  construcción revisa el HTML generado en busca de enlaces internos sin él.
  Ninguno de los dos existía, por eso los seis enlaces pasaron los cinco
  gates y se publicaron rotos.

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
