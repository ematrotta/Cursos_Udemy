-- COMPARISON AND LOGICAL OPERATORS
-- != NOT EQUAL, = IGUAL
-- LIKE: CONTIENE, NOT LIKE: No contiene
-- > mayor que >= mayor o igual
-- < menor que <= menor o igual
-- AND y
-- OR o
-- BETWEEN reemplaza VALOR>= X AND VALOR<=x
SELECT title, released_year FROM books
WHERE released_year <= 2015
AND released_year >= 2004;
 
SELECT title, released_year FROM books
WHERE released_year BETWEEN 2004 AND 2014;

-- Comparing DATES
SELECT * FROM people WHERE birthtime 
BETWEEN CAST('12:00:00' AS TIME) 
AND CAST('16:00:00' AS TIME);
 
SELECT * FROM people WHERE HOUR(birthtime)
BETWEEN 12 AND 16;

-- The IN OPERATOR
-- Es utilizado para traer aquellos valores en los que contiene (IN) o no (NOT IN) cierto dato.
SELECT title, author_lname FROM books
WHERE author_lname = 'Carver' 
OR author_lname = 'Lahiri'
OR author_lname = 'Smith';
 
SELECT title, author_lname FROM books
WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');
 
SELECT title, author_lname FROM books
WHERE author_lname NOT IN ('Carver', 'Lahiri', 'Smith');
 
 
SELECT title, released_year FROM books
WHERE released_year >= 2000 
AND released_year % 2 = 1;

-- CASE
-- Se utiliza como un if else
SELECT * FROM books;
SELECT 
    title,
    released_year,
    CASE
        WHEN released_year > 2000 THEN 'Modern Lit'
        ELSE '20th Century Literature'
    END AS Genero
FROM
    books;
    
select title,stock_quantity,
	CASE
		WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        ELSE '***'
	END
    AS Visualization_stock from books;
    
-- IS NULL
-- Ejercicios
-- 1) Resultado = 0 FALSE
SELECT 10 != 10;
-- 2) Resultado 1 TRUE
SELECT 15>14 AND 99-5<=94;
-- 3) RESULTADO 1 TRUE
SELECT 1 IN (5,3) OR 9 BETWEEN 8 AND 10;
-- 4)
SELECT * FROM books where released_year<1980;
-- 5)
SELECT * FROM books where author_lname IN ('Eggers','Chabon');
-- 6) 
select * from books where author_lname = 'Lahiri' AND released_year>=2000;
-- 7)
SELECT * FROM books where pages BETWEEN 100 and 200;
-- 8)
SELECT * FROM books where author_lname LIKE 'c%' OR 's%';
-- Otra manera
SELECT title, author_lname
FROM books WHERE SUBSTR(author_lname, 1, 1) in ('C', 'S');
-- 9)
SELECT title,author_lname,
	CASE
		WHEN title like '%stories%' THEN 'Short Stories'
        WHEN title like '%just kids%' or title like'%A heartbreaking work%' then 'Memoir'
        else 'Novel'
	END
AS TYPE FROM books;

-- 10)
SELECT author_fname,author_lname,
CASE 
	WHEN count(*) = 1 then '1 book'
    ELSE concat(count(*),' books')
END
 as COUNT from books group by author_fname,author_lname;

