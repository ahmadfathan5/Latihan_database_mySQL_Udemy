-- cara membuat table yang berelasi

CREATE TABLE wishlist(
	id INT NOT NULL AUTO_INCREMENT,
	id_product VARCHAR(10) NOT NULL,
	description TEXT,
	PRIMARY KEY (id),
	CONSTRAINT fk_wishlist_product
		FOREIGN KEY (id_product) REFERENCES products (id)
) ENGINE = InnoDB;

desc wishlist ;

show CREATE table wishlist;

-- menghapus relasi/ foreign key
ALTER TABLE wishlist 
DROP CONSTRAINT fk_wishlist_product;

-- menambahkan relasi pada table yang sudah dibuat
ALTER TABLE wishlist 
ADD CONSTRAINT fk_wishlist_product
FOREIGN KEY (id_product) REFERENCES products (id);

-- menambahkan data pada table yang berelasi

INSERT INTO wishlist (id_product, description)
VALUES ('P0001', 'Makanan Kesukaan');

SELECT * FROM wishlist ; 

-- data pada table product yang berelasi tidak bisa dihapus
DELETE FROM products 
WHERE id = 'P0001';


-- mode pada foreign key
-- RESTRICT : DELETE = X || UPDATE = X
-- CASCADE : DELETE = V || UPDATE = V
-- NO ACTION : DELETE = SKIP || UPDATE = SKIP
-- SET NULL : DELETE = NULL || UPDATE = NULL || ASAL DI IZINKAN NULL

-- mode restrict
ALTER TABLE wishlist 
ADD CONSTRAINT fk_wishlist_product
FOREIGN KEY (id_product) REFERENCES products (id);

-- mode casecade
ALTER TABLE wishlist 
ADD CONSTRAINT fk_wishlist_product
FOREIGN KEY (id_product) REFERENCES products (id)
ON DELETE CASCADE ON UPDATE CASCADE;


-- ===================================================================
-- join table

SELECT * FROM wishlist 
JOIN products p ON (wishlist.id_product = p.id);

SELECT w.id as id_wishlist, p.id as id_product, p.name, w.description FROM wishlist w 
JOIN products p ON (w.id_product = p.id);

-- menambahkan relasi di table wishlist ke table customer
desc customer ;

ALTER TABLE wishlist 
ADD COLUMN id_customer INT;

ALTER TABLE wishlist
ADD CONSTRAINT fk_wishlist_customer
FOREIGN KEY (id_customer) REFERENCES customer (id);


show CREATE table wishlist ;

UPDATE wishlist 
set id_customer = 1
WHERE id = 2;

SELECT * FROM wishlist ;


SELECT c.email, p.id, p.name, w.description FROM wishlist w 
JOIN products p ON p.id = w.id_product
JOIN customer c ON c.id = w.id_customer;


-- ==========================================================================
-- one to one relationship
-- jenis relasi yang mana 1 data hanya terhubung dengan 1 data di table yang berelasi

-- membuat table wallet yang direlasikan dengan table customer dalam relasi one to one
CREATE TABLE wallet(
id INT NOT NULL AUTO_INCREMENT,
id_customer INT NOT NULL,
balance INT NOT NULL DEFAULT 0,
PRIMARY KEY (id),
UNIQUE KEY id_customer_unique (id_customer),
FOREIGN KEY fk_wallet_customer (id_customer) REFERENCES customer (id)
) ENGINE = InnoDB;

SELECT * FROM customer c ;

INSERT INTO wallet(id_customer) values (1), (3);

SELECT * FROM wallet ;

SELECT c.email, w.balance
FROM wallet w JOIN customer c ON w.id_customer = c.id


-- =========================================================================
-- one to many relationship
-- data bisa digunaka lebih dari 1 kali pada table relasinya

CREATE TABLE category(
id VARCHAR(10) NOT NULL ,
name VARCHAR(100) NOT NULL,
PRIMARY KEY (id),
UNIQUE KEY id_category_unique (id)
) ENGINE = InnoDB;

ALTER TABLE products 
DROP COLUMN category;

