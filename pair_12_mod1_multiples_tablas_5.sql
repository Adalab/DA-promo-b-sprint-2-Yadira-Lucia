USE northwind;

-- Ejercicio 1
-- Extraed los pedidos con el máximo "order_date" para cada empleado.
-- Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. Para eso nos pide que lo hagamos con una query correlacionada.

SELECT o1.order_id, o1.customer_id, o1.employee_id, o1.order_date, o1.required_date
FROM orders AS o1
WHERE order_date >=
	(SELECT MAX(order_date) as maximo_pedido
	FROM orders AS o2
	WHERE o1.employee_id = o2.employee_id)

-- 2. Extraed el precio unitario (unit_price) de cada producto vendido.
-- Supongamos que ahora nuestro jefe quiere un informe de los productos más vendidos y su precio unitario. De nuevo lo tendréis que hacer con queries correlacionadas.




-- EJERCICIO 3. Ciudades que empiezan con "A" o "B".
-- Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquelas compañias que están afincadas en ciudades que empiezan por "A" o "B". 
-- Necesita que le devolvamos la ciudad, el nombre de la compañia y el nombre de contacto.

SELECT city, company_name, contact_name
FROM customers
WHERE city LIKE 'B%'
UNION 
SELECT city, company_name, contact_name
FROM customers
WHERE city LIKE 'A%'
ORDER BY city;

-- EJERCICIO 4. Número de pedidos que han hecho en las ciudades que empiezan con L.

SELECT city, company_name, contact_name AS persona_contacto, COUNT(customers.customer_id)
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.order_id
WHERE city LIKE 'L%'
GROUP BY customers.customer_id

-- EJERCICIO 5.






