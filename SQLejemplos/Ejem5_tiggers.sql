CREATE DATABASE Store

CREATE TABLE  Clientes(
cliente_id INT PRIMARY KEY,
nombre VARCHAR(20)
)

CREATE TABLE Pedidos(
pedido_id INT PRIMARY KEY IDENTITY(1,1),
fk_cliente_id INT FOREIGN KEY REFERENCES Clientes(cliente_id),
fechapedido DATE DEFAULT GETDATE(),
total INT )

ALTER TABLE Clientes
ADD totalpedido INT DEFAULT 0

INSERT INTO Clientes(cliente_id,nombre)
VALUES (1,'Andrea'),
(2,'Perla'),
(3,'Lorena')

SELECT * FROM Clientes

SELECT * FROM Pedidos

CREATE  TRIGGER act_total_pedidos ON pedidos
AFTER INSERT
AS 
BEGIN
	UPDATE Clientes 
	SET totalpedido = totalpedido + 1
	FROM Clientes
	INNER JOIN inserted ON clientes.cliente_id = inserted.fk_cliente_id
END

INSERT INTO Pedidos (fk_cliente_id,total)
VALUES (3,3000)

INSERT INTO Pedidos (fk_cliente_id,total)
VALUES (1,3000)

SELECT * FROM Pedidos
SELECT * FROM Clientes


DELETE Pedidos
WHERE pedido_id >= 3
-------------------------eliminar-----------------------

CREATE  TRIGGER act_total_pedidos ON pedidos
AFTER INSERT
AS 
BEGIN
	UPDATE Clientes 
	SET totalpedido = totalpedido - 1
	FROM Clientes
	INNER JOIN deleted ON clientes.cliente_id = deleted.fk_cliente_id
END

DELETE Pedidos
WHERE pedido_id = 6

-----------------------------------------------
SELECT * FROM departamentos
SELECT * FROM EMPLEADOS

UPDATE empleados 
SET departamento = NULL
WHERE ID = 2

CREATE TABLE departamentos (
	ID INT PRIMARY KEY,
	nombre VARCHAR(30)
)
INSERT INTO departamentos
VALUES(1,'Antioquia')
DROP TRIGGER validacion_departamentos
CREATE TRIGGER validacion_departamentos ON empleados
AFTER UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT * FROM departamentos,inserted
		WHERE inserted.Departamento=departamentos.nombre
	)
	BEGIN
		PRINT 'LA ACTUALIZACIÓN DEL DEPARTEMENTO SE REALIZÓ CORRECTAMENTE'
	END
	ELSE
	BEGIN
		ROLLBACK;
	END
END


UPDATE empleados
SET Departamento ='Antioquia'
WHERE ID = 2

CREATE TRIGGER validacion_departamentos_ins ON empleados
AFTER INSERT
AS
BEGIN
	IF EXISTS (
		SELECT * FROM departamentos,inserted
		WHERE inserted.Departamento=departamentos.nombre
	)
	BEGIN
		PRINT 'LA ACTUALIZACIÓN DEL DEPARTEMENTO SE REALIZÓ CORRECTAMENTE'
	END
	ELSE
	BEGIN
		RAISERROR('El departamento no existe',16,1)
		ROLLBACK;
	END
END
SELECT * FROM EMPLEADOS
SELECT * FROM departamentos

INSERT INTO empleados (id,Nombre,Departamento)
VALUES(456,'Juanita','Nariño')

CREATE PROCEDURE ObtenerEmpleados
AS
BEGIN
	SELECT * FROM empleados
END

EXEC ObtenerEmpleados


CREATE PROCEDURE Dep_empleados
	@DepartamentoINS VARCHAR(40)
AS
BEGIN
	SELECT * FROM empleados
	WHERE departamento = @DepartamentoINS
END

EXEC Dep_empleados @DepartamentoINS = 'Antioquia'

--vamos crear un procedimiento almacenado donde me muestre los empleados que tengan el departamento de antioquia
--  y la ultima venta haya sido 26-06-202