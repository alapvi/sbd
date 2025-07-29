# Operaciones con datos CRUD

En MongoDB, las operaciones *CRUD* (*Crear*, *Leer*, *Actualizar*, *Eliminar*) se realizan utilizando métodos específicos. Aquí te muestro cómo realizar cada una de estas operaciones.

Antes de comenzar a trabajar, debemos entrar en una de las bases de datos con `use` y en todo momento podemos ver las colecciones que tenemos en esta base de datos con `use`

## Insertar

Para insertar documentos en una colección, se utiliza el método `insertOne()` o `insertMany()`.

### **InsertOne()**

- `db.collectionName.insertOne(<json>)`: Inserta un solo documento.

<figure markdown="span">
    !["MongoDB. Inserción en colección"](images/MongoDBCRUD01.svg){width="90%" }
    <figcaption>MongoDB. Inserción en colección</figcaption>
</figure>

Ejemplos:

- Insertar un solo documento en la colección `usuarios`:
```python
db.usuarios.insertOne({
    nombre: "Juan",
    edad: 30,
    ciudad: "Barcelona"
});
```
```python
db.usuarios.insertOne({
    nombre: "Pepe",
    edad: 34,
    ciudad: "Valencia",
    intereses: ["fútbol", "música"],
    direccion: { calle: "Calle Mayor", numero: 123 },
    fechaRegistro: new Date(),
    activo: true
});
```
- Insertar un documento con una fecha específica:
    - Los campos antes no estaban entre comillas y en este ejemplo si lo estan; es totalmente indiferente. Pero si debemos tener en cuenta que es **case-sensitive** (Mayúsculas/Minúsculas) es importante y adcemás también cambia si ponemos los datos númericos entre comillas o no, ya que se convierten en texto:
```python
db.usuarios.insertOne({
    "nombre": "Filiberto",
    "edad" : "33",
    "fechaNacimiento": new Date("2004-03-15"),
    "ciudad": "Alacant"
});
```

Cada vez que hacemos una inserción, si es correcta, nos devuelve el resultado del con el siguiente formato:
```python
{
  acknowledged: true,
  insertedId: ObjectId('6888d00e75fc26a2b289b03d')
}
```
### **InsertMany()**

- `db.collectionName.insertMany(<json>)`: Inserción de varios elementos.

Como se trata de una inserción de un conjunto de documentos, lo que hacemos en pasar un array y esto se hace mediante el uso de **corchetes** : `[]`.

Ejemplos:

- Insertar varios documentos en la colección 'usuarios':
```python
db.usuarios.insertMany([
    { nombre: "Ana", edad: 25, ciudad: "Madrid" },
    { nombre: "Carlos", edad: 35, ciudad: "Valencia" }
]);
```
- Insertar varios documentos en la colección 'usuarios':

```python
db.usuarios.insertMany([
    { nombre: "Ana", edad: 25, ciudad: "Madrid", intereses: ["viajes"], fechaRegistro: new Date(), activo: false },
    { nombre: "Carlos", edad: 35, ciudad: "Valencia", intereses: ["lectura"], fechaRegistro: new Date(), activo: true }
]);
```
Observar cómo se trabaja con las fechas

## Leer/Consultar

Uno de los aspectos más interesantes de las bases de datos es la capacidad para realizar consultas, por lo que ahora vamos a ver de forma muy breve como leer datos, pero más adelante profundizaremos en la realización de consultas más elaboradas.

### **`find()`**

Para leer datos de una colección, se utiliza el método `find()`.

- Leer todos los documentos de la colección 'usuarios'
```python
db.usuarios.find();
```
- Leer todos los documentos de la colección `'usuarios'` y formatear la salida `json`
```python
db.usuarios.find().pretty();
```
!!! note

    La función `pretty()` en MongoDB sigue siendo efectiva, pero su uso ha cambiado con las versiones más recientes. En *mongosh* (la nueva shell de MongoDB), pretty() no altera el formato de salida, mientras que en la shell legacy (mongo shell), sí lo hacía, mostrando los resultados de manera más legible.

