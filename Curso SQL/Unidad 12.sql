use ejercicios;
-- UNIQUE
-- Se utiliza para definir aquellas columnas que no sean primary KEY, como unicas
CREATE TABLE contacts (
	name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE
);

-- CHECK CONSTRAINS
-- Restricciones adicionales que se pueden relizar dentro de una tabla
CREATE TABLE users (
	username VARCHAR(20) NOT NULL,
    age INT CHECK (age > 0)
);
 
CREATE TABLE palindromes (
  word VARCHAR(100) CHECK(REVERSE(word) = word)
)

-- CONSTRAINT 
-- Permite definir el nombre de la validación realizada con CHECK
-- También sirve para que en caso de querer modificar la tabla, se pueda modificar esta misma restricción en particular

CREATE TABLE users2 (
    username VARCHAR(20) NOT NULL,
    age INT,
    CONSTRAINT age_not_negative CHECK (age >= 0)
);
 
CREATE TABLE palindromes2 (
  word VARCHAR(100),
  CONSTRAINT word_is_palindrome CHECK(REVERSE(word) = word)
);

-- CONSTRAINT IN MULTIPLE COLUMNS
CREATE TABLE companies (
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    CONSTRAINT name_address UNIQUE (name , address)
);
 
CREATE TABLE houses (
  purchase_price INT NOT NULL,
  sale_price INT NOT NULL,
  CONSTRAINT sprice_gt_pprice CHECK(sale_price >= purchase_price)
);

-- ALTER TABLE
-- Agrear columnas a una tabla ya creada
CREATE TABLE companies(
name VARCHAR(50) NOT NULL,
address VARCHAR(255) NOT NULL
);

INSERT INTO companies (name,address) VALUES
('wornerbros','Siempre viva 123'),
('marvel','Siempre viva 143');

SELECT * FROM companies;

ALTER TABLE companies
ADD COLUMN phone VARCHAR(15);

-- Si se agrega una nueva columna a la tabla y se especifica que no debe ser nula,
-- Aquellos valores que inicialmente no tenían el valor en la tabla, se iniciarán en 0
ALTER TABLE companies
ADD COLUMN employee_count INT NOT NULL;
-- De todas formas puedo especificar si quiero algún valor por defecto
ALTER TABLE companies
ADD COLUMN pisos_count INT NOT NULL DEFAULT 1;

-- Eliminar columnas
ALTER TABLE companies DROP COLUMN phone;

-- Renombrar
-- Renombrar una tabla
RENAME table captions TO captions3;
ALTER TABLE captions3 RENAME TO captions;
-- Renombrar columna
SELECT * from captions;
ALTER TABLE captions RENAME COLUMN text to texto;

-- Modificar columnas
-- Con MODIFY podemos modificar el tipo de dato de una columna ya creada, si es null o no, etc.
-- Con CHANGE podemos modificar así mismo el tipo de dato e incluso el nombre de la columna

ALTER TABLE companies
MODIFY company_name VARCHAR(100) DEFAULT 'unknown';

ALTER TABLE suppliers
CHANGE business biz_name VARCHAR(50);

-- ALTER TABLE CONSTRAINT
-- Agrear o eliminar restricciones
ALTER TABLE houses 
ADD CONSTRAINT positive_pprice CHECK (purchase_price >= 0);
ALTER TABLE houses DROP CONSTRAINT positive_pprice;

