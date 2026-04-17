use proyecto_Gaseosas_del_Valle_SA;

-- 1. productos con stock por debajo del mínimo
select * 
from productos 
where stock_actual < stock_minimo;

-- 2. pedidos realizados entre dos fechas
select * 
from pedidos 
where fecha_pedido 
between '2026-01-01' and '2026-12-31';

-- 3. productos más vendidos (con join y group by)
select pr.nombre_producto, sum(dp.cantidad) as total_vendido
from productos pr
join detalle_pedidos dp on pr.id_producto = dp.id_producto
group by pr.nombre_producto
order by total_vendido desc;

-- 4. mostrar clientes y cantidad de pedidos
select c.nombre_cliente, count(p.id_pedido) as numero_pedidos
from clientes c
left join pedidos p on c.id_cliente = p.id_cliente
group by c.id_cliente;

-- 5. buscar clientes por nombre parcial
select * 
from clientes 
where nombre_cliente like '%cami%';

-- 6. consultar productos de ciertas categorías
select * 
from productos 
where nombre_producto in ('gaseosa cola 1.5l', 'gaseosa limon 1.5l');

-- 7. cliente con mayor número de pedidos 
select nombre_cliente 
from clientes 
where id_cliente = (
    select id_cliente 
    from pedidos 
    group by id_cliente 
    order by count(*) desc limit 1
);

-- 8. pedidos y totales agrupados por sede
select s.nombre_sede, sum(p.total_con_iva) as gran_total
from sedes s
join pedidos p on s.id_sede = p.id_sede
group by s.nombre_sede;



-- vistas

-- 1. vista resumen pedidos por sede
create view vista_resumen_pedidos_por_sede as
select s.nombre_sede, count(p.id_pedido) as total_pedidos, sum(p.total_con_iva) as ventas_totales
from sedes s
left join pedidos p on s.id_sede = p.id_sede
group by s.nombre_sede;

-- 2. vista_productos_bajo_stock
create view vista_productos_bajo_stock as
select nombre_producto, stock_actual, stock_minimo
from productos
where stock_actual <= stock_minimo;

-- 3. vista_clientes_activos
create view vista_clientes_activos as
select distinct c.id_cliente, c.nombre_cliente, c.identificacion
from clientes c
inner join pedidos p on c.id_cliente = p.id_cliente;




