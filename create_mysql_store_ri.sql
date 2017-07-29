-- --------------------------------------------------------------------------------
--  Program Name:   create_mysql_store_ri.sql
--  Creation Date:  March-2017
-- --------------------------------------------------------------------------------

-- Open log file.
TEE create_mysql_store.txt

-- This enables dropping tables with foreign key dependencies.
-- It is specific to the InnoDB Engine.
SET FOREIGN_KEY_CHECKS = 0; 

-- Conditionally drop objects.
SELECT 'SYSTEM_USER' AS "Drop Table";
DROP TABLE IF EXISTS system_user;

-- ------------------------------------------------------------------
-- Create SYSTEM_USER table.
-- ------------------------------------------------------------------
SELECT 'SYSTEM_USER' AS "Create Table";

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
, KEY system_user_fk1 (created_by)
, CONSTRAINT system_user_fk1 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY system_user_fk2 (last_updated_by)
, CONSTRAINT system_user_fk2 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO system_user
( system_user_name
, system_user_type
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
('kylebirc_admin', 1, 1, UTC_DATE(), 1, UTC_DATE());

-- Conditionally drop objects.
SELECT 'COMMON_LOOKUP' AS "Drop Table";
DROP TABLE IF EXISTS common_lookup;

-- ------------------------------------------------------------------
-- Create COMMON_LOOKUP table.
-- ------------------------------------------------------------------
SELECT 'COMMON_LOOKUP' AS "Create Table";

CREATE TABLE common_lookup
( common_lookup_id            INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, common_lookup_table 	      CHAR(30)     NOT NULL
, common_lookup_column		  CHAR(30)	   NOT NULL
, common_lookup_type          CHAR(30)     NOT NULL
, created_by                  INT UNSIGNED NOT NULL
, creation_date               DATE         NOT NULL
, last_updated_by             INT UNSIGNED NOT NULL
, last_update_date            DATE         NOT NULL
, CONSTRAINT common_lookup_u1 UNIQUE INDEX (common_lookup_context, common_lookup_type)
, KEY common_lookup_fk1 (created_by)
, CONSTRAINT common_lookup_fk1 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY common_lookup_fk2 (last_updated_by)
, CONSTRAINT common_lookup_fk2 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- TYPES OF SYSTEM USERS
INSERT INTO common_lookup
( common_lookup_table
, common_lookup_column
, common_lookup_type
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('system_user','system_user_type','dba', 1, UTC_DATE(), 1, UTC_DATE());

-- system_user, system_user_type, dba
INSERT INTO common_lookup
( common_lookup_table
, common_lookup_column
, common_lookup_type
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('SYSTEM_USER','system_user_type','db_developer', 1, UTC_DATE(), 1, UTC_DATE());

-- TYPES OF CONTACTS
INSERT INTO common_lookup
( common_lookup_table
, common_lookup_column
, common_lookup_type
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('contact','contact_type','employee', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO common_lookup
( common_lookup_table
, common_lookup_column
, common_lookup_type
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('contact','contact_type','customer', 1, UTC_DATE(), 1, UTC_DATE());

-- TYPES OF ACCOUNTS
INSERT INTO common_lookup
( common_lookup_table
, common_lookup_column
, common_lookup_type
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('account','account_type','individual', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO common_lookup
( common_lookup_table
, common_lookup_column
, common_lookup_type
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('account','account_type','business', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO common_lookup
( common_lookup_table
, common_lookup_column
, common_lookup_type
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('account','account_type','administrator', 1, UTC_DATE(), 1, UTC_DATE());

-- TYPES OF CREDIT CARDS
INSERT INTO common_lookup
( common_lookup_table
, common_lookup_column
, common_lookup_type
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('credit_card','credit_card_type','discover_card', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO common_lookup
( common_lookup_table
, common_lookup_column
, common_lookup_type
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('credit_card','credit_card_type','master_card', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO common_lookup
( common_lookup_table
, common_lookup_column
, common_lookup_type
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('credit_card','credit_card_type','visa_card', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO common_lookup
( common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('telephone','telephone_type','mobile', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO common_lookup
( common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('telephone','telephone_type','landline', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO common_lookup
( common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('item','DVD_FULL_SCREEN','DVD: Full Screen', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO common_lookup
( common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('item','DVD_WIDE_SCREEN','DVD: Wide Screen', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO common_lookup
( common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('item','NINTENDO_GAMECUBE','Nintendo GameCube', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO common_lookup
( common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('item','PLAYSTATION2','PlayStation2', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO common_lookup
( common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('item','XBOX','XBOX', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO common_lookup
( common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('item','VHS_SINGLE_TAPE','VHS: Single Tape', 1, UTC_DATE(), 1, UTC_DATE());

INSERT INTO common_lookup
( common_lookup_context
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES
('item','VHS_DOUBLE_TAPE','VHS: Double Tape', 1, UTC_DATE(), 1, UTC_DATE());

-- Conditionally drop objects.
SELECT 'account' AS "Drop Table";
DROP TABLE IF EXISTS account;

-- ------------------------------------------------------------------
-- Create ACCOUNT table.
-- ------------------------------------------------------------------
SELECT 'account' AS "Create Table";

CREATE TABLE account
( account_id                   INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, account_type                 INT UNSIGNED
, account_number              CHAR(10)     NOT NULL
, credit_card_number          CHAR(19)     NOT NULL
, credit_card_type            INT UNSIGNED NOT NULL
, created_by                  INT UNSIGNED NOT NULL
, creation_date               DATE         NOT NULL
, last_updated_by             INT UNSIGNED NOT NULL
, last_update_date            DATE         NOT NULL
, KEY account_fk1 (created_by)
, CONSTRAINT account_fk1 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY account_fk2 (last_updated_by)
, CONSTRAINT account_fk2 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Conditionally drop objects.
SELECT 'CONTACT' AS "Drop Table";
DROP TABLE IF EXISTS contact;

-- ------------------------------------------------------------------
-- Create CONTACT table.
-- ------------------------------------------------------------------
SELECT 'CONTACT' AS "Create Table";

CREATE TABLE contact
( contact_id                  INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, account_id                   INT UNSIGNED NOT NULL
, contact_type                INT UNSIGNED NOT NULL
, first_name                  CHAR(20)     NOT NULL
, middle_name                 CHAR(20)
, last_name                   CHAR(20)     NOT NULL
, created_by                  INT UNSIGNED NOT NULL
, creation_date               DATE         NOT NULL
, last_updated_by             INT UNSIGNED NOT NULL
, last_update_date            DATE         NOT NULL
, KEY contact_fk1 (account_id)
, CONSTRAINT contact_fk1 FOREIGN KEY (account_id) REFERENCES account (account_id)
, KEY contact_fk2 (created_by)
, CONSTRAINT contact_fk2 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY contact_fk3 (last_updated_by)
, CONSTRAINT contact_fk3 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Conditionally drop objects.
SELECT 'ADDRESS' AS "Drop Table";
DROP TABLE IF EXISTS address;

-- ------------------------------------------------------------------
-- Create ADDRESS table.
-- ------------------------------------------------------------------
SELECT 'ADDRESS' AS "Create Table";

CREATE TABLE address
( address_id                  INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, contact_id                  INT UNSIGNED NOT NULL
, address_type                INT UNSIGNED NOT NULL
, city                        CHAR(30)     NOT NULL
, state_province              CHAR(30)     NOT NULL
, postal_code                 CHAR(20)     NOT NULL
, created_by                  INT UNSIGNED NOT NULL
, creation_date               DATE         NOT NULL
, last_updated_by             INT UNSIGNED NOT NULL
, last_update_date            DATE         NOT NULL
, KEY address_fk1 (contact_id)
, CONSTRAINT address_fk1 FOREIGN KEY (contact_id) REFERENCES contact (contact_id)
, KEY address_fk2 (created_by)
, CONSTRAINT address_fk2 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY address_fk3 (last_updated_by)
, CONSTRAINT address_fk3 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Conditionally drop objects.
SELECT 'STREET_ADDRESS' AS "Drop Table";
DROP TABLE IF EXISTS street_address;

-- ------------------------------------------------------------------
-- Create STREET_ADDRESS table.
-- ------------------------------------------------------------------
SELECT 'STREET_ADDRESS' AS "Create Table";

CREATE TABLE street_address
( street_address_id           INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, address_id                  INT UNSIGNED NOT NULL
, street_address              CHAR(30)     NOT NULL
, created_by                  INT UNSIGNED NOT NULL
, creation_date               DATE         NOT NULL
, last_updated_by             INT UNSIGNED NOT NULL
, last_update_date            DATE         NOT NULL
, KEY street_address_fk1 (address_id)
, CONSTRAINT street_address_fk1 FOREIGN KEY (address_id) REFERENCES address (address_id)
, KEY street_address_fk2 (created_by)
, CONSTRAINT street_address_fk2 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY street_address_fk3 (last_updated_by)
, CONSTRAINT street_address_fk3 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Conditionally drop objects.
SELECT 'TELEPHONE' AS "Drop Table";
DROP TABLE IF EXISTS telephone;

-- ------------------------------------------------------------------
-- Create TELEPHONE table.
-- ------------------------------------------------------------------
SELECT 'TELEPHONE' AS "Drop Table";

CREATE TABLE telephone
( telephone_id                INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, contact_id                  INT UNSIGNED NOT NULL
, address_id                  INT UNSIGNED
, telephone_type              INT UNSIGNED NOT NULL
, country_code                CHAR(3)      NOT NULL
, area_code                   CHAR(6)      NOT NULL
, telephone_number            CHAR(10)     NOT NULL
, created_by                  INT UNSIGNED NOT NULL
, creation_date               DATE         NOT NULL
, last_updated_by             INT UNSIGNED NOT NULL
, last_update_date            DATE         NOT NULL
, KEY telephone_fk1 (contact_id)
, CONSTRAINT telephone_fk1 FOREIGN KEY (contact_id) REFERENCES contact (contact_id)
, KEY telephone_fk2 (address_id)
, CONSTRAINT telephone_fk2 FOREIGN KEY (address_id) REFERENCES address (address_id)
, KEY telephone_fk3 (created_by)
, CONSTRAINT telephone_fk3 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY telephone_fk4 (last_updated_by)
, CONSTRAINT telephone_fk4 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Conditionally drop objects.
SELECT 'RENTAL' AS "Drop Table";
DROP TABLE IF EXISTS rental;

-- ------------------------------------------------------------------
-- Create RENTAL table.
-- ------------------------------------------------------------------
SELECT 'RENTAL' AS "Create Table";

CREATE TABLE rental
( rental_id                   INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, customer_id                 INT UNSIGNED NOT NULL
, check_out_date              DATE         NOT NULL
, return_date                 DATE         NOT NULL
, created_by                  INT UNSIGNED NOT NULL
, creation_date               DATE         NOT NULL
, last_updated_by             INT UNSIGNED NOT NULL
, last_update_date            DATE         NOT NULL
, KEY rental_fk1 (customer_id)
, CONSTRAINT rental_fk1 FOREIGN KEY (customer_id) REFERENCES contact (contact_id)
, KEY rental_fk2 (created_by)
, CONSTRAINT rental_fk2 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY rental_fk3 (last_updated_by)
, CONSTRAINT rental_fk3 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Conditionally drop objects.
SELECT 'ITEM' AS "Drop Table";
DROP TABLE IF EXISTS item;

-- ------------------------------------------------------------------
-- Create ITEM table.
-- ------------------------------------------------------------------
SELECT 'ITEM' AS "Create Table";

CREATE TABLE item
( item_id                     INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, item_barcode                CHAR(14)     NOT NULL
, item_type                   INT UNSIGNED NOT NULL
, item_title                  CHAR(60)     NOT NULL
, item_subtitle               CHAR(60)
, item_rating                 CHAR(8)      NOT NULL
, item_release_date           DATE         NOT NULL
, created_by                  INT UNSIGNED NOT NULL
, creation_date               DATE         NOT NULL
, last_updated_by             INT UNSIGNED NOT NULL
, last_update_date            DATE         NOT NULL
, KEY item_fk1 (item_type)
, CONSTRAINT item_fk1 FOREIGN KEY (item_type) REFERENCES common_lookup (common_lookup_id)
, KEY item_fk2 (created_by)
, CONSTRAINT item_fk2 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY item_fk3 (last_updated_by)
, CONSTRAINT item_fk3 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Conditionally drop objects.
SELECT 'RENTAL_ITEM' AS "Drop Table";
DROP TABLE IF EXISTS rental_item;

-- ------------------------------------------------------------------
-- Create RENTAL_ITEM table.
-- ------------------------------------------------------------------
SELECT 'RENTAL_ITEM' AS "Create Table";

CREATE TABLE rental_item
( rental_item_id              INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, rental_id                   INT UNSIGNED NOT NULL
, item_id                     INT UNSIGNED NOT NULL
, created_by                  INT UNSIGNED NOT NULL
, creation_date               DATE         NOT NULL
, last_updated_by             INT UNSIGNED NOT NULL
, last_update_date            DATE         NOT NULL
, KEY rental_item_fk1 (rental_id)
, CONSTRAINT rental_item_fk1 FOREIGN KEY (rental_id) REFERENCES rental (rental_id)
, KEY rental_item_fk2 (item_id)
, CONSTRAINT rental_item_fk2 FOREIGN KEY (item_id) REFERENCES item (item_id)
, KEY rental_item_fk3 (created_by)
, CONSTRAINT rental_item_fk3 FOREIGN KEY (created_by) REFERENCES system_user (system_user_id)
, KEY rental_item_fk4 (last_updated_by)
, CONSTRAINT rental_item_fk4 FOREIGN KEY (last_updated_by) REFERENCES system_user (system_user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Commit inserts.
COMMIT;

-- Display tables.
SHOW TABLES;

-- Close log file.
NOTEE
