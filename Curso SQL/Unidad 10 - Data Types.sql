-- DATA TYPES
-- CHAR
-- La diferencia principal respecto a VARCHAR es que almacena los datos de cadena de una forma fija,
-- Es decir que si determinamos que será CHAR(10) se guarda espacio en memoria para 10 caracteres
-- Teniendo en cuenta esto, un string 'ab' ocupará 10 caracteres, rellenando el resto de los espacios
-- con espacios en blanco. 
-- De todas formas, cuando quiera obtener su lenght, marcará 2 caracteres pero no es así en la realidad
-- Así mismo, cuando se intente insertar una cadena más larga de lo permitido, MySQL arrojará error.

-- NUMBERS: INT, TINYINT, BIGINT
-- Se utiliza cada tipo según el tamaño que se quiera ocupar. Cuando se quiera declarar un tipo de dato
-- sin signo para ampliar la capacidad. debe declararse como "nombre_columna INT UNSIGNED"

-- DECIMAL
-- Es el tipo de dato numerico con decimal más preciso de todos y ocupa mucho espacio en memoria.
-- La sintaxis es DECIMAL(5,2) = 5 números en total de los cuales 2 serán decimales
-- Si me excedo al insertar en la parte entera, habrá un error. Si me excedo en la parte decimal,
-- esta será redondeada

-- FLOAT Y DOUBLE
-- Float permita almacenar hasta 7 digitos 4 bytes
-- Double permite almacenar hasta 15 digitos 8 bytes.
-- Si el número ingresado se excede, se redondea el número perdiendo decimales

-- DATES AND TIME
-- DATE: Solo almacena una fecha sin horas ni segundos con el formato 'YYYY-MM-DD'
-- TIME: Representa la hora de un día con horas, minutos y segundos. El formato es 'HH:MM:SS'
-- DATETIME: Almacena la fecha con el horario. Posee el formato 'YYYY-MM-DD HH:MM:SS'

-- Working with DATES

use ejercicios;
create table people(
	name VARCHAR(100) NOT NULL,
    birthdate DATE NOT NULL,
    birthtime TIME NOT NULL,
    birthdt DATETIME NOT NULL
);
DESC people;

insert into people(name,birthdate,birthtime,birthdt) VALUES
('Elthon','1999-02-21','12:04:22','1999-02-21 12:04:22');
SELECT * FROM people;

-- CURRENT DATE TIME
SELECT CURTIME();
SELECT CURDATE();
SELECT NOW();

INSERT INTO people(name,birthdate,birthtime,birthdt) VALUES ('Juan',CURDATE(),CURTIME(),NOW());

-- DATE FUNCTIONS
-- DAY()
SELECT birthdate,day(birthdate) from people;

-- DAY OF WEEK
SELECT birthdate,dayofweek(birthdate) from people;

-- NOMBRE DEL MES
SELECT birthdate,monthname(birthdate) from people;
SELECT birthdate,dayname(birthdate) from people;
SELECT birthdate,week(birthdate) from people;

-- Cuando utilizo algo por ejemplo que no corresponde a una fecha, tengo un horario y quiero
-- obtener el monthname, va a entregarme el nombre del mes actual

-- TIME FUNCTIONS
SELECT name,birthtime,HOUR(birthtime) from people;
SELECT name,birthtime,MINUTE(birthtime) from people;
SELECT name,birthtime,SECOND(birthtime) from people;

-- Formatting Dates
-- Ver tablas de formatos
SELECT birthdate, DATE_FORMAT(birthdate, '%a %b %D') FROM people;
SELECT birthdt, DATE_FORMAT(birthdt, '%H:%i') FROM people;
SELECT birthdt, DATE_FORMAT(birthdt, 'BORN ON: %r') FROM people;

-- DATE MATHS
-- Obtiene la diferencia de dias entre una fecha y otra
SELECT datediff(curdate(),birthdt) from people;

-- Suma intervalos de tiempo
select date_add(curdate(),INTERVAL 1 YEAR);
select date_add(curdate(),INTERVAL 1 MONTH);

-- Resta intervalos de tiempo
select date_sub(curdate(),INTERVAL 1 YEAR);
select date_sub(curdate(),INTERVAL 1 MONTH);

select timediff(now(),birthdt) from people;

-- Se pueden realizar operaciones con operadores matematicos
select now() - INTERVAL 18 YEAR;

-- TIMESTAMPS
-- Son formatos DATETIME que ocupan menos espacio que uno de estos y que la fecha que contempla es más reducida.
-- Suelen resultar útiles cuando queremos grabar el momento actual en el que se realizó alguna interacción por ejemplo

create table captions(
text VARCHAR(50),
created_at TIMESTAMP default current_timestamp
);

INSERT INTO captions (text) VALUES ('Hola como estas'),('Bien y vos?');
SELECT * from captions;

drop table captions2;
create table captions2(
text VARCHAR(50),
created_at TIMESTAMP default current_timestamp,
-- Este comando actualizará la marca de tiempo cada vez que se realice una actualización sobre la fila que la contiene
update_at TIMESTAMP on update current_timestamp default current_timestamp
);

INSERT INTO captions2 (text) VALUES ('Hola como estas'),('Bien y vos?');
SELECT * FROM CAPTIONS2;
update captions2 SET text='mal la verdad' where text like '%?%';

-- Ejercicios Data Types
-- 1)
-- Cuando se sabe que la mayoría de los datos a ingresar tienen el mismo tamaño
-- 2) VARCHAR, DOUBLE, INT
-- 3) La diferencia entre DATETIME y TIMESTAMP es que la primera ocupa más espacio que la segunda. TIMESTAMP llega hasta una fecha determinada.
-- 4) 
select curtime();
-- 5)
select curdate();
-- 6)
select weekday(now());
-- 7) 
select dayname(now());
-- 8)
select date_format(now(),'%m/%d/%Y');
-- 9) 
SELECT DATE_FORMAT(now(),'%M %D at %k:%i');
-- 10)
create table tweets(
tweet_content VARCHAR(140) NOT NULL,
username VARCHAR(20) NOT NULL,
time timestamp NOT NULL default current_timestamp
);
DESC TWEETS;