ALTER TABLE products 
ADD COLUMN id_category VARCHAR(10);

ALTER TABLE products 
ADD CONSTRAINT fk_products_categories
FOREIGN KEY (id_category) REFERENCES category(id);

SELECT * FROM products p ;

INSERT INTO category (id, name)
VALUES ('C0001', 'Makanan'),
('C0002', 'Minuman'),
('C0003', 'Lain-Lain');

UPDATE products
SET id_category = 'C0001'
WHERE id IN ('P0001', 'P0002', 'P0003', 'P0004', 'P0005', 'P0006', 'P0013', 'P0014', 'P0015');

UPDATE products
SET id_category = 'C0002'
WHERE id IN ('P0007', 'P0008', 'P0009');

UPDATE products
SET id_category = 'C0003'
WHERE id IN ('P0010', 'P0011', 'P0012', 'P0016');

SELECT p.id, p.name, c.name
FROM products p 
JOIN category c ON c.id = p.id_category;




-- ===============================================================================
-- MANY to MANY relationship
CREATE TABLE orders(
	id INT NOT NULL AUTO_INCREMENT,
	total INT NOT NULL,
	order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id)
) ENGINE = InnoDB;

DESC order_detail;

CREATE TABLE orders_detail(
	id_product VARCHAR(10) NOT NULL,
	id_order INT NOT NULL,
	price INT NOT NULL,
	quantity INT NOT NULL,
	PRIMARY KEY (id_product, id_order)
) ENGINE = InnoDB;

ALTER TABLE orders_detail 
ADD CONSTRAINT fk_order_detail_product
FOREIGN KEY(id_product) REFERENCES products(id);

ALTER TABLE orders_detail 
ADD CONSTRAINT fk_order_detail_order
FOREIGN KEY(id_order) REFERENCES orders(id);

show CREATE table orders_detail ;

desc orders_detail 

INSERT INTO orders(total)
VALUES (50000);

INSERT INTO orders_detail(id_product, id_order, price, quantity)
VALUES ('P0001', 1, 25000, 1),
       ('P0002', 1, 25000, 1);

INSERT INTO orders_detail(id_product, id_order, price, quantity)
VALUES ('P0003', 2, 25000, 1),
       ('P0004', 3, 25000, 1);

INSERT INTO orders_detail(id_product, id_order, price, quantity)
VALUES ('P0001', 2, 25000, 1),
       ('P0003', 3, 25000, 1);

SELECT * FROM orders ;
SELECT * FROM orders_detail ;


SELECT * FROM orders o 
JOIN orders_detail o1 ON o1.id_order = o.id
JOIN products p ON p.id = o1.id_product;

SELECT o.id, p.id, p.name, o1.quantity, o1.price FROM orders o 
JOIN orders_detail o1 ON o1.id_order = o.id
JOIN products p ON p.id = o1.id_product;




-- ======================================================
-- Jenis Jenis JOIN
select * from category ;
select * from products p  ;

insert into category(id, name)
values ('C0004', 'Oleh-oleh'),
('C0005', 'Gadeget');

INSERT INTO products(id, name, price, quantity) 
VALUES	('X0001', 'X1',  20000, 100),
	  	('X0002', 'X2',  25000, 100),
	 	('X0003', 'X3',  15000, 100);

-- >> INNER JOIN 
SELECT * FROM category c
INNER JOIN products p ON p.id_category = c.id

-- >> RIGHT JOIN
SELECT * FROM category c
RIGHT JOIN products p ON p.id_category = c.id

-- >> LEFT JOIN
SELECT * FROM category c
LEFT JOIN products p ON p.id_category = c.id

-- >> CROSS JOIN
SELECT * FROM category c
LEFT JOIN products p 

CREATE TABLE numbers(
id int NOT NULL,
primary key (id)
)engine = InnoDB;

INSERT INTO numbers(id)
values (1),
       (2),
       (3),
       (4),
       (5),
       (6),
       (7),
       (8),
       (9),
       (10);
      
SELECT numbers1.id, numbers2.id, (numbers1.id * numbers2.id)
FROM numbers as numbers1
         CROSS JOIN numbers as numbers2
