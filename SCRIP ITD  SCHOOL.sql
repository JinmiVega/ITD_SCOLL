
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
idUsuario INT ,-- PK,FK
idCurso INT ,-- PK,FK
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



-- LLAVE PRIMARIAS COMPUESTAS 
ALTER TABLE USUARIOS_CURSOS
ADD CONSTRAINT PK_Usuario_Curso PRIMARY KEY (idUsuario,idCurso);

-- llaves foraneas

ALTER TABLE USUARIOS_CURSOS -- TABLA EN LA QUE ESTA LA LLAVE FORANEA
ADD FOREIGN KEY FK_USUARIOS_CURSOS_idUsuario (idUsuario)  REFERENCES usuarios(idUsuario);
ALTER TABLE USUARIOS_CURSOS -- TABLA EN LA QUE ESTA LA LLAVE FORANEA
ADD FOREIGN KEY FK_USUARIOS_CURSOS_idCurso (idCurso)  REFERENCES cursos(idCurso);

/*
ALTER TABLE USUARIOS
DROP FK_USUARIO
*/


/***********************   4 insertar datos *****************************/


INSERT INTO estadousuario (estado) VALUES('Activo');
INSERT INTO estadousuario (estado) VALUES('Inactivo');


-- SELECT * FROM estadousuario

INSERT INTO usuarios(usuario,nombres,apellidos,dni,edad,idEstado,password) VALUES('jvega@iteamdevs.com','jinmi lidonil','vega vega','44617765',20,1,'1');
INSERT INTO usuarios(usuario,nombres,apellidos,dni,edad,idEstado,password) VALUES('hbautista@iteamdevs.com','hillary','bautista','44617765',20,2,'123');
INSERT INTO usuarios(usuario,nombres,apellidos,dni,edad,idEstado,password) VALUES('vsalazar@iteamdevs.com','Victor','salazar','44617765',19,1,'1');
INSERT INTO usuarios(usuario,nombres,apellidos,dni,edad,idEstado,password) VALUES('jduran@iteamdevs.com','jose','durant','44617765',20,1,'123');
            
            
            
-- SELECT * FROM usuarios

/***********************   5 ACTUALIZAR DATOS DE TABLA  *****************************/
UPDATE usuarios SET dni='70994661',nombres='Hillary Karin' WHERE idUsuario=5;


 /***********************   6 ELIMINAR DATOS DE TABLA  *****************************/       
 
 DELETE FROM usuarios WHERE idUsuario=3;
 
 
 /***********************   7,8 CONSULTAS  DE TABLA  *****************************/  
 
 -- SELECT u.idUsuario,u.usuario,CONCAT(u.Nombres,  ' ', u.Apellidos)as nombreApellido ,u.dni,u.idEstado,eu.estado,u.fechaRegistro FROM usuarios u ,estadousuario eu
 
 
 SELECT u.idUsuario,u.usuario,CONCAT(u.Nombres,  ' ', u.Apellidos)as nombreApellido ,u.dni,u.idEstado,eu.estado,u.fechaRegistro FROM usuarios u 
 INNER JOIN estadousuario eu ON u.idEstado=eu.idEstado
 -- INNER JOIN usuarios_cursos uc ON u.idUsuario=uc.idUsuario
  WHERE idUsuario=1;
  
  
   
 SELECT u.idUsuario,u.usuario,CONCAT(u.Nombres,  ' ', u.Apellidos)as nombreApellido ,u.dni,u.idEstado,eu.estado,u.fechaRegistro FROM usuarios u 
 INNER JOIN estadousuario eu ON u.idEstado=eu.idEstado
  WHERE  u.usuario LIKE 'J%'; -- X%, %XXX, %XXX%
  
  SELECT u.idUsuario,u.usuario,CONCAT(u.Nombres,  ' ', u.Apellidos)as nombreApellido ,u.dni,u.idEstado,eu.estado,u.fechaRegistro FROM usuarios u 
 INNER JOIN estadousuario eu ON u.idEstado=eu.idEstado
  WHERE  u.apellidos LIKE '%a'; -- X%, %XXX, %XXX%
 
   SELECT u.idUsuario,u.usuario,CONCAT(u.Nombres,  ' ', u.Apellidos)as nombreApellido ,u.dni,u.idEstado,eu.estado,u.fechaRegistro FROM usuarios u 
 INNER JOIN estadousuario eu ON u.idEstado=eu.idEstado
  WHERE  u.apellidos LIKE '%v%' AND u.nombres like '%j%'; -- X%, %XXX, %XXX%
  
  
     SELECT u.idUsuario,u.usuario,CONCAT(u.Nombres,  ' ', u.Apellidos)as nombreApellido ,u.dni,u.idEstado,eu.estado,u.fechaRegistro FROM usuarios u 
 INNER JOIN estadousuario eu ON u.idEstado=eu.idEstado
  WHERE  u.apellidos LIKE '%v%' or u.nombres like '%j%'; -- X%, %XXX, %XXX%
  
  
     SELECT u.idUsuario,u.usuario,CONCAT(u.Nombres,  ' ', u.Apellidos)as nombreApellido ,u.dni,u.idEstado,eu.estado,u.fechaRegistro FROM usuarios u 
 INNER JOIN estadousuario eu ON u.idEstado=eu.idEstado
  WHERE  u.edad between 20 and 50; 
  
  
  select * from usuarios
  
  
   /***********************   9 PROCEDIMIENTOS ALMACENADOR  *****************************/ 
  
  
  -- USE db_itdschool;
