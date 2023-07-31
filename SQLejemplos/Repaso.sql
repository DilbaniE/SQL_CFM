CREATE DATABASE Repaso 

CREATE TABLE Estudiantes(
identiti VARCHAR (20) PRIMARY KEY,
nombre VARCHAR (40) NOT NULL,
apellido VARCHAR(40),
telefono VARCHAR(30),
fechanacimiento DATE
)

CREATE TABLE Materias(
idmateria INT  PRIMARY KEY IDENTITY(1,1),
n_materia VARCHAR (40) NOT NULL,
carrera VARCHAR(40),
descripcion TEXT,
)

CREATE TABLE Matriculas(
fechmatricula INT  PRIMARY KEY IDENTITY(1,1),
fk_idmate INT FOREIGN KEY REFERENCES Materias(idmateria),
fk_identificacion VARCHAR (20) FOREIGN KEY REFERENCES Estudiantes(identiti)
)

/*ingresar datos a una tabla*/
INSERT INTO Estudiantes
	VALUES ('1111111','Dilbani','Enriquez','3234853867','1998-08-18'),
	('2222222','Jaime ','Moncayo','3102055589','1996-08-15'),
	('3333333','Nezuko','Monenri','323486952','2021-10-10')

	
INSERT INTO Materias
	VALUES ('Español','Lenguas',' Muy buena clase aprendi mucho'),
	('Bases de Datos','Sistemas ','Me encanta bases de datos aprendo mucho'),
	('Nadado','Natacion','No se nadar bien pero aprendo')

INSERT INTO Estudiantes
VALUES ('4444444','Konnan','Monenri','3105040011','2021-09-20')

INSERT INTO Matriculas (fk_idmate,fk_identificacion)
VALUES (1,'1111111'),
(3,'1111111'),
(3,'2222222'),
(1,'3333333'),
(2,'3333333')

/* DML*/

/*me muestra toda la tabala*/
SELECT * FROM Estudiantes
SELECT * FROM Materias
SELECT * FROM Matriculas


SELECT identiti AS  cedula,nombre,apellido,telefono,fechanacimiento FROM Estudiantes

/*me muestra la fecha y el apellido */
SELECT fechanacimiento, apellido FROM Estudiantes
WHERE nombre = 'Dilbani'

/*traer un usuario espesifico con nombre y apellido*/
SELECT fechanacimiento, apellido FROM Estudiantes
WHERE apellido = 'Enrimon' AND nombre = 'konnan'

/*actualizar*/
UPDATE Estudiantes 
SET apellido = 'Enrimon'
WHERE nombre = 'konnan'

/*eliminar*/
DELETE Estudiantes
WHERE nombre = 'konnan'

