CREATE DATABASE eshop;
USE eshop;
CREATE TABLE  product_category (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE  product_subcategory (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    product_category_id INT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(product_category_id) REFERENCES product_category(id)
);


CREATE TABLE  brand (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE  product (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    product_subcategory_id INT UNSIGNED NOT NULL,
    brand_id INT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL,
    `type` VARCHAR(255),
    PRIMARY KEY(id),
    FOREIGN KEY(product_subcategory_id) REFERENCES product_subcategory(id),
    FOREIGN KEY(brand_id) REFERENCES brand(id)
);

CREATE TABLE  customer (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    mobile_number VARCHAR(20),
    dob DATE,
    PRIMARY KEY(id)
);

CREATE TABLE  `order` (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    customer_id INT UNSIGNED NOT NULL,
    order_id INT UNSIGNED NOT NULL,
    order_date Date NOT NULL,
    order_status VARCHAR(15),
    PRIMARY KEY(id),
    FOREIGN KEY(customer_id) REFERENCES customer(id),
	FOREIGN KEY(order_id) REFERENCES `order`(id)
);

CREATE TABLE  address (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    customer_id INT UNSIGNED NOT NULL,
    order_id INT UNSIGNED,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    company_name VARCHAR(255),
    address_line VARCHAR(255) NOT NULL,
    is_default BOOL, 
    PRIMARY KEY(id),
    FOREIGN KEY(customer_id) REFERENCES customer(id),
	FOREIGN KEY(order_id) REFERENCES `order`(id)
);


CREATE TABLE  product_variant (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    product_id INT UNSIGNED NOT NULL,
    sku INT UNSIGNED NOT NULL,
    stock INT UNSIGNED NOT NULL,
    date_added DATE NOT NULL,
    price DECIMAL(65,4) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(product_id) REFERENCES product(id)
);

CREATE TABLE  product_feature (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    product_variant_id INT UNSIGNED NOT NULL,
    `type` VARCHAR(255),
    `value` VARCHAR(255),
    PRIMARY KEY(id),
    FOREIGN KEY(product_variant_id) REFERENCES product_variant(id)
);

CREATE TABLE  line_item (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    order_id INT UNSIGNED NOT NULL,
    product_variant_id INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(order_id) REFERENCES `order`(id),
    FOREIGN KEY(product_variant_id) REFERENCES product_variant(id)
);

CREATE TABLE  cart (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    customer_id INT UNSIGNED NOT NULL,
    last_accessed DateTime NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(customer_id) REFERENCES customer(id)
);

CREATE TABLE  cart_item (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    cart_id INT UNSIGNED NOT NULL,
    product_variant_id INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(cart_id) REFERENCES cart(id),
    FOREIGN KEY(product_variant_id) REFERENCES product_variant(id)
);

CREATE TABLE  wish_list_item (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    customer_id INT UNSIGNED NOT NULL,
    product_variant_id INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(product_variant_id) REFERENCES product_variant(id),
    FOREIGN KEY(customer_id) REFERENCES customer(id)
);

CREATE TABLE  review (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    customer_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    `text` LONGTEXT NOT NULL,
    date_submitted DATETIME NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(product_id) REFERENCES product(id),
    FOREIGN KEY(customer_id) REFERENCES customer(id)
);

CREATE TABLE  discount_deal (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    product_variant_id INT UNSIGNED NOT NULL,
    discount_percentage DECIMAL(10,2),
    PRIMARY KEY(id),
    FOREIGN KEY(product_variant_id) REFERENCES product_variant(id)
);

CREATE TABLE  clearance (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    product_variant_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(product_variant_id) REFERENCES product_variant(id)
);

INSERT INTO product_category(`name`) VALUES 
 ('Mobiles'),
 ('Home Appliances'),
 ('TVs'),
 ('Computers');
 
INSERT INTO product_subcategory(product_category_id,`name`) VALUES 
 (1,'Gaming Phones'),
 (1,'Foldable Phones'),
 (1,'Kids Phones'),
 (1,'5G Phones'),
 (4,'Laptops'),
 (4,'Ipads'),
 (4,'Desktops'),
 (2,'Fridges'),
 (2,'Washers'),
 (2,'Dryers'),
 (3,'OLED'),
 (3,'Smart TVs');
 
 INSERT INTO brand(`name`) VALUES
 ('Samsung'),
 ('LG'),
 ('Apple'),
 ('HP'),
 ('Microsoft'),
 ('Google'),
 ('Dell'),
 ('TCL'),
 ('Fisher and Paykel');
SELECT * FROM brand;

INSERT INTO product(product_subcategory_id,brand_id,`name`,`type`) VALUES 
 (1,3,'Apple Gaming Phone 1',null),
 (1,3,'Apple Gaming Phone 2',null),
 (1,3,'Apple Gaming Phone 3',null),
 (2,1,'Sam Foldable Phone 1',null),
 (2,1,'Sam Foldable Phone 2',null),
 (3,2,'LG Kids Phones',null),
 (4,3,'Apple 5G Phone',null),
 (4,1,'Sam 5G Phone',null),
 (5,4,'HP Laptop 1',null),
 (5,4,'HP Laptop 2',null),
 (5,7,'Dell Laptop 1',null),
 (6,3,'Ipads',null),
 (8,9,'F&P Fridge','Top Freezer'),
 (8,1,'Sam Fridge','Bottom Freezer'),
 (9,2,'LG Washer','Top Loader'),
 (9,2,'LG Washer','Front Loader'),
 (10,2,'LG Dryer','Top Loader'),
 (10,2,'LG Dryer','Front Loader'),
 (11,8,'TCL OLED','Small Screen'),
 (12,2,'LG Smart TV','Big Screen');
 
INSERT INTO customer(first_name,last_name,email,mobile_number,dob) VALUES
('John', 'Smith','js@somemail.com','04444444444','1980-12-12'),
('Jane', 'Smith','jane@somemail.com','04444444444','1982-10-10');


INSERT INTO address(customer_id,order_id,first_name,last_name,company_name,address_line,is_default) VALUES
(1,null, 'Sam','Smith',null,'1 Happy Lane',true),
(1,null, 'John','Smith','company','1 Work Lane',false),
(2,null,'Jane', 'Smith',null,'2 Happy Lane',true);

