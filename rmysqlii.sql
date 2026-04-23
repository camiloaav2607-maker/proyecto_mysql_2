1. Función verificar_stock_producto
Esta función es más completa que la anterior porque maneja excepciones (productos que no existen).

Paso a paso:

Declaramos una variable para el stock.

Usamos un SELECT ... INTO para guardar el stock del producto.

Usamos un bloque IF para comparar los valores.

SQL

DELIMITER //

CREATE FUNCTION verificar_stock_producto(p_id_producto INT, p_cantidad INT) 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE v_stock INT;
    
    -- Intentamos obtener el stock
    SELECT stock_actual INTO v_stock 
    FROM productos 
    WHERE id_producto = p_id_producto;

    -- Manejo de nulos o inexistentes
    IF v_stock IS NULL THEN
        RETURN 'Producto no encontrado';
    ELSEIF v_stock >= p_cantidad THEN
        RETURN 'Suficiente';
    ELSE
        RETURN 'Insuficiente';
    END IF;
END //

DELIMITER ;
2. Vista vista_productos_bajo_stock
Aquí aplicamos un JOIN para traer la información de la sede. Como tu tabla productos tiene el id_sede, la relación es directa.

SQL

CREATE VIEW vista_productos_bajo_stock AS
SELECT 
    p.nombre_producto, 
    p.stock_actual, 
    s.nombre_sede
FROM productos p
JOIN sedes s ON p.id_sede = s.id_sede
WHERE p.stock_actual <= 10;
3. Consulta Avanzada: Clientes con gasto superior al promedio
Esta es la parte "pro" del examen. Requiere una subconsulta para calcular el promedio global y luego filtrar.

Explicación:

Agrupación: Sumamos el total por cliente.

HAVING: Filtramos el grupo después de sumar.

Subconsulta: Calculamos el promedio de todos los pedidos registrados.

SQL

SELECT 
    c.nombre_cliente, 
    SUM(p.total_con_iva) AS total_gastado
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente
HAVING total_gastado > (SELECT AVG(total_con_iva) FROM pedidos)
ORDER BY total_gastado DESC;
4. Trigger control_stock_negativo
Este es un trigger tipo BEFORE (antes de). Su función es actuar como un guardaespaldas: si no hay stock, cancela la operación antes de que toque la tabla.

SQL

DELIMITER //

CREATE TRIGGER control_stock_negativo
BEFORE INSERT ON detalle_pedidos
FOR EACH ROW
BEGIN
    DECLARE v_stock_disponible INT;

    -- Obtenemos el stock actual del producto que se intenta vender
    SELECT stock_actual INTO v_stock_disponible 
    FROM productos 
    WHERE id_producto = NEW.id_producto;

    -- Si la cantidad pedida es mayor a lo que hay, lanzamos error
    IF NEW.cantidad > v_stock_disponible THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Stock insuficiente para procesar el pedido';
    END IF;
END //

DELIMITER ;
📖 Guía rápida para tu README (Cómo probarlo)
Para que tu entrega sea de 10, añade estas instrucciones de prueba:

Probar la Función:
SELECT verificar_stock_producto(1, 500);
(Debería decir 'Insuficiente' si pides más de lo que hay).

Probar la Vista:
SELECT * FROM vista_productos_bajo_stock;
(Verás los productos que están en riesgo de agotarse).

Probar el Trigger:
Intenta insertar una cantidad exagerada en detalle_pedidos:

SQL

INSERT INTO detalle_pedidos (id_pedido, id_producto, cantidad, subtotal) 
VALUES (1, 1, 9999, 100000);
(DBeaver debería mostrarte el error personalizado: 'Stock insuficiente...').
