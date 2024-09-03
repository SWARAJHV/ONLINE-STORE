CREATE DATABASE OnlineStore;
USE OnlineStore;

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(100) NOT NULL
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(255) NOT NULL,
    CategoryID INT,
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
    Description TEXT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(255) UNIQUE,
    Phone VARCHAR(20),
    Address VARCHAR(255)
);



CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2),
    Status VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


INSERT INTO Categories (CategoryName) VALUES ('Electronics'), ('Clothing'), ('Books');



INSERT INTO Products (ProductName, CategoryID, Price, Stock, Description) 
VALUES ('Laptop', 1, 799.99, 10, '15-inch laptop with 8GB RAM and 256GB SSD'),
       ('T-Shirt', 2, 19.99, 50, '100% cotton t-shirt'),
       ('Novel', 3, 9.99, 20, 'Bestselling fiction novel');


INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES ('John', 'Doe', 'johndoe@example.com', '555-1234', '123 Elm St'),
       ('Jane', 'Smith', 'janesmith@example.com', '555-5678', '456 Oak St');
       
       
       
INSERT INTO Orders (CustomerID, TotalAmount, Status)
VALUES (1, 819.97, 'Shipped'),
       (2, 19.99, 'Processing');


INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES (1, 1, 1, 799.99),  -- John Doe bought a Laptop
       (1, 2, 1, 19.99),  -- John Doe bought a T-Shirt
       (2, 2, 1, 19.99);  -- Jane Smith bought a T-Shirt
       
       
SELECT P.ProductName, C.CategoryName, P.Price, P.Stock
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID;

SELECT O.OrderID, C.FirstName, C.LastName, O.OrderDate, OD.Quantity, P.ProductName, OD.Price
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Customers C ON O.CustomerID = C.CustomerID;


SELECT P.ProductName, SUM(OD.Quantity * OD.Price) AS TotalSales
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName;




