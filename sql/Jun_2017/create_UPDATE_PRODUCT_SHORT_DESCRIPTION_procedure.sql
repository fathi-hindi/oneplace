DROP PROCEDURE UPDATE_PRODUCT_SHORT_DESCRIPTION;

CREATE PROCEDURE UPDATE_PRODUCT_SHORT_DESCRIPTION()
    NO SQL
    COMMENT 'This is used to update product short description'
P1: BEGIN
	DECLARE v_done INT DEFAULT FALSE;
	DECLARE V_STORE_PRIFIX longtext;
	DECLARE C_STORE_PRFIX_LIST CURSOR FOR select store_prefix from x_product_short_description_value;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;	
	
	insert into catalog_product_entity_text (attribute_id, entity_id, value) (select (select attribute_id from eav_attribute where attribute_code = 'short_description' and entity_type_id = (select entity_type_id from eav_entity_type where entity_type_code = 'catalog_product')), entity_id, '' from catalog_product_entity where entity_id not in (select entity_id from catalog_product_entity_text where attribute_id = (select attribute_id from eav_attribute where attribute_code = 'short_description' and entity_type_id = (select entity_type_id from eav_entity_type where entity_type_code = 'catalog_product'))));
		
	OPEN C_STORE_PRFIX_LIST;
		
c_stack_loop: 
	LOOP FETCH C_STORE_PRFIX_LIST INTO V_STORE_PRIFIX;			
		IF v_done THEN 
			LEAVE c_stack_loop; 
		END IF;  
		
		IF (LENGTH(V_STORE_PRIFIX) > 0) THEN 
			update catalog_product_entity_text set value = (select value from x_product_short_description_value where store_prefix = CONCAT(V_STORE_PRIFIX,'')) where entity_id in (select entity_id from catalog_product_entity where sku like CONCAT(V_STORE_PRIFIX, '%')) and attribute_id = (select attribute_id from eav_attribute where attribute_code = 'short_description' and entity_type_id = (select entity_type_id from eav_entity_type where entity_type_code = 'catalog_product'));
		END IF; 
	END LOOP; 
	
	CLOSE C_STORE_PRFIX_LIST; 
	SELECT * from x_product_short_description_value AS summary;  
END P1
