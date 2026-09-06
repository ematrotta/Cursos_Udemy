-- CONCEPTOS DE FOREING KEY
-- Se utiliza para referenciar un ID de otra tabla. Si al insertar la información de la tabla actual,
-- incluimos un id que no corresponde a la tabla relacionada habrá un error.
create database joins;
use joins;
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);
 
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);
 
INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);
       
-- CROSS JOIN
-- Si quisieramos buscar la información de un usuario en particular podríamos realizar la siguiente consulta
-- multiple

SELECT * FROM orders 
WHERE customer_id = (SELECT id FROM customers WHERE last_name = 'George');

-- Existe otra manera de combinar tablas llamada cross join, que combina una tabla con otra repitiendo los datos de la segunda tabla
-- No es algo que se suela usar
SELECT * FROM customers, orders;

-- INNER JOIN (Uniones interiores)
SELECT * FROM customers JOIN orders ON customers.id = orders.customer_id;
SELECT customers.id as ID_CUSTOMER,first_name,email,orders.id as ID_ORDER FROM customers JOIN orders ON customers.id = orders.customer_id;
SELECT first_name,last_name,order_date,amount FROM customers JOIN orders ON customers.id = orders.customer_id;

-- De esta manera siempre muestra el dato de la columna correspondiente al select inicialmente
-- El dato de INNER antes del JOIN esta implicito, colocarlo es relevante
SELECT * FROM orders JOIN customers ON orders.customer_id = customers.id;

-- INNER JOIN CON GROUP BY
-- Con las consultas debajo obtengo exactamente el mismo resultado ya que solo obtengo la intersección
-- de las 2 tablas
SELECT 
    first_name, last_name, SUM(amount) AS total
FROM
    customers
        JOIN
    orders ON customers.id = orders.customer_id
GROUP BY first_name , last_name
ORDER BY total DESC;

SELECT 
    first_name, last_name, SUM(amount) AS total
FROM
    orders
        JOIN
    customers ON customers.id = orders.customer_id
GROUP BY first_name , last_name
ORDER BY total DESC;

-- LEFT JOIN
-- Se toman los datos de la tabla izquierda y si hay filas que no poseen datos, apareceran NULL
SELECT first_name,last_name,order_date,amount FROM customers LEFT JOIN orders ON orders.customer_id = customers.id;
-- La tabla izquierda es customers y la derecha son oders

SELECT first_name,last_name,order_date,CASE WHEN amount IS NULL THEN '0.00' ELSE amount END FROM customers LEFT JOIN orders ON orders.customer_id = customers.id;

-- LEFT JOIN WITH GROUP BY
-- Otra manera de realizar la consulta anterior usando IFNULL()
SELECT first_name,last_name,IFNULL(SUM(amount),0) as Total FROM customers LEFT JOIN orders ON orders.customer_id = customers.id GROUP BY last_name,first_name;

-- RIGHT JOIN
-- Con la consulta debajo obtengo el mismo resultado que en la consulta anterior solo que modifico el orden de las columnas y cambio
-- La sentencia LEFT JOIN pot RIGHT JOIN
SELECT 
    first_name, last_name, IFNULL(SUM(amount), 0) AS Total
FROM
    orders
        RIGHT JOIN
    customers ON orders.customer_id = customers.id
GROUP BY last_name , first_name;

-- ON DELETE CASCADE
-- Al definir una clave foreanea, no solo definimos que un id de una tabla exista en otra, sino que también
-- Incluimos que la eliminacion de la clave primaria, depende también sobre la clave foranea. Es decir que para poder
-- Eliminar el dato que contiene la clave primaria, debemos 1ro eliminar los datos que contienen la clave foranea
-- Para ello entra el concepto descripto, para la eliminación automática.
DROP TABLE orders;
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- En este caso, elimiamos al cliente y se eliminaron automaticamente todas las ordenes que correspondían
-- a ese cliente
select * from customers left join orders on customers.id = orders.customer_id;
select * from orders;
DELETE FROM customers where first_name = 'George';

-- Ejercicios:
-- 1) 

CREATE TABLE students(
id INT auto_increment NOT NULL PRIMARY KEY,
first_name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE papers (
id INT auto_increment NOT NULL PRIMARY KEY,
title VARCHAR(50) NOT NULL UNIQUE,
student_id INT,
grade INT NOT NULL,
constraint grade_minor_1ro CHECK (grade>0),
FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

DESC papers;
DESC students;

SELECT * FROM papers;
SELECT * FROM students;

 -- Started Data
INSERT INTO students (first_name) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

SELECT first_name,title,grade FROM papers INNER JOIN students ON papers.student_id = students.id ORDER BY grade DESC;

-- 2)

SELECT first_name,title,grade FROM papers RIGHT JOIN students ON papers.student_id = students.id;

-- 3)
SELECT first_name,IFNULL(title,'MISSING'),IFNULL(grade,0) FROM papers RIGHT JOIN students ON papers.student_id = students.id;

-- 4) 
SELECT first_name,AVG(ifnull(grade,0)) as average FROM papers RIGHT JOIN students ON papers.student_id = students.id GROUP BY first_name order by average desc;

-- 5)
SELECT 
    first_name,
    AVG(IFNULL(grade, 0)) AS average,
    CASE
        WHEN AVG(IFNULL(grade, 0)) >= 75 THEN 'PASSING'
        ELSE 'FAILING'
    END AS passing_status
FROM
    papers
        RIGHT JOIN
    students ON papers.student_id = students.id
GROUP BY first_name
ORDER BY average DESC;







