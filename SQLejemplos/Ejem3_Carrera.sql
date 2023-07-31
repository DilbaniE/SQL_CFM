CREATE DATABASE Eje3_Carrera

CREATE TABLE carreras(
idcarrera INT PRIMARY KEY IDENTITY(1,1),
nombre_carrera VARCHAR(30),
capacidad INT,
semestres INT
)

CREATE TABLE materias(
idmateria INT PRIMARY KEY IDENTITY(1,1),
nombre_materia VARCHAR(30),
profesor VARCHAR(40)
)

CREATE TABLE estudiantes(
idestudiante INT PRIMARY KEY IDENTITY(1,1),
fk_idmaterias INT FOREIGN KEY REFERENCES carreras(idcarrera),
nombre_estudiante VARCHAR(30),
apellido VARCHAR(30)
)

CREATE TABLE carrerMaterias(
id INT PRIMARY KEY IDENTITY(1,1),
fk_idmaterias INT FOREIGN KEY REFERENCES materias(idmateria),
fk_carreras INT FOREIGN KEY REFERENCES carreras(idcarrera)
)
INSERT INTO carreras (nombre_carrera,capacidad,semestres)
VALUES ('Sistemas',110,10),
('Ambiental',80,8)

INSERT INTO carreras (nombre_carrera,capacidad,semestres) --aqui debo poner el parentesis porque no voy a poner todos los datos, la fk de carreras se llena solo
VALUES('Psicologia',200,10)

SELECT * FROM carreras

INSERT INTO estudiantes --aqui no son necesarios los parentesis porque yo mismo lo voy a ingresar en el orden de la tabla
VALUES (1,'Mariajose','Gomez')

INSERT INTO estudiantes 
VALUES (2,'Luis','Garzon'),
(3,'Simon','Giraldo')

INSERT INTO materias 
VALUES ('ingles','Luisa'),
('Matematicas','Andres'),
('Software','Majo'),
('Lengua materna','Andrea')


carrerMaterias(fk_idmaterias,fk_carreras)
VALUES(1,1),
(2,1),
(3,1),
(1,2),
(1,3),
(4,3)


SELECT * FROM estudiantes
SELECT * FROM materias
SELECT * FROM carreras
SELECT * FROM  carrerMaterias


SELECT nombre_estudiante,apellido FROM estudiantes
SELECT profesor,nombre_materia FROM materias