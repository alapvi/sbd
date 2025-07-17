# Modelos de datos
La principal clasificación de los sistemas de bases de datos NoSQL se realiza respecto a los diferentes modelos de datos:

## Documental
Mientras las bases de datos relacionales almacenan los datos en filas y columnas, las bases de datos documentales emplean documentos. Estos documentos utilizan una estructura JSON, ofreciendo un modo natural e intuitivo para modelar datos de manera similar a la orientación a objetos, donde cada documento es un objeto.


<figure style="align: center;">
    <img src="../images/01document.png" alt="Representación de un documento" width="50%">
    <figcaption>Representación de un documento</figcaption>
</figure>

Los documentos se agrupan en colecciones o bases de datos, dependiendo del sistema, lo que permite agrupar documentos.

Los documentos contienen uno o más campos, donde cada campo contiene un valor con un tipo, ya sea cadena, entero, flotante, fecha, binario o array u otro documento. En vez de extender los datos entre múltiples columnas y tablas, cada registro y sus datos asociados se almacenan de manera unida en un único documento. Esto simplifica el acceso a los datos y reduce (y en ocasiones elimina) la necesidad de joins y transacciones complejas.

Dicho de otra manera, en las bases de datos documentales, los datos que van juntos y se emplean juntos, se almacenan juntos.

### Características
**En una base de datos documental, la noción de esquema es dinámico**: cada documento puede contener diferentes campos. Esta flexibilidad puede ser útil para modelar datos desestructurados y polimórficos, lo que facilita la evolución del desarrollo al permitir añadir nuevos campos de manera dinámica.

Perfectamente podemos tener dos documentos que pertenecen a la misma colección, pero con atributos diferentes. Por ejemplo, un primer documento puede ser el siguiente:
```json
{   
    "_id": "BW001",   
    "nombre": "Bruce",   
    "apellido": "Wayne",   
    "edad": 35,   
    "salario": 10000000 
}
```
Mientras que un segundo documento dentro de la misma colección podría ser:

```json
{
  "_id": "JK1",
  "nombre": "Joker",
  "edad": 34,
  "salario": 5000000,
  "direccion": {               
    "calle": "Asilo Arkham",
    "ciudad": "Gotham"
  },
  "proyectos": [               
    "desintoxicacion-virus",
    "top-secret-007"
  ]
}
```
Normalmente, cada documento contiene un elemento clave, sobre el cual se puede obtener un documento de manera unívoca. De todos modos, las bases de datos documentales ofrecen un completo mecanismo de consultas, posibilitando obtener información por cualquier campo del documento. Algunos productos ofrecen opciones de indexado para optimizar las consultas, como pueden ser índices compuestos, dispersos, con tiempo de vida (TTL), únicos, de texto o geoespaciales.

Además, estos sistemas ofrecen productos que permiten analizar los datos, mediante funciones de agregación o implementación de MapReduce.

Respecto a la modificaciones, los documentos se pueden actualizar en una única sentencia, sin necesidad de dar rodeos para elegir los datos a modificar.

### Casos de uso

Las bases de datos documentales se pueden emplear como sistemas de propósito general, válidos para un amplio abanico de aplicaciones gracias a la flexibilidad que ofrece el modelo de datos, lo que permite consultar cualquier campo y modelar de manera natural con un enfoque similar a la programación orientada a objetos.

Entre los casos de éxito de estos sistemas cabe destacar:

- Sistemas de flujo de eventos: entre diferentes aplicaciones dentro de una empresa.
- Gestores de contenido, plataformas de Blogging: al almacenar los documentos mediante JSON, facilita la estructura de datos para guardar los comentarios, registros de usuarios, etc…​
- Analíticas web, datos en tiempo real: al permitir modificar partes de un documento, e insertar nuevos atributos a un documento cuando se necesita una nueva métrica.
- Aplicaciones eCommerce: conforme las aplicaciones crecen, el esquema también lo hace.

Si nos centramos en aquellos casos donde no conviene este tipo de sistemas podemos destacar:

- Sistemas operacionales con transacciones complejas.
- Sistemas con consultas agregadas que modifican su estructura. Si los criterios de las consultas no paran de cambiar, acabaremos normalizando los datos.

Los productos más destacados son:

