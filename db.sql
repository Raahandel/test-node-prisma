CREATE TABLE User (
    id CHAR(25) PRIMARY KEY NOT NULL,
	handle INTEGER UNSIGNED AUTO_INCREMENT UNIQUE,
	name VARCHAR(50) NOT NULL,
	email VARCHAR(60) UNIQUE NOT NULL,
	password VARCHAR(120) NOT NULL,
	resetToken VARCHAR(255),
	resetTokenExpiry BIGINT,
	userStatus ENUM('APPROVED', 'PENDING', 'SUSPENDED', 'DENIED') NOT NULL,
	createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

# User profile
CREATE TABLE Profile (
	id CHAR(25) PRIMARY KEY NOT NULL,
	userId CHAR(25) UNIQUE NOT NULL,
	contactName VARCHAR(50) NOT NULL,
	billingName VARCHAR(50) NOT NULL,
	billingCompany VARCHAR(50) NOT NULL,
	billingAddress VARCHAR(50) NOT NULL,
	shippingName VARCHAR(50) NOT NULL,
	shippingCompany VARCHAR(50) NOT NULL,
	shippingAddress VARCHAR(50) NOT NULL,
	FOREIGN KEY (userId) REFERENCES User(id)
);

CREATE TABLE Product (
    id CHAR(25) PRIMARY KEY NOT NULL,
	handle INTEGER UNSIGNED AUTO_INCREMENT UNIQUE,
	title VARCHAR(50) NOT NULL,
	type VARCHAR(50) NOT NULL,
	productStatus ENUM('AVAILABLE', 'PENDING', 'DRAFT', 'HIDDEN') NOT NULL,
	createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

# Relations table
# 1 to Many
# A product can have many stocks
CREATE TABLE Stock (
	id CHAR(25) PRIMARY KEY NOT NULL,
	productId CHAR(25) NOT NULL,
	stockId CHAR(25) NOT NULL,
	FOREIGN KEY (productId) REFERENCES Product(id),
	FOREIGN KEY (stockId) REFERENCES StockList(id) on DELETE CASCADE
);

CREATE TABLE StockList (
    id CHAR(25) PRIMARY KEY NOT NULL,
    stockType ENUM('CUSTOMER', 'ENTERPRISE', 'COUNTRY') NOT NULL,
    target VARCHAR(50) NOT NULL,
    productStock SMALLINT UNSIGNED NOT NULL,
);

# Product meta
CREATE TABLE Meta (
    id CHAR(25) PRIMARY KEY NOT NULL,
    productId CHAR(25) UNIQUE NOT NULL,
	unit VARCHAR(20) NOT NULL,
	unitSize DECIMAL(5,2) NOT NULL,
	bulkSize SMALLINT UNSIGNED NOT NULL,
	organic BOOLEAN DEFAULT false,
	cold BOOLEAN DEFAULT false,
	frozen BOOLEAN DEFAULT false,
	FOREIGN KEY (productId) REFERENCES Product(id)
);