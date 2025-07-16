# Almacenamiento de datos. NoSQL

## Almacenamiento de datos

Se puede decir que estamos en la [tercera plataforma](https://en.wikipedia.org/wiki/Third_platform) del almacenamiento de datos. La primera llegó con los primeros computadores y se materializó en las bases de datos jerárquicas y en red, así como en el almacenamiento ISAM. La segunda vino de la mano de Internet y las arquitecturas cliente-servidor, lo que dio lugar a las bases de datos relacionales.

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

**Las bases de datos NoSQL se construyen para permitir la inserción de datos sin un esquema predefinido**. Esto facilita la modificación de la aplicación en tiempo real, sin preocuparse por interrupciones de servicio. Aunque no tengamos un esquema al guardar la información, sí que podemos definir esquemas de lectura (schema-on-read) para comprobar que la información almacenada tiene el formato que espera cargar cada aplicación.

De este modo se consigue un desarrollo más rápido, integración de código más robusto y menos tiempo empleado en la administración de la base de datos.

Aunque lo veremos en profundidad en las siguientes sesiones, los modelos de datos NoSQL priman la redundancia de los datos, denormalizando los datos para evitar el uso de joins. Por ello, es importante que la definición de los esquemas sea flexible para poder añadir campos conforme la aplicación evolucione.

## Particionado (Sharding)

Dado el modo en el que se estructuran *las bases de datos relacionales, normalmente escalan verticalmente*, un único servidor cada vez más potente (más RAM, mejor CPU y almacenamiento), que almacena toda la base de datos para asegurar la disponibilidad continua de los datos. Esto se traduce en costes que se incrementan rápidamente, con un límites definidos por el propio hardware, y en un pequeño número de puntos críticos de fallo dentro de la infraestructura de datos.

La solución es escalar horizontalmente, añadiendo nuevos servidores en vez de concentrarse en incrementar la capacidad de un único servidor, lo que permite tratar con conjuntos de datos más grandes de lo que sería capaz cualquier máquina por sí sola. Este escalado horizontal se conoce como Sharding o Particionado.

El particionado no es único de las bases de datos NoSQL. Las bases de datos relacionales también lo soportan. Si en un sistema relacional queremos particionar los datos, podemos distinguir entre particionado:

- Horizontal: diferentes filas en diferentes particiones.
- Vertical: diferentes columnas en particiones distintas.

<figure style="align: center;">
    <img src="../images/01sharding01.png" alt="Particionado de datos" width="100%">
    <figcaption>Particionado de datos - digitalocean.com</figcaption>
</figure>

En el caso de las bases de datos NoSQL, el particionado depende del modelo de la base de datos:

- Los almacenes clave-valor y las bases de datos documentales normalmente se particionan horizontalmente.
- Las bases de datos basados en columnas se pueden particionar horizontal o verticalmente.
Escalar horizontalmente una base de datos relacional entre muchas instancias de servidores se puede conseguir pero normalmente conlleva el uso de SANs (Storage Area Networks) y otras triquiñuelas para hacer que el hardware actúe como un único servidor.

Como los sistemas SQL no ofrecen esta prestación de forma nativa, los equipos de desarrollo se las tienen que ingeniar para conseguir desplegar múltiples bases de datos relacionales en varias máquinas. Para ello:

- Los datos se almacenan en cada instancia de base de datos de manera autónoma
- El código de aplicación se desarrolla para distribuir los datos y las consultas y agregar los resultados de los datos a través de todas las instancias de bases de datos
- Se debe desarrollar código adicional para gestionar los fallos sobre los recursos, para realizar joins entre diferentes bases de datos, balancear los datos y/o replicarlos, etc…​
Además, muchos beneficios de las bases de datos como la integridad transaccional se ven comprometidos o incluso eliminados al emplear un escalado horizontal.

### Auto‑sharding

Por contra, las bases de datos NoSQL normalmente soportan auto-sharding, lo que implica que de manera nativa y automáticamente se dividen los datos entre un número arbitrario de servidores, sin que la aplicación sea consciente de la composición del pool de servidores. Los datos y las consultas se balancean entre los servidores.

El particionado se realiza mediante un método consistente, como puede ser:

- Por **rangos** de su id: por ejemplo "los usuarios del 1 al millón están en la partición 1" o "los usuarios cuyo nombre va de la A a la L" en una partición, en otra de la M a la Q, y de la R a la Z en la tercera.

<figure style="align: center;">
    <img src="../images/01sharding03range.png" alt="Particionado por rango" width="100%">
    <figcaption>Particionado por rango - digitalocean.com</figcaption>
</figure>

- Por **listas**: dividiendo los datos por la categoría del dato, es decir, en el caso de datos sobre libros, las novelas en una partición, las recetas de cocina en otra, etc..
- Mediante una función **hash**, la cual devuelve un valor para un elemento que determine a qué partición pertenece.
<figure style="align: center;">
    <img src="../images/01sharding02hash.png" alt="Particionado por hash" width="100%">
    <figcaption>Particionado por hash - digitalocean.com</figcaption>
</figure>

### Cuándo particionar
El motivo para particionar los datos se debe a:

- **limitaciones de almacenamiento**: los datos no caben en un único servidor, tanto a nivel de disco como de memoria RAM.
- **rendimiento**: al balancear la carga entre particiones las escrituras serán más rápidas que al centrarlas en un único servidor.
- **disponibilidad**: si un servidor esta ocupado, otro servidor puede devolver los datos. La carga de los servidores se reduce.

>No particionaremos los datos cuando la cantidad sea pequeña, ya que el hecho de distribuir los datos conlleva unos costes que pueden no compensar con un volumen de datos insuficiente. Tampoco esperaremos a particionar cuando tengamos muchísimos datos, ya que el proceso de particionado puede provocar sobrecarga del sistema.

La nube facilita de manera considerable este escalado, mediante proveedores como AWS o Azure los cuales ofrecen virtualmente una capacidad ilimitada bajo demanda, y despreocupándose de todas las tareas necesarias para la administración de la base de datos.

Los desarrolladores ya no necesitamos construir plataformas complejas para nuestras aplicaciones, de modo que nos podemos centrar en escribir código de aplicación. Una granja de servidores con *commodity hardware* puede ofrecer el mismo procesamiento y capacidad de almacenamiento que un único servidor de alto rendimiento por mucho menos coste.

## Replicación
La replicación mantiene copias idénticas de los datos en múltiples servidores, lo que facilita que las aplicaciones siempre funcionen y los datos se mantengan seguros, incluso si alguno de los servidores sufre algún problema.

La mayoría de las bases de datos NoSQL también soportan la replicación automática, lo que implica una alta disponibilidad y recuperación frente a desastres sin la necesidad de aplicaciones de terceros encargadas de ello. Desde el punto de vista del desarrollador, el entorno de almacenamiento es virtual y ajeno al código de aplicación.

Existen dos formas de realizar la replicación:

### Maestro-esclavo / Primario-secundario

Todas las escrituras se realizan en el nodo principal y después se replican a los nodos secundarios. El nodo primario es un SPOF (*single point of failure*).

<figure style="align: center;">
    <img src="../images/01replication-master-slave.jpg" alt="Replicación Primario-secundario" width="100%">
    <figcaption>Replicación Primario-secundario</figcaption>
</figure>


### Par-a-par (peer-to-peer)
Todos los nodos tienen el mismo nivel jerárquico, de manera que todos admiten escrituras. Al poder haber escrituras simultáneas sobre el mismo datos en diferentes nodos, pueden darse inconsistencia en los datos.

<figure style="align: center;">
    <img src="../images/01replication-peer-to-peer.png" alt="Replicación par-a-par" width="100%">
    <figcaption>Replicación Par-a-par</figcaption>
</figure>

La replicación de los datos se utiliza para alcanzar:

- **escalabilidad**, incrementando el rendimiento al poder distribuir las consultas en diferentes nodos, y mejorar la redundancia al permitir que cada nodo tenga una copia de los datos.
- **disponibilidad**, ofreciendo tolerancia a fallos de hardware o corrupción de la base de datos. Al replicar los datos vamos a poder tener una copia de la base de datos, dar soporte a un servidor de datos agregados, o tener nodos a modo de copias de seguridad que pueden tomar el control en caso de fallo.
- **aislamiento (la i en ACID - isolation)**, entendido como la propiedad que define cuando y cómo al realizar cambios en un nodo se propagan al resto de nodos. Si replicamos los datos podemos crear copias sincronizadas para separar procesos de la base de datos de producción, pudiendo ejecutar informes, analítica de datos o copias de seguridad en nodos secundarios de modo que no tenga un impacto negativo en el nodo principal, así como ofrecer un sistema sencillo para separar el entorno de producción del de preproducción.


<div class="admonition caution">
<p class="admonition-title">Replicación vs particionado</p>
<p align="justify">No hay que confundir la replicación (copia de los datos en varias máquinas) con el particionado (cada máquina tiene un subconjunto de los datos). El entorno más seguro y con mejor rendimiento es aquel que tiene los datos particionados y replicados (cada máquina que tiene un subconjunto de los datos está replicada en 2 o más).</p>
<figure style="align: center;">
    <img src="../images/01sharding-replication.png" alt="Replicación y particionado" width="500px">
    <figcaption>Replicación y particionado - codingexplained.com</figcaption>
</figure><p></p>
</div>


## Implantando NoSQL

Normalmente, las empresas empezarán con una prueba de baja escalabilidad de una base de datos NoSQL, de modo que les permita comprender la tecnología asumiendo muy poco riesgo. La mayoría de las bases de datos NoSQL también son open-source, y por tanto se pueden probar sin ningún coste extra. Al tener unos ciclos de desarrollo más rápidos, las empresas pueden innovar con mayor velocidad y mejorar la experiencia de sus cliente a un menor coste.

<div class="admonition question">
<p class="admonition-title">Consideraciones</p>
<ul>
<li align="justify">¿Cuál es el crecimiento previsto de nuestra aplicación en un futuro próximo, por ejemplo, el número de usuarios, y cómo crecerá en 3 meses, 6 meses o un año?</li>
<li align="justify">Para soportar el crecimiento de la base de usuarios, ¿qué funciones de nuestra aplicación requerirán más almacenamiento de datos y pueden escalarse?</li>
<li align="justify">¿Cómo podemos distribuir lógica y físicamente nuestros datos? Por ejemplo, si nuestra aplicación requiere soporte geográfico para dar servicio a varias ciudades, ¿podemos distribuir o separar algunos datos en función de las ciudades?</li>
<li align="justify">¿Qué impacto tendría en la empresa una caída de la base de datos? Es decir ¿Cómo de importante es la alta disponibilidad de nuestra base de datos?</li>
<li align="justify">¿Cuál es el ratio entre las operaciones de lectura frente a las de escritura? ¿Cuál es su pico en horas punta? ¿Qué <em>payload</em> se espera por operación? ¿Cuánta CPU se necesita por operación?</li>
<li align="justify">¿La aplicación requiere un modelo de datos fijo o flexible, el cual permita cambios en el futuro? Y si necesita cambiar el esquema de los modelos de datos existentes, ¿cuál será el impacto en términos de parada de mantenimiento, migraciones necesarias, etc...?</li>
<li align="justify">¿Podemos reducir el tráfico de nuestra aplicación hacia las bases de datos y mejorar el rendimiento?.</li>
</ul>
</div>

Planteadas estas preguntas, claramente elegir la base de datos correcta para nuestros proyectos es un tema importante. Se deben considerar las diferentes alternativas a las infraestructuras legacy teniendo en cuenta varios factores:

- La escalabilidad o el rendimiento más allá de las capacidades del sistema existente.
- Identificar alternativas viables respecto al software propietario.
- Incrementar la velocidad y agilidad del proceso de desarrollo.

Así pues, al elegir un base de datos hemos de tener en cuenta las siguientes dimensiones:

- **Modelo de datos**: A elegir entre un modelo documental, basado en columnas, de grafos o mediante clave-valor.
- **Modelo de consultas**: Dependiendo de la aplicación, puede ser aceptable un modelo de consultas que sólo accede a los registros por su clave primaria. En cambio, otras aplicaciones pueden necesitar consultar por diferentes valores de cada registro. Además, si la aplicación necesita modificar los registros, la base de datos necesita consultar los datos por un índice secundario.
- **Modelo de consistencia**: Los sistemas NoSQL normalmente mantienen múltiples copias de los datos para ofrecer disponibilidad y escalabilidad al sistema, lo que define la consistencia del mismo. Los sistemas NoSQL tienden a ser consistentes o eventualmente consistentes.
- **APIs**: No existe un estándar para interactuar con los sistemas NoSQL. Cada sistema presenta diferentes diseños y capacidades para los equipos de desarrollo. La madurez de un API puede suponer una inversión en tiempo y dinero a la hora de desarrollar y mantener el sistema NoSQL.
- **Soporte comercial y de la comunidad**: Los usuarios deben considerar la salud de la compañía o de los proyectos al evaluar una base de datos. El producto debe evolucionar y mantenerse para introducir nuevas prestaciones y corregir fallos. Una base de datos con una comunidad fuerte de usuarios:
    - Permite encontrar y contratar desarrolladores con destrezas en el producto
    - Facilita encontrar información, documentación y ejemplos de código.
    - Ayuda a las empresas a retener el talento.
    - Favorece que otras empresas de software integren sus productos y participen en el ecosistema de la base de datos.
### Casos de uso
Una vez conocemos los diferentes sistemas y qué elementos puede hacer que nos decidamos por una solución u otra, conviene repasar los casos de uso más comunes:

- Si vamos a crear una aplicación web cuyo campos sean personalizables, usaremos una solución documental.
- Como una capa de caché, mediante un almacén clave-valor.
- Para almacenar archivos binarios sin preocuparse de la gestión de permisos del sistema de archivos, y poder realizar consultas sobre sus metadatos, ya sea mediante una solución documental o un almacén clave-valor.
- Para almacenar un enorme volumen de datos, donde la consistencia no es lo más importante, pero si la disponibilidad y su capacidad de ser distribuida, mediante una solución documental o basada en columnas.

### Limitaciones

Una vez que hemos conocido todas las bondades, es conviente citar las limitaciones asociadas a las soluciones NoSQL:

- **Falta de estándar**: Cada base de datos NoSQL surgió de la necesidad de diferentes casos de uso, y al basarse en código abierto, ninguna base de datos NoSQL es igual a otra y no hay directrices estándar para su uso.
- **Riesgos del código abierto**: Aunque muchas de las soluciones NoSQL han derivado en productos comerciales, puede que algunas de ellas no se mantengan de forma continua y que no haya soporte si nos encontramos con algún problema. Es por ello, que es conveniente comprobar el soporte de la comunidad y de si hay una versión enterprise que podamos contratar en caso de necesidad.
- **Falta de interfaces gráficos para acceder a las bases de datos NoSQL**: Sólo unas pocas soluciones NoSQL soportan una forma fácil de interactuar con los datos.
- **Perfiles escasos**: Al tratarse de una nueva tecnología, encontrar expertos NoSQL a veces es difícil y costoso.

---
## 📝 Actividades propuestas

1. ¿Qué significa el prefijo “No” en NoSQL?  
2. ¿Puede un sistema soportar replicación y particionado simultáneamente?  

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
