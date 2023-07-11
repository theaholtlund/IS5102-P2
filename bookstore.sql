-- Module code: IS5102
-- Module: Database Management Systems
-- Code for book store scenario, adding and manipulating data

-- Ensure the integrity contraints are enforced
PRAGMA foreign_keys = TRUE;

-- As this script will be tested multiple times, instructions are added to drop tables if they already exist
DROP TABLE IF EXISTS customer_phone;
DROP TABLE IF EXISTS "contains";
DROP TABLE IF EXISTS "order";
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS book_genre;
DROP TABLE IF EXISTS supplier_phone;
DROP TABLE IF EXISTS supplies;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS "edition";
DROP TABLE IF EXISTS book;

-- Start off by creating the tables based on the relationtal schema from previous task
CREATE TABLE customer (
    customer_id   VARCHAR(30) NOT NULL,
    customer_name VARCHAR(30) NOT NULL,
    email         VARCHAR(50) NOT NULL,
    street        VARCHAR(50),
    city          VARCHAR(30),
    postcode      VARCHAR(10),
    country       VARCHAR(30),
    PRIMARY KEY (customer_id));

-- Add tuples to the customer table with the INSERT statement
INSERT INTO customer
VALUES  ('10001', 'Lisa Thompsen', 'lisa.tho@gmail.com', '12 Newbury Street', 'St Andrews', 'KY16 8AA', 'United Kingdom'),
        ('10002', 'Henry Stone', 'henry-stone@hotmail.com', '140 Market Parkway', 'London', 'E1 7AD', 'United Kingdom'),
        ('10003', 'Michelle Herrold', 'michelle@gmail.com', '10 Strawberry Lane', 'Manchester', 'M1 1AA', 'United Kingdom'),
        ('10004', 'Stephen Smith', 'stsmith@st-andrews.ac.uk', '24 Timberwood Road', 'Edinburgh', 'EH2 4AC', 'United Kingdom'),
        ('10005', 'Rosie Turner', 'rosie-turner@gmail.com', '44 Hay Market', 'Birmingham', 'B11 6EJ', 'United Kingdom'),
        ('10006', 'Audrey Jones', 'audreyjo@hotmail.com', '2 Sesame Street', 'Liverpool', 'L32 9HB', 'United Kingdom'),
        ('10007', 'Gabrielle Taylor', 'gabby.tay@icloud.com', '112 Breakaway Path', 'Leeds', 'LS15 71A', 'United Kingdom'),
        ('10008', 'Justin Davies', 'justin.davies@hotmail.com', '20 Cherry Lane', 'York', 'YO1 0GJ', 'United Kingdom'),
        ('10009', 'Mark Gold', 'mgold@gmail.com', '38 Portbridge Lane', 'Edinburgh', 'EH1 1AF', 'United Kingdom'),
        ('10010', 'Jonathan Brown', 'jonbro@gmail.com', '16 Bellevue', 'St Andrews', 'KY16 8AE', 'United Kingdom'),
        ('10011', 'Robin Evans', 'robeva@outlook.com', '140 Honey Road', 'Glasgow', 'G4 0PE', 'United Kingdom'),
        ('10012', 'Joe Thomas', 'joe-tho@gmail.com', '8 Arlington Boulevard', 'Edinburgh', 'EH1 1AD', 'United Kingdom');

-- Create a table for the composite attribute customer phone
CREATE TABLE customer_phone (
    customer_id     VARCHAR(30) NOT NULL,
    phone_type      VARCHAR(30),
    phone_number    VARCHAR(30),
    PRIMARY KEY (customer_id, phone_type, phone_number),
    FOREIGN KEY (customer_id) REFERENCES customer);

-- Now, add tuples to the customer_phone table with the INSERT statement
INSERT INTO customer_phone
VALUES  ('10001', 'Mobile', '+44 1234 462093'),
        ('10002', 'Work', '+44 1234 673301'),
        ('10003', 'Landline', '+44 1234 983792'),
        ('10004', 'Mobile', '+40 1234 672910'),
        ('10005', 'Work', '+44 1234 988901'),
        ('10006', 'Mobile', '+44 1234 442332'),
        ('10007', 'Mobile', '+44 1234 605040'),
        ('10008', 'Mobile', '+1 123 797272'),
        ('10009', 'Work', '+44 1234 090908'),
        ('10010', 'Mobile', '+44 1234 603340'),
        ('10011', 'Mobile', '+44 1234 399876'),
        ('10012', 'Mobile', '+44 1234 982243');

