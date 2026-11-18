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
<img width="861" height="538" alt="diagrama de clase " src="https://github.com/user-attachments/assets/8849f6de-ab1e-422d-80d6-257776cd3e9f" />
## Diagrama de caso de uso
<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/e745405c-a089-407f-967b-9b896521c24d" />

## Base de Datos

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