- Leer documentos que coincidan con un criterio específico
```python
db.usuarios.find({ ciudad: "Barcelona" });
```
- Leer documentos que coincidan con un criterio específico (por ejemplo, ciudad igual a 'Madrid' y activo igual a false)
```python
db.usuarios.find({ ciudad: "Madrid", activo: false });
```
Podemos especificar los campos que queremos recuperar en la consulta:

- Leer documentos con proyección (seleccionar campos específicos):
```python
db.usuarios.find({}, { nombre: 1, edad: 1 });
```
- Leer documentos con proyección (seleccionar campos específicos)
```python
db.usuarios.find({}, { nombre: 1, edad: 1, _id: 0 });
```

Para proyectar un campo en el resultado de la consulta el formato a utilizar es `NombreDeCampo: 1`. 
!!! warning "Acerca de las proyecciones"
    MongoDB **no permite mezclar inclusión y exclusión** en la misma proyección, **salvo una excepción específica con el campo `_id`**.

    - Regla general de proyecciones
    
        - Puedes:
            - Incluir campos: `{ nombre: 1, edad: 1 }`
            - Excluir campos: `{ direccion: 0, telefono: 0 }`
        - No se puede mezclar los dos: `{ nombre: 1, edad: 1, direccion: 0 }` --> **Error**

- Leer usuarios cuya fecha de registro fue después de una fecha específica:
```python
db.usuarios.find({ fechaRegistro: { $gt: new Date("2024-01-01") } });
```
- Leer usuarios cuya fecha de registro está entre un rango de fechas:
```python
db.usuarios.find({ fechaRegistro: { $gt: new Date("2024-01-01"), $lt: new Date("2025-01-01") } });
```
!!! note
    No profundizamos más en las búsquedas porque más adelante dedicaremos un punto completo a explicar las búsquedas en más profundidad.

## Actualizar

Para actualizar documentos en una colección, se utiliza el método `updateOne()` o `updateMany()`.

### **`updateOne()`**

- `db.collection.updateOne(<filter>, <update>)`

El método `updateOne()` se utiliza para actualizar **un solo documento** que coincida con un criterio específico. Si hay varios documentos que coinciden con el criterio, **solo se actualizará el primero que se encuentre**.

En la clausula de actualización tenemos el comando `$set`. Además debemos tener en cuenta que tanto el `<filter>` como la `<update>` son `json` por lo que deben estar comprendidos entre *corchetes*:

```python
db.collection.updateOne({}, {$set:{}});
```

Veamos algunos ejemplos

- Ejemplo de `updateOne()`

```python
db.usuarios.updateOne(
    { nombre: "Juan" },
    { $set: { edad: 31 } }
);
```

- Cambiamos más de un valor

```python
db.usuarios.updateOne(
    { nombre: "Juan" },
    { $set: { edad: 31, ciudad: 'Albacete' } }
);
```

- Actualizar la fecha de un evento específico

```python
db.usuarios.updateOne(
    { nombre: "Alberto" },
    { $set: { fechaRegistro: new Date("2024-03-20") } }
);
```

En el primer ejemplo, se actualizará el primer documento de la colección `"usuarios"` que tenga el campo nombre igual a `"Juan"`. Si hay varios documentos con ese nombre, *solo se actualizará uno*.

Una vez realizada la actualización, *MongoDB* avisa:

```python
{
  acknowledged: true,
  insertedId: null,
  matchedCount: 1,
  modifiedCount: 1,
  upsertedCount: 0
}
```

### **`updateMany()`**

- `db.collection.updateMany(<filter>, <update>)`

Por otro lado, el método `updateMany()` se utiliza para actualizar múltiples documentos que coincidan con un criterio específico. Todos los documentos que cumplan el criterio serán actualizados.

- Ejemplo de `updateMany()`

```python
db.usuarios.updateMany(
    { ciudad: "Játiva" },
    { $set: { ciudad: "Xàtiva" } }
);
```
En este ejemplo, se actualizarán todos los documentos de la colección `"usuarios"` que tengan el campo ciudad igual a *"Játiva"*, estableciendo su valor a *"Xàtiva"*.

