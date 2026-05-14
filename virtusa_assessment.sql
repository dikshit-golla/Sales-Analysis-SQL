CREATE database sales_analysis;

USE sales_analysis;

CREATE TABLE Customers(customer_id INT PRIMARY KEY,name VARCHAR(25), city VARCHAR(15));
CREATE TABLE Products(product_id INT PRIMARY KEY,name VARCHAR(50),category VARCHAR(15),price DECIMAL(10,2));
CREATE TABLE Orders(order_id INT PRIMARY KEY,customer_id INT,order_date DATE,FOREIGN KEY (customer_id) REFERENCES Customers(customer_id));
CREATE TABLE Order_Items(order_id INT,product_id INT,quantity INT,PRIMARY KEY (order_id,product_id),FOREIGN KEY (order_id) REFERENCES Orders(order_id), FOREIGN KEY (product_id) REFERENCES Products(product_id));


INSERT INTO Customers VALUES(1,'Dikshit','Mumbai');
INSERT INTO Customers VALUES(2,'Vishnu','Hyderabad');
INSERT INTO Customers VALUES(3,'Srinath','Kolkata');
INSERT INTO Customers VALUES(4,'Samuel','Chennai');
INSERT INTO Customers VALUES(5,'Riyaz','Ahmedabad');
INSERT INTO Customers VALUES(6,'Vijay','Hyderabad');
INSERT INTO Customers VALUES(7,'Harikesh','Delhi');
INSERT INTO Customers VALUES(8,'Harsha','Gurgaon');
INSERT INTO Customers VALUES(9,'Charan','Vijayawada');

INSERT INTO Products VALUES (1, 'iPhone 16 Pro', 'Mobile', 80000.00);
INSERT INTO Products VALUES (2, 'Samsung Galaxy S23', 'Mobile', 74999.00);
INSERT INTO Products VALUES (3, 'OnePlus 13R', 'Mobile', 42999.00);
INSERT INTO Products VALUES (4, 'Google Pixel 10 Pro', 'Mobile', 109999.00);
INSERT INTO Products VALUES (5, 'Nothing Phone 4a Pro', 'Mobile', 45999.00);
INSERT INTO Products VALUES (6, 'Lenovo ThinkPad X1', 'Laptop', 182000.00);
INSERT INTO Products VALUES (7, 'Dell XPS 13', 'Laptop', 250000.00);
INSERT INTO Products VALUES (8, 'HP Spectre x360 14', 'Laptop', 162000.00);
INSERT INTO Products VALUES (9, 'Apple MacBook Pro 14', 'Laptop', 249999.00);
INSERT INTO Products VALUES (10, 'boAt Rockerz 255 Neckband', 'Accessories', 1799.00);
INSERT INTO Products VALUES (11, 'OnePlus Buds 3 Pro', 'Accessories', 10999.00);
INSERT INTO Products VALUES (12, 'BOULT 240 Pro', 'Accessories', 1299.00);
INSERT INTO Products VALUES (13, 'Amazfit GTR 5', 'Smartwatch', 16999.00);
INSERT INTO Products VALUES (14, 'Noise Origin Ultra', 'Smartwatch', 6499.00);
INSERT INTO Products VALUES (15, 'OnePlus Watch 2R', 'Smartwatch', 17999.00);

INSERT INTO Orders VALUES (1, 4, '2026-01-05');
INSERT INTO Orders VALUES (2, 3, '2026-01-10');
INSERT INTO Orders VALUES (3, 1, '2026-01-15');
INSERT INTO Orders VALUES (4, 2, '2026-01-20');
INSERT INTO Orders VALUES (5, 5, '2026-01-25');
INSERT INTO Orders VALUES (6, 6, '2026-02-01');
INSERT INTO Orders VALUES (7, 7, '2026-02-05');
INSERT INTO Orders VALUES (8, 4, '2026-02-10');
INSERT INTO Orders VALUES (9, 3, '2026-02-15');
INSERT INTO Orders VALUES (10, 1, '2026-02-20');
INSERT INTO Orders VALUES (11, 2, '2026-02-25');
INSERT INTO Orders VALUES (12, 5, '2026-03-01');
INSERT INTO Orders VALUES (13, 6, '2026-03-05');
INSERT INTO Orders VALUES (14, 7, '2026-03-10');
INSERT INTO Orders VALUES (15, 4, '2026-03-15');
INSERT INTO Orders VALUES (16, 3, '2026-03-20');
INSERT INTO Orders VALUES (17, 1, '2026-03-25');
INSERT INTO Orders VALUES (18, 2, '2026-03-28');

