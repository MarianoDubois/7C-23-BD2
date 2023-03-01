CREATE DATABASE IF NOT EXISTS GYM
    DEFAULT CHARACTER SET = 'utf8mb4';
use gym;
CREATE TABLE SOCIOS(
    id int PRIMARY KEY
, nombre VARCHAR(30)
, apellido VARCHAR(30)
, fecha_nacimiento DATE
);
CREATE TABLE SEDES(
    id BIGINT PRIMARY KEY
    ,nombre VARCHAR(30)
    ,id_socio int
    ,constraint foreign key(id_socio) references SOCIOS(id)
);
CREATE TABLE CLASES(
    id BIGINT PRIMARY KEY
    ,nombre VARCHAR(30)
    ,fecha_inicio DATETIME
    ,cupo int
    ,id_sede BIGINT
    ,constraint foreign key(id_sede) references SEDES(id)
);
CREATE TABLE RESERVAS(
    id BIGINT PRIMARY KEY
    ,nombre VARCHAR(30)
    ,asistencia BOOLEAN
    ,id_socio int
    ,id_clase BIGINT
    ,constraint foreign key(id_socio) references SOCIOS(id)
    ,constraint foreign key(id_clase) references CLASES(id)
);
CREATE TABLE ESTADOS(
    id BIGINT PRIMARY KEY
    ,nombre VARCHAR(30)
    ,descripcion VARCHAR(120)
);
CREATE TABLE PLANES(
    id BIGINT PRIMARY KEY
    ,nombre VARCHAR(30)
    ,fecha_inicio DATETIME
    ,fecha_final DATETIME
    ,id_socio int
    ,estado BIGINT
    ,constraint foreign key(id_socio) references SOCIOS(id)
    ,constraint foreign key(id_estado) references ESTADOS(id)
);
CREATE TABLE SESIONES(
    id BIGINT PRIMARY KEY
    ,nombre VARCHAR(30)
    ,id_plan BIGINT
    ,constraint foreign key(id_plan) references PLANES(id)
);
CREATE TABLE CIRCUITOS(
    id BIGINT PRIMARY KEY
    ,nombre VARCHAR(30)
    ,id_sesion BIGINT
    ,constraint foreign key(id_sesion) references SESIONES(id)
);
CREATE TABLE EJERCICIOS(
    id BIGINT PRIMARY KEY
    ,nombre VARCHAR(30)
    ,descripcion VARCHAR(120)
    ,series INT
    ,repeticiones INT
    ,id_circuito BIGINT
    ,constraint foreign key(id_circuito) references CIRCUITOS(id)
);
CREATE TABLE REGISTROS(
    id BIGINT PRIMARY KEY
    ,descripcion VARCHAR(120)
    ,id_socio INT
    ,id_circuitos BIGINT
    ,constraint foreign key(id_socio) references SOCIOS(id)
    ,constraint foreign key(id_circuito) references CIRCUITOS(id)
);

