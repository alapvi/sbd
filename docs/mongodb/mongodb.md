# MongoDB
## MongoDB

**MongoDB** es una base de datos *NoSQL*, de **código abierto y orientada a documentos**. En lugar de almacenar datos en tablas, como lo hace una base de datos relacional, **MongoDB almacena datos en documentos** similares a JSON con un formato llamado **BSON (Binary JSON)**.

BSON extiende el formato JSON para incluir tipos de datos adicionales como fechas y binarios, lo que lo hace más adecuado para representar datos complejos.

MongoDB **destaca** porque:

- Soporta **esquemas dinámicos**: diferentes documentos de una misma colección pueden tener atributos diferentes.
- Aunque inicialmente tenía un soporte limitado de **joins**, desde la versión 5.2 se pueden realizar incluso entre colecciones particionadas. Actualmente MongoDB va por la versión. 8.0.
- Soporte de **transacciones** sólo a nivel de aplicación. Lo que en un RDMS puede suponer múltiples operaciones, con MongoDB se puede hacer en una sola operación al insertar/actualizar todo un documento de una sola vez, pero si queremos crear una transacción entre dos documentos, la gestión la debe realizar el driver.

MongoDB se utiliza ampliamente en una variedad de aplicaciones, incluidas aquellas con grandes volúmenes de datos, cargas de trabajo de alta velocidad y requisitos de flexibilidad de esquema. Es especialmente popular en aplicaciones web y móviles, así como en entornos de Big Data y análisis en tiempo real.

Ejemplos muestran la versatilidad de MongoDB en diferentes sectores podrían ser:

- **eBay**: Utiliza MongoDB para gestionar su enorme catálogo de productos y facilitar búsquedas rápidas y eficientes.

- **Uber**: Emplea MongoDB para almacenar datos de viajes y usuarios, permitiendo un análisis en tiempo real y mejorando la experiencia del cliente.

- **LinkedIn**: Utiliza MongoDB para manejar grandes volúmenes de datos de usuarios y conexiones, optimizando la búsqueda y la interacción en la plataforma.

- **Foursquare**: Esta aplicación de recomendaciones de lugares utiliza MongoDB para gestionar datos de usuarios y localizaciones, permitiendo un acceso rápido a información geoespacial.
- **The Guardian**: El medio de comunicación utiliza MongoDB para gestionar su contenido digital, facilitando la publicación y el acceso a artículos y multimedia de manera eficiente.

## Características de MongoDB

Si tuviéramos que resumir a una la principal característica a destacar de MongoDB, sin duda esta sería la **velocidad**, que alcanza un **balance perfecto entre rendimiento y funcionalidad** gracias a su sistema de consulta de contenidos. Pero sus características principales no se limitan solo a esto, *MongoDB* cuenta, además, con otras que lo posicionan posiblemente como la base de datos NoSQL más popular para muchos desarrolladores.

Características principales:

- **Consultas ad hoc**. Con MongoDb podemos realizar todo tipo de consultas. Podemos hacer búsqueda por campos, consultas de rangos y expresiones regulares. Además, estas consultas pueden devolver un campo específico del documento, pero también puede ser una función JavaScript definida por el usuario.
- **Indexación**. El concepto de índices en MongoDB es similar al empleado en bases de datos relacionales, con la diferencia de que cualquier campo documentado puede ser indexado y añadir múltiples índices secundarios.
- **Replicación**. Del mismo modo, la replicación es un proceso básico en la gestión de bases de datos. MongoDB soporta el tipo de replicación primario-secundario. De este modo, mientras podemos realizar consultas con el primario, el secundario actúa como réplica de datos en solo lectura a modo copia de seguridad con la particularidad de que los nodos secundarios tienen la habilidad de poder elegir un nuevo primario en caso de que el primario actual deje de responder.
- **Balanceo de carga**. Resulta muy interesante cómo MongoDB puede escalar la carga de trabajo. MongoDB tiene la capacidad de ejecutarse de manera simultánea en múltiples servidores, ofreciendo un balanceo de carga o servicio de replicación de datos, de modo que podemos mantener el sistema funcionando en caso de un fallo del hardware.
- **Almacenamiento de archivos**. Aprovechando la capacidad de MongoDB para el balanceo de carga y la replicación de datos, Mongo puede ser utilizado también como un sistema de archivos. Esta funcionalidad, llamada GridFS e incluida en la distribución oficial, permite manipular archivos y contenido.
- **Ejecución de JavaScript del lado del servidor**. MongoDB tiene la capacidad de realizar consultas utilizando JavaScript, haciendo que estas sean enviadas directamente a la base de datos para ser ejecutadas.

## Conceptos básicos

Hay una serie de conceptos que conviene conocer antes de entrar en detalle:

- MongoDB tienen el mismo concepto de base de datos que un RDMS. Dentro de una instancia de MongoDB podemos tener 0 o más bases de datos, actuando cada una como un contenedor de alto nivel.
- **Una base de datos tendrá 0 o más colecciones**. Una **colección** es muy similar a lo que entendemos como **tabla** dentro de un RDMS. MongoDB ofrece diferentes tipos de colecciones, desde las normales cuyo tamaño crece conforme lo hace el número de documentos, como las colecciones capped, las cuales tienen un tamaño predefinido y que pueden contener una cierta cantidad de información que se sustituirá por nueva cuando se llene.
- Las **colecciones** contienen 0 o más **documentos**, por lo que es similar a una **fila** o **registro** de un RDMS.
- Cada **documento** contiene 0 o más **atributos**, compuestos de **parejas clave/valor**. Cada uno de estos documentos no sigue ningún esquema, por lo que dos documentos de una misma colección pueden contener todos los atributos diferentes entre sí.

<figure markdown="span">
    !["Elementos de MongoDB"](images/02mongodbitems.png){width="70%" }
    <figcaption>Elementos de MongoDB</figcaption>
</figure>

Así pues, tenemos que una base de datos va a contener varias colecciones, donde cada colección contendrá un conjunto de documentos. Podemos hacer una correspondencia rápida entre bases de datos Relacionales y NoSQL:

<figure markdown="span">
    !["Estructura"](images/MongoDB02.jpeg){width="50%" } 
    !["Estructura"](images/MongoDB17.png){width="50%" }
</figure>

Además, **MongoDB soporta índices**, igual que cualquier RDMS, para acelerar la búsqueda de datos. Al realizar cualquier consulta, se devuelve un cursor, con el cual podemos hacer cosas tales como contar, ordenar, limitar o saltar documentos

## BSON

MongoDB almacena los documentos mediante BSON (Binary JSON).
Repasemos el concepto de JSON: JavaScript Object Notation:

- Formato de texto sencillo para el intercambio de datos.
- Subconjunto de la notación literal de objetos de JavaScript.
- Alternativa a XML como lenguaje de intercambio de datos. Mucho más sencillo de leer y escribir.
- Uso extendido en bases de datos noSQL, entre ellas JSON: JavaScript Object Notation
- Ampliamente soportado por multitud de lenguajes de programación.
- Un objeto JSON está formado por uno o varios pares string: value (cadena:valor).
- Soporta diferentes tipos de datos como cadenas de texto, números, fecha, hora, valores nulos y booleanos.de JSON: JavaScript Object Notation:


<figure markdown="span">
    !["Documento en MongoDB"](images/MongoDB03.png){width="100%" }
    <figcaption>Documento en MongoDB</figcaption>
</figure>

Mediante JavaScript podemos crear objetos que se representan con JSON. Internamente, MongoDB almacena los documentos mediante BSON (Binary JSON). Podemos consultar la especificación en la web oficial de BSON

**BSON** representa un superset de JSON ya que:
- Permite almacenar datos en binario
- Incluye un conjunto de tipos de datos no incluidos en JSON, como pueden ser ObjectId, Date o BinData.
Podemos consultar todos los tipos que soporta un objeto BSON en [http://docs.mongodb.org/manual/reference/bson-types/](http://docs.mongodb.org/manual/reference/bson-types/)

Un ejemplo de un objeto BSON podría ser:
```javascript
var yo = {
  nombre: "Alberto",
  apellidos: "Aparicio",
  fnac: new Date("Aug 13, 1975"),
  hobbies: ["programación", "ciclismo", "música"],
  casado: true,
  hijos: 2,
  contacto: {
    twitter: "@alapvi",
    email: "a.apariciovi@edu.gva.es"
  },
  fechaCreacion: new Timestamp()
}
```

Los documentos BSON tienen las siguientes restricciones:

- No pueden tener un tamaño superior a 16 MB.
- El atributo `_id` queda reservado para la clave primaria.
- Desde MongoDB 5.0 los nombres de los campos pueden empezar por $ y/o contener el ., aunque en la medida de lo posible, es recomendable evitar su uso.

Además MongoDB:
- **No asegura** que el **orden** de los campos se respete.
- Es **sensible** a los **tipos de los datos**
- Es **sensible** a las **mayúsculas**.

Por lo que estos documentos son distintos:

```javascript
{"edad": "18"}
{"edad": 18}
{"Edad": 18}
```

Si queremos validar si un documento JSON es válido, podemos usar la web [JSONLint Validator and Formatter](http://jsonlint.com/). Hemos de tener en cuenta que sólo valida JSON y no BSON, por tanto nos dará errores en los tipos de datos propios de BSON.


