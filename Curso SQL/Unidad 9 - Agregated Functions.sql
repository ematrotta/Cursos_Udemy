-- Agregated functions

-- COUNT
use ejercicios;
SELECT count(*) FROM books;
-- De esta manera no se tienen en cuenta los campos en null, no los cuenta
SELECT count(author_fname) from books;
SELECT count(distinct(author_fname)) from books;
SELECT count(title) from books where title like '%the%';

-- GROUP BY
-- Datos agrupados por resumen en filas que tienen identicos valores
-- No se puede utilizar 2 nombres de columnas dentro del grupo ya que solo agrupa, no es una agrupación dinamica. Lo que ponga seguido al group by
-- debe ser algo que ocupe solo 1 linea como el count
SELECT author_fname,count(author_fname) as books_written from books group by author_fname order by books_written;
SELECT released_year,count(*) from books group by released_year;

-- MAX y MIN
SELECT 
    MIN(released_year) AS 'Año Mínimo',
    MAX(released_year) AS 'Año Máximo'
FROM
    books;
    
-- También se puede utilizar con cadena de caracteres:
SELECT 
    MIN(author_lname) AS '1ER NOMBRE',
    MAX(author_lname) AS 'Ultimo nombre'
FROM
    books;

-- Subqueryes
SELECT * from books where pages = (SELECT min(pages) from books);

-- Grouping by multilple columns
-- Si el nombre de la columna se encuentra entre los datos a agrupar, se pueden colocar más de una para ser agrupadas
SELECT author_lname,author_fname,count(*) as cantidad from books group by author_lname,author_fname order by cantidad desc;

-- MIN y MAX con Group BY
SELECT author_lname,author_fname,count(*),MIN(released_year),MAX(released_year),MAX(pages) from books group by author_lname,author_fname;

-- SUM
-- Si sumo valores que son caracteres, devuelve 0
SELECT SUM(pages) from books;
SELECT author_lname,author_fname,SUM(pages) from books group by author_lname,author_fname;
SELECT author_lname,author_fname,SUM(pages),count(*) from books group by author_lname,author_fname;

-- AVG
-- Promedio
SELECT AVG(released_year) from books;
SELECT author_lname,author_fname,AVG(pages),count(*) from books group by author_lname,author_fname;

-- Ejercicios:
-- 1)
SELECT count(*) as Books from books;
-- 2)
SELECT released_year,count(*) as Books from books group by released_year;
-- 3)
SELECT SUM(stock_quantity) from books;
-- 4)
SELECT author_lname,author_fname,AVG(released_year) from books group by author_lname,author_fname;
-- 5)
SELECT concat(author_lname,' ',author_fname) as author from books where pages = (SELECT MAX(pages) from books);
-- 6)
SELECT released_year as year,count(*) as books ,AVG(pages) as 'avg pages' from books group by released_year order by released_year;