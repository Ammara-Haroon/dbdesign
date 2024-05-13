USE eshop;
-- Get all  caltegory names 
SELECT `name` FROM product_category;

-- List all variants with brand, subcategory and category names
SELECT pvar.* , p.`name` AS product,b.`name` AS brand,psub.`name` AS subcategory, p.`name` AS category
FROM product_variant AS pvar LEFT JOIN product AS p ON(pvar.product_id = p.id) 
LEFT JOIN product_subcategory AS psub ON (p.product_subcategory_id=psub.id)
LEFT JOIN product_category AS pcat ON (psub.product_category_id=pcat.id)
LEFT JOIN brand AS b ON(p.brand_id=b.id);
 
 -- List all products of apple brand
SELECT pvar.* , p.`name` AS product,b.`name` AS brand,psub.`name` AS subcategory, p.`name` AS category
FROM product_variant AS pvar LEFT JOIN product AS p ON(pvar.product_id = p.id) 
LEFT JOIN product_subcategory AS psub ON (p.product_subcategory_id=psub.id)
LEFT JOIN product_category AS pcat ON (psub.product_category_id=pcat.id)
LEFT JOIN brand AS b ON(p.brand_id=b.id) WHERE b.`name` LIKE 'Apple';
 
-- List top 10 customers with most orders
SELECT c.*,COUNT(o.id) AS cnt FROM customer AS c  INNER JOIN `order` as o ON(o.customer_id = c.id) GROUP BY c.id ORDER BY cnt DESC LIMIT 10;

-- Calculate  Order Total for all orders
SELECT *,SUM(li.quantity*pvar.price) FROM `order` AS o  INNER JOIN line_item as li ON(o.id = li.order_id)
 INNER JOIN product_variant as pvar ON (pvar.id=li.product_variant_id) GROUP BY o.id;

