CREATE DATABASE Ejem_Trigger

CREATE TABLE Empleados(
ID INT PRIMARY KEY,
nombre VARCHAR(20) NOT NULL,
departamento VARCHAR(30))

CREATE TABLE Clientes(
ID INT PRIMARY KEY,
nombre VARCHAR(20) NOT NULL,
direccion VARCHAR(60))

CREATE TABLE Ventas(
ID INT PRIMARY KEY IDENTITY(1,1),
IDCliente INT FOREIGN KEY REFERENCES Clientes(ID),
IDEmpleado INT FOREIGN KEY REFERENCES Empleados(ID),
Monto INT NOT NULL
)

CREATE TRIGGER ins_datos ON Empleados
AFTER INSERT 
AS
BEGIN
	INSERT INTO Ventas (IDCliente,IDEmpleado,Monto)
	SELECT NULL,ID,0
	FROM inserted	
END

INSERT INTO Empleados
VALUES (123,'JUAN','Antioquia')

ALTER TABLE Clientes
ADD cantidadcompraS INT

INSERT INTO clientes (ID,nombre,direccion)
VALUES(1,'luis','calle 10')

-----------------------------------------------
CREATE TRIGGER ins_cantidadcompra ON Ventas
AFTER UPDATE
AS
BEGIN
	UPDATE Clientes
	SET cantidadcompraS = cantidadcompraS +1
	FROM Clientes	
	INNER JOIN inserted ON Clientes.ID = inserted.IDCliente
END

SELECT * FROM Empleados
SELECT * FROM Ventas
SELECT * FROM Clientes

UPDATE Clientes
SET cantidadcompraS = 0
WHERE ID = 1

UPDATE Ventas
SET IDCliente = 1
WHERE ID = 1


-----------------------------------------------
CREATE TRIGGER elm_empleado_ventas ON Ventas
AFTER DELETE
AS
BEGIN
	DELETE Empleados
	WHERE Empleados.ID IN (SElECT IDEmpleado FROM deleted)
END

SELECT * FROM Empleados
SELECT * FROM Ventas

DELETE Ventas
WHERE IDEmpleado = 123

---------------------------------------------
CREATE TRIGGER elm_empleado_ventas ON Ventas
AFTER DELETE
AS
BEGIN
	UPDATE Empleados
	SET ultimaventa = GETDATE()
	WHERE empleados.ID IN (SELECT IDEmpleado from inserted)


	WHERE Empleados.ID IN (SElECT IDEmpleado FROM deleted)
END
