-- SQL-команды для создания таблиц

CREATE TABLE employees
(
    employee_id serial PRIMARY KEY,
    first_name varchar(20) NOT NULL,
	last_name varchar(20) NOT NULL,
	title varchar(50) NOT NULL,
	birth_date date NOT NULL,
    notes text NOT NULL
);

CREATE TABLE customers
(
    customer_id int PRIMARY KEY,
    company_name char(5) NOT NULL,
	contact_name varchar(50) NOT NULL
);

CREATE TABLE orders
(
    order_id serial PRIMARY KEY,
	customer_id int UNIQUE REFERENCES customers(customer_id) NOT NULL,
    employee_id int UNIQUE REFERENCES employees(employee_id) NOT NULL,
	order_date date NOT NULL,
	ship_city varchar(50) NOT NULL
);
