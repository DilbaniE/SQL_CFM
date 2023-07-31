CREATE DATABASE Eje4_Hospital

CREATE TABLE Pacientes(
	paciente_id INT PRIMARY KEY,
	n_paciente VARCHAR(40),
	f_nacimiento DATE,
	genero CHAR(1),
	direccion VARCHAR(100)
)
CREATE TABLE Hospitales(
	hospitale_id INT PRIMARY KEY,
	n_hospital VARCHAR(30),
	direccion_h VARCHAR(100),
	telefono VARCHAR(20)
)

CREATE TABLE Doctores(
	doctor_id INT PRIMARY KEY,
	n_doctor VARCHAR(30),
	especialidad VARCHAR(100),
	salario INT,
	fk_hospitale_id INT FOREIGN KEY REFERENCES Hospitales(hospitale_id)
)

CREATE TABLE Medicamentos(
	medicamento_id INT PRIMARY KEY,
	n_medicamento VARCHAR(30),
	descripcion VARCHAR(100),
	stock INT
)

CREATE TABLE Citas(
	cita_id INT PRIMARY KEY,
	fk_paciente_id INT FOREIGN KEY REFERENCES Pacientes(paciente_id),
	fk_doctor_id INT FOREIGN KEY REFERENCES Doctores(doctor_id),
	fecha DATE,
	hora VARCHAR(10)
)

INSERT INTO Pacientes
VALUES(1,'Juan Pérez','1980-05-15','M','Calle 123, Ciudad'),
(2,'María Gómez','1992-11-20','F','Av. Principal, Ciudad'),
(3,'Carlos López','1975-09-10','M','Calle 456, Ciudad'),
(4,'Ana Torres','1988-03-27','F','Calle 789, Ciudad'),
(5,'Luis Rodríguez','1995-08-12','M','Av. Central, Ciudad')

INSERT INTO Pacientes
VALUES(6,'Laura Fernández','1972-12-05','F','Calle 555, Ciudad')

INSERT INTO Pacientes
VALUES(7,'Santiago Fernández','1998-12-05','M','Calle 666, Ciudad')

INSERT INTO Hospitales
VALUES(1,'Hospital A','Calle Principal, Ciudad','123-456-7890'),
(2,'Hospital B','Av. Central,Ciudad','987-654-3210'),
(3,'Hospital C','Calle Secundaria, Ciudad','555-123-4567'
)

INSERT INTO doctores 
VALUES(1,'Dr. González','Pediatría',5000,1),
(2,'Dra. Ramírez','Cardiología',7000,2),
(3,'Dr. Martínez','Cirugía',6000,1),
(4,'Dra. Sánchez','Pediatría',5500, 3),
(5,'Dr. Romero','Dermatología',6500,2),
(6,'Dra. Herrera','Ginecología',6000,3)

INSERT INTO Doctores
VALUES(7,'Dr. Dilbani', 'Neurologia', 9000,1)

INSERT INTO Medicamentos 
VALUES(1,'Paracetamol','Analgésico y antipirético',100),
(2,'Amoxicilina','Antibiótico',50),
(3,'Omeprazol','Inhibidor de la bomba de protones',75),
(4,'Ibuprofeno','Antiinflamatorio',200),
(5,'Loratadina','Antihistamínico',80),
(6,'Cetirizina','Antialérgico',120)

INSERT INTO Citas VALUES (1, 1, 1, '2023/06/22', '10:00am'),
(2, 2, 2, '2023-06-23', '11:30am'), 
(3, 3, 3, '2023-06-24', '09:00am'), 
(4, 4, 4, '2023-06-22', '02:00pm'), 
(5, 5, 5, '2023-06-25', '03:30pm'), 
(6, 6, 6, '2023-06-26', '11:00am')

SELECT * FROM Doctores
SELECT * FROM Hospitales
SELECT * FROM Medicamentos
SELECT * FROM Pacientes
SELECT * FROM Citas

--sud consultas -------------------------

--1doctores donde la especialidad sea pediatra
SELECT * FROM Doctores
WHERE especialidad = 'pediatría'

--2 mostrar el nombre del hospital que tenga la mayor cantidad de doctores
SELECT n_hospital FROM Hospitales
WHERE hospitale_id = (
	SELECT TOP 1 fk_hospitale_id FROM Doctores
	GROUP BY fk_hospitale_id
	ORDER BY COUNT(*) DESC)

--3 encontrar los medicamentos donde el stock sea inferior al  promedio del stock de todos los medicamentos
SELECT * FROM Medicamentos
WHERE stock<(
SELECT AVG(stock) FROM Medicamentos) 

--4 mostrar los pasientes que no tienen citas progrmadas
SELECT * FROM Pacientes
WHERE paciente_id NOT IN (
SELECT fk_paciente_id FROM Citas)


--5 mostrar el nombre y la espcialidad  del doctor con el salario mas alto
SELECT n_doctor, especialidad  FROM Doctores
WHERE salario = (
SELECT max(salario) from doctores)

--6 seleccionar el nombre y la direccion del hospital que tiene al menos un doctor especializados en cardiologia
SELECT n_hospital, direccion_h FROM Hospitales
WHERE hospitale_id IN(
	SELECT fk_hospitale_id FROM Doctores
	WHERE especialidad = 'CardíologÍa')

--TRIGUES----disparadores -------------------------
ALTER TABLE Pacientes
ADD fk_medicamento_id INT FOREIGN KEY REFERENCES medicamentos(medicamento_id)

CREATE TRIGGER actualizar_stock_medicamentos on Pacientes
AFTER INSERT
AS 
BEGIN
	UPDATE medicamentos
	SET stock = stock-1
	WHERE medicamento_id = (Select fk_medicamento_id FROM inserted)
END



