CREATE TABLE x_product_short_description_value ( 
	store_prefix VARCHAR(10) NOT NULL ,
	value VARCHAR(500) NOT NULL ,
	PRIMARY KEY (store_prefix)
) ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_general_ci 
COMMENT = 'product short description value';

