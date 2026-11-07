Sistema de Gestión de Inventario y Ventas de la Zapatería Castillo Blanco en la ciudad de Bucaramanga, 2026.

### Objetivo general
Desarrollar un sistema web que facilite la gestión del inventario y las ventas de la empresa Castillo Blanco, 
ubicada en la ciudad de Bucaramanga, durante el año 2026.

### Objetivos Específicos

- Identificar los requerimientos funcionales y no funcionales necesarios para desarrollar un sistema web sencillo,
eficiente y fácil de utilizar por los usuarios de la zapatería Castillo Blanco.

-Diseñar los módulos de gestión de inventario y ventas que permitan registrar, consultar, actualizar y eliminar la información 
de los productos, así como llevar un control organizado de las existencias y las ventas realizadas en la zapatería.

-Aplicar la sección de inicio utilizando Spring Boot para el backend, Spring Security para la autenticación y 
seguridad de los usuarios, y Thymeleaf para la interfaz web, con el fin de proteger el acceso al sistema.

-Implementar una base de datos en MySQL e integrar la aplicación web mediante Spring Boot, utilizando el patrón Modelo-Vista-
Controlador (MVC) para organizar la gestión comunicación de los datos entre la base de datos  y los módulos del sistema.

-Realizar pruebas de funcionamiento y validación del sistema para comprobar que cumpla con los requerimientos establecidos 
y permita gestionar correctamente el inventario y las ventas.

### Justificación
El desarrollo de este proyecto surge de la necesidad de mejorar la gestión del inventario y las ventas de la zapatería 
Castillo Blanco, ubicada en la ciudad de Bucaramanga, ya que actualmente presenta dificultades para llevar un control 
adecuado de los zapatos disponibles en bodega y de las ventas realizadas.

Por esta razón, se propone desarrollar un sistema web que permita organizar y almacenar la información de los productos, 
teniendo en cuenta características como el modelo, color, talla y cantidad disponible. Además, permitirá registrar las ventas
realizadas por los vendedores y actualizar automáticamente las existencias del inventario.

La implementación de este sistema beneficiará al administrador y a los vendedores, ya que facilitará la consulta de los 
productos disponibles, reducirá los errores en el control de las existencias y permitirá mantener un registro organizado 
de las ventas.

De esta manera, se busca optimizar los procesos de administración de la zapatería, facilitar el acceso a la información y 
mejorar el control de sus actividades comerciales.

### Entorno de Trabajo
* **Lenguaje de programación:** Java
* **Entorno de desarrollo (IDE):** Spring boot(framework de frontend Thymeleaf)
* **Base de Datos:** MySQL
* **Control de versiones:** Github

## Requerimientos funcionales 
RF01	El sistema debe permitir iniciar sesión mediante un usuario y una contraseña.
RF02	El sistema debe permitir diferenciar los perfiles de administrador y vendedor.
RF03	El administrador debe poder registrar nuevos usuarios en el sistema.
RF04	El administrador debe poder consultar, actualizar y eliminar usuarios registrados.
RF05	El administrador debe poder registrar nuevos productos, incluyendo modelo, color, talla, precio y cantidad disponible.
RF06	El administrador debe poder consultar el inventario de productos registrados.
RF07	El administrador debe poder actualizar la información de los productos.
RF08	El administrador debe poder eliminar productos del inventario, siempre que no existan restricciones por ventas
registradas.
RF09	El vendedor debe poder consultar los productos disponibles en el inventario.
RF10	El vendedor debe poder buscar productos por modelo, color o talla.
RF11	El vendedor debe poder registrar las ventas realizadas a los clientes.
RF12	El sistema debe calcular automáticamente el total de cada venta según los productos y las cantidades seleccionadas.
RF13	El sistema debe actualizar automáticamente las existencias del inventario después de registrar una venta.
RF14	El administrador debe poder consultar el historial de todas las ventas realizadas.
RF15	El vendedor debe poder consultar las ventas que ha registrado.
RF16	El administrador debe poder generar reportes sobre el inventario y las ventas realizadas.
RF17	El sistema debe permitir cerrar sesión de forma segura.

## Requerimientos no funcionales
Los requerimientos no funcionales describen cómo debe funcionar el sistema, teniendo en cuenta aspectos como seguridad, rendimiento, facilidad de uso y disponibilidad.
Código	Requerimiento no funcional
RNF01	El sistema debe contar con una interfaz sencilla e intuitiva para facilitar su utilización por parte del administrador y los vendedores.
RNF02	El sistema debe desarrollarse utilizando Spring Boot como tecnología principal para el backend.
RNF03	El sistema debe utilizar Thymeleaf para la creación y visualización de las páginas web.
RNF04	El sistema debe utilizar MySQL para almacenar y administrar la información.
RNF05	El sistema debe implementar Spring Security para proteger el acceso mediante usuario y contraseña.
RNF06	Las contraseñas de los usuarios deben almacenarse de forma segura mediante técnicas de cifrado o hash.
RNF07	El sistema debe restringir el acceso a las funciones según el perfil del usuario, administrador o vendedor.
RNF08	El sistema debe funcionar correctamente en navegadores web modernos como Google Chrome y Microsoft Edge.
RNF09	El sistema debe mantener la integridad y consistencia de la información almacenada en la base de datos.
RNF10	El sistema debe responder de manera adecuada a las operaciones de consulta, registro, actualización y eliminación de información.
RNF11	El sistema debe permitir visualizarse correctamente en computadores de escritorio y portátiles.
RNF12	El sistema debe validar los datos ingresados por los usuarios para evitar registros incompletos o incorrectos.

## 4. Base de Datos
CREATE DATABASE zapateria;
CREATE TABLE rol (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    login VARCHAR(50) NOT NULL UNIQUE,
    clave VARCHAR(255) NOT NULL,
    id_rol INT NOT NULL,

    FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
) ENGINE=InnoDB;

CREATE TABLE producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    modelo VARCHAR(100) NOT NULL,
    color VARCHAR(50) NOT NULL,
    talla INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    cantidad INT NOT NULL DEFAULT 0,
    CHECK (precio >= 0),
    CHECK (cantidad >= 0)
) ENGINE=InnoDB;

CREATE TABLE venta (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(12,2) NOT NULL,
    id_usuario INT NOT NULL,

    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
) ENGINE=InnoDB;

CREATE TABLE detalle_venta (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,

    FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),

    CHECK (cantidad > 0),
    CHECK (precio_unitario >= 0),
    CHECK (subtotal >= 0)
) ENGINE=InnoDB;

INSERT INTO rol (nombre) VALUES
('Administrador'),
('Vendedor');

INSERT INTO producto (modelo, color, talla, precio, cantidad) VALUES
('Deportivo', 'Negro', 38, 120000, 10),
('Casual', 'Blanco', 39, 95000, 15),
('Formal', 'Café', 40, 150000, 8);
