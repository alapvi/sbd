# Primeros pasos
Una vez instalada la base de datos, vamos a interactuar desde su propia consola.


## Trabajando con MongoDB desde la consola
En la máquina donde tenemos instalada la base de datos, podemos acceder a la consola de MongoDB escribimos:

```bash
mongosh
```

<figure markdown="span">
    !["Acceso a través de la consola"](images/MongoDBInst12.png){width="100%" }
    <figcaption>Acceso a través de la consola</figcaption>
</figure>

Vemos que cuando accedemos a través de la consola, nos aparece una serie de recomendaciones que debemos realizar antes de comenzar a trabajar con MongoDB:

- Sistema de archivos XFS recomendado
- No hay control de acceso habilitado
- Aumentar la cantidad de mapeos de memoria virtual
- Swappiness

### Activar autenticación para MongoDB

1. Creamos el usuario a través de la consola de MongoDB:
```python
use admin
db.createUser({
  user: "admin",
  pwd: "password_fuerte",
  roles: [ { role: "root", db: "admin" } ]
})
```
2. Editamos el archivo de configuración `/etc/mongod.conf` y agregamos:
```yaml
security:
  authorization: enabled
```
3. Reiniciamos el servicio
```bash
sudo systemctl restart mongod
```
### Aumentar los mapeos

1. Consultamos los mapeos que tenemos actualmente:
```bash
cat /proc/sys/vm/max_map_count
```
2. Cambiamos el valor temporalmente
```bash
sudo sysctl -w vm.max_map_count=1048575
```
3. Para hacerlo permanentemente:
```bash
echo "vm.max_map_count=1048575" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

### Swappiness
1. Consultamos el valor actual:
```bash
cat /proc/sys/vm/swappiness
```
2. Cambiamos el valor temporalmente:
```bash
sudo sysctl -w vm.swappiness=1
```
3. Para hacerlo temporalmente:
```bash
echo "vm.swappiness=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```
### Operaciones básicas
Conectamos desde la consola con un usuario:
```bash
mongosh -u admin -p 'PasswordSegura' --authenticationDatabase admin
```

Algunas de las operaciones básicas que podemos realizar son :

- Salir de la consola (`quit()` o pulsando `Ctrl+C`)
- Limpiar la consola (`Ctrl+L`)
- Listar las bases de datos (`show dbs`)
- Cambiarse de base de datos (`use <dbname>`)
- Listar las colecciones de una base de datos (`show collections` / `show tables`)
- Mostrar el nombre de la base de datos (`db.getName()` o `db`)
- Listar metadata sobre una base de datos (`db.stats()`)
- Solicitar ayuda sobre comandos (`db.help()`)
- Mostrar fecha y hora del sistema (`Date()`)
- Dar formato JSON (`db.<collectionName>.find().pretty()`)
- Mostrar información sobre el servidor (`db.hostInfo()`)
