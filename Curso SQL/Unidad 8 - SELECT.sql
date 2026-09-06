-- Limitar las selecciones

INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);
-- DISTINCT
-- Se utiliza para obtener resultados distintos en las consultas
-- Se pueden colocar varias clausulas segun se repitan o no cadenas
SELECT distinct author_lname from books;
SELECT distinct concat(author_lname,' ',author_fname) from books;
SELECT distinct author_lname,author_fname from books;

-- ORDER BY

SELECT book_id,author_fname,author_lname FROM books ORDER BY author_lname;
SELECT book_id,author_fname,author_lname FROM books ORDER BY author_lname DESC;
SELECT book_id,author_fname,author_lname FROM books ORDER BY author_lname ASC;
-- Esta clausula ordena por la columna seleccionada correspondiente a la consulta
SELECT book_id,author_fname,author_lname FROM books ORDER BY 2;
-- Se puede ordenar por varias columnas, la mandatoria es la que antecede a la siguiente
SELECT book_id,author_fname,author_lname FROM books ORDER BY 2 desc, pages asc;
SELECT concat_ws(' ',author_fname,author_lname) as full_name from books order by full_name desc;

-- LIMIT
-- Se obtiene un número de filas determinado
SELECT concat_ws(' ',author_fname,author_lname) as full_name from books order by full_name desc limit 3;
SELECT concat_ws(' ',author_fname,author_lname) as full_name from books order by full_name desc limit 0,3;
-- La siguiente sentencia determina el valor de las filas con indice cero desde donde comienza hasta la cantidad de filas solicitadas
SELECT concat_ws(' ',author_fname,author_lname) as full_name from books order by full_name desc limit 1,3;

-- LIKE
SELECT * from books where author_fname like '%d_vid%';
SELECT * from books where author_fname like '___';
-- Si deseo buscar un dato que contiene en su cadena un signo de % o _ y quiero usar LIKE:
-- Debo colocar el caracter de escape \
SELECT title from books where title like '%\%%';

-- Ejercicios
-- 1)
select title from books where title like '%stories%';
-- 2) Encontrar el maximo libro según sus páginas.
select title,pages from books order by pages DESC LIMIT 1;
-- 3) Summary
select concat(title,' - ',released_year) as summary from books order by released_year desc limit 3; 
-- 4)
select title,author_lname from books where author_lname LIKE '% %';
-- 5) 
select title,released_year,stock_quantity from books order by stock_quantity limit 3;
-- 6) 
select title,author_lname from books order by author_lname,title;
-- 7)
SELECT UCASE(CONCAT('MY FAVORITE AUTHOR IS ',author_fname,' ',author_lname,'!')) as yell from books order by author_lname;