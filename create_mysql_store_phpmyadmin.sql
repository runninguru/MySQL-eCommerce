DROP TABLE IF EXISTS system_user;
CREATE TABLE system_user
( system_user_id              INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, system_user_name            VARCHAR(50) 	NOT NULL
, system_user_type            INT UNSIGNED 	NOT NULL
, first_name                  VARCHAR(50)
, middle_name                 VARCHAR(50)
, last_name                   VARCHAR(50)
, created_by                  INT UNSIGNED
, creation_date               DATETIME    
, last_updated_by             INT UNSIGNED
, last_update_date            DATETIME    ) ENGINE=InnoDB;
ALTER TABLE system_user AUTO_INCREMENT = 1001;
ALTER TABLE `system_user` ADD INDEX `system_user_fk1` (`system_user_type`);
ALTER TABLE `system_user` ADD CONSTRAINT `system_user_fk1` FOREIGN KEY (`system_user_type`) 
REFERENCES `system_user_type`(`system_user_type_id`) 
ON DELETE RESTRICT 
ON UPDATE RESTRICT;
DROP TABLE IF EXISTS system_user_type;
CREATE TABLE system_user_type
( system_user_type_id			INT UNSIGNED 	PRIMARY KEY AUTO_INCREMENT
, system_user_type 				VARCHAR(50) 	NOT NULL
, created_by                  	INT UNSIGNED 	
, creation_date               	DATETIME        
, last_updated_by             	INT UNSIGNED 	
, last_update_date            	DATETIME        ) ENGINE=InnoDB;
ALTER TABLE system_user_type AUTO_INCREMENT = 1001;

INSERT INTO system_user_type
( system_user_type 
, created_by
, last_updated_by)
VALUES
('database administrator', 1, 1);

INSERT INTO system_user_type
( system_user_type 
, created_by
, last_updated_by)
VALUES
('database developer', 1, 1);

INSERT INTO system_user
( system_user_name
, system_user_type
, created_by
, last_updated_by)
VALUES
('kylebirc_admin', (SELECT system_user_type_id
						FROM system_user_type
   						WHERE system_user_type = 'database administrator'), 1, 1);

