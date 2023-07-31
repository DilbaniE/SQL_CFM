CREATE DATABASE Ejemplo1

CREATE TABLE Departamentos(
id_departamento INT,
nombre_departamento VARCHAR(20)
)

CREATE TABLE Trabajadores(
id_trabajador VARCHAR(15),
id_departamento INT,
nombre_trabajador VARCHAR(30),
apellido_trabajdaor VARCHAR(30),
phone VARCHAR(15),
ciudad varchar(20)
)

--DROP TABLE Trabajadores-- --eliminar tabla--
--DROP DATABASE Ejemplo1--  --eliminar base de datos--