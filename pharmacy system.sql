CREATE DATABASE PharmacyDB;

USE PharmacyDB;

CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(100)
);

CREATE TABLE Supplier (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    address VARCHAR(100)
);

CREATE TABLE Medicine (
    medicine_id INT PRIMARY KEY,
    medicine_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(10,2),
    stock_quantity INT,
    expiry_date DATE,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    address VARCHAR(100)
);

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    job_role VARCHAR(50),
    phone VARCHAR(15),
    salary DECIMAL(10,2)
);

CREATE TABLE Purchase (
    purchase_id INT PRIMARY KEY,
    supplier_id INT,
    purchase_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);

CREATE TABLE Purchase_Details (
    purchase_detail_id INT PRIMARY KEY,
    purchase_id INT,
    medicine_id INT,
    quantity INT,
    purchase_price DECIMAL(10,2),
    FOREIGN KEY (purchase_id) REFERENCES Purchase(purchase_id),
    FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id)
);

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    sale_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Sales_Details (
    sale_detail_id INT PRIMARY KEY,
    sale_id INT,
    medicine_id INT,
    quantity INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (sale_id) REFERENCES Sales(sale_id),
    FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id)
);

CREATE TABLE Billing (
    bill_id INT PRIMARY KEY,
    sale_id INT,
    bill_date DATE,
    total_amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    FOREIGN KEY (sale_id) REFERENCES Sales(sale_id)
);

INSERT INTO Category VALUES
(1, 'Tablets', 'Tablet Medicines'),
(2, 'Capsules', 'Capsule Medicines'),
(3, 'Syrup', 'Liquid Medicines'),
(4, 'Supplements', 'Vitamin and Health Supplements');

INSERT INTO Supplier VALUES
(101, 'ABC Medical Suppliers', '9876500001', 'Chandigarh'),
(102, 'HealthCare Distributors', '9876500002', 'Mohali'),
(103, 'MediPlus Suppliers', '9876500003', 'Delhi');

INSERT INTO Medicine VALUES
(201, 'Paracetamol', 1, 20, 100, '2027-12-15'),
(202, 'Amoxicillin', 2, 50, 80, '2027-10-20'),
(203, 'Cetirizine', 1, 15, 120, '2028-01-10'),
(204, 'Cough Syrup', 3, 90, 50, '2027-08-15'),
(205, 'Vitamin C', 4, 60, 70, '2028-05-20');

INSERT INTO Customer VALUES
(301, 'Rahul Sharma', '9811100001', 'Chandigarh'),
(302, 'Amit Kumar', '9811100002', 'Mohali'),
(303, 'Priya Singh', '9811100003', 'Delhi'),
(304, 'Neha Verma', '9811100004', 'Ludhiana');

INSERT INTO Employee VALUES
(401, 'Rohit Kumar', 'Pharmacist', '9811200001', 25000),
(402, 'Anjali Sharma', 'Manager', '9811200002', 35000),
(403, 'Vikas Singh', 'Cashier', '9811200003', 18000);

INSERT INTO Purchase VALUES
(501, 101, '2026-10-25', 5000),
(502, 102, '2026-10-26', 4000),
(503, 103, '2026-10-27', 3000);

INSERT INTO Purchase_Details VALUES
(601, 501, 201, 100, 15),
(602, 502, 202, 80, 40),
(603, 503, 204, 50, 70);

INSERT INTO Sales VALUES
(701, 301, 401, '2026-10-28', 100),
(702, 302, 402, '2026-10-29', 150),
(703, 303, 403, '2026-10-30', 90);

INSERT INTO Sales_Details VALUES
(801, 701, 201, 5, 100),
(802, 702, 202, 3, 150),
(803, 703, 204, 1, 90);

INSERT INTO Billing VALUES
(901, 701, '2026-10-28', 100, 'Paid'),
(902, 702, '2026-10-29', 150, 'Unpaid'),
(903, 703, '2026-10-30', 90, 'Paid');

SHOW TABLES;

SELECT * FROM Category;
SELECT * FROM Supplier;
SELECT * FROM Medicine;
SELECT * FROM Customer;
SELECT * FROM Employee;
SELECT * FROM Purchase;
SELECT * FROM Purchase_Details;
SELECT * FROM Sales;
SELECT * FROM Sales_Details;
SELECT * FROM Billing;

SELECT
    Customer.customer_name,
    Employee.employee_name,
    Sales.sale_date,
    Sales.total_amount
FROM Sales
JOIN Customer
    ON Sales.customer_id = Customer.customer_id
JOIN Employee
    ON Sales.employee_id = Employee.employee_id;

SELECT
    Medicine.medicine_name,
    Category.category_name,
    Medicine.price,
    Medicine.stock_quantity
FROM Medicine
JOIN Category
    ON Medicine.category_id = Category.category_id;

SELECT COUNT(*) AS Total_Medicines
FROM Medicine;

SELECT COUNT(*) AS Total_Customers
FROM Customer;

SELECT SUM(total_amount) AS Total_Sales
FROM Sales;

SELECT AVG(price) AS Average_Medicine_Price
FROM Medicine;

SELECT MAX(price) AS Highest_Medicine_Price
FROM Medicine;

SELECT MIN(price) AS Lowest_Medicine_Price
FROM Medicine;

SELECT
    Category.category_name,
    COUNT(Medicine.medicine_id) AS Total_Medicines
FROM Category
LEFT JOIN Medicine
    ON Category.category_id = Medicine.category_id
GROUP BY Category.category_id, Category.category_name;

SELECT * FROM Medicine
WHERE stock_quantity < 60;

SELECT * FROM Medicine
WHERE expiry_date < '2027-01-01';

SELECT * FROM Billing
WHERE payment_status = 'Unpaid';

SELECT * FROM Medicine
ORDER BY price DESC;

SELECT
    Supplier.supplier_name,
    Purchase.purchase_date,
    Purchase.total_amount
FROM Purchase
JOIN Supplier
    ON Purchase.supplier_id = Supplier.supplier_id;

SELECT
    Medicine.medicine_name,
    Sales_Details.quantity,
    Sales_Details.subtotal
FROM Sales_Details
JOIN Medicine
    ON Sales_Details.medicine_id = Medicine.medicine_id;

UPDATE Medicine
SET price = 25
WHERE medicine_id = 201;

UPDATE Medicine
SET stock_quantity = 150
WHERE medicine_id = 201;

UPDATE Billing
SET payment_status = 'Paid'
WHERE bill_id = 902;

DELETE FROM Customer
WHERE customer_id = 304;

CREATE VIEW Medicine_Stock AS
SELECT medicine_id, medicine_name, price, stock_quantity
FROM Medicine;

SELECT * FROM Medicine_Stock;
