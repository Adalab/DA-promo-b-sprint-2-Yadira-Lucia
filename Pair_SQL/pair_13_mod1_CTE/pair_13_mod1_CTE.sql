USE northwind; 

## Ejercicio 1.
# Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
# Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el nombre de la compañia de la tabla Customers

WITH resumen_1 (company_name, customer_id) AS 
(SELECT company_name, customer_id
FROM customers)
SELECT *
FROM resumen_1;

## Ejercicio 2. 
# Selecciona solo los de que vengan de "Germany"

WITH resumen_1 (company_name, customer_id, country) AS 
(SELECT company_name, customer_id, country
FROM customers
WHERE country = "Germany")
SELECT company_name, customer_id, country
FROM resumen_1;


## Ejercicio 3.
# Extraed el id de las facturas y su fecha de cada cliente.
# En este caso queremos extraer todas las facturas que se han emitido a un cliente, su fecha la compañia a la que pertenece.
# 📌 NOTA En este caso tendremos columnas con elementos repetidos(CustomerID, y Company Name

WITH facturas 
AS (SELECT orders.order_id, orders.customer_id, orders.order_date, customers.company_name
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id)
SELECT order_date, order_id
FROM facturas;

## Ejercicio 4
# Contad el número de facturas por cliente
# Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente.

WITH facturas 
AS (SELECT orders.order_id, orders.customer_id, customers.company_name
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id)
SELECT customer_id, COUNT(order_id) AS facturas_totales
FROM facturas
GROUP BY customer_id;

## Ejericio 5 
# Cuál la cantidad media pedida de todos los productos ProductID
# Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media 

WITH media_productos
AS (SELECT product_id, SUM(quantity) AS total
FROM order_details
GROUP BY product_id)
SELECT AVG(total)
FROM media_productos



