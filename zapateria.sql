CREATE DATABASE IF NOT EXISTS zapateria;
USE zapateria;

CREATE TABLE Rol (
    idRol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    login VARCHAR(50) NOT NULL UNIQUE,
    clave VARCHAR(255) NOT NULL,
    idRol INT,
    FOREIGN KEY (idRol) REFERENCES Rol(idRol) ON DELETE SET NULL
);

CREATE TABLE Producto (
    idProducto INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    color VARCHAR(30),
    talla VARCHAR(10),
    precio DECIMAL(10, 2) NOT NULL,
    cantidadDisponible INT DEFAULT 0
);

CREATE TABLE MovimientoInventario (
    idMovimiento INT AUTO_INCREMENT PRIMARY KEY,
    tipoMovimiento VARCHAR(50) NOT NULL,
    cantidad INT NOT NULL,
    fecha DATE NOT NULL,
    idUsuario INT,
    idProducto INT,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario) ON DELETE SET NULL,
    FOREIGN KEY (idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE
);

CREATE TABLE ReporteInventario (
    idReporte INT AUTO_INCREMENT PRIMARY KEY,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    tipoReporte VARCHAR(100) NOT NULL
);

INSERT INTO Rol (nombre) VALUES 
('Administrador'),
('empleado');

INSERT INTO Usuario (nombre, correo, login, clave, idRol) VALUES 
('Carlos Mendoza', 'carlos.mendoza@gmail.com', 'carlos', 'adm123', 1),
('Laura Gomez', 'laura.gomez@hotmail.com', 'laura', '12345', 2);

INSERT INTO Producto (marca, modelo, color, talla, precio, cantidadDisponible) VALUES 
('Nike', 'Air Max 90', 'Negro/Blanco', '40', 129.99, 50),
('Adidas', 'Ultraboost', 'Azul Marino', '42', 179.50, 30),
('Puma', 'Suede Classic', 'Rojo', '41', 75.00, 15),
('Under Armour', 'Charged', 'Gris', '39', 85.00, 0);

INSERT INTO MovimientoInventario (tipoMovimiento, cantidad, fecha, idUsuario, idProducto) VALUES 
('Entrada', 50, '2026-11-01', 1, 1),
('Entrada', 30, '2026-11-02', 2, 2),
('Entrada', 15, '2026-11-05', 2, 3),
('Salida', 5, '2026-11-10', 2, 1);

INSERT INTO ReporteInventario (fechaInicio, fechaFin, tipoReporte) VALUES 
('2026-11-01', '2026-11-15', 'Reporte General de Existencias'),
('2026-11-01', '2026-11-10', 'Reporte Diario de Movimientos');
