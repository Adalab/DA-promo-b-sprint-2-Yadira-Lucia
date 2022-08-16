USE northwind;
#EJERCICIO 1: Qué empresas tenemos en la BBDD Northwind:
#Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre de todas las empresas cliente, 
#los ID de sus pedidos y las fechas.

SELECT orders.order_id, customers.company_name, orders.order_date
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id;

#EJERCICIO 2: Pedidos por cliente de UK:
#Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de pedidos que ha realizado cada cliente 
#del propio Reino Unido de cara a conocerlos mejor y poder adaptarse al mercado actual. Especificamente nos piden el nombre 
#de cada compañía cliente junto con el número de pedidos
SELECT customers.company_name, COUNT(orders.order_id)
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY company_name,customers.country
HAVING customers.country="UK";

#EJERCICIO 3: Empresas de UK y sus pedidos: 
#También nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido (tengan pedidos o no) 
#junto con los ID de todos los pedidos que han realizado, el nombre de contacto de cada empresa y la fecha del pedido.
SELECT customers.company_name,customers.contact_name, orders.order_id, orders.order_date,customers.country
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id AND customers.country= "UK";

#EJERCICIO 4: Empleadas que sean de la misma ciudad:
#Ejercicio de SELF JOIN: Desde recursos humanos nos piden realizar una consulta que muestre por pantalla los datos de todas 
#las empleadas y sus supervisoras. Concretamente nos piden: la ubicación, nombre, y apellido tanto de las empleadas como de 
#las jefas. Investiga el resultado, ¿sabes decir quién es el director?

#Solución con todas las empleadas
SELECT a.city, a.first_name AS NombreEmpleado, a.last_name AS ApellidoEmpleado, a.title AS puesto, b.city, b.first_name AS NombreJefe, b.last_name AS ApellidoJefe, b.title AS puesto
FROM employees a, employees b
WHERE a.employee_id <> b.employee_id;

#Solución agrupada
SELECT a.city, a.first_name AS NombreEmpleado, a.last_name AS ApellidoEmpleado, b.city, b.first_name AS NombreJefe, b.last_name AS ApellidoJefe
FROM employees a, employees b
WHERE a.reports_to = b.employee_id;

-- El jefe es el que no está en la lista 

#BONUS: FULL OUTER JOIN Pedidos y empresas con pedidos asociados o no:
#Selecciona todos los pedidos, tengan empresa asociada o no, y todas las 
#empresas tengan pedidos asociados o no. Muestra el ID del pedido, el nombre de la empresa y la fecha del pedido (si existe).

SELECT orders.order_id, orders.customer_id, orders.order_date, customers.customer_id, customers.company_name
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id
UNION
SELECT orders.order_id, orders.customer_id, orders.order_date, customers.customer_id, customers.company_name
FROM orders
RIGHT JOIN customers
ON orders.customer_id = customers.customer_id;



