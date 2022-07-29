USE northwind;

-- Ejercicio 1. Extraed información de los productos "Beverages"

-- Con inner join
SELECT product_id, product_name, products.category_id
FROM products
INNER JOIN categories
ON products.category_id = categories.category_id
WHERE category_name = "Beverages"; 

-- Con subquery
SELECT product_id, product_name, products.category_id
FROM products
WHERE category_id IN (
	SELECT category_id
	FROM categories
	WHERE category_name = "Beverages");


-- Ejercicio 2. Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país
-- Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, entonces podría dirigirse a estos países para buscar proveedores adicionales

SELECT DISTINCT country
FROM customers
WHERE country NOT IN (
	SELECT DISTINCT country
	FROM suppliers);
    
-- Ejercicio 3. Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread"
-- Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto "Grandma's Boysenberry Spread" (ProductID 6) en un solo pedido

-- Con inner join
SELECT orders.order_id, company_name, customers.customer_id
FROM orders
INNER JOIN customers
ON customers.customer_id = orders.customer_id
INNER JOIN order_details
ON order_details.order_id = orders.order_id
WHERE product_id = 6 AND quantity > 20;

-- Con subquery
SELECT order_id, company_name, customers.customer_id
FROM orders
INNER JOIN customers
ON customers.customer_id = orders.customer_id
WHERE order_id IN
	(SELECT order_id
    FROM order_details
    WHERE product_id = 6 AND quantity > 20);

-- Ejercicio 4. Extraed los 10 productos más caros.
-- Nos siguen pidiendo más queries correlacionadas. En este caso queremos saber cuáles son los 10 productos más caros.

-- Con query única
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 10;

-- Con subquery


-- Bonus. Qué producto es más popular
-- Extraed cuál es el producto que más ha sido comprado y la cantidad que se compró.

SELECT SUM(quantity) AS Cantidad, product_name
FROM order_details
INNER JOIN products
ON order_details.product_id = products.product_id
GROUP BY product_name
HAVING Cantidad = (
	SELECT MAX(Cantidad)
	FROM 
		(SELECT product_id, SUM(quantity) AS Cantidad
		FROM order_details
		GROUP BY product_id) AS t)








