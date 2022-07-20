USE northwing;

#EJERCICIO 1: Relación entre número de pedidos y máxima carga:
SELECT employee_id, COUNT(order_id), MAX(freight)
FROM orders
GROUP BY employee_id;

#EJERCICIO 2: Descartar pedidos sin fecha y ordénalos:
SELECT employee_id, COUNT(order_id), MAX(freight)
FROM orders
WHERE shipped_date != 0000-00-00
GROUP BY employee_id
ORDER BY employee_id;

#EJERCICIO 3:Números de pedidos por día:
 SELECT YEAR (order_date) AS año,MONTH(order_date)AS mes, DAY (order_date) AS dia, COUNT(order_id)
 FROM orders
 GROUP BY (order_date);
 
#EJERCICIO 4: Número de pedidos por mes y año:
 SELECT MONTH(order_date), COUNT(order_id)
 FROM orders
 GROUP BY MONTH (order_date)
 ORDER BY MONTH(order_date);

#EJERCICIO 5:Seleccionad las ciudades con 4 o más empleadas:
SELECT city, COUNT(employee_id)
FROM employees
GROUP BY city
HAVING COUNT(employee_id) >=4;

#EJERCICIO 6: Cread una nueva columna basándonos en la cantidad monetaria:
SELECT unit_price*quantity AS CantidadMonetaria, order_id,
CASE 
	WHEN unit_price*quantity >200 THEN "Alto" #Se modificó a 200 porque son cantidades bajas
    ELSE "Bajo"
    END AS RangoPrecio
FROM order_details
ORDER BY CantidadMonetaria;