DROP TABLE IF EXISTS account;
CREATE TABLE account
( account_id                   	INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, account_type                 	INT UNSIGNED
, account_number              	VARCHAR(10)     NOT NULL
, password 						INT UNSIGNED NOT NULL
, created_by                  	INT UNSIGNED 
, creation_date               	DATETIME     
, last_updated_by             	INT UNSIGNED 
, last_update_date            	DATETIME      ) ENGINE=InnoDB;
ALTER TABLE account AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS account_type;
CREATE TABLE account_type
( account_type_id 				INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, account_type 					INT UNSIGNED
, created_by                  	INT UNSIGNED 
, creation_date               	DATETIME     
, last_updated_by             	INT UNSIGNED 
, last_update_date            	DATETIME      ) ENGINE=InnoDB;
ALTER TABLE account_type AUTO_INCREMENT = 1001;
INSERT INTO account_type
( account_type 
, created_by
, last_updated_by)
VALUES
('administrator', 1, 1);
INSERT INTO account_type
( account_type 
, created_by
, last_updated_by)
VALUES
('user', 1, 1);
DROP TABLE IF EXISTS contact;
CREATE TABLE contact
( contact_id                  INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, account_id                   INT UNSIGNED NOT NULL
, contact_type                INT UNSIGNED 
, email 						VARCHAR(50)	NOT NULL
, first_name                  VARCHAR(50)     NOT NULL
, middle_name                 VARCHAR(50)
, last_name                   VARCHAR(50)     NOT NULL
, telephone_id 					VARCHAR(50) 	NOT NULL
, created_by                  INT UNSIGNED 
, creation_date               DATETIME     
, last_updated_by             INT UNSIGNED 
, last_update_date            DATETIME       ) ENGINE=InnoDB;
ALTER TABLE contact AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS contact_type;
CREATE TABLE contact_type
( contact_type_id 				INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, contact_type 					INT UNSIGNED
, created_by                  	INT UNSIGNED NOT NULL
, creation_date               	DATETIME     
, last_updated_by             	INT UNSIGNED 
, last_update_date            	DATETIME        ) ENGINE=InnoDB;
ALTER TABLE contact_type AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS telephone;
CREATE TABLE telephone
( telephone_id 					INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, area_code 					INT UNSIGNED	NOT NULL
, telephone_number 				INT UNSIGNED	NOT NULL
, telephone_type 				INT UNSIGNED	NOT NULL
, created_by 					INT UNSIGNED
, creation_date               	DATETIME        
, last_updated_by             	INT UNSIGNED 	
, last_update_date            	DATETIME        ) ENGINE=InnoDB;
ALTER TABLE telephone AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS telephone_type;
CREATE TABLE telephone_type
( telephone_type_id 			INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, telephone_type 				INT UNSIGNED	NOT NULL
, created_by                  	INT UNSIGNED 	
, creation_date               	DATETIME        
, last_updated_by             	INT UNSIGNED 	
, last_update_date            	DATETIME        ) ENGINE=InnoDB;
ALTER TABLE telephone_type AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS credit_card;
CREATE TABLE credit_card
( credit_card_id 				INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, account_id 					INT UNSIGNED 	NOT NULL
, credit_card_number 			INT UNSIGNED 	NOT NULL
, credit_card_type 				INT UNSIGNED 	NOT NULL
, expiration_date 				DATETIME 		 	NOT NULL
, cvv 							INT UNSIGNED
, created_by                  	INT UNSIGNED 	
, creation_date               	DATETIME        
, last_updated_by             	INT UNSIGNED 	
, last_update_date            	DATETIME         	) ENGINE=InnoDB;
ALTER TABLE credit_card AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS credit_card_type;
CREATE TABLE credit_card_type
( credit_card_type_id 			INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, credit_card_type 				INT UNSIGNED	NOT NULL
, created_by                  	INT UNSIGNED 
, creation_date               	DATETIME     
, last_updated_by             	INT UNSIGNED 
, last_update_date            	DATETIME     ) ENGINE=InnoDB;
ALTER TABLE credit_card_type AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS address;
CREATE TABLE address
( address_id		 			INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, address_type	 				INT UNSIGNED	NOT NULL
, account_id 					INT UNSIGNED	NOT NULL
, street_address 				VARCHAR(50) 		NOT NULL
, city_state_id 				INT UNSIGNED 	NOT NULL
, postal_code_id 				INT UNSIGNED 	NOT NULL
, created_by                  	INT UNSIGNED 	
, creation_date               	DATETIME        
, last_updated_by             	INT UNSIGNED 	
, last_update_date            	DATETIME         ) ENGINE=InnoDB;
ALTER TABLE address AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS address_type;
CREATE TABLE address_type
( address_type_id	 			INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, address_type 					INT UNSIGNED	NOT NULL
, created_by                  	INT UNSIGNED 	
, creation_date               	DATETIME        
, last_updated_by             	INT UNSIGNED 	
, last_update_date            	DATETIME         	) ENGINE=InnoDB;
ALTER TABLE address_type AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS city;
CREATE TABLE city
( city_id 						INT UNSIGNED 	PRIMARY KEY AUTO_INCREMENT
, city 							INT UNSIGNED	NOT NULL
, created_by                  	INT UNSIGNED 	
, creation_date               	DATETIME        
, last_updated_by             	INT UNSIGNED 	
, last_update_date            	DATETIME         	) ENGINE=InnoDB;
ALTER TABLE city AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS state;
CREATE TABLE state
( state_id 						INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, state 						INT UNSIGNED	NOT NULL
, created_by                  	INT UNSIGNED 	
, creation_date               	DATETIME        
, last_updated_by             	INT UNSIGNED 	
, last_update_date            	DATETIME        ) ENGINE=InnoDB;
ALTER TABLE state AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS city_state;
CREATE TABLE city_state
( city_state_id 				INT UNSIGNED 	PRIMARY KEY AUTO_INCREMENT
, city_id 						INT UNSIGNED 	NOT NULL
, state_id 						INT UNSIGNED 	NOT NULL
, created_by                  	INT UNSIGNED 	
, creation_date               	DATETIME        
, last_updated_by             	INT UNSIGNED 	
, last_update_date            	DATETIME        ) ENGINE=InnoDB;
ALTER TABLE city_state AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS postal_code;
CREATE TABLE postal_code
( postal_code_id 				INT UNSIGNED 	PRIMARY KEY AUTO_INCREMENT
, postal_code 					INT UNSIGNED 	NOT NULL
, created_by                  	INT UNSIGNED 	
, creation_date               	DATETIME        
, last_updated_by             	INT UNSIGNED 	
, last_update_date            	DATETIME         ) ENGINE=InnoDB;
ALTER TABLE postal_code AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS item;
CREATE TABLE item
( item_id 						INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, item_title 					VARCHAR(50) 		NOT NULL
, item_subtitle 				VARCHAR(50) 
, item_category_id 				INT UNSIGNED	NOT NULL
, item_subcategory_id 			INT UNSIGNED 	NOT NULL
, created_by                  	INT UNSIGNED 	
, creation_date               	DATETIME        
, last_updated_by             	INT UNSIGNED 	
, last_update_date            	DATETIME        ) ENGINE=InnoDB;
ALTER TABLE item AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS item_category;
CREATE TABLE item_category
( item_category_id 				INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, item_category 				VARCHAR(50)	NOT NULL
, created_by                  	INT UNSIGNED 	
, creation_date               	DATETIME        
, last_updated_by             	INT UNSIGNED 	
, last_update_date            	DATETIME         ) ENGINE=InnoDB;
ALTER TABLE item_category AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS item_subcategory;
CREATE TABLE item_subcategory
( item_subcategory_id 			INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, category_id 					INT UNSIGNED 	NOT NULL
, item_subcategory 				VARCHAR(50)	NOT NULL
, created_by                  	INT UNSIGNED 	
, creation_date               	DATETIME        
, last_updated_by             	INT UNSIGNED 	
, last_update_date            	DATETIME         ) ENGINE=InnoDB;
ALTER TABLE item_subcategory AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS transaction;
CREATE TABLE transaction
( transaction_id 				INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
, account_id 					INT UNSIGNED 	NOT NULL
, transaction_type 				INT UNSIGNED	NOT NULL
, transaction_date 				DATETIME 			NOT NULL
, amount 						INT UNSIGNED 	NOT NULL
, created_by                  	INT UNSIGNED 	
, creation_date               	DATETIME        
, last_updated_by             	INT UNSIGNED 	
, last_update_date            	DATETIME       ) ENGINE=InnoDB;
ALTER TABLE transaction AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS transaction_type;
CREATE TABLE transaction_type
( transaction_type_id 			INT UNSIGNED 	PRIMARY KEY AUTO_INCREMENT
, transaction_type 				VARCHAR(50) 		NOT NULL
, created_by 					INT UNSIGNED	
, creation_date               	DATETIME        
, last_updated_by             	INT UNSIGNED 	
, last_update_date            	DATETIME         ) ENGINE=InnoDB;
ALTER TABLE transaction_type AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS transaction_item;
CREATE TABLE transaction_item
( transaction_item_id 			INT UNSIGNED 	PRIMARY KEY AUTO_INCREMENT
, transaction_id 				VARCHAR(50) 		NOT NULL
, item_id 						INT UNSIGNED 	NOT NULL
, created_by 					INT UNSIGNED	
, creation_date               	DATETIME        
, last_updated_by             	INT UNSIGNED 	
, last_update_date            	DATETIME        ) ENGINE=InnoDB;
ALTER TABLE transaction_item AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS price;
CREATE TABLE price
( price_id 						INT UNSIGNED 	PRIMARY KEY AUTO_INCREMENT
, item_id 						VARCHAR(50) 		NOT NULL
, price_type 					INT UNSIGNED 	NOT NULL
, active_flag 					text 			NOT NULL
, start_date 					DATETIME 			NOT NULL
, end_date 						DATETIME
, amount 						INT UNSIGNED 	NOT NULL
, created_by 					INT UNSIGNED	
, creation_date               	DATETIME        
, last_updated_by             	INT UNSIGNED 	
, last_update_date            	DATETIME         ) ENGINE=InnoDB;
ALTER TABLE price AUTO_INCREMENT = 1001;
DROP TABLE IF EXISTS price_type;
CREATE TABLE price_type
( price_type_id 				INT UNSIGNED 	PRIMARY KEY AUTO_INCREMENT
, price_type 					VARCHAR(50) 		NOT NULL
, created_by                  	INT UNSIGNED 	
, creation_date               	DATETIME        
, last_updated_by             	INT UNSIGNED 	
, last_update_date            	DATETIME         ) ENGINE=InnoDB;
ALTER TABLE price_type AUTO_INCREMENT = 1001;