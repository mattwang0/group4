DROP SCHEMA IF EXISTS stockSchema;
CREATE SCHEMA stockSchema;
USE stockSchema;

CREATE TABLE users (
	id 				INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	username		    VARCHAR(30) NOT NULL UNIQUE,
	password	VARCHAR(300) NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE stocks (
	username		VARCHAR(30),
	stock1			VARCHAR(4),
	stock1price		DECIMAL(4, 2),
	stock2			VARCHAR(4),
	stock2price		DECIMAL(4, 2),
	stock3			VARCHAR(4),
	stock3price		DECIMAL(4, 2),
	stock4			VARCHAR(4),
	stock4price		DECIMAL(4, 2),
	stock5			VARCHAR(4),
	stock5price		DECIMAL(4, 2),
	stock6			VARCHAR(4),
	stock6price		DECIMAL(4, 2),
	stock7			VARCHAR(4),
	stock7price		DECIMAL(4, 2),
	stock8			VARCHAR(4),
	stock8price		DECIMAL(4, 2),
	stock9			VARCHAR(4),
	stock9price		DECIMAL(4, 2),
	stock10			VARCHAR(4),
	stock10price	DECIMAL(4, 2),
	PRIMARY KEY (username),
	FOREIGN KEY (username) REFERENCES users (username)
);
