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
