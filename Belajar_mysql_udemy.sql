-- melihat databases
SHOW DATABASES;

-- membuat database
CREATE DATABASE belajar_mysql;

-- menghapus database
DROP DATABASE belajar_mysql;

-- menggunakan database
USE belajar_mysql;

-- ===================================================================

-- TIPE DATA NUMBER
-- INT : bilangan bulat
-- >> INT dan BIGINT yang umum digunakan

-- FLOAT dan DOUBLE : bilangan pecahan

-- DECIMAL : tipe data khusus yang bisa ditentukan jumlah precision dan scalenya
-- >> contoh : DECIMAL(5,2) == min : -999.99, max : 999.99 /// DECIMAL(5,0) == min : -99999, max : 99999  

-- NUMBER ATTRIBUTE
-- >> TYPE(N) : memasukan angka sebanyak N
-- >> ZEROFILL : secara otomatis memasukan angka 0 pada data INT yang kurang
-- >>> contoh : INT(3) ZEROFILL, maka apabila dimasukan 1 buah angka misal 7, maka akan secara otomatis akan ditambahkan jumlah karakter yang kurang sehingga menjadi 007



-- TIPE DATA STRING
-- CHAR dan VARCHAR : memasukan jumlah maksimal dari karakter yang bisa ditampung oleh char atau varchar
-- >>> contoh : CHAR(10) atau VARCHAR(10).... karakter maksimal adalah 10 tidak boleh lebih
-- yang membedakan adalah cara menyimpannya.... char: data yang disimpan akan selalu sama dengan jumlah karakter yang sudah ditentukan, sedangkan varchar akan menyesuaikan karakter yang diinput

-- TEXT : tidak bisa ditentukan panjang karakternya
-- terbagi jadi 4 : TINYTEXT, TEXT, MEDIUMTEXT, LONGTEXT

-- ENUM : tipe data string yang bisa ditentukan pilihan-pilihannya,... dan hanya bisa diisi dengan data yang sudah ditentukan diawal, selain itu akan ditolak



-- TIPE DATA DATE dan TIME : khusus mendefinisikan data waktu baik tanggal dan jam, menit, detik
-- >> DATE : hanya data tahun-bulan-tanggal (YYYY-MM-DD)
-- >> DATETIME : data tahun-bulan-tanggal dan waktu jam:menit:detik (YYYY-MM-DD HH:MM:SS)
-- >> TIMESTAMP : data tahun-bulan-tanggal dan waktu jam:menit:detik (YYYY-MM-DD HH:MM:SS), yang membedakan untuk informasi tambahan seperti created_at, updated_at
-- >> TIME : hanya data waktu jam:menit:detik (HH:MM:SS)
-- >> YEAR : hanya data tahun (YYYY)



-- TIPE DATA BOOLEAN : hanya digunakan data kebenaran, TRUE or FALSE 



-- TIPE DATA LAIN LAIN, digunakan apabila dibutuhkan
-- BLOB
-- SPATIAL : untuk data geospasial 
-- JSON
-- SET 
-- dan lain lain


-- ================================================================================================================

-- melihat storage ENGINE : cara database mengelola data
SHOW ENGINES ;

-- melihat table
SHOW TABLES;

-- membuat table
CREATE TABLE barang(
	id INT NOT NULL,
	nama VARCHAR(100) NOT NULL,
	harga INT NOT NULL DEFAULT 0,
	jumlah INT  NOT NULL DEFAULT 0
) ENGINE = InnoDB;

-- melihat struktur table
DESCRIBE barang;
-- atau
DESC barang;
-- melihat struktur table dalam bentuk syntax
SHOW CREATE TABLE barang;


-- merubah atau mengedit table
ALTER TABLE barang 
	ADD COLUMN nama_kolom TEXT, -- untuk menambahkan kolom
	DROP COLUMN nama_kolom, -- menghapus kolom
	RENAME COLUMN nama_kolom TO nama_kolom_baru, -- merubah nama kolom
	MODIFY nama_kolom VARCHAR(100) AFTER nama_kolom2, -- untuk mengubah tipe data
	MODIFY nama_kolom VARCHAR(100) AFTER nama_kolom2, -- untuk mengubah tipe data dan meletakannya setelah nama_kolom2
	MODIFY nama_kolom VARCHAR(100) FIRST -- mengubah tipe data dan meletakannya dipaling depan
;

