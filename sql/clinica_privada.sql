CREATE DATABASE IF NOT EXISTS clinica_privada;
USE clinica_privada;

-- 1. Tabla Especialidad
CREATE TABLE Especialidad (
    id_especialidad INT AUTO_INCREMENT PRIMARY KEY,
    nombre_especialidad VARCHAR(100) NOT NULL
);

-- 2. Tabla Paciente
CREATE TABLE Paciente (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    telefono VARCHAR(20),
    email VARCHAR(100),
    cobertura_medica VARCHAR(50),
    domicilio VARCHAR(150)
);

-- 3. Tabla Medico
CREATE TABLE Medico (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    matricula VARCHAR(50) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    id_especialidad INT NOT NULL,
    CONSTRAINT fk_medico_especialidad FOREIGN KEY (id_especialidad) REFERENCES Especialidad(id_especialidad)
);

-- 4. Tabla Consultorio
CREATE TABLE Consultorio (
    id_consultorio INT AUTO_INCREMENT PRIMARY KEY,
    numero INT NOT NULL,
    descripcion VARCHAR(100),
    id_especialidad INT,
    CONSTRAINT fk_consultorio_especialidad FOREIGN KEY (id_especialidad) REFERENCES Especialidad(id_especialidad)
);

-- 5. Tabla Turno
CREATE TABLE Turno (
    id_turno INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    estado VARCHAR(30) NOT NULL, -- 'Atendido', 'Cancelado', 'Reprogramado'
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    id_consultorio INT NOT NULL,
    CONSTRAINT fk_turno_paciente FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente),
    CONSTRAINT fk_turno_medico FOREIGN KEY (id_medico) REFERENCES Medico(id_medico),
    CONSTRAINT fk_turno_consultorio FOREIGN KEY (id_consultorio) REFERENCES Consultorio(id_consultorio)
);

-- 6. Tabla Consulta Medica
CREATE TABLE Consulta_Medica (
    id_consulta INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    diagnostico TEXT,
    tratamiento TEXT,
    observaciones TEXT,
    id_turno INT UNIQUE NOT NULL,
    CONSTRAINT fk_consulta_turno FOREIGN KEY (id_turno) REFERENCES Turno(id_turno)
);

-- 7. Tabla Estudio Solicitado
CREATE TABLE Estudio_Solicitado (
    id_estudio INT AUTO_INCREMENT PRIMARY KEY,
    nombre_estudio VARCHAR(100) NOT NULL,
    descripcion TEXT,
    id_consulta INT NOT NULL,
    CONSTRAINT fk_estudio_consulta FOREIGN KEY (id_consulta) REFERENCES Consulta_Medica(id_consulta)
);

-- ==========================================
-- GESTION DE USUARIOS Y PERMISOS (DCL)
-- ==========================================
-- Administrador General
CREATE USER 'admin_clinica'@'localhost' IDENTIFIED BY 'AdminClave2026*';
GRANT ALL PRIVILEGES ON clinica_privada.* TO 'admin_clinica'@'localhost' WITH GRANT OPTION;

-- Rol Medico
CREATE USER 'medico_user'@'localhost' IDENTIFIED BY 'MedicoClave2026$';
GRANT SELECT, INSERT, UPDATE ON clinica_privada.Consulta_Medica TO 'medico_user'@'localhost';
GRANT SELECT ON clinica_privada.Paciente TO 'medico_user'@'localhost';

-- Rol Recepcion
CREATE USER 'recepcion_user'@'localhost' IDENTIFIED BY 'RecepcionClave2026#';
GRANT SELECT, INSERT, UPDATE ON clinica_privada.Turno TO 'recepcion_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON clinica_privada.Paciente TO 'recepcion_user'@'localhost';

-- Rol Invitado / Paciente
CREATE USER 'paciente_user'@'%' IDENTIFIED BY 'PacienteClave2026!';
GRANT SELECT ON clinica_privada.Turno TO 'paciente_user'@'%';

FLUSH PRIVILEGES;
