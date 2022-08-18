USE northwind;

/* EJERCICIO 1: Extraed información de los productos "Beverages"
En este caso nuestro jefe nos pide que le devolvamos toda la 
información necesaria para identificar un tipo de producto. 
En concreto, tienen especial interés por los productos con 
categoría "Beverages". Devuelve el ID del producto, el nombre 
del producto y su ID de categoría.*/
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
#Solución 1
SELECT order_id, company_name, customers.customer_id
FROM orders
INNER JOIN customers
ON customers.customer_id = orders.customer_id
WHERE order_id IN
	(SELECT order_id
    FROM order_details
    WHERE product_id = 6 AND quantity > 20);
#Solución 2
SELECT order_id, customer_id
FROM orders
WHERE order_id IN (
	SELECT orders.order_id 
	FROM orders
    INNER JOIN order_details
	ON order_details.order_id = orders.order_id
    WHERE product_id =6 AND quantity>20
    GROUP BY orders.customer_id);

-- Ejercicio 4. Extraed los 10 productos más caros.
-- Nos siguen pidiendo más queries correlacionadas. En este caso queremos saber cuáles son los 10 productos más caros.
SELECT product_name, unit_price, product_id
FROM products
WHERE unit_price IN(
	SELECT DISTINCT products.unit_price
    FROM products
    INNER JOIN order_details
    ON products.product_id = order_details.product_id
	ORDER BY unit_price DESC)
ORDER BY unit_price DESC
LIMIT 10;

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
		GROUP BY product_id) AS t);