-- contoh merubah struktur table
ALTER TABLE barang 
	ADD COLUMN deskripsi TEXT;

ALTER TABLE barang 
	ADD COLUMN salah TEXT;

ALTER TABLE barang 
	DROP COLUMN salah;

ALTER TABLE barang 
	add created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- mengubah status NULL, menambahkan default value, dan menambah currenta_TIMEstamp
desc barang;
ALTER TABLE barang 
	modify kode INT NOT NULL,
	modify nama VARCHAR(100) NOT NULL,
	modify harga INT NOT NULL DEFAULT 0,
	modify jumlah INT NOT NULL DEFAULT 0,
	


-- menginput data
INSERT INTO barang (kode,nama) VALUES (1,'mamat');

-- melihat isi table
Select * from barang;

-- membuat ulang table
TRUNCATE barang;
show tables;

-- menghapus table
DROP TABLE products;



-- menginput data kedalam table
-- membuat table products
-- >> UNSIGNED : tidak boleh negatif
CREATE TABLE products(
	id VARCHAR(10) NOT NULL,
	name VARCHAR(100) NOT NULL,
	description TEXT,
	price INT UNSIGNED NOT NULL,
	quantity INT UNSIGNED NOT NULL DEFAULT 0,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

show tables;
desc products;

-- input data
INSERT INTO products(id, name, price, quantity) 
VALUES('P001', 'Mie Ayam Original', 15000, 100);

INSERT INTO products(id, name, description, price, quantity) 
VALUES('P002', 'Mie Ayam Bakso', 'Mie Ayam Original + Bakso Sapi', 20000, 100);

INSERT INTO products(id, name, price, quantity) 
VALUES	('P003', 'Mie Ayam Ceker',  20000, 100),
	  	('P004', 'Mie Ayam Spesial',  25000, 100),
	 	('P005', 'Mie Ayam Yamin',  15000, 100);

-- menambahkan UNIQUE pada kolom id
ALTER TABLE products MODIFY id VARCHAR(10) NOT NULL UNIQUE;

-- melihat isi table
SELECT * FROM products;



-- =============================================================
-- PERINTAH SELECT : melihat isi data

-- melihat semua data menggunakan tanda *
SELECT * FROM products;

-- melihat kolom tertentu : sebuatkan kolom yang ingin dilihat
SELECT id, name, price, quantity FROM products;

-- penyebutan kolom tidak harus berurutan


-- =======================================
-- PRIMARY KEY : identitas untuk tiap baris data, dan harus unik tidak boleh ada yang sama
-- pada MySQL primari key gak wajib ada sedangkan di postgree harus ada
-- pada kasus khusus pada relasi table many to many maka multiple collumn primary key akan di gunakan... sebaiknya primary key hanya di satu kolom

-- menginisiasi kolom yang menjadi primary key pada table yang sudah dibuat
ALTER TABLE products ADD PRIMARY KEY (id);
desc products ;

show CREATE table products ;

-- ====================================================================
-- WHERE CLAUSE
-- digunakan untuk mecari data dengan kondisi tertentu

SELECT * FROM products WHERE quantity = 100;
SELECT * FROM products WHERE price = 15000;
SELECT * FROM products WHERE id = 'P001';
SELECT * FROM products WHERE name = 'MiE AYAM BAKSO';

-- =============================================================
-- UPDATE DATA

-- menambah kolom kategori
desc products;
ALTER TABLE products 
ADD COLUMN category ENUM('Makanan', 'Minuman', 'Lain-Lain')
AFTER name;

SELECT *FROM products ;

-- update data 1 kolom
UPDATE products 
SET id = 'P0005'
WHERE id = 'P005';

-- update lebih dari 1 kolom
UPDATE products
SET category = 'Makanan',
	description = 'Mie Ayam original + ceker'
WHERE id = 'P003';

-- update dengan aritmatika
UPDATE products 
SET price = price + 5000
WHERE id = 'P005';

SELECT * FROM products ;

-- Menghapus data pada table

INSERT INTO products(id, name, price, quantity) 
VALUES('P009', 'Mie Ayam Original', 15000, 100);

DELETE FROM products
WHERE id = 'P009';


-- =============================================================
-- ALIAS : digunakan untuk mengubah nama table atau kolom

-- alias pada kolom
SELECT 
id as kode,
name as nama,
category as kategori,
price as harga,
quantity as "jumlah produk"
FROM products ;


-- alias pada table
SELECT 
p.id as kode,
p.name as nama,
p.category as kategori,
p.price as harga,
p.quantity as "jumlah produk"
FROM products as p ; 


-- ============================
-- WHERE OPERATOR
-- > operator perbandingan
-- >> sama dengan (=)
-- >> tidak sama dengan (!= atau <>)
-- >> kurang dari (<)
-- >> kurang dari sama dengan (<=)
-- >> lebih dari (>)
-- >> lebih dari (>=)


-- menambahkan data lagi
INSERT INTO products(id, category, name, price, quantity)
VALUES ('P0006', 'Makanan', 'Bakso Rusuk', 25000, 200),
       ('P0007', 'Minuman', 'Es Jeruk', 10000, 300),
       ('P0008', 'Minuman', 'Es Campur', 15000, 500),
       ('P0009', 'Minuman', 'Es Teh Manis', 5000, 400),
       ('P0010', 'Lain-Lain', 'Kerupuk', 2500, 1000),
       ('P0011', 'Lain-Lain', 'Keripik Udang', 10000, 300),
       ('P0012', 'Lain-Lain', 'Es Krim', 5000, 200),
       ('P0013', 'Makanan', 'Mie Ayam Jamur', 20000, 50),
       ('P0014', 'Makanan', 'Bakso Telor', 20000, 150),
       ('P0015', 'Makanan', 'Bakso Jando', 25000, 300);

-- operator lebih dari (>)
SELECT quantity FROM products 
WHERE quantity > 100;

-- lebih dari samadengan (>=)
SELECT quantity FROM products 
WHERE quantity >= 100;

-- tidak sama dengan
SELECT * FROM products 
WHERE category != 'Makanan';

-- sama dengan
SELECT * FROM products 
WHERE category = 'Makanan';


-- Operatir logika

-- operator AND == 1 AND 1 = 1 selain itu false (0)

-- operator AND
SELECT * FROM products 
WHERE quantity > 100 AND price > 20000;

SELECT * FROM products 
WHERE category = 'makanan' AND price < 20000;


-- operator OR == 0 or 0 = 0 selain itu TRUE (1)

-- operator OR
SELECT * FROM products 
WHERE quantity > 100 OR price > 20000;

SELECT * FROM products 
WHERE category = 'makanan' AND price < 20000;


-- kombinasi operator and dan or
-- yang didalam kurung menjadi prioritas

SELECT * FROM products 
WHERE (category = 'makanan' OR quantity >500) AND price > 20000;

SELECT * FROM products 
WHERE category = 'makanan' OR (quantity >500 AND price > 20000);


-- LIKE OPERATOR
-- >> LIKE 'B%' : string dengan awalan B
-- >> LIKE '%B' : string dengan akhiran B
-- >> LIKE '%B%' : string dengan B ditengah atau diantara karakter lain
-- >> NOT LIKE : tidak LIKE


-- mencari sebagian string

SELECT * FROM products 
WHERE name LIKE '%mie%'


-- disaran tidak digunakan apabila data terlalu banyak

--  NULL OPERATOR
-- is NULL untuk mencari NULL dan IS NOT NULL data yang tidak null

SELECT * FROM products 
WHERE description IS NULL;

SELECT * FROM products 
WHERE description IS NOT NULL;


-- OPERATOR BEETWEEN
-- mencari data beradasarkan rentang
SELECT * FROM products 
WHERE price BETWEEN 10000 AND 20000;

SELECT * FROM products 
WHERE price NOT BETWEEN 10000 AND 20000;


-- OPERATOR IN
-- mencari data berdasarkan ada atau tidak yaa intinya sebagai pengganti operator OR

SELECT * FROM products 
WHERE category IN('Makanan','Minuman');

SELECT * FROM products 
WHERE category NOT IN('Makanan','Minuman');



-- =====================================================
-- KLAUSA Order By

SELECT id, category, name, price FROM products 
ORDER BY category;

-- mengurutkan dengan 2 parameter

SELECT id, category, name, price FROM products 
ORDER BY category ASC, price DESC;


-- ================================
-- KLAUSA LIMIT
-- membatasi jumlah baris data yang ditampilkan

-- hanya menampilkan 5 data
SELECT * FROM products 
LIMIT 5;

-- menampilkan 5 data dengan offset 5

SELECT * FROM products 
LIMIT 5,5;


-- ==========================
-- SELECT DISTINCT data
-- untuk menghilakan data duplikt
-- pastikan yang di disticn kolom yang tidak unik

SELECT DISTINCT category FROM products ;


-- =======================================================
-- NUMERIC FUNCTION

-- %, MOD : modulo atau sisa bagi
-- * : perkalian
-- + : penjumlahan
-- - : pengurangan
-- -x : membuat angka jadi nilai minus
-- / : pembagian
-- div : hasil bagi tapi bulat

-- perkalian
SELECT 10, 10, 10*10 as hasil;

-- div
SELECT id, name, price, price div 1000 as 'price in K' from products ;

-- operator matematika lainnya
SELECT id, COS(price), SIN(price), TAN(price) FROM products ;

-- more aritmatik function
SELECT id, name, price from products WHERE  price div 1000 > 15 ;



-- ========================================================
-- AUTO INCREMENT
-- mengisi data berurut secara otomatis,... terutama digunakan pada kolom id

CREATE TABLE admin(
	id int not null auto_increment,
	first_name varchar(100) not null,
	last_name varchar(100) not null,
	primary key (id)
) engine = innoDB;

desc admin;

-- kolom yang auto increment tidak perlu di input manual

INSERT INTO admin(first_name, last_name)
VALUES ('Eko', 'Khannedy'),
       ('Budi', 'Nugraha'),
       ('Joko', 'Morro');

SELECT * FROM admin order by id;

DELETE from admin WHERE id = 3;

INSERT INTO admin(first_name, last_name)
VALUES ('Rully', 'Hidayat');

-- untuk melihat id yang terakhir di insert
SELECT LAST_INSERT_ID() ;



-- ===========================================
-- string function

SELECT id, 
	LOWER(name) as 'Name Lower', -- lowercase
	UPPER(name) as 'Name Upper', -- Uppercase
	LENGTH(name) as 'Name Length' -- banyak karakter
FROM products ;

-- =================================================
-- Date time function

SELECT id, created_at,
	EXTRACT(YEAR FROM created_at) as Year,
	EXTRACT(MONTH FROM created_at) as Month
FROM products;

SELECT id, created_at,
	YEAR(created_at),
	MONTH(created_at)
FROM products p ;


-- ======================================================
-- flow control function
-- seperti if else pada bahasa pemprograman pada umumnya

-- CASE : layaknya swtich case pada umunya

SELECT id, category,
	CASE category 
		WHEN 'Makanan' THEN 'Enak'
		WHEN 'Minuman' THEN 'Segar'
		ELSE 'Apaan Tuh?!'
		END AS 'new_kategori'
FROM products p; 


-- IF FUNCTION
SELECT id, price,
	IF(
		price <= 15000, 'Murah',
		 	IF (
		 		price <= 20000, 'Mahal', 'Mahal Banget'
		 	)
	) as 'Mahal?'
FROM products p;


-- IF NULL FUNCTION
SELECT id, name, 
	IFNULL(description, 'Kosong')
FROM products p ;

-- --===========================================
-- Aggregate Function
-- saat menggunakan agregat function... tidak bisa digabungkan dengan kolom biasa
SELECT COUNT(id) as 'total produk' FROM products p group by category; 

SELECT MAX(price) as 'harga tertinggi' FROM products p group by category;

SELECT MIN(price) as 'harga terendah' FROM products p group by category;

SELECT AVG(price) as 'rata-rata harga produk' FROM products p group by category;

SELECT SUM(quantity) as 'rata-rata harga produk' FROM products p group by category ;
-- dan functon agregat lain

-- ===================================================================
-- GROPING Klausa

SELECT category,
	COUNT(id) as 'total produk',
	MAX(price) as 'harga tertinggi',
	MIN(price) as 'harga terendah',
	AVG(price) as 'rata-rata harga produk',
	SUM(quantity) as 'abskba'
FROM products p 
GROUP BY category ;

-- having klausa.... digunakan untuk filtering data... pengganti where saat menggunakan agregat function
SELECT category,
	COUNT(id) as total
FROM products p 
GROUP BY category 
HAVING total > 5;



-- =======================================================================
-- Constraint
-- digunakan untuk menjaga data agar tetep baik.... menjaga terjadi validasi yang salah di program kita

-- >> unique constrain : menjaga agar tidak ada data yang duplikat pada kolom yang harus unik

-- membuat table customer dengan unique key constraint

CREATE TABLE customer(
	id INT NOT NULL AUTO_INCREMENT,
	email VARCHAR(100) NOT NULL,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100),
	PRIMARY KEY (id),
	UNIQUE KEY email_uniqe (email)
) ENGINE = InnoDB;