INSERT INTO Order_Items VALUES (1, 6, 1);
INSERT INTO Order_Items VALUES (1, 9, 1);
INSERT INTO Order_Items VALUES (1,15,1);

INSERT INTO Order_Items VALUES (2, 7, 1);
INSERT INTO Order_Items VALUES (2, 2, 2);

INSERT INTO Order_Items VALUES (3, 2, 1);
INSERT INTO Order_Items VALUES (3, 10, 3);
INSERT INTO Order_Items VALUES (3,14,1);

INSERT INTO Order_Items VALUES (4, 2, 2);
INSERT INTO Order_Items VALUES (4, 10, 2);

INSERT INTO Order_Items VALUES (5, 3, 1);
INSERT INTO Order_Items VALUES (5, 10, 2);

INSERT INTO Order_Items VALUES (6, 6, 1);
INSERT INTO Order_Items VALUES (6, 10, 2);

INSERT INTO Order_Items VALUES (7, 2, 1);
INSERT INTO Order_Items VALUES (7, 10, 3);

INSERT INTO Order_Items VALUES (8, 9, 1);
INSERT INTO Order_Items VALUES (8, 6, 1);

INSERT INTO Order_Items VALUES (9, 7, 1);
INSERT INTO Order_Items VALUES (9, 2, 2);

INSERT INTO Order_Items VALUES (10, 2, 1);
INSERT INTO Order_Items VALUES (10, 10, 2);

INSERT INTO Order_Items VALUES (11, 2, 2);
INSERT INTO Order_Items VALUES (11, 10, 1);

INSERT INTO Order_Items VALUES (12, 3, 1);
INSERT INTO Order_Items VALUES (12, 10, 2);

INSERT INTO Order_Items VALUES (13, 6, 1);
INSERT INTO Order_Items VALUES (13, 10, 2);

INSERT INTO Order_Items VALUES (14, 2, 1);
INSERT INTO Order_Items VALUES (14, 10, 3);

INSERT INTO Order_Items VALUES (15, 9, 1);
INSERT INTO Order_Items VALUES (15, 6, 1);

INSERT INTO Order_Items VALUES (16, 7, 1);
INSERT INTO Order_Items VALUES (16, 2, 2);

INSERT INTO Order_Items VALUES (17, 2, 1);
INSERT INTO Order_Items VALUES (17, 10, 2);

INSERT INTO Order_Items VALUES (18, 2, 2);
INSERT INTO Order_Items VALUES (18, 10, 1);

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM Order_Items;

#Top SELLING PRODUCTS
SELECT P.name,SUM(I.quantity) AS no_of_products_sold from Products P JOIN Order_Items I ON I.product_id=P.product_id GROUP BY I.product_id ORDER BY no_of_products_sold DESC LIMIT 5;

#MOST VALUABLE CUSTOMERS
SELECT C.name,SUM(P.price*I.quantity) AS TOTAL_CUSTOMER_VALUE FROM Customers C JOIN Orders O ON C.customer_id=O.customer_id JOIN Order_Items I ON I.order_id=O.order_id JOIN Products P ON P.product_id=I.product_id GROUP BY C.customer_id ORDER BY TOTAL_CUSTOMER_VALUE DESC LIMIT 5;

#MONTHLY REVENUE ANALYSIS
SELECT month(O.order_date) AS MONTH, SUM(P.price*I.quantity) AS TOTAL_REVENUE FROM Orders O JOIN Order_Items I ON O.order_id=I.order_id JOIN Products P ON P.product_id=I.product_id GROUP BY MONTH;

#CATEGORY-WISE SALES 
SELECT P.category, SUM(I.quantity) AS no_of_sales FROM Products P JOIN Order_Items I ON I.product_id=P.product_id GROUP BY P.category;

#INACTIVE CUSTOMERS 
SELECT C.customer_id,C.name FROM Customers C WHERE C.customer_id NOT IN (SELECT O.customer_id FROM Orders O);

#INACTIVE CUSTOMERS OVER LAST THREE MONTHS 
SELECT C.customer_id,C.name FROM Customers C WHERE C.customer_id NOT IN (SELECT O.customer_id FROM Orders O WHERE DATEDIFF(CURDATE(), order_date) <= 90);