ORDER BY numbers1.id, numbers2.id;


-- ==========================================================================
-- SUB QUERY
-- menambahakan query lain ke dalam suatu query untuk mendapat hasil yang diinginkan


-- SUB QUERY DI WHERE
SELECT * FROM products p
WHERE price > (SELECT AVG(price) FROM products p2 )


-- sub query di from
update products set price = 1000000 where id ='X0003';

SELECT MAX(price) from products p ;
 
SELECT MAX(price) 
FROM (
	select price from category c join products p on p.id_category = c.id
) as cp;




-- ======================================================================
-- set operator

-- jenis operator SET 
-- >> UNION 
-- >> UNION ALL 
-- >> INTERSECT 
-- >> MINUS


-- membuat table baru guest book

CREATE TABLE guestbooks(
	id INT NOT NULL AUTO_INCREMENT,
	email VARCHAR(100) NOT NULL,
	title VARCHAR(200) NOT NULL,
	content TEXT,
	PRIMARY KEY (id)
) ENGINE = InnoDB;

INSERT INTO guestbooks(email, title, content)
VALUES ('guest@gmail.com', 'Hello', 'Hello'),
       ('guest2@gmail.com', 'Hello', 'Hello'),
       ('guest3@gmail.com', 'Hello', 'Hello'),
       ('eko@gmail.com', 'Hello', 'Hello'),
       ('eko@gmail.com', 'Hello', 'Hello'),
('eko@gmail.com', 'Hello', 'Hello');


SELECT * FROM guestbooks ;

-- union : DUPLIKAT TIDAK AKAN DITAMPILKAN
SELECT DISTINCT email FROM customer c 
UNION
SELECT DISTINCT email FROM guestbooks ;

SELECT  email FROM customer c 
UNION 
SELECT  email FROM guestbooks ;

-- union ALL : DUPLIKAT JUGA DITAMPILKAN
SELECT DISTINCT email FROM customer c 
UNION ALL
SELECT DISTINCT email FROM guestbooks ;

SELECT emails.email, COUNT(emails.email) FROM
(SELECT  email FROM customer c 
UNION ALL
SELECT  email FROM guestbooks) as emails 
GROUP BY emails.email;


-- intersect : hanya menampilakan data yang beririsan
-- inner join ternyata juga secara otomatis melakukan intersect tetaoi ditambahkan distinct
SELECT DISTINCT email
FROM customers
WHERE email IN (SELECT DISTINCT email FROM guestbooks);

SELECT DISTINCT customers.email
FROM customers
INNER JOIN guestbooks ON (guestbooks.email = customers.email);


-- minus : data yang sama antara query pertama dan kedua maka data tersebut akan dihapus, dan hanya menampilakn data dari query pertama
-- left join menghasilakn minus tetapi ditambahkan kondisi where is null
SELECT DISTINCT customer.email, guestbooks.email
FROM customer
         LEFT JOIN guestbooks ON (customer.email = guestbooks.email)
WHERE guestbooks.email IS NULL;



-- TRANSACTION
-- hanya bisa menggunakan perintah di DML

START TRANSACTION;

INSERT INTO guestbooks (email, title, content)
VALUES ('contoh@gmail.com', 'Contoh', 'Contoh'),
       ('contoh2@gmail.com', 'Contoh', 'Contoh'),
       ('contoh3@gmail.com', 'Contoh', 'Contoh');

SELECT *
FROM guestbooks;

COMMIT;

START TRANSACTION;

DELETE
FROM guestbooks;

SELECT *
FROM guestbooks;

ROLLBACK;



-- ===================================================================================
-- locking
-- LOCKING OTOMATIS MENGGUNKANA TRANSACTION

-- LOCKING MANUAL

-- DEAD LOCK
-- DEAD LOCK TERJADI KETIKA USER 1 MEN LOCK DATA 1 DAN USER 2 MENLOCK DATA 2, KETIKA USER 1 INGIN MENLOCK DATA 2 DAN BEGITU JUGA USER 2 INGIN MENLOCK DATA 1 MEREKA AKAN SALING MENUNGGU

















