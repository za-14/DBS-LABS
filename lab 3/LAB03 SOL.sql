-- LAB 03

--Q1
CREATE TABLE my_first_table(
    name varchar2(255),
    email varchar2(255),
    age int,
    marks number(3,1)
);

DESC my_first_table;

--Q2
CREATE TABLE Products(
    product_id int,
    product_name varchar2(255),
    price decimal(5,2),
    supplier_id int,
    category_id int
);

--Q3
CREATE TABLE IF NOT EXISTS Products(
    product_id int,
    product_name varchar2(255),
    price decimal(5,2),
    supplier_id int,
    category_id int  
);

--Q4
CREATE TABLE duplicate_Products LIKE Products;

--Q5
CREATE TABLE dup_data_Products AS
SELECT product_id, product_name, price, supplier_id, category_id
FROM Products;

DESC dup_data_Products;

--Q6
CREATE TABLE Suppliers(
    supplier_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    supplier_name varchar2(255) NOT NULL,
    address varchar2(255) NOT NULL,
    city varchar2(3) NOT NULL
);

DESC Suppliers;

--Q7
CREATE TABLE Order_Details(
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity NUMBER CHECK (quantity < 50)
);

INSERT INTO Order_Details VALUES (1,1,100);

SELECT * FROM Order_Details;

--Q8
CREATE TABLE Supplier_2(
supplier_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
supplier_name varchar2(255),
address varchar2(255),
city varchar2(3) CHECK ( city IN ('KHI','ISB','LHR') )
);

INSERT INTO Supplier_2 (supplier_name, address, city)
Values ('MySupplier1','MyAddress','LHR');

INSERT INTO Supplier_2 (supplier_name, address, city)
Values ('MySupplier2','MyAddress','RWP');

SELECT * FROM Supplier_2;

--Q9
CREATE TABLE ORDERS(
    order_id INT PRIMARY KEY,
    order_date varchar2(10) CHECK (order_date LIKE '__/__/____'),
    ship_address varchar2(255)
);

INSERT INTO Orders VALUES (1,'23/05/2023','Address');
INSERT INTO Orders VALUES (2, TO_DATE('2-5-2023','D-M-YYYY'),'Address2');

--Q10
ALTER TABLE Products
MODIFY product_id PRIMARY KEY;

--Q11
DROP TABLE Suppliers;

CREATE TABLE Suppliers(
    supplier_id NUMBER PRIMARY KEY,
    supplier_name varchar2(255),
    address varchar2(255),
    city varchar2(3)  
);

--Q12
CREATE TABLE Categories(
    category_id INT PRIMARY KEY,
    category_name varchar2(255),
    description varchar2(255)
);

--Q13
DROP TABLE Products;

CREATE TABLE Products(
    product_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_name varchar2(255),
    CONSTRAINT UC_Pname UNIQUE (product_name),
    price decimal(5,2),
    SupId INT,
    CatID INT,
    --FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
    CONSTRAINT FK_SupID FOREIGN KEY (SupID) REFERENCES Suppliers(supplier_id),
    -- FOREIGN KEY (category_id) REFERENCES Categories(category_id)
    CONSTRAINT FK_CatID FOREIGN KEY (CatID) REFERENCES CATEGORIES(category_id)
);

--Q14
DROP TABLE ORDERS;

CREATE TABLE ORDERS(
    order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_date DATE DEFAULT sysdate,
    ship_address varchar2(255)
);

INSERT INTO Orders (ship_address) VALUES ('Address');
SELECT * FROM Orders;

--Q15
DROP TABLE ORDER_DETAILS;

CREATE TABLE ORDER_DETAILS(
    order_ID INT,
    product_ID INT,
    quantity number(2,0),
    CONSTRAINT PK_op_ID PRIMARY KEY (order_ID, product_ID)
);

--Q16
INSERT INTO CATEGORIES 
VALUES (1,'Beverages','Soft drinks, coffees, teas');
INSERT INTO CATEGORIES 
VALUES (2,'Dairy Products','Cheese');
INSERT INTO CATEGORIES 
VALUES (3,'Condiments','Sweet and savory sauces, spreads and
seasonings');
INSERT INTO CATEGORIES 
VALUES (4,'Confections','Desserts and candies');

SELECT * FROM CATEGORIES 
ORDER BY category_id;

--Q17

INSERT INTO Suppliers
Values (1,'Alpha','205 A, Street 11, Gulshan-e-Iqbal','KHI');
INSERT INTO Suppliers
Values (2,'Bravo','100 B, Street 2, F-6/3','ISB');

SELECT * FROM SUPPLIERS
ORDER BY supplier_id;

-- Q18

INSERT INTO Products (product_ID,product_name,price,SupId,CatID)
Values (1,'Chai',100.00,1,1);
INSERT INTO Products (product_ID,product_name,price,SupId,CatID)
Values (2,'Cheddar Cheese',950.00,2,2);
INSERT INTO Products (product_ID,product_name,price,SupId,CatID)
Values (3,'BBQ sauce',500.00,2,3);
INSERT INTO Products (product_ID,product_name,price,SupId,CatID)
Values (4,'Coffee',200.00,1,1);
INSERT INTO Products (product_ID,product_name,price,SupId,CatID)
Values (5,'Sprite',80.00,1,1);
INSERT INTO Products (product_ID,product_name,price,SupId,CatID)
Values (6,'Mayo Garlic Sauce',450.00,2,3);

SELECT * FROM Products
ORDER BY product_ID;

-- Q19
SELECT * FROM PRODUCTS WHERE CatID = 1 AND SupID = 1;

--Q20
SELECT CatID, ROUND(AVG(price),2)
FROM PRODUCTS
GROUP BY CatID;

--Q21
SELECT category_name 
FROM Categories
ORDER BY category_name;