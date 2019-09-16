 -- --------------------------------------------------------------------------------
--  Program Name:   create_mysql_store_ri.sql
--  Creation Date:  March-2017
-- --------------------------------------------------------------------------------
-- Open log file.
-- mysql workbench doesn't like TEE
-- TEE create_mysql_store.txt

-- This enables dropping tables with foreign key dependencies.
-- It is specific to the InnoDB Engine.
SET FOREIGN_KEY_CHECKS = 0; 

-- Conditionally drop objects.
SELECT 'SYSTEM_USER' AS 'Drop Table';
DROP TABLE IF EXISTS system_user;

-- ------------------------------------------------------------------
-- Create SYSTEM_USER table.
-- ------------------------------------------------------------------
SELECT 'SYSTEM_USER' AS 'Create Table';

CREATE TABLE system_user
( system_user_id              INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, system_user_name            CHAR(20)     NOT NULL
, system_user_type            INT UNSIGNED NOT NULL
, first_name                  CHAR(20)
, middle_name                 CHAR(20)
, last_name                   CHAR(20)
, created_by                  INT UNSIGNED NOT NULL
, creation_date               DATE         NOT NULL
, last_updated_by             INT UNSIGNED NOT NULL
, last_update_date            DATE         NOT NULL
, KEY system_user_fk1 (system_user_type)
, CONSTRAINT system_user_fk1 FOREIGN KEY (system_user_type) REFERENCES system_user_type (system_user_type_id)
, KEY system_user_fk2 (created_by)
, CONSTRAINT system_user_fk2 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY system_user_fk3 (last_updated_by)
, CONSTRAINT system_user_fk3 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE system_user AUTO_INCREMENT = 1001;


-- Conditionally drop objects.
SELECT 'SYSTEM_USER_TYPE' AS 'Drop Table';
DROP TABLE IF EXISTS system_user_type;

CREATE TABLE system_user_type
( system_user_type_id			INT UNSIGNED 	PRIMARY KEY AUTO_INCREMENT
, system_user_type 				CHAR(30)	NOT NULL
, created_by                  	INT UNSIGNED 	NOT NULL
, creation_date               	DATE         	NOT NULL
, last_updated_by             	INT UNSIGNED 	NOT NULL
, last_update_date            	DATE         	NOT NULL
, KEY system_user_type_fk1 (created_by)
, CONSTRAINT system_user_type_fk1 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY system_user_type_fk2 (last_updated_by)
, CONSTRAINT system_user_type_fk2 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE system_user_type AUTO_INCREMENT = 1001;


-- first insert into system_user_type, then insert into system_user

INSERT INTO system_user_type
( system_user_type 
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('database administrator', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO system_user_type
( system_user_type 
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('database developer', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO system_user
( system_user_name
, system_user_type
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
('kylebirc_admin'
, 1
, (SELECT system_user_type_id
   FROM system_user_type
   WHERE system_user_type = 'database administrator')
, UTC_DATE()
, 1
, UTC_DATE());

-- Conditionally drop objects.
SELECT 'account' AS 'Drop Table';
DROP TABLE IF EXISTS account;

-- ------------------------------------------------------------------
-- Create ACCOUNT table.
-- ------------------------------------------------------------------
SELECT 'account' AS 'Create Table';

CREATE TABLE account
( account_id           	   		INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, account_type               	INT UNSIGNED
, account_number         	CHAR(10)     			NOT NULL
, password 						INT UNSIGNED 		NOT NULL
, created_by                  	INT UNSIGNED 		NOT NULL
, creation_date               	DATE         				NOT NULL
, last_updated_by            INT UNSIGNED 		NOT NULL
, last_update_date           DATE         				NOT NULL
, KEY account_fk1 (account_type)
, CONSTRAINT account_fk1 FOREIGN KEY (account_type) REFERENCES account_type (account_type_id)
, KEY account_fk2 (created_by)
, CONSTRAINT account_fk2 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY account_fk3 (last_updated_by)
, CONSTRAINT account_fk3 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE account AUTO_INCREMENT = 1001;


-- Conditionally drop objects.
SELECT 'account_type' AS 'Drop Table';
DROP TABLE IF EXISTS account_type;

SELECT 'account_type' AS 'create_table';

CREATE TABLE account_type
( account_type_id 				INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, account_type 					CHAR(30) 			NOT NULL
, created_by                  		INT UNSIGNED 	NOT NULL
, creation_date               		DATE         			NOT NULL
, last_updated_by             	INT UNSIGNED 	NOT NULL
, last_update_date            	DATE         			NOT NULL
, KEY account_type_fk1 (created_by)
, CONSTRAINT account_type_fk1 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY account_type_fk2 (last_updated_by)
, CONSTRAINT account_type_fk2 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE account_type AUTO_INCREMENT = 1001;


-- create default account types
INSERT INTO account_type
( account_type 
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('administrator', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO account_type
( account_type 
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('user', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO account_type
( account_type 
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('group', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO account_type
( account_type 
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('individual', 1, UTC_DATE(), 1, UTC_DATE());

-- Conditionally drop objects.
SELECT 'CONTACT' AS 'Drop Table';
DROP TABLE IF EXISTS contact;

-- ------------------------------------------------------------------
-- Create CONTACT table.
-- ------------------------------------------------------------------
SELECT 'CONTACT' AS 'Create Table';

CREATE TABLE contact
( contact_id                  	INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, account_id                   	INT UNSIGNED 	NOT NULL
, contact_type                	INT UNSIGNED 
, email 							CHAR(30)			NOT NULL
, first_name                  	CHAR(30)     		NOT NULL
, middle_name               	CHAR(30)	
, last_name                   	CHAR(30)     		NOT NULL
, created_by                  	INT UNSIGNED 	NOT NULL
, creation_date               	DATE         			NOT NULL
, last_updated_by            INT UNSIGNED NOT NULL
, last_update_date           DATE         			NOT NULL
, KEY contact_fk1 (account_id)
, CONSTRAINT contact_fk1 FOREIGN KEY (account_id) REFERENCES account (account_id)
, KEY contact_fk2 (contact_type)
, CONSTRAINT contact_fk2 FOREIGN KEY (contact_type) REFERENCES contact_type (contact_type_id)
, KEY contact_fk3 (created_by)
, CONSTRAINT contact_fk3 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY contact_fk4 (last_updated_by)
, CONSTRAINT contact_fk4 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE contact AUTO_INCREMENT = 1001;


-- Conditionally drop objects.
SELECT 'contact_type' AS 'Drop Table';
DROP TABLE IF EXISTS contact_type;

SELECT 'contact_type' AS 'CREATE TABLE';

CREATE TABLE contact_type
( contact_type_id 				INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, contact_type 						CHAR(30)				NOT NULL
, created_by                  		INT UNSIGNED 		NOT NULL
, creation_date               		DATE         				NOT NULL
, last_updated_by             	INT UNSIGNED 		NOT NULL
, last_update_date            	DATE         				NOT NULL
, KEY contact_type_fk1 (created_by)
, CONSTRAINT contact_type_fk1 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY contact_type_fk2 (last_updated_by)
, CONSTRAINT contact_type_fk2 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE contact_type AUTO_INCREMENT = 1001;


-- Conditionally drop objects.
SELECT 'telephone' AS 'Drop Table';
DROP TABLE IF EXISTS telephone;

SELECT 'telephone' AS 'create table';

CREATE TABLE telephone
( telephone_id 					INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, contact_id                    INT UNSIGNED NOT NULL
, area_code 		            CHAR(3)	        NOT NULL
, telephone_number 		    	CHAR(20)				NOT NULL
, telephone_type 				INT UNSIGNED		NOT NULL
, created_by                    INT UNSIGNED 		NOT NULL
, creation_date         		DATE         				NOT NULL
, last_updated_by             	INT UNSIGNED 		NOT NULL
, last_update_date            	DATE         				NOT NULL
, KEY telephone_fk1 (contact_id)
, CONSTRAINT telephone_fk1 FOREIGN KEY (contact_id) REFERENCES contact (contact_id)
, KEY telephone_fk2 (telephone_type)
, CONSTRAINT telephone_fk2 FOREIGN KEY (telephone_type) REFERENCES telephone_type (telephone_type_id)
, KEY telephone_fk3 (created_by)
, CONSTRAINT telephone_fk3 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY telephone_fk4 (last_updated_by)
, CONSTRAINT telephone_fk4 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE telephone AUTO_INCREMENT = 1001;


-- Conditionally drop objects.
SELECT 'telephone_type' AS 'Drop Table';
DROP TABLE IF EXISTS telephone_type;

SELECT 'telephone_type' AS 'create table';

CREATE TABLE telephone_type
( telephone_type_id 			INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, telephone_type 				CHAR(30)			NOT NULL
, created_by                  		INT UNSIGNED 	NOT NULL
, creation_date               		DATE         			NOT NULL
, last_updated_by             	INT UNSIGNED 	NOT NULL
, last_update_date            	DATE         			NOT NULL
, KEY telephone_type_fk1 (created_by)
, CONSTRAINT telephone_type_fk1 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY telephone_type_fk2 (last_updated_by)
, CONSTRAINT telephone_type_fk2 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE telephone_type AUTO_INCREMENT = 1001;


-- Conditionally drop objects.
SELECT 'credit_card' AS 'Drop Table';
DROP TABLE IF EXISTS credit_card;

SELECT 'credit_card' AS 'create table';

CREATE TABLE credit_card
( credit_card_id 				INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, account_id 					INT UNSIGNED 		NOT NULL
, credit_card_number 		CHAR(16)		 		NOT NULL
, credit_card_type 			INT UNSIGNED 		NOT NULL
, expiration_date 			DATE 		 				NOT NULL
, cvv 								CHAR(6)
, created_by                  	INT UNSIGNED 		NOT NULL
, creation_date               	DATE         				NOT NULL
, last_updated_by			INT UNSIGNED 		NOT NULL
, last_update_date			DATE         				NOT NULL
, KEY credit_card_fk1 (account_id)
, CONSTRAINT credit_card_fk1 FOREIGN KEY (account_id) REFERENCES account (account_id)
, KEY credit_card_fk2 (credit_card_type)
, CONSTRAINT credit_card_fk2 FOREIGN KEY (credit_card_type) REFERENCES credit_card_type (credit_card_type_id)
, KEY credit_card_fk3 (created_by)
, CONSTRAINT credit_card_fk3 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY credit_card_fk4 (last_updated_by)
, CONSTRAINT credit_card_fk4 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE credit_card AUTO_INCREMENT = 1001;


-- Conditionally drop objects.
SELECT 'credit_card_type' AS 'Drop Table';
DROP TABLE IF EXISTS credit_card_type;

SELECT 'credit_card_type' AS 'create table';

CREATE TABLE credit_card_type
( credit_card_type_id 			INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, credit_card_type 				CHAR(30)			NOT NULL
, created_by                  		INT UNSIGNED 	NOT NULL
, creation_date               		DATE         			NOT NULL
, last_updated_by             	INT UNSIGNED 	NOT NULL
, last_update_date            	DATE         			NOT NULL
, KEY credit_card_type_fk1 (created_by)
, CONSTRAINT credit_card_type_fk1 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY credit_card_type_fk2 (last_updated_by)
, CONSTRAINT credit_card_type_fk2 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE credit_card_type AUTO_INCREMENT = 1001;

-- create address table
-- Conditionally drop objects.
SELECT 'address' AS 'Drop Table';
DROP TABLE IF EXISTS address;

SELECT 'address' AS 'create table';

CREATE TABLE address
( address_id				INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, address_type	 		INT UNSIGNED
, account_id 				INT UNSIGNED		NOT NULL
, street_address 			CHAR(50) 				NOT NULL
, city_state_id				INT UNSIGNED 		NOT NULL
, postal_code_id			INT UNSIGNED 		NOT NULL
, created_by				INT UNSIGNED 		NOT NULL
, creation_date			DATE         				NOT NULL
, last_updated_by		INT UNSIGNED 		NOT NULL
, last_update_date		DATE         				NOT NULL
, KEY address_fk1 (address_type)
, CONSTRAINT address_fk1 FOREIGN KEY (address_type) REFERENCES address_type (address_type_id)
, KEY address_fk2 (account_id)
, CONSTRAINT address_fk2 FOREIGN KEY (account_id) REFERENCES account (account_id)
, KEY address_fk3 (city_state_id)
, CONSTRAINT address_fk3 FOREIGN KEY (city_state_id) REFERENCES city_state (city_state_id)
, KEY address_fk4 (postal_code_id)
, CONSTRAINT address_fk4 FOREIGN KEY (postal_code_id) REFERENCES postal_code (postal_code_id)
, KEY address_fk5 (created_by)
, CONSTRAINT address_fk5 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY address_fk6 (last_updated_by)
, CONSTRAINT address_fk6 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE address AUTO_INCREMENT = 1001;

-- create address_type table
-- Conditionally drop objects.
SELECT 'address_type' AS 'Drop Table';
DROP TABLE IF EXISTS address_type;

SELECT 'address_type' AS 'create table';

CREATE TABLE address_type
( address_type_id	 		INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, address_type 				INT UNSIGNED
, created_by                  	INT UNSIGNED 		NOT NULL
, creation_date               	DATE         				NOT NULL
, last_updated_by 			INT UNSIGNED 		NOT NULL
, last_update_date    		DATE         				NOT NULL
, KEY address_type_fk1 (created_by)
, CONSTRAINT address_type_fk1 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY address_type_fk2 (last_updated_by)
, CONSTRAINT address_type_fk2 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE address_type AUTO_INCREMENT = 1001;

-- create city table
-- Conditionally drop objects.
SELECT 'city' AS 'Drop Table';
DROP TABLE IF EXISTS city;

SELECT 'city' AS 'create table';

CREATE TABLE city
( city_id 						INT UNSIGNED 	PRIMARY KEY AUTO_INCREMENT
, city 							CHAR(200)				NOT NULL
, created_by				INT UNSIGNED 		NOT NULL
, creation_date           	DATE         				NOT NULL
, last_updated_by        INT UNSIGNED 		NOT NULL
, last_update_date       DATE         				NOT NULL
, KEY city_fk1 (created_by)
, CONSTRAINT city_fk1 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY city_fk2 (last_updated_by)
, CONSTRAINT city_fk2 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE city AUTO_INCREMENT = 1001;

-- create state table
-- Conditionally drop objects.
SELECT 'state' AS 'Drop Table';
DROP TABLE IF EXISTS state;

SELECT 'state' AS 'create table';

CREATE TABLE state
( state_id 				INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, state 						INT UNSIGNED
, created_by     		INT UNSIGNED 		NOT NULL
, creation_date    	DATE         				NOT NULL
, last_updated_by	INT UNSIGNED 		NOT NULL
, last_update_date	DATE         				NOT NULL
, KEY state_fk1 (created_by)
, CONSTRAINT state_fk1 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY state_fk2 (last_updated_by)
, CONSTRAINT state_fk2 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE state AUTO_INCREMENT = 1001;

-- create city_state table
-- Conditionally drop objects.
SELECT 'city_state' AS 'Drop Table';
DROP TABLE IF EXISTS city_state;

SELECT 'city_state' AS 'create table';

CREATE TABLE city_state
( city_state_id 				INT UNSIGNED 	PRIMARY KEY AUTO_INCREMENT
, city_id 						INT UNSIGNED 		NOT NULL
, state_id 					INT UNSIGNED 		NOT NULL
, created_by          		INT UNSIGNED 		NOT NULL
, creation_date      		DATE         				NOT NULL
, last_updated_by    	INT UNSIGNED 		NOT NULL
, last_update_date    	DATE         				NOT NULL
, KEY city_state_fk1 (city_id)
, CONSTRAINT city_state_fk1 FOREIGN KEY (city_id) REFERENCES city (city_id)
, KEY city_state_fk2 (state_id)
, CONSTRAINT city_state_fk2 FOREIGN KEY (state_id) REFERENCES state (state_id)
, KEY city_state_fk3 (created_by)
, CONSTRAINT city_state_fk3 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY city_state_fk4 (last_updated_by)
, CONSTRAINT city_state_fk4 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE city_state AUTO_INCREMENT = 1001;

-- create postal_code table
SELECT 'postal_code' AS 'Drop Table';
DROP TABLE IF EXISTS postal_code;

SELECT 'postal_code' AS 'create table';

CREATE TABLE postal_code
( postal_code_id 			INT UNSIGNED 	PRIMARY KEY AUTO_INCREMENT
, postal_code 				INT UNSIGNED 		NOT NULL
, created_by      			INT UNSIGNED 		NOT NULL
, creation_date    		DATE         				NOT NULL
, last_updated_by  		INT UNSIGNED 		NOT NULL
, last_update_date   	DATE         				NOT NULL
, KEY postal_code_fk1 (created_by)
, CONSTRAINT postal_code_fk1 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY postal_code_fk2 (last_updated_by)
, CONSTRAINT postal_code_fk2 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE postal_code AUTO_INCREMENT = 1001;


-- create item_category table
SELECT 'item_category' AS 'Drop Table';
DROP TABLE IF EXISTS item_category;

SELECT 'item_category' AS 'create table';

CREATE TABLE item_category
( item_category_id 			INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, item_category 				CHAR(50)				NOT NULL
, created_by        			INT UNSIGNED 		NOT NULL
, creation_date      			DATE         				NOT NULL
, last_updated_by    		INT UNSIGNED 		NOT NULL
, last_update_date  		DATE         				NOT NULL
, KEY item_category_fk1 (created_by)
, CONSTRAINT item_category_fk1 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY item_category_fk2 (last_updated_by)
, CONSTRAINT item_category_fk2 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE item_category AUTO_INCREMENT = 1001;

-- create item_subcategory table

SELECT 'item_subcategory' AS 'Drop Table';
DROP TABLE IF EXISTS item_subcategory;

SELECT 'item_subcategory' AS 'create table';

CREATE TABLE item_subcategory
( item_subcategory_id 	INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, category_id 					INT UNSIGNED 		NOT NULL
, item_subcategory 			CHAR(50)				NOT NULL
, created_by                  	INT UNSIGNED 		NOT NULL
, creation_date               	DATE         				NOT NULL
, last_updated_by   			INT UNSIGNED 		NOT NULL
, last_update_date    		DATE         				NOT NULL
, KEY item_subcategory_fk1 (category_id)
, CONSTRAINT item_subcategory_fk1 FOREIGN KEY (category_id) REFERENCES item_category (item_category_id)
, KEY item_subcategory_fk2 (created_by)
, CONSTRAINT item_subcategory_fk2 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY item_subcategory_fk3 (last_updated_by)
, CONSTRAINT item_subcategory_fk3 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE item_subcategory AUTO_INCREMENT = 1001;



-- create item table
SELECT 'item' AS 'Drop Table';
DROP TABLE IF EXISTS item;

SELECT 'item' AS 'create table';

CREATE TABLE item
( item_id 							INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, item_title 						CHAR(255) 			NOT NULL
, item_subtitle 					CHAR(255) 
, item_category_id 			INT UNSIGNED		NOT NULL
, item_subcategory_id 	INT UNSIGNED
, created_by                  	INT UNSIGNED
, creation_date               	DATE         				NOT NULL
, last_updated_by  			INT UNSIGNED 		NOT NULL
, last_update_date 			DATE         				NOT NULL
, KEY item_fk1 (item_category_id)
, CONSTRAINT item_fk1 FOREIGN KEY (item_category_id) REFERENCES item_category (item_category_id)
, KEY item_fk2 (item_subcategory_id)
, CONSTRAINT item_fk2 FOREIGN KEY (item_subcategory_id) REFERENCES item_subcategory (item_subcategory_id)
, KEY item_fk3 (created_by)
, CONSTRAINT item_fk3 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY item_fk4 (last_updated_by)
, CONSTRAINT item_fk4 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE item AUTO_INCREMENT = 1001;



-- Create transaction Table
SELECT 'transaction' AS 'drop Table';
DROP TABLE IF EXISTS transaction;

SELECT 'transaction' AS 'create table';

CREATE TABLE transaction
( transaction_id 			INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, account_id 				INT UNSIGNED 		NOT NULL
, transaction_type 		INT UNSIGNED
, transaction_date 		DATE 						NOT NULL
, amount 						INT UNSIGNED 		NOT NULL
, created_by           		INT UNSIGNED 		NOT NULL
, creation_date     		DATE         				NOT NULL
, last_updated_by      	INT UNSIGNED 		NOT NULL
, last_update_date     	DATE         				NOT NULL
, KEY transaction_fk1 (account_id)
, CONSTRAINT transaction_fk1 FOREIGN KEY (account_id) REFERENCES account (account_id)
, KEY transaction_fk2 (transaction_type)
, CONSTRAINT transaction_fk2 FOREIGN KEY (transaction_type) REFERENCES transaction_type (transaction_type_id)
, KEY transaction_fk3 (created_by)
, CONSTRAINT transaction_fk3 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY transaction_fk4 (last_updated_by)
, CONSTRAINT transaction_fk4 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE transaction AUTO_INCREMENT = 1001;


-- Create transaction_type table
SELECT 'transaction_type' AS 'drop table';
DROP TABLE IF EXISTS transaction_type;

SELECT 'transaction_type' AS 'create table';

CREATE TABLE transaction_type
( transaction_type_id 		INT UNSIGNED 	PRIMARY KEY AUTO_INCREMENT
, transaction_type 			CHAR(50) 				NOT NULL
, created_by 					INT UNSIGNED		NOT NULL
, creation_date       			DATE         				NOT NULL
, last_updated_by     		INT UNSIGNED 		NOT NULL
, last_update_date       	DATE         				NOT NULL
, KEY transaction_type_fk1 (created_by)
, CONSTRAINT transaction_type_fk1 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY transaction_type_fk2 (last_updated_by)
, CONSTRAINT transaction_type_fk2 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE transaction_type AUTO_INCREMENT = 1001;


-- create transaction_item table
SELECT 'transaction_item' AS 'drop table';
DROP TABLE IF EXISTS transaction_item;

SELECT 'transaction_item' AS 'create table';

CREATE TABLE transaction_item
( transaction_item_id 		INT UNSIGNED 	PRIMARY KEY AUTO_INCREMENT
, transaction_id 				INT UNSIGNED 		NOT NULL
, item_id 							INT UNSIGNED 		NOT NULL
, created_by 					INT UNSIGNED		NOT NULL
, creation_date       			DATE         				NOT NULL
, last_updated_by    		INT UNSIGNED 		NOT NULL
, last_update_date     		DATE         				NOT NULL
, KEY transaction_item_fk1 (transaction_id)
, CONSTRAINT transaction_item_fk1 FOREIGN KEY (transaction_id) REFERENCES transaction (transaction_id)
, KEY transaction_item_fk2 (item_id)
, CONSTRAINT transaction_item_fk2 FOREIGN KEY (item_id) REFERENCES item (item_id)
, KEY transaction_item_fk3 (created_by)
, CONSTRAINT transaction_item_fk3 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY transaction_item_fk4 (last_updated_by)
, CONSTRAINT transaction_item_fk4 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE transaction_item AUTO_INCREMENT = 1001;


-- create price table
SELECT 'price' AS 'drop table';
DROP TABLE IF EXISTS price;

SELECT 'price' AS 'create table';

CREATE TABLE price
( price_id 					INT UNSIGNED 	PRIMARY KEY AUTO_INCREMENT
, item_id 						INT UNSIGNED 		NOT NULL
, price_type 				INT UNSIGNED 		
, active_flag 				TEXT 						NOT NULL
, start_date 					DATE 						NOT NULL
, end_date 					DATE
, amount 						INT UNSIGNED 		NOT NULL
, created_by 				INT UNSIGNED		NOT NULL
, creation_date      		DATE         				NOT NULL
, last_updated_by       	INT UNSIGNED 		NOT NULL
, last_update_date       DATE         				NOT NULL
, KEY price_fk1 (item_id)
, CONSTRAINT price_fk1 FOREIGN KEY (item_id) REFERENCES item (item_id)
, KEY price_fk2 (price_type)
, CONSTRAINT price_fk2 FOREIGN KEY (price_type) REFERENCES price_type (price_type_id)
, KEY price_fk3 (created_by)
, CONSTRAINT price_fk3 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY price_fk4 (last_updated_by)
, CONSTRAINT price_fk4 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE price AUTO_INCREMENT = 1001;


-- create price_type table
SELECT 'price_type' AS 'drop table';
DROP TABLE IF EXISTS price_type;

SELECT 'price_type' AS 'create table';

CREATE TABLE price_type
( price_type_id 			INT UNSIGNED 	PRIMARY KEY AUTO_INCREMENT
, price_type 				CHAR(50) 				NOT NULL
, created_by       			INT UNSIGNED 		NOT NULL
, creation_date      		DATE         				NOT NULL
, last_updated_by   		INT UNSIGNED 		NOT NULL
, last_update_date   	DATE         				NOT NULL
, KEY price_type_fk1 (created_by)
, CONSTRAINT price_type_fk1 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY price_type_fk2 (last_updated_by)
, CONSTRAINT price_type_fk2 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE price_type AUTO_INCREMENT = 1001;
-- Commit inserts.
COMMIT;

-- Display tables.
SHOW TABLES;

-- Close log file.
-- NOTEE
