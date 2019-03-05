--	1.	Get all customers and their addresses.
SELECT * FROM "customers"
JOIN "addresses" on "addresses"."customer_id" = "customers"."id";

--	2.	Get all orders and their line items (orders, quantity and product).
SELECT "orders"."id" as "order_id", "order_date", "quantity", "description" FROM "orders"
JOIN "line_items" on "line_items"."order_id" = "orders"."id"
JOIN "products" on "line_items"."product_id" = "products"."id";

--	3.	Which warehouses have cheetos?
SELECT "product_id", "warehouse_id", "warehouse", "description" FROM "warehouse_product"
JOIN "warehouse" on "warehouse"."id" = "warehouse_product"."warehouse_id"
JOIN "products" on "products"."id" = "warehouse_product"."product_id"
WHERE "product_id" = 5;

--	4.	Which warehouses have diet pepsi?
SELECT "product_id", "warehouse_id", "warehouse", "description" FROM "warehouse_product"
JOIN "warehouse" on "warehouse"."id" = "warehouse_product"."warehouse_id"
JOIN "products" on "products"."id" = "warehouse_product"."product_id"
WHERE "product_id" = 6;

--	5.	Get the number of orders for each customer. 
--		NOTE: It is OK if those without orders are not included in results.
SELECT "customers"."id", "customers"."first_name", "customers"."last_name", COUNT(*) FROM "orders"
JOIN "addresses" on "orders"."address_id" = "addresses"."id"
JOIN "customers" on "customers"."id" = "addresses"."customer_id"
GROUP BY "customers"."id";

--	6.	How many customers do we have?
SELECT COUNT(*) FROM "customers";

--	7.	How many products do we carry?
SELECT COUNT(*) FROM "products";

--	8.	What is the total available on-hand quantity of diet pepsi?
SELECT "product_id", "description", SUM("on_hand") FROM "warehouse_product"
JOIN "products" on "products"."id" = "warehouse_product"."product_id"
WHERE "product_id" = 6
GROUP BY "product_id", "description";

-- STRETCH -------

--	9.	How much was the total cost for each order?
SELECT  "order_id", SUM("quantity" * "unit_price") AS "total_cost" FROM "line_items"
JOIN "products" on "products"."id" = "line_items"."product_id"
GROUP BY "order_id";

--	10.	How much has each customer spent in total?
SELECT "customer_id", SUM("quantity" * "unit_price")  FROM "line_items"
FULL JOIN "orders" on "orders"."id" = "line_items"."order_id" 
FULL JOIN "addresses" on "addresses"."id" = "orders"."address_id"
FULL JOIN "products" on "products"."id" = "line_items"."product_id"
GROUP BY "customer_id";
