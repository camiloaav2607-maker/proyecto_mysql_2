create database proyecto_Gaseosas_del_Valle_SA;
use proyecto_Gaseosas_del_Valle_SA;

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre_cliente VARCHAR(100) NOT NULL,
    identificacion VARCHAR(50) NOT NULL UNIQUE,
    telefono_cliente VARCHAR(50)
);

CREATE TABLE productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto VARCHAR(50) NOT NULL,
    precio_producto DECIMAL(10,2) NOT NULL,
    stock_actual INT NOT NULL,
    stock_minimo INT NOT NULL
);


CREATE TABLE sedes (
    id_sede INT PRIMARY KEY AUTO_INCREMENT,
    nombre_sede VARCHAR(50) NOT NULL,
    ubicacion_sede VARCHAR(100) NOT NULL
);

CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_sede INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    total_sin_iva DECIMAL(10,2),
    total_con_iva DECIMAL(10,2),
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_pedido_sede FOREIGN KEY (id_sede) REFERENCES sedes(id_sede)
);

CREATE TABLE auditoria_precios (
    id_auditoria INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT NOT NULL,
    precio_anterior DECIMAL(10,2),
    precio_nuevo DECIMAL(10,2),
    fecha_cambio DATETIME,
    CONSTRAINT fk_auditoria_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE detalle_pedidos (
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10,2),
    CONSTRAINT fk_detalle_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);


insert into clientes (nombre_cliente, identificacion, telefono_cliente) 
values ('camilo albarracin', '1098765432', '3001234567');

insert into sedes (nombre_sede, ubicacion_sede) 
values ('sede central giron', 'calle principal #10-20');

insert into productos (nombre_producto, precio_producto, stock_actual, stock_minimo) 
values 
('gaseosa cola 1.5l', 3500.00, 100, 10),
('gaseosa limon 1.5l', 3200.00, 80, 5),
('agua mineral 500ml', 1500.00, 200, 20);

insert into pedidos (id_cliente, id_sede, fecha_pedido, total_sin_iva, total_con_iva)
values (1, 1, curdate(), 0.00, 0.00);