desc customer;

-- hapus constrain
ALTER TABLE customer 
DROP CONSTRAINT email_uniqe;

-- menambahkan constraint pada table yang sudah dibuat
ALTER TABLE customer 
ADD CONSTRAINT email_unique UNIQUE (email);

-- memasukan data
INSERT INTO customer(email, first_name, last_name)
VALUES ('eko@gmail.com', 'eko', 'kurniawan');

SELECT * FROM customer ;

INSERT INTO customer(email, first_name, last_name)
VALUES ('kurniawan@gmail.com', 'eko', 'kurniawan');

-- >> cek constraint : digunakan untuk mengecek data sebelum di input dengan kondisi tertentu

-- cara membuatnya sama seperti di unique

-- menambahkan contraint di table product dengan alter
-- test input
select * from products p ;

INSERT INTO products(id, name, category, price, quantity) 
VALUES('P0017', 'permen', 'Lain-lain', 500, 1000);

UPDATE products 
SET price = '500'
WHERE id = 'P0016';

ALTER TABLE products
ADD CONSTRAINT price_check CHECK (price >= 1000);


-- =======================================================
-- index
-- dengan index database akan tersimpan dalam bentuk B-tree, atau di simpan dalam bentuk tree bukan tabular... sehingga dengan begitu bisa membuat pencarian data dalam database akan menjadi jauh lebih cepat

