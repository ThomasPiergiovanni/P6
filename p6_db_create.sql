
DROP SCHEMA IF EXISTS p6_db;
CREATE SCHEMA IF NOT EXISTS p6_db CHARACTER SET utf8 ;
USE p6_db ;

DROP TABLE IF EXISTS p6_db.address ;
CREATE TABLE IF NOT EXISTS p6_db.address (
  id INT NOT NULL AUTO_INCREMENT,
  street_number VARCHAR(64) NULL DEFAULT NULL,
  street_name VARCHAR(128) NULL DEFAULT NULL,
  ZIP_code VARCHAR(64) NULL DEFAULT NULL,
  city_name VARCHAR(128) NULL DEFAULT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;

DROP TABLE IF EXISTS p6_db.unit ;
CREATE TABLE IF NOT EXISTS p6_db.unit (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(64) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX Name_UNIQUE (name ASC) )
ENGINE = InnoDB;

DROP TABLE IF EXISTS p6_db.ingredient ;
CREATE TABLE IF NOT EXISTS p6_db.ingredient (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(64) NOT NULL,
  unit_id INT NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX Name_UNIQUE (name ASC) ,
  INDEX fk_ingredient_unit1_idx (unit_id ASC) ,
  CONSTRAINT fk_ingredient_unit1
    FOREIGN KEY (unit_id)
    REFERENCES p6_db.unit (id))
ENGINE = InnoDB;

DROP TABLE IF EXISTS p6_db.role ;
CREATE TABLE IF NOT EXISTS p6_db.role (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(64) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX Name_UNIQUE (name ASC) )
ENGINE = InnoDB;

DROP TABLE IF EXISTS p6_db.user ;
CREATE TABLE IF NOT EXISTS p6_db.user (
  id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(128) NULL DEFAULT NULL,
  last_name VARCHAR(128) NULL DEFAULT NULL,
  email VARCHAR(128) NULL DEFAULT NULL,
  password VARCHAR(128) NULL DEFAULT NULL,
  phone VARCHAR(32) NULL DEFAULT NULL,
  role_id INT NOT NULL,
  address_id INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_user_role1_idx (role_id ASC) ,
  INDEX fk_user_address1_idx (address_id ASC) ,
  CONSTRAINT fk_user_role1
    FOREIGN KEY (role_id)
    REFERENCES p6_db.role (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_user_address1
    FOREIGN KEY (address_id)
    REFERENCES p6_db.address (id))
ENGINE = InnoDB;

DROP TABLE IF EXISTS p6_db.restaurant ;
CREATE TABLE IF NOT EXISTS p6_db.restaurant (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(64) NOT NULL,
  email VARCHAR(128) NULL DEFAULT NULL,
  phone VARCHAR(32) NULL DEFAULT NULL,
  address_id INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_pizzeria_address1_idx (address_id ASC) ,
  UNIQUE INDEX Name_UNIQUE (name ASC) ,
  CONSTRAINT fk_pizzeria_address1
    FOREIGN KEY (address_id)
    REFERENCES p6_db.address (id))
ENGINE = InnoDB;


DROP TABLE IF EXISTS p6_db.status ;
CREATE TABLE IF NOT EXISTS p6_db.status (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX name_UNIQUE (name ASC) )
ENGINE = InnoDB;

DROP TABLE IF EXISTS p6_db.order ;
CREATE TABLE IF NOT EXISTS p6_db.order (
  id INT NOT NULL AUTO_INCREMENT,
  order_number INT NOT NULL,
  user_id INT NOT NULL,
  restaurant_id INT NOT NULL,
  address_id INT NOT NULL,
  status_id INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_order_address1_idx (address_id ASC) ,
  INDEX fk_order_user1_idx (user_id ASC) ,
  INDEX fk_order_pizzeria1_idx (restaurant_id ASC) ,
  UNIQUE INDEX order_number_UNIQUE (order_number ASC) ,
  INDEX fk_order_status1_idx (status_id ASC) ,
  CONSTRAINT fk_order_address1
    FOREIGN KEY (address_id)
    REFERENCES p6_db.address (id),
  CONSTRAINT fk_order_user1
    FOREIGN KEY (user_id)
    REFERENCES p6_db.user (id),
  CONSTRAINT fk_order_restaurant1
    FOREIGN KEY (restaurant_id)
    REFERENCES p6_db.restaurant (id),
  CONSTRAINT fk_order_status1
    FOREIGN KEY (status_id)
    REFERENCES p6_db.Status (id))
ENGINE = InnoDB;

DROP TABLE IF EXISTS p6_db.category ;
CREATE TABLE IF NOT EXISTS p6_db.category (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(64) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX Name_UNIQUE (name ASC) )
ENGINE = InnoDB;

DROP TABLE IF EXISTS p6_db.product ;
CREATE TABLE IF NOT EXISTS p6_db.product (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(128) NOT NULL,
  price DECIMAL(5,2) NOT NULL,
  category_id INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_product_category1_idx (category_id ASC) ,
  UNIQUE INDEX name_UNIQUE (name ASC) ,
  CONSTRAINT fk_product_category1
    FOREIGN KEY (category_id)
    REFERENCES p6_db.category (id))
ENGINE = InnoDB;

DROP TABLE IF EXISTS p6_db.receipt ;
CREATE TABLE IF NOT EXISTS p6_db.receipt (
  product_id INT NOT NULL,
  ingredient_id INT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (product_id, ingredient_id),
  INDEX fk_receipt_ingredient1_idx (ingredient_id ASC) ,
  CONSTRAINT fk_receipt_product1
    FOREIGN KEY (product_id)
    REFERENCES p6_db.product (id),
  CONSTRAINT fk_receipt_ingredient1
    FOREIGN KEY (ingredient_id)
    REFERENCES p6_db.ingredient (id))
ENGINE = InnoDB;

DROP TABLE IF EXISTS p6_db.stock ;
CREATE TABLE IF NOT EXISTS p6_db.stock (
  restaurant_id INT NOT NULL,
  ingredient_id INT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (restaurant_id, ingredient_id),
  INDEX fk_stock_ingredient1_idx (ingredient_id ASC) ,
  CONSTRAINT fk_stock_restaurant1
    FOREIGN KEY (restaurant_id)
    REFERENCES p6_db.restaurant (id),
  CONSTRAINT fk_stock_ingredient1
    FOREIGN KEY (ingredient_id)
    REFERENCES p6_db.ingredient (id))
ENGINE = InnoDB;

DROP TABLE IF EXISTS p6_db.orderline ;
CREATE TABLE IF NOT EXISTS p6_db.orderline (
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (order_id, product_id),
  INDEX fk_order_has_product_product1_idx (product_id ASC) ,
  INDEX fk_order_has_product_order1_idx (order_id ASC) ,
  CONSTRAINT fk_order_has_product_order1
    FOREIGN KEY (order_id)
    REFERENCES p6_db.order (id),
  CONSTRAINT fk_order_has_product_product1
    FOREIGN KEY (product_id)
    REFERENCES p6_db.product (id))
ENGINE = InnoDB;
