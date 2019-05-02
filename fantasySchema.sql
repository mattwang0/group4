DROP SCHEMA IF EXISTS stockSchema;
CREATE SCHEMA stockSchema;
USE stockSchema;

CREATE TABLE users (
	id 				INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	username		    VARCHAR(30) NOT NULL UNIQUE,
	password	VARCHAR(300) NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE owns (
	username		VARCHAR(30),
	stock			VARCHAR(4),
	price			DECIMAL(4, 2),
	PRIMARY KEY (username, stock),
	FOREIGN KEY (username) REFERENCES users (username)
);