Por tanto, `updateOne()` es útil cuando solo quieres **actualizar un único documento**, mientras que `updateMany()` es útil cuando necesitas **actualizar múltiples documentos** que cumplan un criterio específico.

Además de establecer un valor en una actualización, tenemos otras opciones para las modificaciones a aplicar. Utiliza operadores como:

- `$set`: Para establecer un nuevo valor.
- `$unset`: Para eliminar un campo.
- `$inc`: Para incrementar un valor numérico.
- `$push`: Para agregar un elemento a un array.

En el siguiente ejemplo, incrementamos un año la edad de los usuarios con un determinado nombre;

```python
db.usuarios.updateMany(
    { nombre : "Juan" },
    { $inc: { edad: 1 } }
);
```

### **`replaceOne()`**

- `db.collection.replaceOne(<filter>, <update>)`

Reemplazo completo de un documento. En este caso, al reemplazar el documento que encontramos por una nuevo, no necesitamos el comando $set

- Ejemplo donde reemplaza el primer registro qe encuentra con el filtro aplicado

```python
db.usuarios.replaceOne(
    { nombre: "Alberto" },
    {     
        nombre: "Alberto A.",
        edad: 18,
        ciudad: "Xàtiva",
        intereses: ["Baloncesto", "Informática"],
        fechaRegistro: new Date(),
        activo: true 
    }
);
```

En este caso, vamos a ver su ejecución, donde veremos incluso que al cambiar el nombre, este campo también cambia aunque se el utilizado para hacer la búsqueda:

<figure markdown="span">
    !["Replace en MongoDB"](images/MongoDBCRUD02.png){width="70%" }
    !["Replace en MongoDB"](images/MongoDBCRUD03.png){width="70%" }
    <figcaption>Reemplazando documentos en MongoDB</figcaption>
</figure>

## Eliminar

Para eliminar documentos de una colección, se utiliza el método `deleteOne()` o `deleteMany()`.
En *MongoDB*, tanto `deleteOne()` como `deleteMany()` son métodos utilizados para eliminar documentos de una colección. Aquí tienes las diferencias entre ellos:

### **`deleteOne()`**

El método `deleteOne()` se utiliza para eliminar un solo documento que coincida con un criterio específico. **Si hay varios documentos** que coinciden con el criterio, **solo se eliminará el primero** que se encuentre.

- Ejemplo de `deleteOne()`

```python
db.usuarios.deleteOne({ nombre: "Juan" });
```

En este ejemplo, se eliminará el primer documento de la colección `"usuarios"` que tenga el campo nombre igual a `"Juan"`. Si hay varios documentos con ese nombre, **solo se eliminará uno**.

### **`deleteMany()`**

Por otro lado, el método `deleteMany()` se utiliza para eliminar varios documentos que coincidan con un criterio específico. Todos los documentos que cumplan el criterio serán eliminados.

- Ejemplo de `deleteMany()`

```python
db.usuarios.deleteMany({ activo: false });
```

En este ejemplo, se eliminarán todos los documentos de la colección `"usuarios"` que tengan el campo `activo` igual a `false`.

Otros ejemplos

- Eliminar varios documentos que cumplan el criterio especificado

```python
db.usuarios.deleteMany({ ciudad: "Xàtiva" });
```

- Eliminar usuarios con una fecha de registro específica

```python
db.usuarios.deleteMany({ fecha: { $lt: new Date("2025-01-01") } });
```

!!! warning "Cuidado!"
    Como siempre debemos tener cuidad a la hora de borrar, de hecho si hacemos
    ```python
    db.usuarios.deleteMany({});
    ```

    **Nos borrará todos los documentos** de la colección.

!!! info "Uso de json"
    Siempre se debe pasar un `json` dentro de la condición, o sea, dentro de los paréntesis deben haber llaves:
    
    ```python
    db.usuarios.deleteMany();     //error
    db.usuarios.deleteMany({});   //correcto: json vacío
    ```

Ahora que ya tenemos más herramientas y hemos visto las operaciones básicas de *MongoDB* en la siguiente sección vamos a profundizar sobre las consultas de los datos, aunque ya las hemos visto brevemente con anterioridad. 









