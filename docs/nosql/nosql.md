# Almacenamiento de datos. NoSQL

## Almacenamiento de datos

Se puede decir que estamos en la [tercera plataforma](https://en.wikipedia.org/wiki/Third_platform) tercera plataforma del almacenamiento de datos. La primera llegó con los primeros computadores y se materializó en las bases de datos jerárquicas y en red, así como en el almacenamiento ISAM. La segunda vino de la mano de Internet y las arquitecturas cliente-servidor, lo que dio lugar a las bases de datos relacionales.

La tercera se ve motivada por el Big Data, los dispositivos móviles, las arquitecturas cloud, las redes de IoT y las tecnologías/redes sociales. Es tal el volumen de datos que se genera que aparecen nuevos paradigmas como NoSQL, NewSQL y las plataformas de Big Data. En esta sesión nos vamos a centrar en NoSQL.

NoSQL aparece como una necesidad debida al creciente volumen de datos sobre usuarios, objetos y productos que las empresas tienen que almacenar, así como la frecuencia con la que se accede a los datos. Los SGDB relacionales existentes no fueron diseñados teniendo en cuenta la escalabilidad ni la flexibilidad necesaria por las frecuentes modificaciones que necesitan las aplicaciones modernas; tampoco aprovechan que el almacenamiento a día de hoy es muy barato, ni el nivel de procesamiento que alcanzan las máquinas actuales.


<div style="text-align: center;">
  <img src="../images/nosql.png" alt="Motivación NoSQL" width="100%"/>
</div>

La solución es el **despliegue de las aplicaciones y sus datos en clústeres de servidores, distribuyendo el procesamiento en múltiples máquinas.**

## No Solo SQL

### Definición NoSQL
Si definimos **NoSQL** formalmente, podemos decir que se trata de un **conjunto de tecnologías** que permiten el procesamiento rápido y eficiente de conjuntos de datos dando la mayor importancia al rendimiento, la fiabilidad y la agilidad.

Si nos basamos en el acrónimo, el término da la sensación que se refiere a cualquier almacén de datos que no sigue un modelo relacional, los datos no son relacionales y por tanto no utilizan SQL como lenguaje de consulta. Realmente implica que el **No** hace referencia a **not only**, es decir, _que los sistemas NoSQL se centran en sistemas complementarios a los SGBD relacionales_, que fijan sus **prioridades en la escalabilidad y la disponibilidad en contra de la atomicidad y consistencia de los datos.**

Es decir, más que sustitutos de los sistemas relacionales, las soluciones NoSQL se plantean como alternativas y complementarias a los sistemas gestores de bases de datos relacionales.

<div class="admonition info">
<p class="admonition-title">ACID</p>
<p>Las bases de datos relacionales cumplen las características ACID para ofrecer transaccionalidad sobre los datos:</p>
<ul>
<li><strong>A</strong>tomicidad: las transacciones implican que se realizan todas las operaciones o no se realiza ninguna.</li>
<li><strong>C</strong>onsistencia: la base de datos asegura que los datos pasan de un estado válido o otro también.</li>
<li><strong>I</strong>solation (Aislamiento): Una transacción no afecta a otras transacciones, de manera que la modificación de un registro / documento no es visible por otras lecturas hasta que ha finalizado la transacción. Esto implica que ninguna transacción obtiene una versión intermedia de los datos.</li>
<li><strong>D</strong>urabilidad: La escritura de los datos asegura que una vez finalizada una operación, los datos no se perderán.</li>
</ul>
</div>

Los diferentes tipos de bases de datos NoSQL existentes se pueden agrupar en cuatro categorías:

- **Clave-Valor**: Los almacenes clave-valor son las bases de datos NoSQL más simples. Cada elemento de la base de datos se almacena con un nombre de atributo (o clave) junto a su valor, a modo de diccionario. Los almacenes más conocidos son [Redis](https://redis.io), [Riak](https://riak.com) y [AWS DynamoDB](https://aws.amazon.com/es/dynamodb/). Algunos almacenes, como es el caso de Redis, permiten que cada valor tenga un tipo (por ejemplo, integer) lo cual añade funcionalidad extra.

- **Documentales**: Cada clave se asocia a una estructura compleja que se conoce como documento. Este puede contener diferentes pares clave-valor, o pares de clave-array o incluso documentos anidados, como en un documento JSON. Los ejemplos más conocidos son [MongoDB](https://www.mongodb.com/), [CouchDB](https://couchdb.apache.org/) o [Elastic Search](https://www.elastic.co/es/).

- **Grafos**: Los almacenes de grafos se usan para almacenar información sobre redes, como pueden ser conexiones sociales. Los ejemplos más conocidos son [Neo4j](https://neo4j.com/), [Amazon Neptune](https://aws.amazon.com/es/neptune/) y [ArangoDB](https://arangodb.com/).

- **Basados en columnas**: Los almacenes basados en columnas como [Hypertabla de Google](https://hypertable.com/), [Apache Cassandra](https://cassandra.apache.org/_/index.html) y [Apache HBase](https://hbase.apache.org/) están optimizados para consultas sobre grandes conjuntos de datos, y almacenan los datos como columnas en vez de como filas.

<div style="text-align: center;">
  <img src="../images/01nosql-databases.jpg" alt="Categorías NoSQL" width="50%"/>
</div>

## Características principales

Si nos centramos en sus beneficios y los comparamos con las base de datos relacionales, las bases de datos NoSQL son más escalables, ofrecen un rendimiento mayor y sus modelos de datos resuelven varios problemas que no se plantearon al definir el modelo relacional:

- **Grandes volúmenes de datos estructurados, semi-estructurados y sin estructurar**. Casi todas las implementaciones NoSQL ofrecen algún tipo de representación para datos sin esquema, lo que permite comenzar con una estructura y con el paso del tiempo, añadir nuevos campos, ya sean sencillos o anidados a datos ya existentes.
- **Sprints ágiles**, iteraciones rápidas y frecuentes commits/pushes de código, al emplear una sintaxis sencilla para la realización de consultas y la posibilidad de tener un modelo que vaya creciendo al mismo ritmo que el desarrollo.
- **Arquitectura eficiente y escalable diseñada para trabajar con clusters** en vez de una arquitectura monolítica y costosa. Las soluciones NoSQL soportan la escalabilidad de un modo transparente para el desarrollador y ofrecen una solución cloud.

Una característica adicional que comparten los sistemas NoSQL es que ofrecen un mecanismo de caché de datos integrado (en los sistemas relacionales se pueden configurar de manera externa), pudiendo configurar los sistemas para que los datos se mantengan en memoria y se persistan de manera periódica. El uso de una caché conlleva que la consistencia de los datos no sea completa y podamos tener una consistencia eventual.

## Esquemas dinámicos

**Las bases de datos relacionales requieren definir los esquemas antes de añadir los datos**. Una base de datos SQL necesita saber de antemano los datos que vamos a almacenar; por ejemplo, si nos centramos en los datos de un cliente, serían el nombre, apellidos, número de teléfono, etc…​

**Esto casa bastante mal con los enfoques de desarrollo ágil**, ya que cada vez que añadimos nuevas funcionalidades, el esquema de la base de datos suele cambiar. De modo que si a mitad de desarrollo decidimos almacenar los productos favoritos de un cliente del cual guardábamos su dirección y números de teléfono, tendríamos que añadir una nueva columna a la base de datos y migrar la base de datos entera a un nuevo esquema.

**Si la base de datos es grande, conlleva un proceso lento que implica parar el sistema durante un tiempo considerable**. Si frecuentemente cambiamos los datos que la aplicación almacena (al usar un desarrollo iterativo), también tendremos períodos frecuentes de inactividad del sistema, a no ser que utilicemos un despliegue azul/verde y tengamos redundancia de nuestro sistema de almacenamiento. Así pues, no hay un modo efectivo mediante una base de datos relacional de almacenar los datos que están desestructurados o que no se conocen de antemano.

Las bases de datos NoSQL se construyen para permitir la inserción de datos sin un esquema predefinido. Esto facilita la modificación de la aplicación en tiempo real, sin preocuparse por interrupciones de servicio. Aunque no tengamos un esquema al guardar la información, sí que podemos definir esquemas de lectura (schema-on-read) para comprobar que la información almacenada tiene el formato que espera cargar cada aplicación.

De este modo se consigue un desarrollo más rápido, integración de código más robusto y menos tiempo empleado en la administración de la base de datos.

Aunque lo veremos en profundidad en las siguientes sesiones, los modelos de datos NoSQL priman la redundancia de los datos, denormalizando los datos para evitar el uso de joins. Por ello, es importante que la definición de los esquemas sea flexible para poder añadir campos conforme la aplicación evolucione.

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
