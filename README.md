📝 Descripción del Proyecto
El sistema "Gaseosas del Valle S.A." es una solución integral de base de datos relacional diseñada para automatizar y optimizar el ciclo comercial de una empresa distribuidora de bebidas.

Este proyecto no solo se limita al almacenamiento de datos, sino que implementa inteligencia de negocio a nivel de servidor mediante el uso de objetos programados (funciones, triggers y vistas) para garantizar la integridad y eficiencia operativa.

🎯 Objetivos Principales
Control de Inventario Automatizado: Gracias a los disparadores (triggers), el stock de productos se actualiza en tiempo real con cada venta, eliminando errores manuales de conteo.

Gestión Financiera Precisa: Implementación de funciones personalizadas para el cálculo automático de impuestos (IVA 19%) sobre los pedidos registrados.

Auditoría y Seguridad: Registro histórico de cualquier cambio en los precios de los productos, permitiendo un seguimiento transparente de las modificaciones de costos en el tiempo.

Análisis de Datos: Disponibilidad de vistas analíticas para identificar rápidamente productos críticos (bajo stock), clientes recurrentes y rendimiento de ventas por sede física.

📋 Modelo Entidad relacion

<img width="1243" height="655" alt="diagrama_ER" src="https://github.com/user-attachments/assets/98cb0f2e-3c1e-4846-8831-cf406eae05d0" />

⚙️ Explicación de Lógica Programada
1. Funciones Personalizadas (UDF)
Las funciones son bloques de código reutilizables que devuelven un valor específico tras procesar los datos.

fn_calcular_total_con_iva(id_pedido):

Propósito: Automatizar el cálculo tributario de cada venta.

Funcionamiento: Recibe el identificador de un pedido, suma todos los campos subtotal de la tabla detalle_pedidos asociados a ese ID y multiplica el resultado por 1.19 (correspondiente al 19% de IVA).

fn_validar_stock(id_producto, cantidad):

Propósito: Actuar como filtro de seguridad preventivo.

Funcionamiento: Consulta la columna stock_actual en la tabla productos. Si la cantidad solicitada es menor o igual a la existencia, devuelve el mensaje 'stock disponible'; de lo contrario, alerta con 'stock insuficiente'.

2. Disparadores (Triggers)
Los triggers son eventos automáticos que reaccionan ante cambios (INSERT o UPDATE) en las tablas para mantener la integridad de la base de datos.

tr_actualizar_stock:

Evento: Se ejecuta DESPUÉS (AFTER) de insertar un nuevo registro en la tabla detalle_pedidos.

Acción: Toma la cantidad vendida del nuevo registro (NEW.cantidad) y la resta automáticamente de la columna stock_actual del producto correspondiente en la tabla productos. Esto garantiza que el inventario siempre sea real.

tr_auditar_cambio_precio:

Evento: Se ejecuta DESPUÉS (AFTER) de actualizar el campo precio_producto en la tabla productos.

Acción: Compara si el precio nuevo es distinto al anterior. Si hay un cambio, inserta una fila en la tabla auditoria_precios guardando el ID del producto, el precio viejo, el precio nuevo y la fecha/hora exacta del movimiento (NOW()).

3. Procedimientos Almacenados (Stored Procedures)
A diferencia de las funciones, los procedimientos ejecutan una serie de acciones complejas en la base de datos.

sp_registrar_producto: Simplifica la inserción de nuevos artículos asegurando que todos los campos obligatorios (nombre, precio, stock y stock mínimo) sean proporcionados correctamente.

sp_finalizar_pedido: Es el cerebro del cierre de venta. Suma los detalles, invoca la función de IVA y actualiza los campos total_sin_iva, total_con_iva y el estado_pedido en la tabla principal de pedidos de una sola vez.

📸 Ejemplos de consultas y capturas de resultados

