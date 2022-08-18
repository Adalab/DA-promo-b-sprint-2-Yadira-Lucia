USE northwind;

/* Ejercicio 1. Pedidos por empresa en UK.
Desde las oficinas en UK nos han pedido con urgencia que realicemos 
una consulta a la base de datos con la que podamos conocer cuántos 
pedidos ha realizado cada empresa cliente de UK. Nos piden el ID 
del cliente y el nombre de la empresa y el número de pedidos.*/
SELECT COUNT(orders.order_id) AS numerodepedidos, customers.company_name AS nombre_de_empresa, customers.customer_id AS identificador
FROM customers
CROSS JOIN orders
WHERE customers.customer_id = orders.customer_id AND customers.country = "UK"
GROUP BY customers.customer_id, customers.company_name; 

## Solución 2 con Having
SELECT COUNT(customers.customer_id) AS identificador, customers.company_name AS nombre_de_empresa, customers.country AS pais
FROM customers
CROSS JOIN orders
WHERE customers.customer_id = orders.customer_id 
GROUP BY customers.customer_id
HAVING customers.country = "UK";


/*EJERCICIO 2: Productos pedidos por empresa en UK por año:
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta 
a su petición anterior y han decidido pedirnos una serie de consultas 
adicionales. La primera de ellas consiste en una query que nos sirva para 
conocer cuántos objetos ha pedido cada empresa cliente de UK durante cada 
año. Nos piden concretamente conocer el nombre de la empresa, el año, y la 
cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.*/
SELECT c.company_name, YEAR(b.shipped_date), SUM(a.quantity)
FROM orders b
INNER JOIN order_details a 
ON  b.order_id = a.order_id
INNER JOIN customers c 
ON c.customer_id = b.customer_id
GROUP BY b.customer_id, YEAR(b.shipped_date), b.ship_country
HAVING b.ship_country = "UK"
ORDER BY c.company_name,YEAR(b.shipped_date);

#Solución 2
SELECT customers.company_name AS nombreempresa, YEAR(orders.order_date) AS año, SUM(order_details.quantity) AS numobjetos
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN order_details
ON orders.order_id = order_details.order_id
WHERE customers.country = "UK"
GROUP BY YEAR (orders.order_date), customers.company_name; 


/*EJERCICIO 3: Mejorad la query anterior:
Lo siguiente que nos han pedido es la misma consulta anterior pero con la 
adición de la cantidad de dinero que han pedido por esa cantidad de objetos, 
teniendo en cuenta los descuentos, etc. Ojo que los descuentos en nuestra 
tabla nos salen en porcentajes, 15% nos sale como 0.15.*/
SELECT c.company_name, YEAR(b.shipped_date), SUM((a.quantity*a.unit_price)-(a.quantity*a.unit_price)*discount)
FROM orders b
INNER JOIN order_details a 
ON  b.order_id = a.order_id
INNER JOIN customers c 
ON c.customer_id = b.customer_id
GROUP BY b.customer_id, YEAR(b.shipped_date), b.ship_country
HAVING b.ship_country = "UK"
ORDER BY c.company_name,YEAR(b.shipped_date);

## Solución 2
SELECT 
customers.company_name AS nombreempresa, YEAR(orders.order_date) AS año, SUM(order_details.quantity) AS numobjetos, 
SUM(order_details.unit_price*order_details.quantity - order_details.unit_price*order_details.quantity*order_details.discount) AS dinerototal
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN order_details
ON orders.order_id = order_details.order_id
WHERE customers.country = "UK"
GROUP BY YEAR (orders.order_date), customers.company_name; 


#BONUS 1: Pedidos que han realizado cada compañía y su fecha:
# Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han obtenido, desde la central nos han pedido una 
#consulta que indique el nombre de cada compañia cliente junto con cada pedido que han realizado y su fecha.
SELECT orders.order_id, customers.company_name, orders.order_date
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id; 

#BONUS 2: Tipos de producto vendidos:
#Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías, nombre de la categoría y el nombre del producto, y el 
#total de dinero por el que se ha vendido cada tipo de producto (teniendo en cuenta los descuentos).
#Pista Necesitaréis usar 3 joins.
SELECT categories.category_id, categories.category_name, products.product_name, SUM(order_details.unit_price*order_details.quantity - order_details.unit_price*order_details.quantity*order_details.discount)
FROM categories
INNER JOIN products
ON categories.category_id = products.category_id
INNER JOIN order_details
ON products.product_id = order_details.product_id
GROUP BY categories.category_id, categories.category_name, products.product_name
ORDER BY 1,2,3;


