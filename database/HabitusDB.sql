DROP DATABASE IF EXISTS HabitusDB;
CREATE DATABASE HabitusDB;
USE HabitusDB;

CREATE TABLE Cat_Paises (
    id_pais INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    codigo_iso VARCHAR(2) NOT NULL UNIQUE
);

CREATE TABLE Cat_Objetivos (
    id_objetivo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT NULL
);

CREATE TABLE Cat_Tipos_Dieta (
    id_tipo_dieta INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT NULL
);

CREATE TABLE Cat_Equipos (
    id_equipo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Cat_Tipos_Notificacion (
    id_tipo_notificacion INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    mensaje_predeterminado VARCHAR(255) NOT NULL
);

CREATE TABLE Cat_Alergias_Alimentarias (
    id_alergia INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE Cat_Enfermedades (
    id_enfermedad INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE Cat_Limitaciones_Fisicas (
    id_limitacion INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE Cat_Grupos_Musculares (
    id_grupo_muscular INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Cat_Ejercicios (
    id_ejercicio INT PRIMARY KEY AUTO_INCREMENT,
    id_grupo_muscular INT NULL,
    id_equipo_requerido INT NULL,
    nombre VARCHAR(150) NOT NULL UNIQUE,
    descripcion TEXT NULL,
    url_video_demostracion VARCHAR(255) NULL,
    FOREIGN KEY (id_grupo_muscular) REFERENCES Cat_Grupos_Musculares(id_grupo_muscular) ON DELETE SET NULL,
    FOREIGN KEY (id_equipo_requerido) REFERENCES Cat_Equipos(id_equipo) ON DELETE SET NULL
);

CREATE TABLE Cat_Ingredientes (
    id_ingrediente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE Cat_Recetas (
    id_receta INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL UNIQUE,
    descripcion TEXT NULL,
    instrucciones TEXT NOT NULL,
    calorias_aproximadas INT NULL,
    tiempo_preparacion_min INT NULL
);

CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    id_pais INT NULL,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    genero ENUM('Masculino', 'Femenino', 'Otro', 'Prefiero no decirlo') NULL,
    fecha_nacimiento DATE NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pais) REFERENCES Cat_Paises(id_pais) ON DELETE SET NULL
);

CREATE TABLE Perfiles_Salud (
    id_perfil_salud INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_objetivo INT NULL,
    altura_cm DECIMAL(5, 2) NULL,
    peso_kg DECIMAL(5, 2) NULL,
    nivel_actividad ENUM('Sedentario', 'Ligero', 'Moderado', 'Activo', 'Muy Activo') NULL,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_objetivo) REFERENCES Cat_Objetivos(id_objetivo) ON DELETE SET NULL
);

CREATE TABLE Preferencias (
    id_preferencia INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_tipo_dieta INT NULL,
    objetivo_calorias_diarias INT NULL,
    recordatorio_comer TIME NULL,
    tiempo_sesion_ejercicio_min INT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_tipo_dieta) REFERENCES Cat_Tipos_Dieta(id_tipo_dieta) ON DELETE SET NULL
);

CREATE TABLE Notificaciones (
    id_notificacion INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_tipo_notificacion INT NOT NULL,
    horario TIME NOT NULL,
    habilitada TINYINT(1) DEFAULT 1,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_tipo_notificacion) REFERENCES Cat_Tipos_Notificacion(id_tipo_notificacion) ON DELETE CASCADE
);

CREATE TABLE Receta_Ingredientes (
    id_receta INT NOT NULL,
    id_ingrediente INT NOT NULL,
    cantidad VARCHAR(50) NULL,
    PRIMARY KEY (id_receta, id_ingrediente),
    FOREIGN KEY (id_receta) REFERENCES Cat_Recetas(id_receta) ON DELETE CASCADE,
    FOREIGN KEY (id_ingrediente) REFERENCES Cat_Ingredientes(id_ingrediente) ON DELETE CASCADE
);

CREATE TABLE Usuario_Alergias (
    id_usuario INT NOT NULL,
    id_alergia INT NOT NULL,
    PRIMARY KEY (id_usuario, id_alergia),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_alergia) REFERENCES Cat_Alergias_Alimentarias(id_alergia) ON DELETE CASCADE
);

CREATE TABLE Usuario_Enfermedades (
    id_usuario INT NOT NULL,
    id_enfermedad INT NOT NULL,
    PRIMARY KEY (id_usuario, id_enfermedad),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_enfermedad) REFERENCES Cat_Enfermedades(id_enfermedad) ON DELETE CASCADE
);

CREATE TABLE Usuario_Limitaciones (
    id_usuario INT NOT NULL,
    id_limitacion INT NOT NULL,
    PRIMARY KEY (id_usuario, id_limitacion),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_limitacion) REFERENCES Cat_Limitaciones_Fisicas(id_limitacion) ON DELETE CASCADE
);

CREATE TABLE Usuario_Equipos (
    id_usuario INT NOT NULL,
    id_equipo INT NOT NULL,
    PRIMARY KEY (id_usuario, id_equipo),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_equipo) REFERENCES Cat_Equipos(id_equipo) ON DELETE CASCADE
);

CREATE TABLE Usuario_Dias_Disponibles (
    id_usuario INT NOT NULL,
    dia_semana TINYINT NOT NULL CHECK (dia_semana BETWEEN 1 AND 7),
    PRIMARY KEY (id_usuario, dia_semana),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE Usuario_Ejercicios_Preferidos (
    id_usuario INT NOT NULL,
    id_ejercicio INT NOT NULL,
    PRIMARY KEY (id_usuario, id_ejercicio),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_ejercicio) REFERENCES Cat_Ejercicios(id_ejercicio) ON DELETE CASCADE
);