-- Create a table for the order entity
CREATE TABLE "order" (
    order_id            VARCHAR(30) NOT NULL,
    delivery_street     VARCHAR(30),
    delivery_city       VARCHAR(30),
    delivery_postcode   VARCHAR(30),
    delivery_country    VARCHAR(30),
    date_ordered        date,
    date_delivered      date,
    customer_id         VARCHAR(30),
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES customer);

-- Add tuples to the order table with the INSERT statement
INSERT INTO "order" 
VALUES  ('10001', '12 Newbury Street', 'St Andrews', 'KY16 8AA', 'United Kingdom', '2022-06-16', '2022-06-20', '10001'),
        ('10002', '140 Market Parkway', 'Edinburgh', 'EH1 1AD', 'United Kingdom', '2022-02-12', '2022-02-18', '10012'),
        ('10003', '140 Market Parkway', 'London', 'E1 7AD', 'United Kingdom', '2022-10-11', '2022-10-19', '10005'),
        ('10004', '10 Strawberry Lane', 'Manchester', 'M1 1AA', 'United Kingdom', '2022-01-08', '2022-01-16', '10006'),
        ('10005', '24 Timberwood Road', 'Edinburgh', 'EH2 4AC', 'United Kingdom', '2022-03-03', '2022-03-09', '10004'),
        ('10006', '44 Hay Market', 'Birmingham', 'B11 6EJ', 'United Kingdom', '2022-06-18', '2022-06-23', '10007'),
        ('10007', '2 Sesame Street', 'Liverpool', 'L32 9HB', 'United Kingdom', '2022-02-24', '2022-02-24', '10008'),
        ('10008', '112 Breakaway Path', 'Leeds', 'LS15 71A', 'United Kingdom', '2022-06-16', '2022-06-23', '10002'),
        ('10009', '20 Cherry Lane', 'York', 'YO1 0GJ', 'United Kingdom', '2022-09-01', '2022-09-08', '10011'),
        ('10010', '38 Portbridge Lane', 'St Andrews', 'KY16 8AF', 'United Kingdom', '2022-10-16', '2022-10-21', '10002'),
        ('10011', '16 Bellevue', 'St Andrews', 'KY16 8AE', 'United Kingdom', '2022-04-22', '2022-04-28', '10010'),
        ('10012', '2 Sesame Street', 'Liverpool', 'L32 B14', 'United Kingdom', '2022-10-16', '2022-10-23', '10003'),
        ('10013', '24 Springfield Road', 'Edinburgh', 'EH1 1AF', 'United Kingdom', '2022-08-28', '2022-09-02', '10009'),
        ('10014', '38 Portbridge Lane', 'London', 'E1 7AA', 'United Kingdom', '2022-10-17', '2022-10-24', '10003'),
        ('10015', '10 Franklin Avenue', 'Bristol', 'BS13 2AC', 'United Kingdom', '2022-01-30', '2022-02-05', '10001');


-- Create a table for the book entity
CREATE TABLE book (
    book_id       VARCHAR(30) NOT NULL,
    title         VARCHAR(30) NOT NULL,
    author        VARCHAR(30) NOT NULL,
    publisher     VARCHAR(30) NOT NULL,
    PRIMARY KEY (book_id));

-- Add tuples to the book table with the INSERT statement
INSERT INTO book 
VALUES  ('1001', 'SQL For Dummies', 'Stephen Hawking, Leonardo da Vinci', 'HarperCollins'),
        ('1002', 'Learning SQL The Hard Way', 'Dr. Seuss', 'Ultimate Books'),
        ('1003', 'Struggles Of Database Management Systems', 'David Baldacci', 'Macmillan Publishers'),
        ('1004', 'Making Beautiful Code', 'Elly Griffiths, Mark Twain', 'HarperCollins'),
        ('1005', 'DDL and DML', 'Boris Johnson', 'Supreme Publising UK'),
        ('1006', 'Accomplish Your Goals In Just Two Weeks', 'Leo Tolstoy, Michael Bublé', 'Simon and Schuster'),
        ('1007', 'Best Golfers In St Andrews', 'William Shakespeare', 'New Press Publishing'),
        ('1008', 'New Ways To Learn SQL', 'Lewis Capaldi', 'Ultimate Books'),
        ('1009', 'How To Stop Procrastinating', 'Agatha Christie', 'New Press Publishing'),
        ('1010', 'E-R Diagrams And Relational Schemas', 'Enid Blyton, Drew Barrymore', 'HarperCollins'),
        ('1011', 'Learning Computer Science', 'J. K. Rowling', 'Macmillan Publishers'),
        ('1012', 'How To Become A Great Coder', 'Liz Truss', 'Supreme Publising UK'),
        ('1013', 'How To Excel In Your Job', 'Eddie Murphy', 'HarperCollins'),
        ('1014', 'Coding Like A Pro: JavaScript', 'Steve Carell', 'Ultimate Books'),
        ('1015', 'The Art Of Good Coding', 'Will Ferrell', 'Transparent Books Publishing');

