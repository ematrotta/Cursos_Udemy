-- VISTAS:
-- Son Querys ya perparadas para ser ejecutadas que obtienen una tabla ya unida por ejemplo
-- y evita que varias veces hagamos la misma consulta. Es entonces cuando creamos una consulta
-- que ya nos trae una tabla armada y nosotros podemos usar ésta tabla como si fuese una más dentro de nuestra
-- base de datos. 

use manytomany;
CREATE VIEW full_reviews AS
    SELECT 
        reviews.id AS id_review,
        rating,
        series.id AS id_serie,
        released_year,
        genre,
        reviewers.id AS id_reviewer,
        first_name,
        last_name
    FROM
        reviews
            JOIN
        series ON series.id = reviews.id_serie
            JOIN
        reviewers ON reviewers.id = reviews.id_reviewer;

SELECT * FROM full_reviews;

-- No se pueden realizar todo tipo de operaciones con las vistas. Esta limitado su uso:
-- https://dev.mysql.com/doc/refman/8.0/en/view-updatability.html

CREATE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;
 
CREATE OR REPLACE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year DESC;
 
ALTER VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;
 
DROP VIEW ordered_series;

-- HAVING
-- Se utiliza como el where pero para luego de un group by, es decir para después de que ya se seleccionaron
-- los datos.
SELECT 
    title, 
    AVG(rating),
    COUNT(rating) AS review_count
FROM full_reviews 
GROUP BY title HAVING COUNT(rating) > 1;

-- WITH ROLLUP
-- Permite obtener la media de cada dato que agrupo. Si hay mas de una agrupación,
-- 1ero hace la media por la 1er agrupación, y luego por la siguiente y luego la media de todo ese grupo.
-- Y por último la media de toda la tabla

SELECT 
    title, AVG(rating)
FROM
    full_reviews
GROUP BY title WITH ROLLUP;
 
SELECT 
    title, COUNT(rating)
FROM
    full_reviews
GROUP BY title WITH ROLLUP;
 
SELECT 
    first_name, released_year, genre, AVG(rating)
FROM
    full_reviews
GROUP BY released_year , genre , first_name WITH ROLLUP;

-- SQL Modes Basics
-- Son configuraciones iniciales que se pueden realiar dentro de SQL que pueden darse a nivel de base, tabla o global
-- Ej: No admitir 0, o espacios en blanco, etc
-- Evita los warnings por ejemplo según algún determinado error
-- Si se cambia algún modo desde la SESSION, al cerrar el programa y luego volver a abir, se reestablece.
-- Si quisiera que los cambios fueran permanantes, debo hacerlo desde GLOBAL
-- To View Modes:
SELECT @@GLOBAL.sql_mode;
SELECT @@SESSION.sql_mode;
 
-- To Set Them:
SET GLOBAL sql_mode = 'modes';
SET SESSION sql_mode = 'modes';

-- STRICT_TRANS_TABLES
-- Es uno de los modos más importantes. Al estar activado, si quisieramos insertar una fila por ejemplo con datos incorrectos,
-- este nos arrojaría un error y la inserción no se realizaría pero en el caso de estar apagado.
-- La inserción si se realizaría pero generaría un warning y dentro de la inserción los campos
-- que se pretendían insertar, estarían en una instancia "empty" dependiendo del tipo de dato (\'',0,etc)

-- Otros Modes
-- https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html