-- kekurangan menggunakan index membuat proses manipulasi data menjadi lebih lambat
-- sehingga disarankna untuk tidak menggunakan index pada banyak kolom...
-- tentukan dengan bijak dalam penggunaan index manaa yang harus digunakan index dan mana yang tidak


-- apabila sudah menggunakan primary key dan atau constrain unique itu diperlukan index lagi

-- membuat table dengan index

CREATE TABLE sellers(
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	name2 VARCHAR(100),
	name3 VARCHAR(100),
	email VARCHAR(100) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE KEY (email),
	INDEX name_index(name),
	INDEX name2_index(name2),
	INDEX name3_index(name3),
	INDEX name1_name2_name3_index(name, name2, name3) -- ini digunakan untuk membuat index sekaligus jadi gak perlu yang index yang pertama (name) karna sudah tercover oleh index ini... tapi index untuk name2 dan 3 tetap diperlukan
)Engine = InnoDB;

desc sellers ;

-- menambahkan index pada table yang sudah jadi
ALTER TABLE sellers 
ADD INDEX name_index(name);

-- menghapus index pada table
ALTER TABLE sellers 
DROP INDEX name_index;



-- ===============================================================================
-- FULL TEXT SEARCH
-- full text search memungkinkan kita bisa mencari sebagian kata di kolom dengan tipe data string
-- ini sangat cocok ketika pada kasus yang memang membutuhkan pencari yang tidak hanya sekedar operasi (equals / sama dengan)
-- catatan: mysql bukan database untuk mesin search jadi ini fitur yang tidak terlalu digunakna untuk search engine
-- CATATAN LAGI : FULLTEXT SAMA DENGAN INDEX

-- membuat table dengan full text >>> cara membuatnya sama saja seperti fitur fitur lain
-- jadi sekarang kita hanya menggunakan alter table karna table sudah dibuat

ALTER TABLE products 
ADD FULLTEXT product_fulltext (name, description);

show CREATE table products ;


-- mode natural language mode : penyesuaian per kata
SELECT * FROM products p
WHERE MATCH(name, description)
AGAINST('ayam' IN NATURAL LANGUAGE MODE)


-- BOOLEAN mode : PEMILIHAN DENGAN KONDISI ADA DAN ATAU TIDAK ADA KATA TERTENTU
SELECT * FROM products p
WHERE MATCH(name, description)
AGAINST('+ayam -bakso' IN BOOLEAN MODE)


-- QUERY EXPANTION	 mode : MENCARI DATA LAIN YANG MENDEKATI DATA PERTAMA YANG DICARI
SELECT * FROM products p
WHERE MATCH(name, description)
AGAINST('bakso' WITH QUERY EXPANSION)













