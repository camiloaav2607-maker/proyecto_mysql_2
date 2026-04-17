
use proyecto_Gaseosas_del_Valle_SA;

-- funcion calcular iva

DELIMITER //

create function fn_calcular_total_con_iva(p_id_pedido INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

    DECLARE v_resultado DECIMAL(10,2) DEFAULT 0.00;
    SELECT IFNULL(sum(subtotal), 0) * 1.19 INTO v_resultado
    from detalle_pedidos
    where id_pedido = p_id_pedido;
    RETURN v_resultado;
    
END //

DELIMITER ;

-- funcion validar stock

DELIMITER //

create function fn_validar_stock(p_id_producto int, p_cantidad_solicitada int)
returns varchar(50)
deterministic
BEGIN
    DECLARE v_stock int default 0;
    declare v_mensaje varchar(50);

    select stock_actual into v_stock 
    from productos 
    where id_producto = p_id_producto;

    if v_stock >= p_cantidad_solicitada then
        set v_mensaje = 'stock disponible';
    else
        set v_mensaje = 'stock insuficiente';
    end if;

    return v_mensaje;
END //

DELIMITER ;


-- prueba stock

select fn_validar_stock(1, 50) as prueba_1;

select fn_validar_stock(1, 150) as prueba_2;

-- prueba iva

insert into detalle_pedidos (id_pedido, id_producto, cantidad, subtotal)
values (1, 1, 10, 35000.00);

select fn_calcular_total_con_iva(1) as total_con_iva;

