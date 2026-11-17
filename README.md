Sistema de Gestión de Inventario en la Zapatería Castillo Blanco en la ciudad de Bucaramanga, 2026.

### Objetivo general
Desarrollar un sistema web que facilite la gestión del inventario de la empresa Castillo Blanco, 
ubicada en la ciudad de Bucaramanga, durante el año 2026.

### Objetivos Específicos

- Identificar los requerimientos funcionales y no funcionales necesarios para desarrollar un sistema web sencillo,
eficiente y fácil de utilizar por los usuarios de la zapatería Castillo Blanco.

-Diseñar los módulos de gestión de inventario que permitan registrar, consultar, actualizar y eliminar la información de los productos, así como llevar un control organizado de las entradas y salidas de los productos.

-Implementar un sistema de autenticación utilizando Spring Boot y Spring Security para gestionar el acceso de los usuarios según sus perfiles, junto con Thymeleaf para desarrollar la interfaz web.

-Implementar una base de datos en MySQL e integrarla con la aplicación web mediante Spring Boot, utilizando el patrón Modelo-Vista-Controlador (MVC) para organizar la comunicación entre los datos y los módulos del sistema.

-Realizar pruebas de funcionamiento y validación del sistema para comprobar que cumpla con los requerimientos establecidos y permita gestionar correctamente el inventario de la zapatería.

### Justificación

El desarrollo de este proyecto surge de la necesidad de mejorar la gestión del inventario de la zapatería Castillo Blanco, ubicada en la ciudad de Bucaramanga, ya que actualmente presenta dificultades para llevar un control adecuado de los zapatos disponibles en bodega.

Por esta razón, se propone desarrollar un sistema web que permita organizar y almacenar la información de los productos, teniendo en cuenta características como el modelo, color, talla y cantidad disponible. Además, permitirá registrar las entradas y salidas de los productos, manteniendo actualizadas las existencias del inventario.

La implementación de este sistema beneficiará al administrador y a los empleados de la zapatería, ya que facilitará la consulta de los productos disponibles, reducirá los errores en el control de las existencias y permitirá mantener la información organizada.

De esta manera, se busca optimizar la administración del inventario, facilitar el acceso a la información y mejorar el control de los productos de la zapatería.

### Entorno de Trabajo
* **Lenguaje de programación:** Java
* **Entorno de desarrollo (IDE):** Spring boot(framework de frontend Thymeleaf)
* **Base de Datos:** MySQL
* **Control de versiones:** Github

## Requerimientos funcionales 

RF01 El sistema debe permitir iniciar sesión mediante un usuario y una contraseña.

RF02 El sistema debe permitir diferenciar los perfiles de administrador y empleado.

RF03 El administrador debe poder registrar nuevos usuarios en el sistema.

RF04 El administrador debe poder consultar, actualizar y eliminar usuarios registrados.

RF05 El administrador debe poder registrar nuevos productos, incluyendo marca, modelo, color, talla, precio y cantidad disponible.

RF06 El sistema debe permitir consultar el inventario de productos registrados. 

RF07 El administrador debe poder actualizar la información de los productos.

RF08 El administrador debe poder eliminar productos que no tengan movimientos de inventario asociados.

RF09 El empleado debe poder consultar los productos disponibles en el inventario.

RF10 El empleado debe poder buscar productos por marca, modelo, color o talla.

RF11 El sistema debe permitir registrar las entradas de productos al inventario.

RF12 El sistema debe permitir registrar las salidas de productos del inventario.

RF13 El sistema debe actualizar automáticamente las existencias después de registrar una entrada o salida. 

RF14 El sistema debe permitir consultar el historial de movimientos del inventario. 

RF15 El administrador debe poder generar reportes sobre las existencias y los movimientos del inventario. 

RF16 El sistema debe permitir cerrar sesión de forma segura. 

## Requerimientos no funcionales

RNF01 El sistema debe contar con una interfaz sencilla e intuitiva para facilitar su utilización por parte del administrador y los empleados.

RNF02 El sistema debe desarrollarse utilizando Spring Boot como tecnología principal para el backend.

RNF03 El sistema debe utilizar Thymeleaf para la creación y visualización de las páginas web.

RNF04 El sistema debe utilizar MySQL para almacenar y administrar la información. 

RNF05 El sistema debe implementar Spring Security para proteger el acceso mediante usuario y contraseña.

RNF06 Las contraseñas de los usuarios deben almacenarse de forma segura mediante funciones de hash, evitando guardar las claves en texto plano.

RNF07 El sistema debe restringir el acceso a las funciones según el perfil del usuario, administrador o empleado. 

RNF08 El sistema debe funcionar correctamente en navegadores web modernos como Google Chrome y Microsoft Edge. 

RNF09 El sistema debe mantener la integridad y consistencia de la información almacenada en la base de datos. 

RNF10 El sistema debe responder adecuadamente a las operaciones de consulta, registro, actualización y eliminación de información.

RNF11 El sistema debe visualizarse correctamente en computadores de escritorio y portátiles. 

RNF12 El sistema debe validar los datos ingresados por los usuarios para evitar registros incompletos o incorrectos. 

## Diagrama de clase 

<img width="1170" height="464" alt="image" src="https://github.com/user-attachments/assets/1b636402-5ba3-493e-9f83-37e243e6b762" />

## Diagrama de caso de uso










## Base de Datos
CREATE DATABASE IF NOT EXISTS zapateria
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE zapateria;

CREATE TABLE rol (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    login VARCHAR(50) NOT NULL UNIQUE,
    clave VARCHAR(255) NOT NULL,
    id_rol INT NOT NULL,
    CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol) 
        REFERENCES rol(id_rol) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    color VARCHAR(30) NOT NULL,
    talla INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE movimiento_inventario (
    id_movimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_usuario INT NOT NULL,
    tipo_movimiento VARCHAR(20) NOT NULL,
    cantidad INT NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_movimiento_producto FOREIGN KEY (id_producto) 
        REFERENCES producto(id_producto) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT,
    CONSTRAINT fk_movimiento_usuario FOREIGN KEY (id_usuario) 
        REFERENCES usuario(id_usuario) 
        ON UPDATE CASCADE 
        ON DELETE RESTRICT
) ENGINE=InnoDB;

INSERT INTO rol (nombre_rol) VALUES 
('Administrador'),
('Empleado');

INSERT INTO usuario (nombre, correo, login, clave, id_rol) VALUES 
('Carlos Mendoza', 'carlos.mendoza@gmail.com', 'Carlos', 'admin123', 1),
('Laura Gómez', 'laura.gomez@hotmail.com', 'Laura', 'empleado', 2);

INSERT INTO producto (marca, modelo, color, talla, cantidad) VALUES 
('Nike', 'Air Force 1', 'Blanco', 40, 25),
('Adidas', 'Ultraboost', 'Negro', 42, 15),
('Vans', 'Old Skool', 'Azul Marino', 38, 30),
('Converse', 'Chuck Taylor', 'Rojo', 39, 18);

INSERT INTO movimiento_inventario (id_producto, id_usuario, tipo_movimiento, cantidad, fecha) VALUES 
(1, 2, 'Entrada', 10, '2026-11-15 09:30:00'),
(2, 2, 'Salida', 2, '2026-11-16 14:15:00'),
(3, 1, 'Entrada', 15, '2026-11-16 16:45:00'),
(1, 2, 'Salida', 1, '2026-11-17 10:05:00');