-- Create a table for the composite attribute book genre
CREATE TABLE book_genre (
    book_id    VARCHAR(30) NOT NULL,
    genre      VARCHAR(30),
    PRIMARY KEY (book_id, genre),
    FOREIGN KEY (book_id) REFERENCES book);

-- Add tuples to the book_genre table with the INSERT statement
INSERT INTO book_genre 
VALUES  ('1001', 'Science Fiction'),
        ('1002', 'Science Fiction'),
        ('1003', 'Science Fiction'),
        ('1004', 'Dystopian'),
        ('1005', 'Thriller'),
        ('1006', 'Science and Technology'),
        ('1007', 'Science and Technology'),
        ('1008', 'Science Fiction'),
        ('1009', 'Thriller'),
        ('1010', 'Science and Technology'),
        ('1011', 'Mystery'),
        ('1012', 'Science and Technology'),
        ('1013', 'Mystery'),
        ('1014', 'Science Fiction'),
        ('1015', 'Fantasy');

-- Create a table for the edition entity
CREATE TABLE "edition" (
    book_id             VARCHAR(30) NOT NULL,
    edition_no          INT(5),
    edition_type        CHAR(9),
    price               NUMERIC(5, 2),
    quantity_in_stock   INTEGER(8),
    CONSTRAINT edition_no
    CHECK(edition_no BETWEEN 1 AND 20)
    PRIMARY KEY (edition_no, edition_type),
    FOREIGN KEY (book_id) REFERENCES book);

-- Add tuples to the edition table with the INSERT statement
INSERT INTO "edition"
VALUES  ('1001', 1, 'Audiobook', 18.80, 112),
        ('1002', 2, 'Hardcover', 112.00, 3),
        ('1003', 3, 'Audiobook', 30.00, 122),
        ('1004', 4, 'Hardcover', 50.00, 2),
        ('1005', 5, 'Audiobook', 120.20, 19),
        ('1006', 6, 'Audiobook', 60.00, 3),
        ('1007', 7, 'Hardcover', 80.00, 242),
        ('1008', 8, 'Paperback', 26.00, 60),
        ('1009', 9, 'Paperback', 6.99, 2),
        ('1010', 10, 'Paperback', 40.60, 140),
        ('1011', 11, 'Paperback', 58.50, 168),
        ('1012', 12, 'Audiobook', 8.90, 411),
        ('1013', 13, 'Hardcover', 12.99, 102),
        ('1014', 14, 'Audiobook', 12.50, 4),
        ('1015', 15, 'Hardcover', 116.00, 88);

-- Create a table for the supplier entity
CREATE TABLE supplier (
    supplier_id     VARCHAR(30) NOT NULL,
    supplier_name   VARCHAR(30),
    account_no      VARCHAR(30),
    PRIMARY KEY (supplier_id));

-- Add tuples to the supplier table with the INSERT statement
INSERT INTO supplier
VALUES  ('101', 'Rich Distribution AS', '00001'),
        ('102', 'Book Source', '00002'),
        ('103', 'Bargain Books', '00003'),
        ('104', '101 Good Books', '00004'),
        ('105', 'Sassy Books', '00005'),
        ('106', 'Lomond Books Ltd', '00006'),
        ('107', 'Books For The People', '00007'),
        ('108', 'Hardwick Books', '00008'),
        ('109', 'UK Book Publishing', '00009'),
        ('110', 'Green Books UK', '00010'),
        ('111', 'Kingdom Publishers', '00011'),
        ('112', 'New Books For You', '00012'),
        ('113', 'Really Good Books', '00013'),
        ('114', 'Special Coding Books', '00014'),
        ('115', 'Publishing Good SQL', '00015');