- MongoDB: [http://www.mongodb.com](http://www.mongodb.com). Esta base de datos la vamos a estudiar en profundidad en esta unidad de trabajo.
- CouchDB: [http://couchdb.apache.org](http://couchdb.apache.org)

## Clave-Valor
Un almacén clave-valor es una simple tabla hash donde todos los accesos a la base de datos se realizan a través de la clave primaria.

Desde una perspectiva de modelo de datos, los almacenes de clave-valor son los más básicos.

Su funcionamiento es similar a tener una tabla relacional con dos columnas, por ejemplo `id` y `nombre`, siendo `id` la columna utilizada como clave y `nombre` como valor. Mientras que en una base de datos relacional en el campo nombre sólo podemos almacenar datos de tipo cadena o numérico, en un almacén clave-valor, el valor puede ser de un dato simple o un objeto. En muchos casos, se almacena un objeto binario *BLOB (Binary Large Object)*. Cuando una aplicación accede mediante la clave y el valor, se almacenan el par de elementos. Si la clave ya existe, el valor se modifica.

<figure style="align: center;">
    <img src="../images/01key-value.jpg" alt="Representación de un almacén clave-valor" width="80%">
    <figcaption>Representación de un almacén clave-valor</figcaption>
</figure>

El cliente puede tanto obtener el valor por la clave, asignar un valor a una clave o eliminar una clave del almacén. El valor, sin embargo, es opaco al sistema, el cual no sabe que hay dentro de él, ya que los datos sólo se pueden consultar por la clave, lo cual puede ser un inconveniente. Así pues, la aplicación es responsable de saber qué hay almacenado en cada valor.

Por ejemplo, [Riak](https://riak.com/) utiliza el concepto de *bucket (cubo)* como una manera de agrupar claves, de manera similar a una tabla.

Por ejemplo, Riak permite interactuar con la base de datos mediante peticiones HTTP:

```bash
curl -v -X PUT <http://localhost:8091/riak/heroes/ace> -H "Content-Type: application/json" -d {"nombre" : "Batman", "color" : "Negro"}
```
Algunos almacenes clave-valor, como puede ser Redis, permiten almacenar datos con cualquier estructura, como por ejemplos listas, conjuntos, hashes, permitiendo realizar operaciones como la intersección, unión, diferencia y rango.

=== "Redis"
    ```redis
    SET nombre "Bruce Wayne"      // String
    HSET heroe nombre "Batman"    // Hash – set
    HSET heroe color "Negro"
    SADD "heroe:amigos" "Robin" "Alfred"   // Set – create/update
    ```

=== "Python"
    ```python
    import redis
    r = redis.Redis()
    r.mset({"Croatia": "Zagreb", "Bahamas": "Nassau"})
    r.get("Bahamas")
    # b'Nassau'
    ```

Estas prestaciones hacen que *Redis* se extrapole a ámbitos ajenos a un almacén clave-valor. Otra característica que ofrecen algunos almacenes es que permiten crear un segundo nivel de consulta o incluso definir más de una clave para un mismo objeto.

Como los almacenes clave-valor siempre utilizan accesos por clave primaria, de manera general tienen un gran rendimiento y son fácilmente escalables.

Si queremos que su rendimiento sea máximo, pueden configurarse para que mantengan la información en memoria y que se serialice de manera periódica, a costa de tener una consistencia eventual de los datos.

### Diferencias entre modelo Documental y Clave-Valor

Los modelos de datos Documental y Clave-Valor son dos paradigmas comunes en las bases de datos *NoSQL*. Pueden parecer similares pero existen unas diferencias claras entre ellos:

- **Estructura de datos**: En el modelo documental, los datos se organizan en documentos con una estructura interna, mientras que en el modelo clave-valor, los datos se almacenan como pares de clave-valor simples sin una estructura interna definida.

- **Flexibilidad**: El modelo documental ofrece más flexibilidad para almacenar datos semiestructurados o no estructurados, mientras que el modelo clave-valor es más adecuado para datos simples y bien definidos.

- **Consultas**: El modelo documental permite consultas más complejas y flexibles utilizando índices secundarios y lenguajes de consulta avanzados, mientras que en el modelo clave-valor, la recuperación de datos se realiza principalmente mediante búsquedas directas por clave.

### Casos de uso
Este modelo es muy **útil para representar datos desestructurados** o polimórficos, ya que no fuerzan ningún esquema más allá de los pares de clave-valor.

Entre los casos de uso de estos almacenes podemos destacar el almacenaje de:

- Información sobre la sesión de navegación *(sessionid)*
- Perfiles de usuario, preferencias
- Datos del carrito de la compra
- Cachear datos

Todas estas operaciones van a asociada a operaciones de recuperación, modificación o inserción de los datos de una sola vez, de ahí su elección.

En cambio, **no conviene utilizar estos almacenes cuando queremos realizar**:

- Relaciones entre datos
- Transacciones entre varias operaciones
- Consultas por los datos del valor
- Operaciones con conjuntos de claves

Los almacenes más empleados son:

- Riak: [https://riak.com](https://riak.com)
- Redis: [http://redis.io](http://redis.io)
- AWS DynamoDB: [http://aws.amazon.com/dynamodb](http://aws.amazon.com/dynamodb)
- Voldemort: [http://www.project-voldemort.com/voldemort](http://www.project-voldemort.com/voldemort) implementación open-source de Amazon DynamoDB

## Basado en columnas
Las bases de datos relacionales utilizan la fila como unidad de almacenamiento, lo que permite un buen rendimiento de escritura. Sin embargo, cuando las **escrituras son ocasionales** y es más común tener que leer unas pocas columnas de muchas filas a la vez, es mejor utilizar como unidad de almacenamiento un **grupos de columnas**. Es decir, lo que hacemos es girar el modelo 90 grados, de manera que **los registros se almacenan en columnas en vez de hacerlo por filas**.

Supongamos que tenemos los siguientes datos:

<figure style="align: center;">
    <img src="../images/04formatos-tabla.png" alt="Ejemplo de una tabla" width="50%">
    <figcaption>Ejemplo de una tabla</figcaption>
</figure>

Dependiendo del almacenamiento en filas o columnas tendríamos la siguiente representación:

<figure style="align: center;">
    <img src="../images/04formatos-filacolumna.png" alt="Comparación filas/columnas" width="100%">
    <figcaption>Comparación filas/columnas</figcaption>
</figure>

En un formato columnar los datos del mismo tipo se agrupan, lo que permite codificarlos/comprimirlos, lo que mejora el rendimiento de acceso y reduce el tamaño:


<figure style="align: center;">
    <img src="../images/04formatos-column-encoding.png" alt="Comparación filas/columnas" width="100%">
    <figcaption>Comparación filas/columnas</figcaption>
</figure>

=== "Columnar por filas"
    ```python
    { 
    "Fila 1": [1, "US", "Free"],
    "Fila 2": [2, "UK", "Paid"],
    "Fila 3": [3, "ES", "Paid"]
    }
    ```

=== "Columnar por columnas"
    ```python
    { 
    "user_id": [1, 2, 3],
    "country": ["US", "UK", "ES"],
    "subscription_type": ["Free", "Paid", "Paid"]
    }
    ```

!!! Question "Autoevaluación"
    Si tenemos que añadir un nuevo registro ¿Qué modelo será más eficiente?

Sin embargo, a medida que se incrementa la utilización de análisis de datos en memoria, con soluciones como Spark, los beneficios relativos de la base de datos columnares comparados con los de las bases de datos orientadas a filas pueden llegar a ser menos importantes.

### Representación

Un modelo basado en columnas se representa como una estructura agregada de dos niveles. El primer nivel formado por un almacén clave-valor, siendo la clave el identificador de la fila, y el valor un nuevo mapa con los datos agregados de la fila (familias de columnas). Los valores de este segundo nivel son las columnas. De este modo, podemos acceder a los datos de un fila, o a una determinada columna:

<figure markdown="span">
    !["Representación de un almacén basado en columnas"](../images/01column.jpg){width="90%" }
    <figcaption>Representación de un almacén basado en columnas</figcaption>
</figure>

!!! note "BigTable"
    Los modelos de datos basados en columnas se basan en la implementación de Google de la tecnología BigTable [http://research.google.com/archive/bigtable.html](http://research.google.com/archive/bigtable.html), la cual consiste en columnas separadas y sin esquema, a modo de mapa de dos niveles.

Así pues, los almacenes basados en columnas utilizan un mapa ordenado multi-dimensional y distribuido para almacenar los datos. Están pensados para que cada fila tenga una gran número de columnas (del orden del millón), almacenando las diferentes versiones que tenga una fila (pudiendo almacenar del orden de miles de millones de filas).

### Familias de columnas

Una columna consiste en un pareja `name-value`, donde el nombre hace de clave. Además, contiene un atributo timestamp para poder expirar datos y resolver conflictos de escritura.


Un ejemplo de columna podría ser:
```python
{
  name: "nombre",
  value: "Bruce",
  timestamp: 12345667890
}
```
Una fila es una colección de columnas agrupadas a una clave.
```python
{
    {         
        name: "nombre",         
        value: "Bruce",         
        timestamp: 12345667890     
    },     
    {         
        name: "nombre",         
        value: "Clark",         
        timestamp: 12345667891     
    },     
    {         
        name: "nombre",         
        value: "Barbara",         
        timestamp: 12345667892     
    } 
}
```
Si agrupamos filas similares tendremos una **familia de columnas** (similar al concepto de tabla):
```python
// familia de columnas
{
  // fila
  "tim-gordon" : {
    nombre: "Tim",
    apellido: "Gordon",
    ultimaVisita: "2015/12/12"
  }
  // fila
  "bruce-wayne" : {
    nombre: "Bruce",
    apellido: "Wayne",
    lugar: "Gotham"
  }
}
```
Con este ejemplo, podemos ver como las diferentes filas de la misma tabla (familia de columnas) no tienen por que compartir el mismo conjunto de columnas.
Además, las columnas se pueden anidar dentro de otras formando **super-columnas**, donde el valor es un nuevo mapa de columnas.

```python
{
    name: "libro:978-84-16152-08-7",   
    value: 
    {     
        autor: "Grant Morrison",     
        titulo: "Batman - Asilo Arkham",     
        isbn: "978-84-16152-08-7"   
    } 
}
```
Cuando se utilizan super columnas para crear familias de columnas tendremos una familia de super columnas.

En resumen, las bases de datos basadas en columnas, almacenan los datos en familias de columnas como filas, las cuales tienen muchas columnas asociadas al identificador de una fila. Las familias de columnas son grupos de datos relacionados, a las cuales normalmente se accede de manera conjunta.


### Operaciones






---
## 📝 Actividades propuestas
1. Asignar modelo de datos a escenarios:  
    - Wiki de cómics  
    - Información académica de un país  
2. Investigar **persistencia políglota**  
3. Clasificar: BigTable, Cassandra, CouchDB, DynamoDB, HBase, MongoDB, Redis, Riak, Voldemort según CAP  

