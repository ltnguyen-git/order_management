CREATE DATABASE classicmodels_olap;

-- Tạo các bản của cơ sở dữ liệu OLAP
CREATE TABLE classicmodels_olap.dim_customer (
  	customerNumber INT NOT NULL,
  	customerName VARCHAR(100),
  	city VARCHAR(50),
  	state VARCHAR(50),
  	country VARCHAR(50),
  	PRIMARY KEY (customerNumber) );
    
CREATE TABLE classicmodels_olap.dim_employee (
 	employeeNumber INT,
  	employeeName VARCHAR(100),
  	jobTitle VARCHAR(100),
  	officeCode VARCHAR(10),
  	city VARCHAR(50),
  	state VARCHAR(50),
  	country VARCHAR(50),
  PRIMARY KEY (employeeNumber) ) ;

CREATE TABLE classicmodels_olap.dim_order (
  	orderNumber INT,
  	status VARCHAR(50),
  	PRIMARY KEY (orderNumber) );
    
CREATE TABLE classicmodels_olap.dim_product (
	productCode VARCHAR(50),
  	productName VARCHAR(50),
	productLine VARCHAR(50),
	productVendor VARCHAR(50),
  	PRIMARY KEY (productCode) );

CREATE TABLE classicmodels_olap.dim_date (
  	dateID DATE,
  	day INT,
  	quarter INT,
  	year INT,
  	PRIMARY KEY (dateID) );
    
CREATE TABLE fact_customer (
  	employeeNumber INT,
  	customerNumber INT,
  	creditLimit DECIMAL(10,2),
  	FOREIGN KEY (employeeNumber) REFERENCES dim_employee (employeeNumber),
  	FOREIGN KEY (customerNumber) REFERENCES dim_customer (customerNumber) );

CREATE TABLE fact_orderdetails (
  	dateID DATE,  customerNumber INT,
  	employeeNumber INT,  productCode VARCHAR(50),
  	orderNumber INT,  quantityOrder INT,
  	priceEach DECIMAL(10,2) ,  `status` VARCHAR(45),
  	FOREIGN KEY (customerNumber) REFERENCES dim_customer (customerNumber),
 	FOREIGN KEY (dateID) REFERENCES dim_date (dateID),
  	FOREIGN KEY (employeeNumber) REFERENCES dim_employee (employeeNumber),
  	FOREIGN KEY (orderNumber) REFERENCES dim_order (orderNumber),
  	FOREIGN KEY (productCode) REFERENCES dim_product (productCode) );

CREATE TABLE fact_payment (
  	customerNumber INT,
  	dateID DATE,
  	amount decimal(10,2),
  	FOREIGN KEY (customerNumber) REFERENCES dim_customer (customerNumber),
  	FOREIGN KEY (dateID) REFERENCES dim_date (dateID) );


CREATE TABLE fact_stock (
  	productCode VARCHAR(50),
  	buyPrice DECIMAL(10,2),
  	quantityInStock INT,
  	MSRP DECIMAL(10,2),
 	FOREIGN KEY (productCode) REFERENCES dim_product (productCode) );

-- Thực hiện đổ dữ liệu vào các bảng mới của cơ sở dữ liệu OLAP
INSERT INTO classicmodels_olap.dim_customer(
	customerNumber,
	customerName,
	city,
	state,
	country)
SELECT
	customerNumber,
	customerName,
	city,
	state,
	country
FROM	customers;

INSERT INTO classicmodels_olap.dim_employee(
	employeeNumber, employeeName,
	jobTitle, officeCode,
	city, state, 	country)
SELECT
	employeeNumber,
	CONCAT(firstName,'  ',lastName) AS employeeName,
	jobTitle,
	officeCode,
	city,
	state,
	country
FROM	mydata.employees INNER JOIN mydata.offices USING(officeCode);

INSERT INTO classicmodels_olap.Dim_Order(
	orderNumber,
	`status`)
SELECT
	orderNumber,
	`status`
FROM
	mydata.orders;

INSERT INTO classicmodels_olap.dim_product(
	productCode,
	productName,
	productLine,
	productVendor)
SELECT
	productCode,
	productName,
	productLine,
	productVendor
FROM
	mydata.products;

DROP PROCEDURE IF EXISTS fillDates;
DELIMITER |
CREATE PROCEDURE `fillDates`(dateStart DATE, dateEnd DATE)
BEGIN
       	WHILE dateStart <= dateEnd DO
            	INSERT INTO dim_date 
		VALUES (	dateStart,
			DAY(dateStart),
			QUARTER(dateStart),
			YEAR(dateStart) );
           	SET dateStart = date_add(dateStart, INTERVAL 1 DAY);
          	END WHILE;
        END;
|
DELIMITER ;
CALL fillDates("2003-01-01", "2005-12-31");	

INSERT INTO classicmodels_olap.fact_customer( 
	employeeNumber,
	customerNumber,
	creditLimit)
SELECT
	dim_employee.employeeNumber,
	classicmodels_olap.dim_customer.customerNumber,
	mydata.customers.creditLimit
FROM
	dim_customer LEFT JOIN mydata.customers USING (customerNumber)
	INNER JOIN dim_employee ON 
	dim_employee.employeeNumber = mydata.customers.salesRepEmployeeNumber;
    
INSERT INTO classicmodels_olap.fact_payment(
	customerNumber,
	dateID,
	amount)
SELECT
	customerNumber,
	dateID,
	amount
FROM
	dim_customer INNER JOIN mydata.payments USING (customerNumber)
	INNER JOIN dim_date ON mydata.payments.paymentDate = dim_date.dateID;

INSERT INTO fact_orderdetails
SELECT	dim_date.dateID, dim_customer.customerNumber,
	dim_employee.employeeNumber,	dim_product.productCode,
	dim_order.orderNumber, quantityOrdered,
	priceEach,	dim_order.`status`
FROM	dim_customer INNER JOIN mydata.customers USING (customerNumber)
	INNER JOIN dim_employee ON dim_employee.employeeNumber = 	mydata.customers.salesRepEmployeeNumber
	INNER JOIN mydata.orders USING (customerNumber)
	INNER JOIN dim_order USING (orderNumber)
	INNER JOIN mydata.orderdetails USING (orderNumber)
	INNER JOIN dim_product USING (productCode)
	INNER JOIN dim_date ON mydata.orders.orderDate = dim_date.dateID;


INSERT INTO classicmodels_olap.fact_stock(
	productCode,
	buyPrice,
	quantityInStock,
	MSRP)
SELECT
	classicmodels_olap.dim_product.productCode,
	mydata.products.buyPrice,
	mydata.products.quantityInStock,
	mydata.products.MSRP
FROM
	dim_product LEFT JOIN mydata.products USING (productCode);

    
