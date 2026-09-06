-- Las funciones de ventana, agrupan los datos y permiten crear operaciones
-- así como lo sería un promedio o una suma, pero en vez de agrupar los datos, muestra el resultado
-- en una nueva columna fila por fila, es decir, sin haber reducido la tabla

CREATE DATABASE windows_funcs;
use windows_funcs;
CREATE TABLE employees (
    emp_no INT PRIMARY KEY AUTO_INCREMENT,
    department VARCHAR(20),
    salary INT
);
 
INSERT INTO employees (department, salary) VALUES
('engineering', 80000),
('engineering', 69000),
('engineering', 70000),
('engineering', 103000),
('engineering', 67000),
('engineering', 89000),
('engineering', 91000),
('sales', 59000),
('sales', 70000),
('sales', 159000),
('sales', 72000),
('sales', 60000),
('sales', 61000),
('sales', 61000),
('customer service', 38000),
('customer service', 45000),
('customer service', 61000),
('customer service', 40000),
('customer service', 31000),
('customer service', 56000),
('customer service', 55000);

-- En este caso por ejemplo, traerá el promedio de salario mostrando todas las columnas y agregando una nueva llamada promedio_salario,
-- que contiene la información del promedio general de salarios de toda la tabla

SELECT emp_no, department, salary, AVG(salary) OVER() as promedio_salario FROM employees;
 
 -- En este caso, se agregan 2 columnas adicionales por cada fila, una con el mínimo y otra con el maximo
SELECT 
    emp_no, 
    department, 
    salary, 
    MIN(salary) OVER(),
    MAX(salary) OVER()
FROM employees;

-- Esta consulta da error porque no utiliza los OVER() y se intentan usar funcines de grupo
-- (MAX y MIN)

SELECT 
    emp_no, department, salary, MIN(salary), MAX(salary)
FROM
	employees;
    

-- PARTITION BY
-- Permite dividir los OVER en resultados que contengan cierta caracteristica de grupo
-- Ejemplos:
SELECT 
    emp_no, 
    department, 
    salary, 
    AVG(salary) OVER(PARTITION BY department) AS dept_avg,
    AVG(salary) OVER() AS company_avg
FROM employees;
 
SELECT 
    emp_no, 
    department, 
    salary, 
    COUNT(*) OVER(PARTITION BY department) as dept_count
FROM employees;
 
SELECT 
    emp_no, 
    department, 
    salary, 
    SUM(salary) OVER(PARTITION BY department) AS dept_payroll,
    SUM(salary) OVER() AS total_payroll
FROM employees;

-- ORDER BY With Windows
-- Cuando se coloca ORDER BY dentro de la clausula OVER se agrupan los datos teniendo en cuenta la partición
-- Es decir, que los datos se van a agrupar por cada partición.alter
-- A su vez, si se debe efectuar una suma por ejemplo, al colocar la opción de order by,
-- La suma la irá haciendo fila a fila y se ven las modificación realizadas al número

-- Ejemplos:
SELECT 
    emp_no, 
    department, 
    salary, 
    SUM(salary) OVER(PARTITION BY department ORDER BY salary) AS rolling_dept_salary,
    SUM(salary) OVER(PARTITION BY department) AS total_dept_salary
FROM employees;
 
SELECT 
    emp_no, 
    department, 
    salary, 
    MIN(salary) OVER(PARTITION BY department ORDER BY salary DESC) as rolling_min
FROM employees;

-- FUNCIONES EXCLUSIVAS DE VENTANA: RANK, DENSE_RANK, ROW_NUMBER
-- RANK() Permite obtener los nros de fila en base al orden que pudimos darle.
-- ACLARACIÓN: Cuando dentro de la condición que deba cumplirse, por ejemplo ordenar los salarios por departamento
-- Si hay un salario que se repite, el nro de fila no progresa, sino que los 2 registros tendrán
-- el mismo número de fila y cuando pase al siguiente dato, distinto de los anteriores, 
-- la numeración de fila dará un salto como se muestra en el ejemplo debajo

SELECT 
	department,
	salary,
    RANK() OVER(partition by department ORDER BY salary DESC) as rank_salaries_dep,
    RANK() OVER(ORDER BY salary DESC) as rank_salaries_overall
FROM employees;

-- ROW_NUMBER() indica el nro de fila dentro de un OVER(). Siempre es consecutiva, los 
-- numeros no se repiten a menos que esten en distinto grupo
-- DENSE_RANK() Se pueden repetir los numero en base si hay igualdades en los valores agrupados
-- pero no hará un salto en la númeración. Es decir, podemos tener 2 filas con el nro 7, pero
-- luego irá a la 8. No saltará a la 9 como en el caso de RANK().

SELECT 
    emp_no, 
    department, 
    salary,
    ROW_NUMBER() OVER(PARTITION BY department ORDER BY SALARY DESC) as dept_row_number,
    RANK() OVER(PARTITION BY department ORDER BY SALARY DESC) as dept_salary_rank,
    RANK() OVER(ORDER BY salary DESC) as overall_rank,
    DENSE_RANK() OVER(ORDER BY salary DESC) as overall_dense_rank,
    ROW_NUMBER() OVER(ORDER BY salary DESC) as overall_num
FROM employees ORDER BY overall_rank;

-- NTILE()
-- Divide en cuadrantes los valores obtenidos segun las agrupaciones en las cantidades que se quieran
SELECT 
    emp_no, 
    department, 
    salary,
    NTILE(4) OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_quartile,
	NTILE(4) OVER(ORDER BY salary DESC) AS salary_quartile
FROM employees;

-- FIRST_VALUE()
-- Permite obtener el 1er valor de la agrupación. Se puede obtener de todo o según un grupo en especial
SELECT 
    emp_no, 
    department, 
    salary,
    FIRST_VALUE(emp_no) OVER(PARTITION BY department ORDER BY salary DESC) as highest_paid_dept,
    FIRST_VALUE(emp_no) OVER(ORDER BY salary DESC) as highest_paid_overall
FROM employees;

-- LEAD Y LAG (VENTAJA Y RETRASO)
-- LAG TRAERÁ LOS VALORES DE LA FILA SUPERIOR A ELLA. Puede ser útil para calcular la 
-- diferencia de salario por ejemplo con el empleado que se encuentra por encima
-- LEAD traerá los valores de la fila que se encuentra debajo de ella. Distinto de LAG que toma los datos de la fila que se 
-- encuentra encima

SELECT 
    emp_no, 
    department, 
    salary,
    salary - LAG(salary) OVER(ORDER BY salary DESC) as salary_diff
FROM employees;
 
SELECT 
    emp_no, 
    department, 
    salary,
    salary - LAG(salary) OVER(PARTITION BY department ORDER BY salary DESC) as dept_salary_diff
FROM employees;




