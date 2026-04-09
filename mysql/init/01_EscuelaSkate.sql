CREATE DATABASE IF NOT EXISTS EscuelaSkate;
USE  EscuelaSkate;
CREATE TABLE ALUMNO (
    Cod_alumno INT PRIMARY KEY AUTO_INCREMENT,
    Nom_alumno_CC VARCHAR(100),
    Ap_alumno VARCHAR(70),
    DNI_alumno VARCHAR(20),
    Edad INT,
    Datos_Padres_OP VARCHAR(255)
);


CREATE TABLE GRUPO (
    Cod_grupo INT PRIMARY KEY AUTO_INCREMENT,
    Cod_alumno_FK INT,
    Nivel VARCHAR(50),
    FOREIGN KEY (Cod_alumno_FK) REFERENCES ALUMNO(Cod_alumno)
);


CREATE TABLE MATERIAL (
    Cod_Material INT PRIMARY KEY AUTO_INCREMENT,
    Cod_alumno_FK INT,
    Tipo_material VARCHAR(50),
    Precio DECIMAL(10,2),
    Tiempo INT,
    FOREIGN KEY (Cod_alumno_FK) REFERENCES ALUMNO(Cod_alumno)
);


CREATE TABLE ALQUILAR (
    Cod_Material_FK INT,
    Cod_alumno_FK INT,
    Fecha_Inicio DATE,
    Fecha_Fin DATE,
    FOREIGN KEY (Cod_Material_FK) REFERENCES MATERIAL(Cod_Material),
    FOREIGN KEY (Cod_alumno_FK) REFERENCES ALUMNO(Cod_alumno)
);


CREATE TABLE PROFESOR (
    Cod_Profesor INT PRIMARY KEY AUTO_INCREMENT,
    Nom_CC VARCHAR(100),
    Ap_profesor VARCHAR(70),
    DNI_profesor VARCHAR(20),
    Años_experiencia INT
);


CREATE TABLE CLASE_SKATE (
    Cod_ClaseSkate INT PRIMARY KEY AUTO_INCREMENT,
    Cod_Profesor_FK INT,
    Tipo_ClaseSkate VARCHAR(50),
    Tarifa DECIMAL(10,2),
    FOREIGN KEY (Cod_Profesor_FK) REFERENCES PROFESOR(Cod_Profesor)
);


CREATE TABLE CONTRATAR (
    Cod_alumno_FK INT,
    Cod_ClaseSkate_FK INT,
    Fecha_Inicio DATE,
    Fecha_Fin DATE,
    FOREIGN KEY (Cod_alumno_FK) REFERENCES ALUMNO(Cod_alumno),
    FOREIGN KEY (Cod_ClaseSkate_FK) REFERENCES CLASE_SKATE(Cod_ClaseSkate)
);


CREATE TABLE HORARIO (
    Cod_horario INT PRIMARY KEY AUTO_INCREMENT,
    Cod_ClaseSkate_FK INT,
    Dia VARCHAR(20),
    Hora TIME,
    FOREIGN KEY (Cod_ClaseSkate_FK) REFERENCES CLASE_SKATE(Cod_ClaseSkate)
);
-- Datos de prueba
INSERT INTO ALUMNO (Nom_alumno_CC, Ap_alumno, DNI_alumno, Edad, Datos_Padres_OP) VALUES
('Elena', 'Baston', '12345678A', 25, NULL),
('Marcos', 'Platas', '87654321B', 28, NULL),
('Hugo', 'Lavandeira', '56789012C', 17, 'Datos de los padres de Hugo');

INSERT INTO PROFESOR (Nom_CC, Ap_profesor, DNI_profesor, Años_experiencia) VALUES
('Jesus', 'Regueira', '13579246X', 8),
('Andres', 'Aguilar', '24681357Y', 5),
('Carlos', 'Chacon', '98765432Z', 1);

INSERT INTO CLASE_SKATE (Cod_Profesor_FK, Tipo_ClaseSkate, Tarifa) VALUES
(1, 'Street Skate', 25.00),
(2, 'Ramp Skate', 30.00),
(3, 'Street Skate2', 20.00);

INSERT INTO GRUPO (Cod_alumno_FK, Nivel) VALUES
(1, 'Principiante'),
(2, 'Intermedio'),
(3, 'Avanzado');

INSERT INTO MATERIAL (Cod_alumno_FK, Tipo_material, Precio, Tiempo) VALUES
(1, 'Rodilleras', 30.50, 7),
(2, 'Tabla de Skate', 45.75, 5),
(3, 'Casco', 15.20, 3);

INSERT INTO HORARIO (Cod_ClaseSkate_FK, Dia, Hora) VALUES
(1, 'Lunes', '18:00:00'),
(2, 'Miércoles', '16:00:00'),
(3, 'Viernes', '20:00:00');