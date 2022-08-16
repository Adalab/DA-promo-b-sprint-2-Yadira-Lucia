USE northwind;

-- Ejercicio 1. Extraer toda la información sobre las compañias que tengamos en la BBDD
SELECT company_name, city, contact_name, 'Customers' AS Relationship #Esta última sería la columna temporal
FROM customers
UNION
SELECT company_name, city, contact_name, 'Suppliers' AS Relationship
FROM suppliers
ORDER BY city;

-- Ejercicio 2. Extraer todos los pedidos gestinados por "Nancy Davolio". 
-- En este caso, nuestro jefe quiere saber cuantos pedidos ha gestionado "Nancy Davolio",
-- una de nuestras empleadas. Nos pide todos los detalles tramitados por ella.
SELECT *
FROM orders
WHERE employee_id IN (
	SELECT first_name = "Nancy" AND last_name = "Davolio"
	FROM employees);

-- Ejercicio 3. Extraed todas las empresas que no han comprado en el año 1997.
-- En este caso, nuestro jefe quiere saber cuántas empresas no han comprado en el año 1997.
SELECT company_name, country
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
    WHERE YEAR (order_date = 1997));

-- Ejercicio 4. Extraed toda la información de los pedidos donde tengamos "Konbu".
-- Estamos muy interesados en saber como ha sido la evolución de la venta de Konbu a lo largo del tiempo.
-- Nuestro jefe nos pide que nos muestre todos los pedidos que contengan "Konbu".
SELECT *
FROM orders
WHERE order_id IN (
	SELECT order_details.order_id
    FROM order_details
    INNER JOIN products
    ON products.product_name = "Konbu");






