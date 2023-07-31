CREATE DATABASE Taller_Producto

CREATE TABLE Productos(
idproducto INT PRIMARY KEY IDENTITY(1,1),
n_producto VARCHAR(40),
precio INT
)

CREATE TABLE Clientes(
idcliente INT PRIMARY KEY IDENTITY(1,1),
n_cliente VARCHAR(40),
ciudad VARCHAR(50)
)

CREATE TABLE Ventas(
idventa INT PRIMARY KEY IDENTITY(1,1),
fk_idproducto INT FOREIGN KEY REFERENCES Productos(idproducto),
fk_idcliente INT FOREIGN KEY REFERENCES Clientes(idcliente),
cantidad INT
)

SELECT * FROM Productos
SELECT * FROM Clientes
SELECT * FROM Ventas


INSERT INTO Productos(n_producto,precio)
VALUES ('Producto A',10999),
('Producto B',8000),
('Producto C',100000),
('Producto D',80000)

INSERT INTO Clientes(n_cliente,ciudad)
VALUES ('Cliente A','Ciudad X'),
('Cliente  B','Ciudad Y'),
('Cliente  C','Ciudad X'),
('Cliente  D','Ciudad Z')

INSERT INTO Ventas(fk_idproducto,fk_idcliente,cantidad)
VALUES(1,1,2),
(2,2,3),
(1,3,1),
(3,4,4)

SELECT * FROM Productos
INNER JOIN Ventas ON idproducto=fk_idproducto
INNER JOIN Clientes ON idcliente=fk_idcliente
WHERE n_producto='Producto A'

