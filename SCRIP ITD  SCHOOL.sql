
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

)
-- TBL USUARIOS
CREATE TABLE usuarios(
idUsuario int not null AUTO_INCREMENT,
usuario varchar(250) not null unique,
nombres varchar(250)not null,
apellidos varchar(250),
dni char(8),
edad int,
isEstado int,
password varchar(20),
fechaRegistro datetime default now(),
fechaModificacion datetime ,
 CONSTRAINT UC_Usuario UNIQUE (usuario,dni),
 PRIMARY KEY (idUsuario)


)







