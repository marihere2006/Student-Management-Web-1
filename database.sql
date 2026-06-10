CREATE DATABASE student_web_1;

USE student_web_1;

CREATE TABLE students(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age INT,
    dept VARCHAR(50)
);