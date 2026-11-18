CREATE DATABASE IF NOT EXISTS zapateria;
USE zapateria;

CREATE TABLE rol (
    idRol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    login VARCHAR(50) NOT NULL UNIQUE,
    clave VARCHAR(255) NOT NULL,
    idRol INT NOT NULL,
    CONSTRAINT fk_usuario_rol FOREIGN KEY (idRol) REFERENCES rol(idRol)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE producto (
    idProducto INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    color VARCHAR(30),
    talla VARCHAR(20),
    precio DECIMAL(10, 2) NOT NULL,
    cantidadDisponible INT NOT NULL DEFAULT 0
);

CREATE TABLE movimiento_inventario (
    idMovimiento INT AUTO_INCREMENT PRIMARY KEY,
    tipoMovimiento VARCHAR(50) NOT NULL,
    cantidad INT NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    idUsuario INT NOT NULL,
    idProducto INT NOT NULL,
    CONSTRAINT fk_movimiento_usuario FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_movimiento_producto FOREIGN KEY (idProducto) REFERENCES producto(idProducto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

INSERT INTO rol (idRol, nombre) VALUES
(1, 'Administrador'),
(2, 'Empleado');

INSERT INTO usuario (nombre, correo, login, clave, idRol) VALUES
('Jose Carrillo', 'josecarrillo@gmail.com', 'jose', 'admin123', 1),
('Carlos Pérez', 'carlos.perez@hotmail.com', 'carlos', '12345', 2);

INSERT INTO producto (marca, modelo, color, talla, precio, cantidadDisponible) VALUES
('Nike', 'Air Force 1', 'Blanco', '38', 350000.00, 15),
('Adidas', 'Ultraboost', 'Negro', '37', 420000.00, 8),
('Puma', 'RS-X', 'Multicolor', '39', 290000.00, 12),
('Converse', 'Chuck Taylor', 'Rojo', '36', 220000.00, 20);

INSERT INTO movimiento_inventario (tipoMovimiento, cantidad, idUsuario, idProducto) VALUES
('Entrada', 15, 1, 1),
('Entrada', 8, 1, 2),
('Salida', 2, 2, 1);