-- DROP procedure IF EXISTS `SP_USUARIOS_InsertUpdate`;

DELIMITER $$
USE `db_itdschool`$$
CREATE PROCEDURE SP_USUARIOS_InsertUpdate (
IN prm_idUsuario int ,
IN prm_usuario varchar(250) ,
IN prm_nombres varchar(250),
IN prm_apellidos varchar(250),
IN prm_dni char(8),
IN prm_edad int,
IN prm_idEstado int
-- OUT msg varchar(100)
)
BEGIN
	
	IF prm_idUsuario > 0 THEN -- actualizo
	   UPDATE USUARIOS SET 
		usuario=prm_usuario,
		nombres=prm_nombres,
		apellidos=prm_apellidos,
		dni=prm_dni,
		edad=prm_edad,
        idEstado=prm_idEstado,
		fechaModificacion=NOW()
		where idUsuario=prm_idUsuario;
	
           
		-- SET msg = 'Actualizacion exitosa';
	ELSE     
         
		  INSERT INTO USUARIOS(
			usuario,
			nombres,
			apellidos,
			dni,
			edad,
            idEstado,
            fechaRegistro
			
        )values(
			prm_usuario,
			prm_nombres,
			prm_apellidos,
			prm_dni,
			prm_edad,
            prm_idEstado,
			NOW()      
        );
			
           -- set  msg = 'Registro exitoso';
          -- select last_insert_id();
           
    END if;

END$$

DELIMITER ;

--  consultar procedimiento


call SP_USUARIOS_InsertUpdate( 9,'Pvega@gmail.com','lidonil','vega','44617765',25,1);

select * from usuarios


-- con parametro de salida




DELIMITER $$
USE `db_itdschool`$$
CREATE PROCEDURE SP_USUARIOS_InsertUpdate2 (
IN prm_idUsuario int ,
IN prm_usuario varchar(250) ,
IN prm_nombres varchar(250),
IN prm_apellidos varchar(250),
IN prm_dni char(8),
IN prm_edad int,
IN prm_idEstado int,
 OUT msg varchar(100)
)
BEGIN
	
	IF prm_idUsuario > 0 THEN -- actualizo
	   UPDATE USUARIOS SET 
		usuario=prm_usuario,
		nombres=prm_nombres,
		apellidos=prm_apellidos,
		dni=prm_dni,
		edad=prm_edad,
        idEstado=prm_idEstado,
		fechaModificacion=NOW()
		where idUsuario=prm_idUsuario;
	
           
		SET msg = 'Actualizacion exitosa';
	ELSE     
         
		  INSERT INTO USUARIOS(
			usuario,
			nombres,
			apellidos,
			dni,
			edad,
            idEstado,
            fechaRegistro
			
        )values(
			prm_usuario,
			prm_nombres,
			prm_apellidos,
			prm_dni,
			prm_edad,
            prm_idEstado,
			NOW()      
        );
			
           set  msg = 'Registro exitoso';
          -- select last_insert_id();
           
    END if;

END$$

DELIMITER ;

call SP_USUARIOS_InsertUpdate2( 0,'Xvega@gmail.com','lidonil','vega','44617765',25,1,@msg);
select @msg;




  
 
 
 
 
























































-- select now();





