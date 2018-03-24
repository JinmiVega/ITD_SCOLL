
/*


0 modelamiento de datos  *

*/
-- 1 creacion de base de datos
-- DROP DATABASE db_itdchool
CREATE DATABASE DB_ItdSchool;
USE  DB_ItdSchool;

/***********************   2 CREACION  DE TABLAS *****************************/
-- TBL. ESTADO USUARIO


CREATE TABLE EstadoUsuario(
idEstado int PRIMARY KEY NOT NULL AUTO_INCREMENT ,-- PK,NO NULOS, AUTOINCREMENTABLE 
estado varchar(20)

);
-- TBL USUARIOS
-- DROP TABLE usuarios;
CREATE TABLE usuarios(
idUsuario int not null AUTO_INCREMENT,
usuario varchar(250) not null unique,
nombres varchar(250)not null,
apellidos varchar(250),
dni char(8),
edad int,
idEstado int,-- FK
password varchar(20),
fechaRegistro datetime default now(),
fechaModificacion datetime ,
 CONSTRAINT UC_Usuario UNIQUE (usuario,dni),
 PRIMARY KEY (idUsuario)
);


-- TBL CURSOS
CREATE TABLE cursos(
idCurso INT PRIMARY KEY AUTO_INCREMENT,
curso VARCHAR(100),
horasDuracion INT,
fechaInicio date,
fechaFin date,
fechaRegistro datetime
);

CREATE TABLE USUARIOS_CURSOS(
idUsuario INT ,
idCurso INT ,
importe real,
fechaRegistro datetime default now()
);



/***********************   3 Restricciones *****************************/
-- LLAVES FORANEAS, PRIMARIAS, CAMPOS UNICOS
-- crear llaves foraneas
ALTER TABLE usuarios -- TABLA EN LA QUE ESTA LA LLAVE FORANEA
ADD FOREIGN KEY FK_USUARIO (idEstado)  REFERENCES EstadoUsuario(idEstado); -- hacemos referencia al campo de la tabla padre


-- crear campos unicos / SEGUNA MANERA
ALTER TABLE usuarios
ADD CONSTRAINT UC_Usuario UNIQUE (usuario,dni);


-- RESTRICCIONES EN TABLA USUARIOS CURSO:




ALTER TABLE USUARIOS
ADD CONSTRAINT PK_Usuario PRIMARY KEY (idUsuario);




/*
ALTER TABLE USUARIOS
DROP FK_USUARIO
*/




















































-- select now();





