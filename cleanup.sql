/* 
Drop tables, views, and referential constraints from the database.
*/
-- Provide a log file debugging statement.
SELECT 'DROP PROCEDURE IF EXISTS dropForeignKeys';

-- Conditionally drop the procedure.
DROP PROCEDURE IF EXISTS dropForeignKeys;

-- Provide a log file debugging statement.
SELECT 'CREATE PROCEDURE dropForeignKeys';
 
-- Change delimiter to create procedure.
DELIMITER $$
 
-- Create procedure.
CREATE PROCEDURE dropForeignKeys
( pv_database          VARCHAR(64)
, pv_referenced_table  VARCHAR(64))
BEGIN
 
  /* Declare local statement variables. */
  DECLARE lv_stmt VARCHAR(1024);
 
  /* Declare local cursor variables. */
  DECLARE lv_table_name       VARCHAR(64);
  DECLARE lv_constraint_name  VARCHAR(64);
 
  /* Declare control variable for handler. */
  DECLARE fetched       INT DEFAULT 0;
 
  /* Declare local cursor. */
  DECLARE foreign_key_cursor CURSOR FOR
    SELECT   rc.TABLE_NAME
    ,        rc.constraint_name
    FROM     information_schema.referential_constraints rc
    WHERE    constraint_schema = IFNULL(pv_database,database())
    AND      referenced_table_name = pv_referenced_table
    ORDER BY rc.TABLE_NAME
    ,        rc.constraint_name;
 
  /* Declare a not found record handler to close a cursor loop. */
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fetched = 1;

  /* Open a local cursor. */  
  OPEN foreign_key_cursor;
  cursor_foreign_key: LOOP
 
    FETCH foreign_key_cursor
    INTO  lv_table_name
    ,     lv_constraint_name;
 
    /* Place the catch handler for no more rows found
       immediately after the fetch operation.          */
    IF fetched = 1 THEN LEAVE cursor_foreign_key; END IF;

    /* Set a SQL statement by using concatenation. */
    SET @SQL := CONCAT('ALTER TABLE',' ',lv_table_name,' ','DROP FOREIGN KEY',' ',lv_constraint_name);

    /* Prepare, run, and deallocate statement. */
    PREPARE lv_stmt FROM @SQL;
    EXECUTE lv_stmt;
    DEALLOCATE PREPARE lv_stmt;

  END LOOP cursor_foreign_key;
  CLOSE foreign_key_cursor;  
 
END;
$$
 
-- Reset delimiter to run SQL statements.
DELIMITER ;

-- Provide a log file debugging statement.
SELECT 'DROP PROCEDURE IF EXISTS dropViews';

-- Conditionally drop the procedure.
DROP PROCEDURE IF EXISTS dropViews;

-- Provide a log file debugging statement.
SELECT 'CREATE PROCEDURE dropViews';
 
-- Change delimiter to create procedure.
DELIMITER $$
 
-- Create procedure.
CREATE PROCEDURE dropViews
( pv_database  VARCHAR(64))
BEGIN
 
  /* Declare local statement variables. */
  DECLARE lv_stmt VARCHAR(1024);
 
  /* Declare local cursor variables. */
  DECLARE lv_view_name       VARCHAR(64);
 
  /* Declare control variable for handler. */
  DECLARE fetched       INT DEFAULT 0;
 
  /* Declare local cursor. */
  DECLARE view_cursor CURSOR FOR
    SELECT   v.table_name
    FROM     information_schema.views v
    WHERE    table_schema = IFNULL(pv_database, database())
    ORDER BY v.table_name;
 
  /* Declare a not found record handler to close a cursor loop. */
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fetched = 1;
 
  /* Open a local cursor. */  
  OPEN view_cursor;
  cursor_view: LOOP
 
    FETCH view_cursor
    INTO  lv_view_name;
 
    /* Place the catch handler for no more rows found
       immediately after the fetch operation.          */
    IF fetched = 1 THEN LEAVE cursor_view; END IF;
 
    /* Set a SQL statement by using concatenation. */
    SET @SQL := CONCAT('DROP VIEW',' ',lv_view_name);
 
    /* Prepare, run, and deallocate statement. */
    PREPARE lv_stmt FROM @SQL;
    EXECUTE lv_stmt;
    DEALLOCATE PREPARE lv_stmt;
 
  END LOOP cursor_view;
  CLOSE view_cursor;  
 
END;
$$
 
-- Reset delimiter to run SQL statements.
DELIMITER ;

-- Drop the views.
CALL dropViews(null);

-- Provide a log file debugging statement.
SELECT 'DROP PROCEDURE IF EXISTS dropTables';

-- Conditionally drop the procedure.
DROP PROCEDURE IF EXISTS dropTables;

-- Provide a log file debugging statement.
SELECT 'CREATE PROCEDURE dropTables';
 
-- Change delimiter to create procedure.
DELIMITER $$
 
-- Create procedure.
CREATE PROCEDURE dropTables
( pv_database  VARCHAR(64))
BEGIN
 
  /* Declare local statement variables. */
  DECLARE lv_stmt  VARCHAR(1024);
 
  /* Declare local cursor variables. */
  DECLARE lv_table_name  VARCHAR(64);
 
  /* Declare control variable for handler. */
  DECLARE fetched       INT DEFAULT 0;
 
  /* Declare local cursor. */
  DECLARE table_cursor CURSOR FOR
    SELECT   t.table_name
    FROM     information_schema.tables t
    WHERE    table_schema = IFNULL(pv_database, database())
    ORDER BY t.table_name;
 
  /* Declare a not found record handler to close a cursor loop. */
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fetched = 1;

  /* Drop the views. */
  CALL dropViews(null);
  
  /* Open a local cursor. */  
  OPEN table_cursor;
  cursor_table: LOOP
 
    FETCH table_cursor
    INTO  lv_table_name;
 
    /* Place the catch handler for no more rows found
       immediately after the fetch operation.          */
    IF fetched = 1 THEN LEAVE cursor_table; END IF;

    /* Drop the tables. */
    CALL dropForeignKeys(null,lv_table_name);

    /* Set a SQL statement by using concatenation. */
    SET @SQL := CONCAT('DROP TABLE',' ',lv_table_name);
 
    /* Prepare, run, and deallocate statement. */
    PREPARE lv_stmt FROM @SQL;
    EXECUTE lv_stmt;
    DEALLOCATE PREPARE lv_stmt;
 
  END LOOP cursor_table;
  CLOSE table_cursor;  
 
END;
$$
 
-- Reset delimiter to run SQL statements.
DELIMITER ;

-- Drop the tables, views, and referential constraints.
CALL dropTables(null);

SHOW TABLES;
