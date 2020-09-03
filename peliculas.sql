-- 1. Crear base de datos llamada películas 
CREATE DATABASE peliculas;

-- 2. Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes, determinando la relación entre ambas tablas.
CREATE TABLE peliculas(id SERIAL NOT NULL, pelicula VARCHAR(100) NOT NULL UNIQUE, año INT, director VARCHAR(70), PRIMARY KEY(id));
CREATE TABLE reparto(id INT, actor VARCHAR(70), FOREIGN KEY(id) REFERENCES peliculas(id);
-- se crea una columna con foreign key para relacionar ambas tablas


-- 3. Cargar ambos archivos a su tabla correspondiente
\copy peliculas FROM '~/Escritorio/peliculas.csv' CSV HEADER
\copy reparto FROM '~/Escritorio/reparto.csv' CSV HEADER

-- 4. Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película, año de estreno, director y todo el reparto.
SELECT * FROM peliculas INNER JOIN reparto ON peliculas.id = reparto.id WHERE peliculas.id = 2;

--5. Listar los titulos de las películas donde actúe Harrison Ford.
SELECT pelicula FROM peliculas INNER JOIN reparto ON peliculas.id=reparto.id WHERE actor='Harrison Ford';

--6. Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en el top 100.
SELECT peliculas.director, COUNT(director) FROM peliculas GROUP BY(director) ORDER BY(count(director)) DESC LIMIT(10);

--7. Indicar cuantos actores distintos hay 
SELECT actor FROM reparto GROUP BY actor HAVING COUNT(*)>1;

--8. Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas por título de manera ascendente.
SELECT pelicula, año FROM peliculas  WHERE año >=1990 AND año<=1999 ORDER BY(pelicula);

--9. Listar el reparto de las películas lanzadas el año 2001 
SELECT * FROM reparto INNER JOIN peliculas ON reparto.id = peliculas.id WHERE peliculas.año = 2001;

--10. Listar los actores de la película más nueva 
peliculas=# SELECT * FROM reparto INNER JOIN peliculas ON reparto.id = peliculas.id WHERE año = (SELECT MAX(año) FROM peliculas) LIMIT(10);
