create database manyToMany;
use manyToMany;
CREATE TABLE reviewers(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL
);

CREATE TABLE series(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(100) NOT NULL UNIQUE,
released_year YEAR NOT NULL,
genere VARCHAR(30) NOT NULL
);
ALTER TABLE series RENAME COLUMN genere TO genre;

CREATE TABLE reviewes(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
rating DECIMAL(2,1) NOT NULL,
id_serie INT NOT NULL,
id_reviewer INT NOT NULL,
FOREIGN KEY (id_serie) REFERENCES series(id),
FOREIGN KEY (id_reviewer) REFERENCES reviewers(id)
);

INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
 
 
INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
    
 
INSERT INTO reviews(id_serie, id_reviewer, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);
ALTER TABLE reviewes RENAME TO reviews;

-- Ejercicios
-- TV Chalenge #1
SELECT title,rating FROM series JOIN reviews ON series.id = reviews.id_serie;
-- TV Chalenge #2
SELECT title,ROUND(AVG(rating),2) as avg_rating FROM series JOIN reviews ON series.id = reviews.id_serie GROUP BY title ORDER BY avg_rating;
-- TV Chalenge #3
SELECT first_name,last_name,rating FROM reviewers JOIN reviews ON reviewers.id = reviews.id_reviewer;
-- TV Chalenge #4
SELECT distinct title as unreviewed_series from series left join reviews ON series.id = reviews.id_serie WHERE rating is null;
-- TV Chalenge #5
SELECT genre,AVG(rating) as av_rating FROM series JOIN reviews ON series.id = reviews.id_serie GROUP BY genre ORDER BY av_rating;
-- TV Challenge #6
SELECT 
    first_name,
    last_name,
    IFNULL(COUNT(reviews.id), 0) AS COUNT,
    IFNULL(MIN(rating), 0.0) AS MIN,
    IFNULL(MAX(rating), 0.0) AS MAX,
    IFNULL(AVG(rating), 0) AS AVG,
    CASE
        WHEN COUNT(rating) >= 10 THEN 'POWERUSER'
        WHEN COUNT(rating) > 0 AND COUNT(rating)<10 THEN 'ACTIVE'
        ELSE 'INACTIVE'
    END AS STATUS
FROM
    reviewers
        LEFT JOIN
    reviews ON reviewers.id = reviews.id_reviewer
GROUP BY last_name , first_name;

-- TV Challenge #7
SELECT 
    title,
    rating,
    CONCAT(first_name, ' ', last_name) AS reviewer
FROM
    series
        JOIN
    reviews ON reviews.id_serie = series.id
        JOIN
    reviewers ON reviews.id_reviewer = reviewers.id;