<img width="1918" height="1198" alt="vista_3" src="https://github.com/user-attachments/assets/b9b8a30d-07d4-4f8a-b01f-1c481c4bb579" />
<img width="1918" height="1198" alt="vista_2" src="https://github.com/user-attachments/assets/cfe2b8ee-26af-49ee-b923-46b60908f4ec" />
<img width="1918" height="1198" alt="vista_1" src="https://github.com/user-attachments/assets/e266b5f5-ade4-449e-9c44-b85f20269e3d" />
<img width="1918" height="1141" alt="prueba2_funcion_stock" src="https://github.com/user-attachments/assets/32b71e04-5e0f-4c75-9a2c-02f89e722b10" />
<img width="1918" height="1198" alt="prueba1_funcion_stock" src="https://github.com/user-attachments/assets/15592eb6-b190-449b-b67c-7e3fee81d1fd" />
<img width="1918" height="1138" alt="prueba_trigger_auditar_cambio_de_precio" src="https://github.com/user-attachments/assets/63bad434-b494-42f3-bb6e-8e7f35abe40d" />
<img width="1918" height="1145" alt="prueba_trigger_actualizar_stock" src="https://github.com/user-attachments/assets/def1b57e-1d30-4165-ab6d-b2bd353afa69" />
<img width="1918" height="1198" alt="prueba_funcion_iva" src="https://github.com/user-attachments/assets/e14f132f-af00-41fa-934f-56e02e3cb86e" />
<img width="1918" height="1198" alt="consulta_8" src="https://github.com/user-attachments/assets/ca65086a-733c-428f-9427-7a137f520804" />
<img width="1918" height="1198" alt="consulta_7" src="https://github.com/user-attachments/assets/7925b90e-af69-457f-8e4a-b7e22487cac7" />
<img width="1918" height="1198" alt="consulta_6" src="https://github.com/user-attachments/assets/0f849908-e9ec-4cea-bcf2-17e6d5a467e8" />
<img width="1918" height="1198" alt="consulta_5" src="https://github.com/user-attachments/assets/d90979f7-d303-4eb8-a02b-2b554c92a183" />
<img width="1918" height="1198" alt="consulta_4" src="https://github.com/user-attachments/assets/6658ebc4-036d-46d9-a4ba-e923940827d8" />
<img width="1912" height="1198" alt="consulta_3" src="https://github.com/user-attachments/assets/73b93cac-32dd-45ce-9e02-4f018c83bcf0" />
<img width="1918" height="1198" alt="consulta_2" src="https://github.com/user-attachments/assets/e451339e-3dce-4aef-9ffb-3459388d0d67" />
<img width="1918" height="1135" alt="consulta_1" src="https://github.com/user-attachments/assets/54662189-671a-4529-9c9b-1938222685fc" />

🚀 Recomendaciones para la Expansión Futura
Para escalar el sistema de Gaseosas del Valle S.A. y convertirlo en un ERP (Enterprise Resource Planning) completo, se sugieren las siguientes mejoras:

1. Módulo de Proveedores y Compras
Implementación: Crear tablas de proveedores y ordenes_compra.

Beneficio: Permitir que cuando el stock_actual llegue al stock_minimo, el sistema genere automáticamente una alerta o una orden de compra sugerida para reponer inventario.

2. Gestión de Usuarios y Permisos (RBAC)
Implementación: Crear una tabla de usuarios con roles definidos (Vendedor, Administrador, Auditor).

Beneficio: Restringir el acceso para que, por ejemplo, solo el 'Administrador' pueda usar el sp_registrar_producto o modificar precios, garantizando que el trigger de auditoría no sea manipulado.

3. Integración de Facturación Electrónica
Implementación: Agregar campos para el código CUFE y generación de archivos JSON/XML.

Beneficio: Cumplir con las normativas legales vigentes y permitir que el sp_finalizar_pedido se conecte con un servicio externo de validación tributaria.

4. Dashboard de Analítica de Datos
Implementación: Conectar las vistas (vista_resumen_pedidos_por_sede) a una herramienta de visualización como Power BI o Tableau.

Beneficio: Visualizar en tiempo real cuáles son las sedes con mayor rendimiento y qué productos tienen baja rotación para crear estrategias de marketing.

5. Módulo de Logística y Rutas
Implementación: Agregar tablas para vehiculos y repartidores.

Beneficio: Hacer seguimiento al estado de entrega de los pedidos (Despachado, En Ruta, Entregado) desde la misma base de datos.

6. Histórico de Precios de Venta
Implementación: Crear un disparador que guarde no solo el cambio de precio en el catálogo, sino una tabla de "precios históricos por temporada".

Beneficio: Realizar análisis comparativos de cómo ha afectado la inflación o la demanda al precio de las gaseosas en los últimos años.






