CREATE DATABASE repaso_Bombero

CREATE TABLE Bomberos(
	bombero_id INT PRIMARY KEY,
	nombre VARCHAR(30),
	apellido VARCHAR(30),
	edad INT,
	direcccion VARCHAR(100),
	telefono VARCHAR(20),
	fechaingreso DATE NOT NULL,
	rango VARCHAR(50)
)

CREATE TABLE Estaciones(
	estacion_id INT PRIMARY KEY,
	nombre VARCHAR(30),
	direcccion VARCHAR(100),
	ciudad VARCHAR(30),
	telefono VARCHAR(20)
)

CREATE TABLE Vehiculos(
	vehicuo_id INT PRIMARY KEY,
	estacion_id INT FOREIGN KEY REFERENCES Estaciones(estacion_id),
	tipo VARCHAR(50),
	numero_serie VARCHAR(100),
	capacidad_agua INT,
	capacidad_person INT
)

CREATE TABLE Incidencias(
	incidencia_id INT PRIMARY KEY,
	estacion_id INT FOREIGN KEY REFERENCES Estaciones(estacion_id),
	fecha DATE,
	descripccion TEXT,
	duracion INT,
	bombero_id INT FOREIGN KEY REFERENCES Bomberos(bombero_id)
)

--------------proceedimiento variables-------
CREATE PROCEDURE insert_bomberos
	@id INT,
	@nombre VARCHAR(30),
	@apellido VARCHAR(30),
	@edad INT,
	@direcccion VARCHAR(100),
	@telefono VARCHAR(20),
	@fechaingreso DATE,
	@rango VARCHAR(50)
AS
BEGIN
	INSERT INTO Bomberos
	VALUES( @id,@nombre,@apellido,@edad,@direcccion, @telefono, @fechaingreso, @rango)
END

EXEC insert_bomberos 1,'Juan','Perez',30,'Calle principal 123','555-123-4567','2010-05-15','Jefe'
EXEC insert_bomberos 2,'Maria', 'Lopez', 28,'Avenida Central 456','555-987-6543','2012-08-20','Bombero'
EXEC insert_bomberos 3,'Carlos','Rodríguez',32,'Calle Secundaria 789','555-789-1234','2014-10-13','Bombero'
EXEC insert_bomberos 4,'Laura','García', 26,'Avenida Principal','789555-456-7890','2015/11/01','Subjefe'

SELECT * FROM bomberos

-------------------------INSERTANDO DATOS---------------------
INSERT INTO Estaciones (estacion_id, nombre, direcccion, ciudad, telefono)
VALUES
    (1, 'Estación Central', 'Calle Mayor 789', 'Ciudad A', '555-123-4567'),
    (2, 'Estación Norte', 'Avenida Principal 456', 'Ciudad B', '555-987-6543'),
    (3, 'Estación Sur', 'Calle Secundaria 123', 'Ciudad A', '555-789-1234');


INSERT INTO Vehiculos (vehicuo_id, estacion_id, tipo, numero_serie, capacidad_agua, capacidad_person)
VALUES
    (1, 1, 'Camión de Bomberos', 'ABC123', 2000, 5),
    (2, 1, 'Ambulancia', 'XYZ789', NULL, 2),
    (3, 2, 'Camión de Bomberos', 'DEF456', 1500, 4),
    (4, 3, 'Vehículo de Rescate', 'GHI789', NULL, 3);


INSERT INTO Incidencias (incidencia_id, estacion_id, fecha, descripccion, duracion, bombero_id)
VALUES
    (1, 1, '2023-06-01', 'Incendio en edificio residencial', 60, 2),
    (2, 2, '2023-06-02', 'Rescate de persona atrapada en auto', 45, 3),
    (3, 1, '2023-06-03', 'Fuga de gas en local comercial', 30, 1),
    (4, 3, '2023-06-04', 'Accidente de tráfico', 90, 4);

INSERT INTO Incidencias (incidencia_id, estacion_id, fecha, descripccion, duracion, bombero_id)
VALUES (5, 3, '2023-06-28', 'Se subio el gato al arbol', 60, 3);
------------------------CONSULTAS---------------
--obtener la lista de nombres y apellidos de todos los bomberos
SELECT nombre,apellido FROM Bomberos

--obtener la lista de nombres y direccion de estaciones
SELECT nombre, direcccion FROM Estaciones

--mostrar las incidencias ocurridas el dia actual
SELECT * FROM Incidencias
WHERE fecha =  CONVERT(DATE,GETDATE())

--obtener el nombre y la fecha de los boberos que tienen mas de 5 años de antiguedad
SELECT * FROM Bomberos

SELECT nombre,fechaingreso FROM Bomberos
WHERE DATEDIFF(YEAR, fechaingreso,GETDATE()) > 5


--mostrar la cantidad de vehiculos en cada en estacion
SELECT * FROM Vehiculos

SELECT * FROM Estaciones
SELECT nombre, COUNT(*) FROM Vehiculos
INNER JOIN Estaciones ON Vehiculos.estacion_id= Estaciones.estacion_id
GROUP BY nombre

------------------agregar una columna a la tabla de bomberos MAX(37,37)
ALTER TABLE Bomberos
ADD salario NUMERIC(5,2)


UPDATE Bomberos
SET salario = 100.00
WHERE bombero_id = 1

UPDATE Bomberos
SET salario = 400.00
WHERE bombero_id in (2,3)

UPDATE Bomberos
SET salario = 700.00
WHERE bombero_id = 4

--------casteo para quitarle  decimales
SELECT CAST(AVG(salario) AS NUMERIC(10,2)) FROM Bomberos

----------modificacion de los registros DECIMAL O NUMERICO-----
ALTER TABLE Bomberos
ALTER COLUMN salario DECIMAL(15,2)


--cantidad de insidentes que ha resuelto cada bombero
SELECT TOP 1 nombre, COUNT(*) AS   CANTIDAD FROM Bomberos
INNER JOIN Incidencias on Incidencias.bombero_id = Bomberos.bombero_id
GROUP BY nombre
ORDER BY COUNT (*) DESC

--INCIDENCIAS DONDE ES NULL
SELECT * FROM Bomberos
FULL JOIN Incidencias ON Incidencias.bombero_id = Bomberos.bombero_id
WHERE incidencia_id IS NULL

-- mostrar el nombre, apellido, y rango de los bomberos que pertenecen a la estacion "estacin central"
--sud querys
SELECT nombre,apellido,rango FROM Bomberos
WHERE bombero_id in (
	SELECT estacion_id FROM Estaciones
	WHERE nombre = 'Estación central')

--mostrar el carro que se uso para la incidencia numero 3
SELECT * FROM Estaciones
INNER JOIN Vehiculos ON Estaciones.estacion_id = Vehiculos.estacion_id
INNER JOIN Incidencias ON	Vehiculos.estacion_id = Incidencias.estacion_id
WHERE incidencia_id = 3




