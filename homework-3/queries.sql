-- Напишите запросы, которые выводят следующую информацию:

-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)

-Вариант 1
SELECT company_name, CONCAT(last_name,' ' ,first_name) as employee
FROM(SELECT last_name, first_name, customer_id FROM (SELECT DISTINCT last_name, first_name, employee_id FROM employees WHERE city = 'London')
JOIN (SELECT customer_id, employee_id FROM orders WHERE ship_via = (SELECT DISTINCT shipper_id FROM shippers WHERE company_name = 'United Package'))
USING (employee_id))
JOIN (SELECT DISTINCT customer_id, company_name FROM customers WHERE city = 'London') USING (customer_id)

-Вариант 2
SELECT customers.company_name, CONCAT(last_name,' ',first_name) as employee, shippers.company_name FROM orders
JOIN employees USING (employee_id)
JOIN customers USING (customer_id)
JOIN shippers ON orders.ship_via = shippers.shipper_id
WHERE shippers.company_name = 'United Package'
AND customers.city = 'London'
AND employees.city = 'London'

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.

SELECT DISTINCT product_name, units_in_stock, contact_name, phone FROM products
JOIN suppliers USING (supplier_id)
JOIN categories USING (category_id)
WHERE discontinued = 0
AND products.units_in_stock < 25
AND categories.category_name in ('Dairy Products', 'Condiments')
ORDER BY units_in_stock

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT company_name FROM customers
WHERE customers.customer_id NOT IN(SELECT customer_id FROM orders)

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
-Вариант 1
SELECT DISTINCT product_name FROM products
JOIN (SELECT product_id FROM order_details
WHERE quantity = 10) USING (product_id)

-Вариант 2
SELECT product_name FROM products
WHERE product_id IN (SELECT product_id FROM order_details
WHERE quantity = 10)