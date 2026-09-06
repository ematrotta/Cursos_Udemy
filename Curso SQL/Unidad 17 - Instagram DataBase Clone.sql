create database instagram;
use instagram;
create table users(
id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
name VARCHAR(30) NOT NULL UNIQUE,
created_at TIMESTAMP default NOW()
);

create table photos(
id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
image_url VARCHAR(150) NOT NULL UNIQUE,
user_id INT NOT NULL,
created_at TIMESTAMP default NOW(),
FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
);

create table comments(
id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
comment_text VARCHAR(150) NOT NULL,
user_id INT NOT NULL,
photo_id INT NOT NULL,
created_at TIMESTAMP default NOW(),
FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
FOREIGN KEY(photo_id) REFERENCES photos(id) ON DELETE CASCADE
);

CREATE TABLE likes (
    user_id INTEGER NOT NULL,
    photo_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    
    -- Se realiza esta acción para asegurarse que no se repita el mismo id de usuario
    -- con el mismo id de foto
    PRIMARY KEY(user_id, photo_id)
);

CREATE TABLE follows (
    follower_id INTEGER NOT NULL,
    followee_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    PRIMARY KEY(follower_id, followee_id)
);