-- Create a table for the composite attribute supplier phone
CREATE TABLE supplier_phone (
    supplier_id     VARCHAR(30) NOT NULL,
    phone           VARCHAR(30),
    PRIMARY KEY (supplier_id, phone),
    FOREIGN KEY (supplier_id) REFERENCES supplier);

-- Add tuples to the supplier_phone table with the INSERT statement
INSERT INTO supplier_phone
VALUES  ('101', '+44 1234 012314'),
        ('102', '+44 1234 873920'),
        ('103', '+1 123 258023'),
        ('104', '+44 1234 056620'),
        ('105', '+44 1234 802380'),
        ('106', '+44 1234 798029'),
        ('107', '+44 1234 803340'),
        ('108', '+44 1234 983829'),
        ('109', '+44 802930'),
        ('110', '+44 982039'),
        ('111', '+44 1234 702938'),
        ('112', '+44 1234 712470');

-- Create a table for the reviews relationship
CREATE TABLE reviews (
    customer_id     VARCHAR(30) NOT NULL,
    book_id         VARCHAR(30) NOT NULL,
    rating          NUMERIC(1),
    PRIMARY KEY (customer_id, book_id),
    FOREIGN KEY (customer_id) REFERENCES customer,
    FOREIGN KEY (book_id) REFERENCES book);

-- Add tuples to the reviews relationship table with the INSERT statement
INSERT INTO reviews
VALUES  ('10001', '1001', 1),
        ('10001', '1013', 4),
        ('10002', '1002', 5),
        ('10002', '1014', 2),
        ('10003', '1003', 1),
        ('10003', '1015', 2),
        ('10004', '1004', 5),
        ('10005', '1005', 2),
        ('10006', '1006', 5),
        ('10007', '1007', 2),
        ('10008', '1008', 4),
        ('10009', '1009', 1),
        ('10010', '1010', 5),
        ('10011', '1011', 3),
        ('10012', '1012', 5);

-- Create a table for the supplies relationship
CREATE TABLE supplies (
    supplier_id     VARCHAR(30) NOT NULL,
    edition_no      INT(5),
    edition_type    CHAR(9),
    supply_price    NUMERIC(5, 2),
    CONSTRAINT edition_no
    CHECK(edition_no BETWEEN 1 AND 20)
    PRIMARY KEY (supplier_id, edition_no, edition_type),
    FOREIGN KEY (supplier_id) REFERENCES supplier,
    FOREIGN KEY (edition_no, edition_type) REFERENCES "edition");

-- Add tuples to the supplies relationship table with the INSERT statement
INSERT INTO supplies
VALUES  ('101', 1, 'Audiobook', 10.00),
        ('102', 2, 'Hardcover', 70.00),
        ('103', 3, 'Audiobook', 20.00),
        ('104', 4, 'Hardcover', 2.00),
        ('105', 5, 'Audiobook', 18.00),
        ('106', 6, 'Audiobook', 22.00),
        ('107', 7, 'Hardcover', 18.00),
        ('108', 8, 'Paperback', 65.00),
        ('109', 9, 'Paperback', 4.00),
        ('110', 10, 'Paperback', 30.00),
        ('111', 11, 'Paperback', 12.00),
        ('112', 12, 'Audiobook', 8.00);

-- Create a table for the contains relationship
CREATE TABLE "contains" (
    order_id        VARCHAR(30) NOT NULL,
    edition_no      INT(5),
    edition_type    CHAR(9),
    amount          NUMERIC(5, 2),
    CONSTRAINT edition_no
    CHECK(edition_no BETWEEN 1 AND 20)
    PRIMARY KEY (order_id, edition_no, edition_type),
    FOREIGN KEY (order_id) REFERENCES "order",
    FOREIGN KEY (edition_no, edition_type) REFERENCES "edition");

-- Add tuples to the contains relationship table with the INSERT statement
INSERT INTO "contains"
VALUES  ('10001', 1, 'Audiobook', 2),
        ('10002', 2, 'Hardcover', 1),
        ('10003', 3, 'Audiobook', 1),
        ('10004', 4, 'Hardcover', 1),
        ('10005', 5, 'Audiobook', 1),
        ('10006', 6, 'Audiobook', 1),
        ('10007', 7, 'Hardcover', 1),
        ('10008', 8, 'Paperback', 2),
        ('10009', 9, 'Paperback', 1),
        ('10010', 10, 'Paperback', 1),
        ('10011', 11, 'Paperback', 1),
        ('10012', 12, 'Audiobook', 2),
        ('10013', 13, 'Hardcover', 1),
        ('10014', 14, 'Audiobook', 1),
        ('10015', 15, 'Hardcover', 1);
       
