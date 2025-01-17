--Librairie-requetes

SELECT firstname, lastname FROM authors;

SELECT name FROM editors WHERE name LIKE ;

SELECT l.id, b.title, m.firstname, m.lastname, l.loan_date, l.return_date 
FROM loans l
JOIN book_editions be ON l.book_edition_isbn = be.isbn
JOIN books b ON be.book_id = b.id
JOIN members m ON l.member_id = m.id
WHERE l.is_returned = FALSE AND l.return_date < CURDATE();

SELECT title FROM books WHERE LENGTH(title) < 50;

--ecommerce-requetes

SELECT oi.quantity
FROM ORDER_ITEMS oi
WHERE oi.product_id = 2456;

SELECT p.name
FROM PRODUCTS p
WHERE p.stock = 0;


SELECT c.name, c.email
FROM CUSTOMER c
WHERE c.email LIKE '@gmail.com';

--exposition d'art

DROP DATABASE IF EXISTS art_exhibition;

CREATE DATABASE art_exhibition;
USE art_exhibition;

CREATE TABLE authors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(255) NOT NULL,
    lastname VARCHAR(255) NOT NULL
);

CREATE TABLE artworks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    acquisition_date DATE NOT NULL,
    catalog_number VARCHAR(255) NOT NULL UNIQUE,
    author_ids VARCHAR(255) 
);

CREATE TABLE rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_number INT NOT NULL,
    room_name VARCHAR(255),
    num_of_artworks INT, 
    lighting_type VARCHAR(255)
);

CREATE TABLE exhibitions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    artwork_id INT NOT NULL,
    room_id INT NOT NULL,
    start_date DATE NOT NULL,
    duration INT NOT NULL,
    FOREIGN KEY (artwork_id) REFERENCES artworks(id),
    FOREIGN KEY (room_id) REFERENCES rooms(id)
);

CREATE TABLE loans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    artwork_id INT NOT NULL,
    owner_firstname VARCHAR(255),
    owner_lastname VARCHAR(255),
    owner_address VARCHAR(255),
    loan_start_date DATE,
    loan_duration INT,
    FOREIGN KEY (artwork_id) REFERENCES artworks(id)
);

-- Table des Assurances
CREATE TABLE insurance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    artwork_id INT NOT NULL,
    insurance_premium DECIMAL(10, 2),
    insured_value DECIMAL(10, 2),
    company_name VARCHAR(255),
    company_address VARCHAR(255),
    FOREIGN KEY (artwork_id) REFERENCES artworks(id)
);

CREATE TABLE private_owners (
    owner_id INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(255),
    lastname VARCHAR(255),
    address VARCHAR(255),
    artwork_type VARCHAR(255)
);

--gestion de stock

DROP DATABASE IF EXISTS gcivil_stock;

CREATE DATABASE gcivil_stock;
USE gcivil_stock;

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(255) NOT NULL,
    designation VARCHAR(255) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE suppliers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL
);

CREATE TABLE product_suppliers (
    product_id INT NOT NULL,
    supplier_id INT NOT NULL,
    purchase_price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (product_id, supplier_id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
);


