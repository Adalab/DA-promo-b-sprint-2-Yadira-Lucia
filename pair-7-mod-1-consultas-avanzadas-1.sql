USE northwind;

## Ejercicio 1. Pedidos por empresa en UK.
## Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos con la que podamos 
## conocer cuántos pedidos ha realizado cada empresa cliente de UK. Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.

SELECT COUNT(customers.customer_id) AS identificador, customers.company_name AS nombre_de_empresa, customers.country AS pais
FROM customers
CROSS JOIN orders
WHERE customers.customer_id = orders.customer_id 
GROUP BY customers.customer_id
HAVING customers.country = "UK";


## Productos pedidos por empresa en UK por año:
## Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y han decidido pedirnos una serie de 
## consultas adicionales. La primera de ellas consiste en una query que nos sirva para conocer cuántos objetos ha pedido cada empresa 
## cliente de UK durante cada año. Nos piden concretamente conocer el nombre de la empresa, el año, y la cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.

SELECT SUM(order_details.quantity) AS objetos, Orders.order_id
FROM order_details
INNER JOIN orders
ON order_details.order_id = orders.order_id
GROUP BY orders.order_id
HAVING 



SELECT order_details.quantity AS objetos, orders.customer_id, orders.order_id, order_details.product_id, YEAR(order_date)
FROM order_details
INNER JOIN orders
ON order_details.order_id = orders.order_id;


SELECT customers.company_name, customers.country
FROM customers
WHERE country = "UK"
INNER JOIN orders
ON order_details.order_id = orders.order_id;



SELECT customers.company_name, customers.country
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.country


HAVING customers.country = "UK";















