-- Ver todas las bases de datos
show databases;
-- crear una nueva base
create database nueva_base;
-- Indica la base de datos seleccionada actual
drop database nueva_base;
select database();
-- Usar una base de deatos
use nueva_base;
-- Crear una nueva tabla
create table tabla_1(
columna1 VARCHAR(50),
columna2 INT
);
-- Ver las propiedades de las columnas que contiene a tabla
show columns from pet_shop.cats;
desc cats;
describe cats;
show tables;
-- Eliminar tabla
drop table cats;

-- Ejericio Nro 1
create database pasteleria;
use pasteleria;
select database();
show tables;
create table pastel(
name varchar(50),
cantidad int
);
desc pastel;
drop table pastel;
select database();
drop database pasteleria;
-- Ejercicio 2
create database pet_shop;
use pet_shop;
create table cats (
name varchar(50),
breed varchar(100),
age int
);
INSERT INTO cats (name,breed,age) VALUES ('Nala','Americano',3);
select * from cats;

-- INSERTS
INSERT INTO cats (name,breed,age) VALUES ('Nala','Americano',3);
INSERT INTO cats (name,breed,age) VALUES ('Aslan','Americano',5),('Nina','Americano',7);

-- Ejercicio 3
create database Ejercicios;
use Ejercicios;
create table people(
first_name varchar(20),
last_name varchar(20),
age int
);
INSERT INTO people (first_name,last_name,age) VALUES
('Emanuel','Trotta',24),
('Tatiana','Lagorio',21),
('Elias','Trotta',23);
SELECT * FROM people;
show columns from people;
drop table people;
-- USO DEL NOT NULL
show databases;
show tables from pet_shop;
select database();
use pet_shop;
create table dogs(name varchar(50) NOT NULL,
breed varchar(100) NOT NULL,
age INT NOT NULL);
desc dogs;

-- Uso de commillas
-- Si quiero agregar una comilla dentro de un texto debo anteponer un \
-- Ejemplo marios\' Pizza
select 'marios\' pizza';

-- USO DE DEFAULT
select database();
create table cats2(
name varchar(50) NOT NULL default 'pepe',
breed varchar(100) NOT NULL default 'siveriano',
age int NOT NULL default 10
);
show columns from cats2;
select * from cats2;
INSERT INTO cats2() values();

-- PRIMARY KEYS
create table cats3(
id_cats int not null primary key,
name varchar(50) NOT NULL default 'pepe',
breed varchar(100) NOT NULL default 'siveriano',
age int NOT NULL default 10
);
-- Otra manera
-- ACTALRACION, NO ES NECESARIO DECLARAR COMO NOT NULL UNA PRIMARY KEY
-- Porque por naturaleza ya no lo pueden ser
CREATE TABLE unique_cats2 (
	cat_id INT,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY (cat_id)
);
show columns from cats3;
insert into cats3 (id_cats,name,breed,age) values 
(1,'Aslan','Americano blanco',5),
(2,'Nala','Americano negro',2);
select * from cats3;
-- VALORES AUTOINCREMENTALES
CREATE TABLE cats4 (
	cat_id INT auto_increment,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY (cat_id)
);
desc cats4;

-- Ejercicio 4
show databases;
use ejercicios;
create table employees(
id int auto_increment,
last_name varchar(50) NOT NULL,
first_name varchar(50) NOT NULL,
middle_name varchar(50),
age int NOT NULL,
current_satatus varchar(30) NOT NULL default 'employed',
primary key(id)
);
desc employees;

INSERT INTO employees (last_name,first_name,age) values 
('Trotta','Emanuel',24);
select * from employees;

-- CRUD de datos
use pet_shop;
show tables;
drop table cats;
create table cats(
id int auto_increment,
name varchar(100),
breed varchar(100),
age int,
primary key(id)
);
insert into cats (name,breed,age) values
('Ringo','Siberiano',4),
('Tatiana','Border Colie',1),
('Scooby','Dogo',3);
select * from cats;

-- Ejercicio 5 CRUD 
create database shirts_db;
use shirts_db;
create table shirts(
shirt_id int auto_increment,
article varchar(50) NOT NULL,
color varchar(20) NOT NULL,
shirt_size varchar(3) NOT NULL,
last_worn int NOT NULL,
primary key(shirt_id)
);
insert into shirts(article,color,shirt_size,last_worn)
VALUES ('t-shirt','white','S',10),
('t-shirt','green','S',200),
('polo shirt','black','M',10),
('tank top','blue','S',50),
('t-shirt','pink','S',0),
('polo shirt','red','M',5),
('tank top','white','S',200),
('tank top','blue','M',15);
select * from shirts;
INSERT INTO shirts(article,color,shirt_size,last_worn)
VALUES ('polo shirt','pruple','M',50);
select article,color from shirts;
select shirt_id from shirts where shirt_size='M';
update shirts set shirt_size='L' where article='polo shirt';
update shirts set last_worn = 0 where last_worn = 15;
update shirts set color='off white',shirt_size='XS' where color = 'white';
delete from shirts where last_worn>=200;
delete from shirts where article='tank top';
delete from shirts;
drop table shirts;
show tables;
desc shirts;