# Almacenamiento de datos. NoSQL

## Almacenamiento de datos

Se puede decir que estamos en la [tercera plataforma](https://en.wikipedia.org/wiki/Third_platform) tercera plataforma del almacenamiento de datos. La primera llegó con los primeros computadores y se materializó en las bases de datos jerárquicas y en red, así como en el almacenamiento ISAM. La segunda vino de la mano de Internet y las arquitecturas cliente-servidor, lo que dio lugar a las bases de datos relacionales.

La tercera se ve motivada por el Big Data, los dispositivos móviles, las arquitecturas cloud, las redes de IoT y las tecnologías/redes sociales. Es tal el volumen de datos que se genera que aparecen nuevos paradigmas como NoSQL, NewSQL y las plataformas de Big Data. En esta sesión nos vamos a centrar en NoSQL.

NoSQL aparece como una necesidad debida al creciente volumen de datos sobre usuarios, objetos y productos que las empresas tienen que almacenar, así como la frecuencia con la que se accede a los datos. Los SGDB relacionales existentes no fueron diseñados teniendo en cuenta la escalabilidad ni la flexibilidad necesaria por las frecuentes modificaciones que necesitan las aplicaciones modernas; tampoco aprovechan que el almacenamiento a día de hoy es muy barato, ni el nivel de procesamiento que alcanzan las máquinas actuales.


<p align="center">
  <img src="../../images/01nosql.png" alt="Motivación de NoSQL" width="100%"/>
</p>


## No Solo SQL

**Definición formal**: tecnologías que priorizan rendimiento, fiabilidad y agilidad frente a modelos relacionales :contentReference[oaicite:3]{index=3}.

Interpretación de NoSQL:

- **No = Not only**: complementarios a SQL.
- Priorizan **escalabilidad** y **disponibilidad** en lugar de **atomicidad** y **consistencia** estricta (ACID):
  - **A**tomización
  - **C**onsistencia
  - **I**solación
  - **D**urabilidad :contentReference[oaicite:4]{index=4}

## Modelos de datos NoSQL

1. **Clave‑Valor**: pares simples; ejemplos: Redis, Riak, DynamoDB :contentReference[oaicite:5]{index=5}  
2. **Documental**: documentos JSON; ejemplos: MongoDB, CouchDB :contentReference[oaicite:6]{index=6}  
3. **Grafos**: para redes; ejemplos: Neo4J, Neptune, ArangoDB :contentReference[oaicite:7]{index=7}  
4. **Columnas**: optimizadas para grandes volúmenes; ejemplos: BigTable, Cassandra, HBase :contentReference[oaicite:8]{index=8}

## Características principales

- Manejo de **volúmenes masivos** y datos semi/estructurados  
- **Esquemas dinámicos**: añadir campos sin migraciones  
- **Escalabilidad horizontal** mediante clusters  
- Caché integrada → permite **consistencia eventual** :contentReference[oaicite:9]{index=9}

## Esquemas dinámicos

No requieren definición previa del esquema → ágil integración y sin downtime. Posibilidad de definir esquema solo al leer (schema-on-read) :contentReference[oaicite:10]{index=10}

## Particionado (Sharding)

- Crucial para escalar horizontalmente  
- Tipos: **horizontal** (filas) vs **vertical** (columnas)  
- En NoSQL, se usa especialmente en clave‑valor y documental; columnas pueden usar ambos :contentReference[oaicite:11]{index=11}

### Auto‑sharding

Distribución automática transparente para la aplicación (por rango, lista, hash) :contentReference[oaicite:12]{index=12}

## Replicación

Copia de datos en varios nodos para **alta disponibilidad** y **tolerancia a fallos**.  
- **Peer-to-peer**: todos escriben, posible inconsistencia temporal :contentReference[oaicite:13]{index=13}  
- Replicación + particionado = entorno ideal :contentReference[oaicite:14]{index=14}

## Implantación

Proceso típico:

1. Prueba piloto con baja escala (gratuita, open-source)  
2. Escalado tras análisis del crecimiento, modelo de datos, consistencia, APIs, soporte y comunidad :contentReference[oaicite:15]{index=15}

### Decisión tecnológica

Evaluar según:

- Modelo de datos (documental, columnar, grafos, clave‑valor)  
- Necesidades de consulta y de índices secundarios  
- Consistencia vs disponibilidad  
- APIs y ecosistema  
- Comunidad y soporte :contentReference[oaicite:16]{index=16}

## Casos de uso

- Aplicaciones web con campos personalizables → **Documental**  
- Caché → **Clave‑Valor**  
- Almacenamiento de metadatos binarios → Documental o Clave‑Valor  
- Grandes volúmenes, baja consistencia → Documental o Columnar :contentReference[oaicite:17]{index=17}

## Limitaciones

- Ausencia de estándar único  
- Riesgo en proyectos open‑source sin soporte comercial  
- Interfaces gráficas limitadas  
- Profesionales con experiencia escasa :contentReference[oaicite:18]{index=18}

## Teorema de CAP

De Brewer (2000): en sistemas distribuidos solo se pueden cumplir dos de tres:  
- **C**onsistencia  
- **A**vailability  
- **P**artition tolerance :contentReference[oaicite:19]{index=19}

Se elige entre CP, AP o CA, pero no los tres.

### Modelo BASE

- **B**asically **A**vailable, **S**oft‑state y **E**ventual consistency  
- Prioriza disponibilidad y tolerancia a particiones (AP) :contentReference[oaicite:20]{index=20}

---

## 📝 Actividades propuestas

1. ¿Qué significa el prefijo “No” en NoSQL?  
2. ¿Puede un sistema soportar replicación y particionado simultáneamente?  
3. Asignar modelo de datos a escenarios:  
   - Wiki de cómics  
   - Información académica de un país  
4. Investigar **persistencia políglota**  
5. Clasificar: BigTable, Cassandra, CouchDB, DynamoDB, HBase, MongoDB, Redis, Riak, Voldemort según CAP  
6. Crear presentación sobre **NewSQL**, su relación con NoSQL y ejemplos como CockroachDB o VoltDB

<div class="admonition info">
<p class="admonition-title">Fuentes utilizadas</p>
<p>Las principales fuentes consultadas para la realización de esta sección han sido:</p>
<ul>
<li><a href="https://aitor-medrano.github.io/iabd/sa/nosql.html">Aitor Medrano. Cursos Inteligencia Artificial y Big Data. Almacen de datos NoSQL</a></li>
<li><a href="https://link.springer.com/book/10.1007/978-1-4842-1329-2">Next Generation Databases</a>: NoSQL, NewSQL, and Big Data</li>
<li><a href="https://www.informit.com/store/nosql-distilled-a-brief-guide-to-the-emerging-world-9780321826626">NoSQL Distilled</a>: A Brief Guide to the Emerging World of Polyglot Persistence</li>
<li><a href="https://dataschool.com/data-modeling-101/row-vs-column-oriented-databases/">Row vs Column Oriented Databases</a></li>
<li><a href="https://www.digitalocean.com/community/tutorials/understanding-database-sharding">Understanding Database Sharding</a></li>
</ul>
</div>
