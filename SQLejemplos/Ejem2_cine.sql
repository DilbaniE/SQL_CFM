CREATE DATABASE Eje2_Cine

CREATE TABLE Salas(
id_sala INT,
nombre  VARCHAR(30),
tiposala CHAR(2)
)
CREATE TABLE Peliculas(
id_sala INT,
nombre_pelicula  VARCHAR(60),
duracion INT,
genero VARCHAR(20)
)

CREATE TABLE proyecciones(
pk_idproyecciones INT,
id_pelicula INT,
id_sala INT,
fecha DATE,
horario INT
)

SELECT * FROM salas
SELECT * FROM Peliculas
