CREATE DATABASE Taller3_Mascotas2

CREATE TABLE Clientes(
	cliente_id INT PRIMARY KEY,
	n_cliente VARCHAR(40),
	telefono VARCHAR(20),
	email VARCHAR(40)
)

CREATE TABLE Tratamientos(
	tratamiento_id INT PRIMARY KEY,
	n_tratamiento VARCHAR(40),
	precio INT
)

CREATE TABLE Mascotas(
	mascota_id INT PRIMARY KEY,
	n_mascotas VARCHAR(40),
	especie VARCHAR(40),
	edad INT,
	fk_cliente_id INT FOREIGN KEY REFERENCES Clientes(cliente_id),
)

CREATE TABLE Citas(
	cita_id INT PRIMARY KEY,
	fecha DATE,
	hora VARCHAR(20),
	fk_mascota_id INT FOREIGN KEY REFERENCES Mascotas(mascota_id),
)

CREATE TABLE THistorials(
	THistorial_id INT PRIMARY KEY,
	fk_cita_id INT FOREIGN KEY REFERENCES Citas(cita_id),
	fk_tratamiento_id INT FOREIGN KEY REFERENCES Tratamientos(tratamiento_id),
)


INSERT INTO Tratamientos
VALUES (1, 'Vacunación', 50.00),
    (2, 'Desparasitación', 30.00),
    (3, 'Esterilización', 100.00)



INSERT INTO Clientes
VALUES (1, 'Juan Perez', '555-1234567', 'juan@example.com'),
    (2, 'Maria Lopez', '555-9876543', 'maria@example.com'),
    (3, 'Pedro Gomez', '555-5555555', 'pedro@example.com'),
    (4, 'Ana Torres', '555-1112222', 'ana@example.com'),
    (5, 'Carlos Ramirez', '555-3334444', 'carlos@example.com'),
    (6, 'Laura Sanchez', '555-5551111', 'laura@example.com'),
    (7, 'Luis Herrera', '555-6667777', 'luis@example.com'),
    (8, 'Sofia Rodriguez', '555-8889999', 'sofia@example.com'),
    (9, 'Marcos Castro', '555-2223333', 'marcos@example.com'),
    (10, 'Isabel Ramirez', '555-7778888', 'isabel@example.com')



INSERT INTO Mascotas
VALUES(1, 'Max', 'Perro', 3, 1),
    (2, 'Luna', 'Gato', 5, 1),
    (3, 'Rocky', 'Perro', 2, 2),
    (4, 'Nala', 'Gato', 4, 3),
    (5, 'Toby', 'Perro', 1, 4),
    (6, 'Simba', 'Gato', 6, 4),
    (7, 'Bella', 'Perro', 4, 5),
    (8, 'Lucy', 'Gato', 2, 5),
    (9, 'Charlie', 'Perro', 7, 6),
    (10, 'Oscar', 'Gato', 3, 7),
    (11, 'Coco', 'Perro', 5, 8)

	
INSERT INTO Citas
VALUES
    (1, '2023-07-01', '10:00:00', 1),
    (2, '2023-07-02', '15:30:00', 3),
    (3, '2023-07-03', '14:00:00', 2),
    (4, '2023-07-04', '11:30:00', 5),
    (5, '2023-07-05', '09:00:00', 6),
    (6, '2023-07-06', '16:45:00', 8),
    (7, '2023-07-07', '13:15:00', 9),
    (8, '2023-07-08', '10:30:00', 11),
    (9, '2023-07-09', '14:45:00', 4),
    (10, '2023-07-10', '12:00:00', 7),
    (11, '2023-07-11', '17:30:00', 10),
    (12, '2023-07-12', '09:45:00', 1),
    (13, '2023-07-13', '16:00:00', 6),
    (14, '2023-07-14', '11:15:00', 9),
    (15, '2023-07-15', '13:30:00', 11),
    (16, '2023-07-16', '10:45:00', 2),
    (17, '2023-07-17', '15:00:00', 3),
    (18, '2023-07-18', '12:15:00', 4),
    (19, '2023-07-19', '16:30:00', 7),
    (20, '2023-07-20', '13:45:00', 8),
    (21, '2023-07-21', '11:00:00', 10),
    (22, '2023-07-22', '14:15:00', 5),
    (23, '2023-07-23', '09:30:00', 6),
    (24, '2023-07-24', '16:45:00', 9),
    (25, '2023-07-25', '12:00:00', 11),
    (26, '2023-07-26', '17:15:00', 1),
    (27, '2023-07-27', '10:30:00', 2),
    (28, '2023-07-28', '15:45:00', 4),
    (29, '2023-07-29', '13:00:00', 7),
    (30, '2023-07-30', '11:15:00', 8)


INSERT INTO THistorials
VALUES
    (1, 1, 1),
    (2, 1, 2),
    (3, 2, 3),
    (4, 3, 1),
    (5, 4, 2),
    (6, 5, 3),
    (7, 6, 1)

--1** Obtener el nombre de los clientes cuyas mascotas tienen más de 5 años.
SELECT n_cliente FROM Clientes
where cliente_id IN(
	SELECT edad from Mascotas
	WHERE edad > 5)

--2.Mostrar el nombre de las mascotas que han tenido al menos una cita.
SELECT n_mascotas FROM Mascotas
WHERE mascota_id in(
SELECT TOP 11 fk_mascota_id FROM Citas
GROUP BY fk_mascota_id
	ORDER BY COUNT(*) DESC)

	/*SELECT n_mascotas FROM Mascotas
	WHERE cita_id IN (
	SELECT mascota_id FROM Citas
	)*/

--3.***	Encontrar el nombre y especie de las mascotas que han recibido algún tratamiento.
SELECT n_mascotas,especie FROM Mascotas
WHERE mascota_id IN(
	SELECT tratamiento_id FROM Tratamientos)

	/*SELECT n_mascotas, especie FROM Mascotas
	WHERE mascota_id in(
	SELECT mascota_id FROM Citas
	where cita_id in(
		SELECT cita_id FROM THistorials))*/
	
--4.***	Obtener el nombre y cantidad de citas de las m-ascotas cuyas mascotas 
--tienen una edad mayor al promedio.

select * from THistorials
SELECT n_mascotas FROM Mascotas
WHERE EDAD >(
	SELECT AVG(EDAD) FROM Mascotas)

	


--5.***	Mostrar el nombre y precio de los tratamientos que tienen un costo mayor al promedio
SELECT n_tratamiento,precio FROM Tratamientos
WHERE precio >(
	SELECT AVG(precio) FROM Tratamientos)

--***6.Obtener el nombre y correo electrónico de los clientes que tienen mascotas de especie "Gato".
SELECT n_cliente,email FROM Clientes
WHERE cliente_id IN(
	SELECT fk_cliente_id FROM Mascotas
	WHERE especie = 'Gato')

--7.	Encontrar el nombre y edad de las mascotas que tienen citas programadas para EL 15 DE JULIO.
 SELECT n_mascotas, edad FROM Mascotas
 WHERE mascota_id in(
	SELECT mascota_id FROM Citas
	WHERE fecha > '2023-07-15')
 )
	 SELECT c.fk_mascota_id
    FROM Citas c
    WHERE c.fecha = DATEADD(day, 1, GETDATE())