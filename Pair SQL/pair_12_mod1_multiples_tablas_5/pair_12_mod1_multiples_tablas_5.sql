USE northwind;

-- Ejercicio 1
-- Extraed los pedidos con el máximo "order_date" para cada empleado.
-- Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. Para eso nos pide que lo hagamos con una query correlacionada.
#Sin Group
SELECT o1.order_id, o1.customer_id, o1.employee_id, o1.order_date, o1.required_date
FROM orders AS o1
WHERE order_date >=
	(SELECT MAX(order_date) as maximo_pedido
	FROM orders AS o2
	WHERE o1.employee_id = o2.employee_id);
    
#Con Group
SELECT order_id, customer_id, employee_id, order_date, required_date
FROM orders AS ord1
WHERE ord1.order_date = (
	SELECT MAX(ord2.order_date)
    FROM orders AS ord2
    WHERE ord1.employee_id = ord2.employee_id
    GROUP BY ord2.employee_id)
ORDER BY ord1.order_date;
    

-- 2. Extraed el precio unitario (unit_price) de cada producto vendido.
-- Supongamos que ahora nuestro jefe quiere un informe de los productos más vendidos y su precio unitario. De nuevo lo tendréis que hacer con queries correlacionadas.

SELECT product_id, unit_price
FROM products
WHERE product_id IN (
	SELECT product_id
	FROM order_details
	GROUP BY product_id
	HAVING SUM(quantity) > 0);

-- EJERCICIO 3. Ciudades que empiezan con "A" o "B".
-- Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquelas compañias que están afincadas en ciudades que empiezan por "A" o "B". 
-- Necesita que le devolvamos la ciudad, el nombre de la compañia y el nombre de contacto.
SELECT city, company_name, contact_name
FROM customers
WHERE city LIKE 'B%' OR city LIKE 'A%';

-- EJERCICIO 4. Número de pedidos que han hecho en las ciudades que empiezan con L.
SELECT city, company_name, contact_name AS persona_contacto, COUNT(customers.customer_id)
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.order_id
WHERE city LIKE 'L%'
GROUP BY customers.customer_id;

/* EJERCICIO 5: Todos los clientes cuyo "contact_title" no incluya "Sales".
Nuestro objetivo es extraer los clientes que no tienen el contacto 
"Sales" en su "contact_title". Extraer el nombre de contacto, 
su posisión (contact_title) y el nombre de la compañia.*/
SELECT contact_name, contact_title, company_name
FROM customers
WHERE contact_title NOT LIKE '%Sales%';

/* EJERCICIO 6: Todos los clientes que no tengan una "A" en segunda posición en su nombre.
Devolved unicamente el nombre de contacto.*/
SELECT contact_name
FROM customers
WHERE contact_name NOT LIKE '_A%';








