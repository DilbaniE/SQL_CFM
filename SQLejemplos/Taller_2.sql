CREATE DATABASE Taller2

CREATE TABLE SOLDADO (
    ID INT PRIMARY KEY ,
    NOMBRE VARCHAR(50),
    APELLIDO VARCHAR(59),
    RANGO VARCHAR(20),
    EDAD INT,
    SALARIO INT
)

CREATE TABLE MISIONES (
    ID_MISION INT PRIMARY KEY,
    FK_ID_SOL INT FOREIGN KEY REFERENCES SOLDADO(ID),
    FECHA_INICIO DATE,
    FECHA_FIN DATE,
    TIPO VARCHAR(20),
    DURACION INT
)

-- Insertar datos en la tabla SOLDADO
INSERT INTO SOLDADO VALUES (1, 'John', 'Smith', 'Coronel', 35, 80000);
INSERT INTO SOLDADO VALUES (2, 'Sarah', 'Johnson', 'Mayor', 32, 65000);
INSERT INTO SOLDADO VALUES (3, 'David', 'Williams', 'Sargento', 28, 55000);
INSERT INTO SOLDADO VALUES (4, 'Emily', 'Brown', 'Cabo', 25, 45000);
INSERT INTO SOLDADO VALUES (5, 'Daniel', 'Jones', 'Soldado raso', 22, 35000);

SELECT * FROM SOLDADO
SELECT * FROM MISIONES

-- Insertar datos en la tabla MISIONES
INSERT INTO MISIONES VALUES (1, 1, '2023-07-01', '2023-07-15', 'Combate', 14);
INSERT INTO MISIONES VALUES (2, 2, '2023-03-01', '2023-03-15', 'Reconocimiento', 14);
INSERT INTO MISIONES VALUES (3, 2, '2023-04-01', '2023-04-15', 'Rescate', 14);
INSERT INTO MISIONES VALUES (4, 2, '2023-08-14', '2023-08-20', 'Combate', 6);
INSERT INTO MISIONES VALUES (5, 3, '2023-08-20', '2023-08-25', 'Combate', 5);
INSERT INTO MISIONES VALUES (6, 3, '2023-12-20', '2023-12-31', 'Rescate', 11);
INSERT INTO MISIONES VALUES (7, 4, '2023-06-01', '2023-06-05', 'Combate', 5);

INSERT INTO MISIONES VALUES (8, 1, '2023-07-01', '2023-07-15', '', 14);


--Seleccionar el nombre, apellido y salario de todos los soldados.
SELECT nombre, apellido,salario FROM SOLDADO

--Seleccionar el nombre, apellido y salario de los soldados con un rango de "Mayor"
SELECT nombre,apellido,salario FROM SOLDADO
WHERE RANGO = 'Mayor'

--¿Cuántos soldados hay de cada rango?
SELECT NOMBRE, RANGO, COUNT(*) AS CANTIDAD FROM SOLDADO
GROUP BY RANGO

--Seleccionar los soldados que no han participado en ninguna misión.
SELECT * FROM SOLDADO
SELECT * FROM MISIONES

SELECT NOMBRE FROM SOLDADO
FULL JOIN MISIONES ON ID=FK_ID_SOL
WHERE ID_MISION IS NULL

--Seleccionar los soldados que han participado en más de una misión y mostrar cuántos cumplen con esa condición.
SELECT NOMBRE,COUNT(*) as CANTIDADMISIONES FROM SOLDADO
INNER JOIN MISIONES ON ID=FK_ID_SOL
GROUP BY NOMBRE
HAVING COUNT(*) >1

--Determinar el salario promedio de los soldados.
SELECT AVG(SALARIO) AS PROMEDIO FROM SOLDADO

--Determinar la duración promedio de las misiones por cada soldado.
SELECT NOMBRE,AVG(DURACION) AS SUMA FROM SOLDADO
INNER JOIN MISIONES ON ID=FK_ID_SOL
GROUP BY NOMBRE

--Seleccionar al soldado que ha participado en la misión de mayor duración, mostrar su nombre, apellido y duración total de las misiones.
SELECT TOP 1 NOMBRE, APELLIDO,SUM(DURACION) AS SUMA FROM SOLDADO
INNER JOIN MISIONES ON ID=FK_ID_SOL
GROUP BY NOMBRE,APELLIDO,DURACION
ORDER BY SUMA DESC

--Mostrar la cantidad de misiones de cada tipo realizadas por cada soldado.
SELECT NOMBRE,SUM(DURACION) AS CONTEO,TIPO FROM SOLDADO 
INNER JOIN MISIONES ON ID = FK_ID_SOL
GROUP BY NOMBRE, TIPO

-- cambiar el nombre de una columna con precusion por que tendria que cambiarlos donde este nombrado
--EXEC sp_rename 'SOLDADO.SALARIO', 'SALARIO','COLUMN'

