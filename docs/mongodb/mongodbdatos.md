# Operaciones con datos: Consultas y métodos

Ahora que ya tenemos más herramientas y hemos visto las operaciones básicas de *MongoDB* vamos a profundizar sobre las consultas de los datos, aunque ya las hemos visto brevemente con anterioridad.

Aprovechamos para introducir una base de datos con una colección con datos de prueba. En el siguiente [enlace](https://www.w3resource.com/mongodb-exercises/mongodb-sample-dataset/sample_mflix/movies.zip) tenemos una base de datos de películas que podemos introducir en *MongoDB* por ejemplo usando en *MongoDB Compass*. Para ello creamos una base de datos llamada consultas e importamos el fichero descargado.

El comando básico es `.find()`

```python
db.collection.find()            // devuelve todos los documentos
db.collection.find(<filter>)    // devuelve los documentos que cumplen el filtro
```

## Operadores *MongoDB*

Antes de continuar, en la siguiente tabla esta el listado de los principales operadores utilizados en consultas *MongoDB* para la construcción de los filtros:

| Operador | Descripción                                      | Ejemplo                                                     |
|----------|--------------------------------------------------|-------------------------------------------------------------|
| `$eq`    | Igualdad                                         | `db.collection.find({campo: {$eq: valor}})`                |
| `$ne`    | No igual                                         | `db.collection.find({campo: {$ne: valor}})`                |
| `$gt`    | Mayor que                                        | `db.collection.find({campo: {$gt: valor}})`                |
| `$gte`   | Mayor o igual que                                | `db.collection.find({campo: {$gte: valor}})`               |
| `$lt`    | Menor que                                        | `db.collection.find({campo: {$lt: valor}})`                |
| `$lte`   | Menor o igual que                                | `db.collection.find({campo: {$lte: valor}})`               |
| `$in`    | Igual a cualquiera de los valores en un array    | `db.collection.find({campo: {$in: [valor1, valor2]}})`     |
| `$nin`   | No igual a ninguno de los valores en un array    | `db.collection.find({campo: {$nin: [valor1, valor2]}})`    |
| `$exists`| Verifica si el campo existe                      | `db.collection.find({campo: {$exists: true/false}})`       |
| `$type`  | Verifica el tipo de datos del campo              | `db.collection.find({campo: {$type: tipo}})`               |
| `$regex` | Realiza una búsqueda de expresión regular        | `db.collection.find({campo: {$regex: /patrón/}})`          |
| `$or`    | Realiza una disyunción lógica                    | `db.collection.find({$or: [{condición1}, {condición2}]})`  |
| `$and`   | Realiza una conjunción lógica                    | `db.collection.find({$and: [{condición1}, {condición2}]})` |
| `$not`   | Niega una expresión                              | `db.collection.find({campo: {$not: {condición}}})`         |
| `$nor`   | Realiza una disyunción negada                    | `db.collection.find({$nor: [{condición1}, {condición2}]})` |

Estos operadores son fundamentales para realizar consultas avanzadas en *MongoDB*, permitiendo filtrar y buscar documentos en función de diferentes criterios. Puedes combinar estos operadores para construir consultas complejas y poderosas que se adapten a tus necesidades específicas.

## Consultas con `.find()`. Ejemplos prácticos.

Utilizando la tabla de movies vamos a realizar algunas consultas que servirán para ilustrar los aspectos más interesantes de las búsquedas en *MongoDB*.

Veamos un documento tipo:
```js
{
  _id: ObjectId('573a1390f29313caabcd4135'),
  plot: 'Three men hammer on an anvil and pass a bottle of beer around.',
  genres: [ 'Short' ],
  runtime: 1,
  cast: [ 'Charles Kayser', 'John Ott' ],
  num_mflix_comments: 1,
  title: 'Blacksmith Scene',
  fullplot: 'A stationary camera looks at a large anvil with a blacksmith behind it and one on either side. The smith in the middle draws a heated metal rod from the fire, places it on the anvil, and all three begin a rhythmic hammering. After several blows, the metal goes back in the fire. One smith pulls out a bottle of beer, and they each take a swig. Then, out comes the glowing metal and the hammering resumes.',
  countries: [ 'USA' ],
  released: ISODate('1893-05-09T00:00:00.000Z'),
  directors: [ 'William K.L. Dickson' ],
  rated: 'UNRATED',
  awards: { wins: 1, nominations: 0, text: '1 win.' },
  lastupdated: '2015-08-26 00:03:50.133000000',
  year: 1893,
  imdb: { rating: 6.2, votes: 1189, id: 5 },
  type: 'movie',
  tomatoes: {
    viewer: { rating: 3, numReviews: 184, meter: 32 },
    lastUpdated: ISODate('2015-06-28T18:34:09.000Z')
  }
}
```

Comenzamos con consultas sencillas y vamos incrementando el nivel.

### Consultas básicas

- Obtener películas lanzadas en el año 1983 :

```js
db.movies.find({ year: 1993 })
```

- Buscar películas de genero "corto" (`genres = short`)

```js
db.movies.find({ genres: "Short" })
```

### Consultas con operadores lógicos

- Buscar películas de duración (`runtime`) superior a 120 minutos

```js
db.movies.find({ "runtime": { $gt: 120 } })
```

- Buscar películas cuya duración se encuentre entre 90 y 100 minutos ambos incluidos

```js
db.movies.find({ "runtime": { $gte: 90, $lte: 120 } })
```

- Buscar películas que no tengan puntuación (UNRATED) y que duren más de 100 minutos.

```js
db.movies.find({rated: "UNRATED",runtime: {$gt: 100} })
```

Equivale exactamente a

```js
db.movies.find({$and: [ {rated: "UNRATED"},{runtime: {$gt: 100} }]})
db.movies.find({$and: [ {$or: [{rated: "NOT RATED"},{rated: "UNRATED"}]}, {runtime: {$gt: 100}} ]}  )
```



!!! note "Nota"

    Podemos utilizar `.size()` o `.count()` al final para hacer recuento y verificar que el resultado de las dos consultas anteriores son iguales.



- Buscar las películas que han no han tenido escritores (writers):

    En este caso no debe existir la propiedad writers

```js
db.movies.find({"writers": { $exists: true }})
```

- Buscar las películas donde ha intervenido el actor "Charles Kayser", pero mostrar solo titulo, fecha de lanzamiento, idioma, director y premios ganados:
```js
db.movies.find({
    "cast": "Charles Kayser"
    }, {
    "title": 1,
    "released": 1,
    "languages": 1,
    "directors": 1,
    "awards": 1,
})
```

- Buscar películas lanzadas en una fecha determinada, y mostrando unos campos determinados.:
```js
db.movies.find({
    released: ISODate("1997-05-01T00:00:00.000Z")
    }, {
    title: 1,
    languages: 1,
    released: 1,
    directors: 1,
    writers: 1,
    countries: 1
  }
)
```


### Consultas sobre objetos anidados

- Buscar películas que han recibido más de 1000 votos en IMDb

```js
db.movies.find({ "imdb.votes": { $gt: 1000 } })
```

- Buscar las películas que han recibido algún premio:

```js
db.movies.find({"awards.wins": { $gt: 0 }})
```

- Buscar las películas que han sido nominadas y mostrar solo el titulo, directores y año.

```js
db.movies.find({
    "awards.nominations": { $gt: 0 }
  }, {
    "title": 1,
    "directors": 1,
    "year": 1
  })
```

- Buscar películas con una puntuación entre 3 y 4 en el rating de viewer en tomatoes. Mostrar solo algunos campos por simplicidad

```js
db.movies.find(
  { 'tomatoes.viewer.rating': { $gte: 3, $lt: 4 } },
  { 
    title: 1, 
    languages: 1, 
    released: 1, 
    directors: 1, 
    'tomatoes.viewer': 1, 
    writers: 1, 
    countries: 1 
  }
)
```

### Consultas con expresiones regulares

Si queremos realizar consultas sobre partes de un campo de texto, hemos de emplear expresiones regulares. Para ello, tenemos el operador `$regexp` o, de manera más sencilla, indicando como valor la expresión regular a cumplir:

- Buscar todas las películas (titulo, lenguaje, lanzamiento, directores y guionistas) que tenga el literal "scene" en el titulo

```js
db.movies.find(
    { title: { $regex: /scene/i } },
    { title: 1, 
      languages: 1, released: 1, directors: 1, writers: 1, countries: 1 }
)
```

equivale a:

```js
db.movies.find(
    { title: /scene/i },
    { title: 1, languages: 1, released: 1, directors: 1, writers: 1, countries: 1 }
)
```

- Buscar películas que tengan en su sinopsis (fullplot) la palabra "fire", sean anteriores al 1980 y que sean del genero "Shorts"

```js
db.movies.find(
  {
    fullplot: { $regex: /fire/i },
    year: { $lt: 1980 },
    genres: "Short"
  }, 
  { 
    title: 1, 
    year: 1, 
    languages: 1, 
    fullplot: 1, 
    released: 1, 
    directors: 1, 
    writers: 1, 
    countries: 1 
  }
)
```

- Buscar pelicuas que tengan cualquiera de estos actores: "Tom Cruise", "Tom Hanks" o un actor que contenga "Smith" en su nombre

```js
db.movies.find({
    cast: /Tom Cruise|Tom Hanks|Smith/
  }, 
  { 
    _id: 0,
    title: 1, 
    cast: 1,
    year: 1
  }
)
```

!!! info "Consulta de elementos de un array"
    
    Mediante las expresiones regulares hemos visto cómo se consulta de forma sencialla elementos de un array, sin embargo tenemos un filtro especifico para estos casos `$elemMatch`
    
    `db.movies.find({ cast: { $elemMatch: { $eq: "Leonardo DiCaprio" }}});`
    
    Mientras que expresiones regulares encuentra elementos que coindicen parcial o totalmente, con este filtro buscamos elementos exactos.

## Otros métodos interesantes

Existen gran variedad de métodos que nos permiten realizar todo tipo de consultas sobre una base de datos y más concretamente sobre una colección.

Un listado detallado de todos estos métodos lo encontramos en la web oficial de MongoDB: [MongoDB Manual - Collection Methods](https://www.mongodb.com/docs/manual/reference/method/js-collection/)

Pueden resultar interesante los siguientes:

### Método `.distinct()`

Obtiene los valores diferentes de un campo de una colección:

```js
db.movies.distinct( 'genres' );
```

```js
db.movies.distinct( 'type' );
```

Estos dos ejemplos obtienen los diferentes valores de los atributos indicados.

### Método `.count()`

Cuenta la cantidad de documentos que cumplen una condición.

```js
db.movies.find({
    year: { $lt: 2000 },
    genres: "Short"
}).count()
```

Obtenemos la cantidad de cortos de la colección, posterior al año 2000

- Buscar la cantidad películas que tengan en su sinopsis (fullplot) la palabra "fire", sean anteriores al 1980 y que sean del genero "Shorts"

```js
db.movies.find({
    fullplot: { $regex: /fire/i },
    year: { $lt: 1900 },
    genres: "Short"
}).count()
```

### Método `.limit()`

Muestra una cantidad de documentos indicada que cumplan una condición.

```js
db.movies.find({
    year: { $lt: 2000 },
    genres: "Short"
}).limit(5)
```

Obtenemos 5 documentos de cortos de la colección, posterior al año 2000

### Método `.sort()`

Ordena los documentos devueltos por una consulta.

La sintaxis básica es la siguiente:

```js
db.collection.find().sort({ campo: orden })
```

- `campo`: El nombre del campo por el cual deseas ordenar.
- `orden`: Puede ser `1` para orden *ascendente* o `-1` para orden *descendente*.

Por ejemplo, para ordenar por año de lanzamiento de forma ascendente:

```js
db.movies.find().sort({ year: 1 })
```

Si deseas ordenarlas de forma descendente:

```js
db.movies.find().sort({ year: -1 })
```

También podemos ordenar por más de un campo. Por ejemplo, para ordenar primero por genre y luego por rating:

```js
db.movies.find().sort({ genre: 1, rating: -1 })
```

También podemos encadenar estas funciones:

- Listado de las 5 mejores películas según la puntuación "imdb"

```js
db.movies.find({}, {
    title: 1,
    imdb: 1
}).sort({ imdb: 1 }).limit(5)
```

Mejoramos el resultado anterior y le quitamos los valores vacios en la puntuación:

```js
db.movies.find({ "imdb.rating": {"$ne": ""}}, {
    title: 1,
    imdb: 1
}).sort({ imdb: -1 }).limit(5)
```

## Cursores

Al hacer una consulta en el shell se devuelve un cursor. Este cursor lo podemos guardar en un variable, y partir de ahí trabajar con él, como haríamos mediante cualquier lenguaje de programación. Si `cur` es la variable que referencia al cursor, podremos utilizar los siguientes métodos:

| Método             | Uso                                                            | Lugar de ejecución |
|--------------------|----------------------------------------------------------------|---------------------|
| `cur.hasNext()`    | `true/false` para saber si quedan elementos                    | Cliente             |
| `cur.next()`       | Pasa al siguiente documento                                     | Cliente             |
| `cur.limit(cantidad)` | Restringe el número de resultados a `cantidad`              | Servidor            |
| `cur.sort({campo:1})` | Ordena los datos por campo: `1` ascendente o `-1` descendente | Servidor            |
| `cur.skip(cantidad)`  | Permite saltar `cantidad` elementos con el cursor           | Servidor            |
| `cur.count()`      | Obtiene la cantidad de documentos                              | Servidor            |

Como tras realizar una consulta con find realmente se devuelve un cursor, un uso muy habitual es encadenar una operación de `find` con `sort` y/o `limit` y/o `count` para ordenar el resultado por uno o más campos y posteriormente limitar el número de documentos a devolver o simplemente contar.

Estos cursores se utilizan cuando accedemos a consulta desde script en javascript u otros lenguajes.

Por ejemplo, a continuacion tenemos código en javascript que imprime por consola todos los documentos obtenidos tras una consulta

=== "javscript"
    ```javascript
    // necesario node.js
    // Conectar a la base de datos test
    // const db = connect("mongodb://user:pass@localhost:27017/test?authSource=admin");
    const db = connect("mongodb://localhost:27017/test");

    // Realizar una consulta para encontrar todas (5) las películas
    var cursor = db.movies.find().limit( 5);

    // Iterar sobre los resultados usando un cursor
    while (cursor.hasNext()) {
        printjson(cursor.next());
    }
    ```
=== "Python"
    ```python
    # necesaria librería pymongo: 
    from pymongo import MongoClient

    # Conectar a la base de datos
    # client = MongoClient("mongodb://user:pass@localhost:27017/test?authSource=admin")
    client = MongoClient("mongodb://localhost:27017/")
    # Utilizamos la base de datos "text"
    db = client.test

    # Realizar una consulta para encontrar todas (5) las películas
    cursor = db.movies.find().limit(5)

    # Iterar sobre los resultados usando un cursor
    for document in cursor:
        print(document)
    ```

Se puede también usar métodos como `limit` y `skip` para controlar la cantidad de resultados:

- Ejemplo: obtenemos 5 registros de una colecccón

=== "javscript"
    ```javascript
    // necesario node.js
    // Conectar a la base de datos test
    // const db = connect("mongodb://user:pass@localhost:27017/test?authSource=admin");
    const db = connect("mongodb://localhost:27017/test");

    // Obtener las primeras 5 películas
    var limitedCursor = db.movies.find().limit(5);

    // Iterar sobre los resultados limitados
    while (limitedCursor.hasNext()) {
        printjson(limitedCursor.next());
    }

    // Saltar las primeras 2 películas y obtener las siguientes 3
    var paginatedCursor = db.movies.find().skip(2).limit(3);

    while (paginatedCursor.hasNext()) {
        printjson(paginatedCursor.next());
    }
    ```
=== "Python"
    ```python
    # necesaria librería pymongo: 
    from pymongo import MongoClient

    # Conectar a la base de datos
    # client = MongoClient("mongodb://user:pass@localhost:27017/test?authSource=admin")
    client = MongoClient("mongodb://localhost:27017/")
    # Utilizamos la base de datos "text"
    db = client.test

    # Obtener las primeras 5 películas
    limited_cursor = db.movies.find().limit(5)

    # Iterar sobre los resultados limitados
    for document in limited_cursor:
        print(document)

    # Saltar las primeras 2 películas y obtener las siguientes 3
    paginated_cursor = db.movies.find().skip(2).limit(3)

    # Iterar sobre los resultados paginados
    for document in paginated_cursor:
        print(document)

    ```

En todo caso, estos ejemplos quedan fuera del alcance de nuestro objetivo para este curso. Para más información [MongoDB Documentation → MongoDB Drivers → Node.js](https://www.mongodb.com/docs/drivers/node/v3.6/fundamentals/connection/connect/)

