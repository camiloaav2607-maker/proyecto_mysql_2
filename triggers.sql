use proyecto_Gaseosas_del_Valle_SA;

-- actualizar stock

DELIMITER //

CREATE TRIGGER tr_actualizar_stock
after insert on detalle_pedidos
for each row
begin
    update productos 
    set stock_actual = stock_actual - new.cantidad
    where id_producto = new.id_producto;
end //

DELIMITER ;

-- auditar cambio de precio

DELIMITER //

create trigger tr_auditar_cambio_precio
after update on productos
for each row
BEGIN
    if old.precio_producto <> new.precio_producto then
        INSERT INTO auditoria_precios (id_producto, precio_anterior, precio_nuevo, fecha_cambio)
        values (old.id_producto, old.precio_producto, new.precio_producto, now());
    end if;
END //

DELIMITER ;

-- prueba actualizar stock

select id_producto, stock_actual from productos where id_producto = 1;

insert into detalle_pedidos (id_pedido, id_producto, cantidad, subtotal)
values (1, 1, 20, 70000.00);

select id_producto, stock_actual from productos where id_producto = 1;

-- prueba auditar cambio de precio

update productos 
set precio_producto = 3800.00 
where id_producto = 1;

select * from auditoria_precios;