-- para crear una vista temporal
CREATE VIEW V_MAYOR2MISIONES AS
SELECT NOMBRE,APELLIDO FROM SOLDADO
INNER JOIN MISIONES ON ID=FK_ID_SOL
GROUP BY NOMBRE,APELLIDO
HAVING COUNT(*) >2
--eliminar una vista
--DROP VIEW V_MAYOR2MISIONES

--ver la vista y elementos
SELECT * FROM V_MAYOR2MISIONES

--cambiar el nombre a una tabla
--EXEC sp_rename 'SOLDADO', 'GUERREROS'

--constrain -----------------------------------------------------
ALTER TABLE SOLDADO
ADD CONSTRAINT UO_SOLDADO_SALARIO UNIQUE (SALARIO)

--eliminar un contrain
ALTER TABLE SOLDADO
DROP CONSTRAINT UO_SOLDADO_SALARIO

--constran para agregar una regla que me quite el not null
ALTER TABLE MISIONES
ALTER COLUMN TIPO VARCHAR (20)NOT NULL

ALTER TABLE MISIONES
ALTER COLUMN DURACION INT NOT NULL


--agregar a la columna tipo en la fila que este not null
UPDATE MISIONES
SET TIPO = 'Rescate'
WHERE TIPO IS NULL

--constrain para agregar una regla donde el rango es unico
ALTER TABLE SOLDADO
ADD CONSTRAINT UQ_SOLDADO_RAGO UNIQUE (RANGO)

--eliminar un campo de una tabla
DELETE SOLDADO
WHERE ID=6

SELECT * FROM MISIONES
SELECT * FROM SOLDADO

DELETE MISIONES
WHERE ID_MISION=8

--eliminar una regla del constrain 
ALTER TABLE SOLDADO
DROP CONSTRAINT UQ_SOLDADO_RAGO

--una vista almacenada una tablita pequeña, una vista rapda de los datos algo mas espesifico
 CREATE VIEW DATOSOLDADOS AS
SELECT NOMBRE,APELLIDO FROM SOLDADO

SELECT * FROM DATOSOLDADOS

--------------------------------------------
SELECT * FROM SOLDADO

--renombrar una columna de una tabla 
EXEC sp_rename 'SOLDADO.NOMBRESOLDADO', 'NOMBRE','COLUMN'
-- renombrar una tabla ---------
EXEC sp_rename 'SOLDADITO','SOLDADO'

-------------------------SUDCONSULTAS------------------

SELECT * FROM SOLDADO
WHERE RANGO = 'MAYOR'

--nombre y apellido de la tabla soldado donde el tipo sea sea igual a cobate CON INNNER  JOIN
SELECT NOMBRE, APELLIDO, TIPO FROM SOLDADO
INNER JOIN MISIONES ON SOLDADO.ID = MISIONES.FK_ID_SOL
GROUP BY NOMBRE,APELLIDO,TIPO
HAVING MISIONES.TIPO = 'Combate'

------------------------SUDCONSULTA---------------------------
SELECT NOMBRE,APELLIDO FROM SOLDADO
WHERE ID IN(
	SELECT FK_ID_SOL FROM MISIONES
	WHERE TIPO = 'Combate')

-- oobtener el nombre y el apellido de los soldados donde la edad sea mayor al promedio de todos los soldados
SELECT NOMBRE,APELLIDO FROM SOLDADO
WHERE EDAD >(
	SELECT AVG(EDAD) FROM SOLDADO)

--agregando un nuevo campo a la tabla soldados 

ALTER TABLE SOLDADO
ADD GENERO VARCHAR(15)

UPDATE SOLDADO
SET GENERO = 'MASCULINO'
WHERE ID IN (1,3,5)

UPDATE SOLDADO
SET GENERO = 'FEMENINO'
WHERE ID IN (2,4)

--obtener los nombres y rangos de los soldados que han participado en misisones con una 
--duracion mayor a la duracion promedio
SELECT NOMBRE,APELLIDO  FROM SOLDADO
WHERE ID IN (
	SELECT FK_ID_SOL FROM MISIONES
	WHERE DURACION > (
		SELECT AVG(DURACION) FROM MISIONES))
----------------------------------------------------------
SELECT NOMBRE, APELLIDO FROM SOLDADO
INNER JOIN MISIONES ON ID = FK_ID_SOL
WHERE DURACION > (SELECT AVG(DURACION) FROM MISIONES)

--obtener los nombres y apellidos de los soldados cuyo salario sea igual al salario 
--maximo en la tabla soldado
SELECT NOMBRE, APELLIDO FROM SOLDADO
WHERE SALARIO = (
SELECT MAX(SALARIO) FROM SOLDADO)

--muestreme el rango del soldado mas joven 
SELECT RANGO FROM SOLDADO
WHERE EDAD =(
SELECT MIN(EDAD) FROM SOLDADO)

--el soldado que no ha participado en ninguna mision
SELECT * FROM SOLDADO
WHERE NOT EXISTS(
	SELECT * FROM MISIONES
	WHERE FK_ID_SOL = SOLDADO.ID) 






