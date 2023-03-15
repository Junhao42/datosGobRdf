# Infraestructura RDF para datos.org

En este repositorio se proporcionan las distintas versiones que puedan tener una imagen Docker, que despliegue un repositorio RDF con los datos importados desde ficheros Turtle extraidos de un conjunto de datos disponible en datos.gob

### Instrucciones:
#### 1. Creación del archivo Dockerfile.
Empezaremos creando el [dockerfile](https://www.cloudbees.com/blog/what-is-a-dockerfile). En un archivo sin extensión de nombre `Dockerfile` seguimos los siguientes pasos. Partimos de la imagen de `ontotext/graphdb:10.1.5`. Luego, nos situamos en la carpeta `/root/graphdb-import`. Esta carpeta nos permite insertar archivos para **GraphDB**. Finalmente, descargamos el archivo de extension _.ttl_ del dataset deseado, en nuestro caso sobre  [estaciones de bicicleta](https://www.zaragoza.es/sede/servicio/urbanismo-infraestructuras/estacion-bicicleta.ttl) y exponemos el puerto **7200**. A continuación mostramos el resultado final:

```dockerfile
FROM ontotext/graphdb:10.1.5
RUN mkdir /root/graphdb-import
WORKDIR /root/graphdb-import
RUN curl -O https://www.zaragoza.es/sede/servicio/urbanismo-infraestructuras/estacion-bicicleta.ttl
EXPOSE 7200
```
#### 2. Creación de la imagen.
Nos situamos en el directorio donde se encuentre el archivo `Dockerfile` antes creado. Abrimos una terminal y ejecutamos el siguiente código
```bat
docker build -t 'ImagenDocker' .
```
Esta instrucción nos creará la imagen a partir del `Dockerfile` de nombre _ImagenDocker_.

#### 3. Creación del repositorio.
Una vez tengamos la imagen creada, levantaremos el contenedor con la instrucción:
```bat
docker run --name 'NombreContenedor' -p 7200:7200 'ImagenDocker'
```
Ésta línea levantará nuestro contenedor de nombre _NombreContenedor_ alojado en el puerto **7200** a partir de la imagen antes creada _ImagenDocker_. Ahora, en un buscador introducimos `localhost:7200`. Nos encontraremos en la aplicación de GraphDB. Para crear el repositorio, seleccionamos `Create new repository`, situado a la derecha de la pantalla. Una vez clicamos, seleccionamos la primera opción `GraphDB Repository`. Rellenamos los campos pertinentes, como `Repository ID` y `Repository description`. Ahora, bajamos hasta el final de la página y seleccionamos `Create`. Finalmente tendremos con esto el repositorio creado. Para comprobarlo, podemos seleccionar a la derecha la opción de `Imports`. En la pestaña de `Server files` veremos nuestro repositorio creado.

#### 4. Creación de la imagen final.

Finalmente, crearemos una imagen a partir del contenedor levantado con el fin de que aquellos que quieran usar los datos que tenemos disponibles no tengan que volver a realizar el proceso de creación de la imagen. Para ello usaremos el siguiente mandato:
```bat
docker commit `IdContenedor` `NombreNuevaImagen`
```

De esta forma, se creará una imagen, a partir del contenedor que especificamos, la cual guardará todos los cambios realizados de forma automática. Para poder ver el Id del contenedor podemos usar el comando:
```bat
docker container ps
```
De esta forma, obtenemos una visualización de la información de todos los contenedores activos que tenemos.


En este punto, hemos conseguido crear una imagen docker que facilita la creación de nuestro servicio de forma totalmente automática. Es decir, podemos crear un contenedor usando esta nueva imagen, el cual incorporará el repositorio con los datos ya importados.