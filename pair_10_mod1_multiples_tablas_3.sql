USE northwind;

-- Ejercicio 1. Extraer toda la información sobre las compañias que tengamos en la BBDD

SELECT city, company_name, contact_name, "customers" AS "relationship"
FROM customers
UNION 
SELECT city, company_name, contact_name, "suppliers" AS "relationship"
FROM suppliers; 

-- Ejercicio 2. Extraer todos los pedidos gestinados por "Nancy Davolio". 
-- En este caso, nuestro jefe quiere saber cuantos pedidos ha gestionado "Nancy Davolio",
-- una de nuestras empleadas. Nos pide todos los detalles tramitados por ella.

SELECT *
FROM orders
WHERE employee_id in (
SELECT first_name = "Nancy" AND last_name = "Davolio"
FROM employees);

-- Ejercicio 3. Extraed todas las empresas que no han comprado en el año 1997.
-- En este caso, nuestro jefe quiere saber cuántas empresas no han comprado en el año 1997.

SELECT company_name, country, customer_id
FROM customers
WHERE customer_id NOT IN (
	SELECT customer_id
    FROM orders
    WHERE YEAR(order_date) = 1997);    

    
-- Ejercicio 4. Extraed toda la información de los pedidos donde tengamos "Konbu".
-- Estamos muy interesados en saber como ha sido la evolución de la venta de Konbu a lo largo del tiempo.
-- Nuestro jefe nos pide que nos muestre todos los pedidos que contengan "Konbu".

SELECT *
FROM orders
WHERE order_id IN (
SELECT order_details.order_id
FROM products
INNER JOIN order_details
ON products.product_name = "Konbu")






