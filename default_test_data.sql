DROP DATABASE IF EXISTS test1;

CREATE DATABASE test1;
USE test1;
CREATE TABLE accounts (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20),
  surname VARCHAR(20),
  credits INT,
  age INT
);
