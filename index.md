---
layout: page
title: Pedaleando por Corea
---

Entre la última semana de septiembre y las dos primeras de octubre de 2026
cruzamos Corea del Sur en bicicleta, de **Seúl a Busan**, siguiendo la ruta
**국토종주 (Gukto Jongju)**: 633 km oficiales que se convirtieron en más de
700 contando desvíos a los alojamientos y la ida al kilómetro 0.

Fueron **24 jornadas** seguidas, y así es como están contadas aquí: por
número de día, no por fecha.

Fuimos tres. Esto es lo que vimos, lo que costó, dónde dormimos, qué comimos y
en qué nos equivocamos — por si a alguien le sirve para preparar el suyo.

## El viaje, día a día

{% assign dias = site.posts | where_exp: "p", "p.dia" | sort: "dia" %}

Las **{{ dias | size }} jornadas** del viaje, en orden. Se leen empezando por
el día 1: al final de cada una hay enlace a la siguiente.

<ol class="lista-dias">
{% for p in dias %}
  <li value="{{ p.dia }}">
    <a href="{{ p.url | relative_url }}">{{ p.title }}</a>
  </li>
{% endfor %}
</ol>

## Por temas

Las entradas que no cuentan un día concreto, sino algo que atraviesa el viaje
entero.

<ul class="lista-temas">
{% assign temas = site.posts | where_exp: "p", "p.dia == nil" | sort: "date" %}
{% for p in temas %}
  <li>
    <a href="{{ p.url | relative_url }}">{{ p.title }}</a>
    {% if p.description %}<br><small>{{ p.description | strip_newlines | truncate: 160 }}</small>{% endif %}
  </li>
{% endfor %}
</ul>
