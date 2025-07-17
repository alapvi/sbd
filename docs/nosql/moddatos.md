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

=== "Python"
    ```python
    print("A")
    ```

=== "Javascript"
    ```js
    var a=4
    ```  

=== "Comandos Redis"
    ```redis
    SET nombre "Bruce Wayne"      // String
    HSET heroe nombre "Batman"    // Hash – set
    HSET heroe color "Negro"
    SADD "heroe:amigos" "Robin" "Alfred"   // Set – create/update
    ```

=== "Comandos Python"
    ```python
    import redis
    r = redis.Redis()
    r.mset({"Croatia": "Zagreb", "Bahamas": "Nassau"})
    r.get("Bahamas")
    # b'Nassau'
    ```


---
## 📝 Actividades propuestas
1. Asignar modelo de datos a escenarios:  
    - Wiki de cómics  
    - Información académica de un país  
2. Investigar **persistencia políglota**  
3. Clasificar: BigTable, Cassandra, CouchDB, DynamoDB, HBase, MongoDB, Redis, Riak, Voldemort según CAP  

