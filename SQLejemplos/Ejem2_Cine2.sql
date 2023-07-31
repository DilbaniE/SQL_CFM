
CREATE TABLE  peliculas (
 id_pelicula INT PRIMARY KEY IDENTITY(1,1),
 nombre_pelicula VARCHAR(30),
 duracion INT,
  gener VARCHAR(50)
)

CREATE TABLE salas(
idsala INT PRIMARY KEY IDENTITY(1,1),
nombre VARCHAR(20) NOT NULL,
tiposala CHAR(2)
)

CREATE TABLE  proyecciones(
idproyeccion INT PRIMARY KEY IDENTITY(1,1),
fk_idpelicula INT FOREIGN KEY REFERENCES peliculas(id_pelicula),
fk_idsala INT FOREIGN KEY REFERENCES salas(idsala),
fecha DATE,
horario INT
)