-- List all books published by “Ultimate Books” which are in the “Science Fiction” genre
SELECT        book.book_id, book.title, book.publisher, book_genre.genre
FROM          book
NATURAL JOIN  book_genre
WHERE         book.publisher = "Ultimate Books"
AND           book_genre.genre = "Science Fiction"
ORDER BY      book.title;

-- List titles and ratings of books in the “Science and Technology” genre, ordered first by rating, then by title
SELECT        book.book_id, book.title, book_genre.genre, reviews.rating
FROM          book
NATURAL JOIN  book_genre
NATURAL JOIN  reviews
WHERE         book_genre.genre = "Science and Technology"
ORDER BY      reviews.rating DESC, book.title;

-- List orders placed by customers with an address in Edinburgh, since 2020, in chronological order, latest first
SELECT    customer.customer_id, customer.city, "order".date_ordered
FROM      customer
JOIN      "order" ON customer.customer_id = "order".customer_id
WHERE     customer.city = "Edinburgh"
AND       "order".date_ordered > 2020-01-01
ORDER BY  "order".date_ordered DESC;

-- List all book editions which have less than 5 items in stock, together with the name, account number and supply price of the minimum priced supplier for that edition
SELECT    "edition".edition_type, "edition".edition_no, "edition".quantity_in_stock, "edition".price, supplier.supplier_name, supplier.account_no, MIN(supplies.supply_price)
FROM      supplies
JOIN      supplier ON supplier.supplier_id = supplies.supplier_id
JOIN      "edition" ON supplies.edition_no = "edition".edition_no
AND       supplies.edition_type = "edition".edition_type
WHERE     "edition".quantity_in_stock < 5 
GROUP BY  "edition".edition_no;

-- Calculate the total value of all audiobook sales since 2020 for each publisher
SELECT    book.publisher, SUM("edition".price) AS "Value"
FROM      "order"
JOIN      "contains" ON "contains"."order_id" = "order"."order_id"
JOIN      book ON book.book_id = "edition".book_id
JOIN      book_genre ON book_genre.book_id = book.book_id
JOIN      "edition" ON "edition".book_id = book.book_id
WHERE     "edition".edition_type = "Audiobook"
AND       "order".date_ordered > 2020-01-01
GROUP BY  book.publisher;

-- List all book titles with a rating of 3 or lower, together with the price the book is sold for, ordered by publisher
SELECT    book.title, book.publisher, "edition".price, reviews.rating
FROM      book
JOIN      "edition" ON book.book_id = "edition".book_id
JOIN      reviews ON book.book_id = reviews.book_id
WHERE     reviews.rating < 3
ORDER BY  book.publisher;

-- List the name of all customers who placed an order within the past three months from October 1st 2022, and their e-mail address
SELECT    customer.customer_name, customer.email, "order".date_ordered
FROM      customer
JOIN      "order" ON customer.customer_id = "order".customer_id
WHERE     "order".date_ordered > "2022-07-01"
ORDER BY  "order".date_ordered DESC;

-- Calculate the average supply price of all books with the "Science Fiction" genre for each publisher
SELECT    book.title, book.publisher, AVG("edition".price) AS "Average price", book_genre.genre
FROM      book
JOIN      book_genre ON book.book_id = book_genre.book_id
JOIN      "edition" ON book.book_id = "edition".book_id
WHERE     book_genre.genre = "Science Fiction"
GROUP BY  book.publisher;

-- Find the number of customers who gave more than one review for books they have purchased
SELECT    customer_id, COUNT (customer_id) AS "Count"
FROM      reviews
GROUP BY  customer_id
HAVING    COUNT(customer_id) > 1 ;

-- Find all books that have more than one author
SELECT *
FROM book
WHERE author LIKE "%,%";

-- Create a view showing all the bookstore customers based in the United Kingdom
CREATE VIEW [UK Bookstore Customers] AS
SELECT customer_name, country, email
FROM customer
WHERE country = 'United Kingdom';

-- Create a view showing all books that have "SQL" in the title
CREATE VIEW [SQL Books] AS
SELECT book_id, title
FROM book
WHERE title LIKE "%SQL%";
