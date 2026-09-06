CREATE TABLE books 
	(
		book_id INT NOT NULL AUTO_INCREMENT,
		title VARCHAR(100),
		author_fname VARCHAR(100),
		author_lname VARCHAR(100),
		released_year INT,
		stock_quantity INT,
		pages INT,
		PRIMARY KEY(book_id)
	);

INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);

select * from books;
-- CONCAT Y CONCAT_WS
select *,concat(author_fname,' ',author_lname) as complete_name from books;
-- Esta función se utiliza para concatenar con un separador determinado
select *,concat_ws(' ',author_fname,author_lname) as complete_name from books;
-- SUBSTRING Y SUBSTR
select substring(title,1,15) as title from books;
select concat(substr(title,1,10),'...') as title_concatenate from books;
SELECT 
    CONCAT_WS('.',
            SUBSTR(author_fname, 1, 1),
            SUBSTR(author_lname, 1, 1),
            '') AS author_Name_Initials
FROM
    books;
-- Con el simbolo de la escoba, el contenido de la query se actualiza solo
-- REPLACE
SELECT replace('Hello World',' ',' and ');
-- REVERSE
SELECT REVERSE ('Hello world');
-- CHAR_LENGHT
SELECT char_length('Hello world');
-- Esto devuelve la cantidad de bytes
SELECT length('hello world');
SELECT char_length(title) from books;
-- UPPER AND LOWER
SELECT UPPER('Emanuel');
SELECT LOWER('Emanuel');
SELECT LCASE('Emanuel');
select ucase('Emanuel');
SELECT UCASE(title) from books;
-- INSERT
-- El 1er parametro es un string, segundo la posición, 3ero la cantidad de caracteres a reemplazar
-- 4to la cadena a insertar
SELECT INSERT('Hello world',6,0,' and');
-- RIGHT AND LEFT
-- Obtiene un sibstring que comienza por la derecha o izquierda respectivamente obteniendo la cantidad de 
-- caracteres solicitadas
SELECT right('Hello',3);
SELECT left('Hello',3);
-- REPEAT
-- Repite varias veces una cadena
SELECT repeat('Hello',3);
-- TRIM
-- Remueve espacios al comienzo o al final, no el medio
SELECT TRIM('    Hello    world');
-- Elimina los caracteres solicitados al comienzo de la cadena
SELECT TRIM(LEADING '.' FROM '....Hello world....');
-- Elimina los caracteres solicitados al comienzo y al final de la cadena
SELECT TRIM(both '.' FROM '....Hello world....');
-- Elimina los caracteres solicitados al final de la cadena
SELECT TRIM(trailing '.' FROM '....Hello world....');

-- Ejercicios:
-- 1)
SELECT REVERSE(UCASE('Why does my cat at me watch such hatred'));
-- 2) Resultado = I-Like-cats
-- 3) 
SELECT REPLACE(title,' ','->') as title from books;
-- 4)
SELECT author_lname as forwards,REVERSE(author_lname) as backwards from books;
-- 5)
SELECT UPPER(CONCAT(author_fname,' ',author_lname)) as 'full name in caps' from books;
-- 6)
SELECT concat_ws(' was released in ',title,released_year) as blurb from books;
-- 7)
SELECT title,char_length(title) as 'character count' from books;
-- 8)
SELECT 
    CONCAT(SUBSTR(title, 1, 10), '...') AS 'short title',
    CONCAT_WS(',', author_lname, author_fname) AS author,
    CONCAT(stock_quantity, ' in stock') AS quantity
FROM
    books; 
    





