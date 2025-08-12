-- create schema in standard database

drop schema if exists grocery_store cascade;
create schema if not exists grocery_store;
SET search_path TO grocery_store;

-- creates all relevant tables for project grocery store

CREATE TABLE if not exists products (
  "product_id" serial PRIMARY KEY,
  "supplier_id" int NOT NULL,
  "name" varchar(50) NOT NULL,
  "price" numeric(10,2) NOT NULL,
  "category_id" int NOT NULL
);

CREATE TABLE if not exists "categories" (
  "category_id" serial PRIMARY KEY,
  "name" varchar(50) NOT NULL,
  "description" varchar(200)
);

CREATE TABLE if not exists "suppliers" (
  "supplier_id" serial PRIMARY KEY,
  "supplier_name" varchar(50) UNIQUE NOT NULL,
  "description" varchar(50),
  "contact_name" varchar(50) NOT NULL,
  "contact_details" varchar(50),
  "account_manager" int NOT NULL
);

CREATE TABLE if not exists "inventory" (
  "location_id" serial PRIMARY KEY,
  "product_id" int NOT NULL,
  "quantity" smallint NOT NULL DEFAULT 0,
  "last_updated" timestamp NOT NULL DEFAULT 'now()',
  "min_stock" smallint NOT NULL,
  "min_order" smallint NOT NULL
);

CREATE TABLE if not exists "orders" (
  "order_id" serial PRIMARY KEY,
  "order_date" timestamp NOT NULL DEFAULT (now()),
  "fulfillment_method" int NOT NULL DEFAULT 0,
  "fulfillment_date" timestamp,
  "total_amount" numeric(10,2) NOT NULL,
  "payment_method_id" int NOT NULL,
  "customer_id" int NOT NULL,
  "employee_id" int NOT NULL
);

CREATE TABLE if not exists "fulfillment_methods" (
  "method_id" serial PRIMARY KEY,
  "name" varchar(50) NOT NULL
);

CREATE TABLE if not exists "payment_methods" (
  "payment_method_id" serial PRIMARY KEY,
  "name" varchar(50) NOT NULL,
  "description" varchar(200)
);


CREATE TABLE if not exists "order_items" (
  "order_item_id" serial PRIMARY KEY,
  "order_id" int not null,
  "product_id" int NOT NULL,
  "quantity" int NOT NULL,
  "price_sold" numeric(10,2) NOT NULL,
  "subtotal" numeric(10,2) NOT NULL
);

CREATE TABLE if not exists "employees" (
  "employee_id" serial PRIMARY KEY,
  "first_name" varchar(50) NOT NULL,
  "last_name" varchar(50) NOT NULL,
  "role_id" int NOT NULL,
  "hire_date" date NOT NULL DEFAULT 'now()',
  "leave_date" date,
  "salary" int NOT NULL,
  "supervisor" int
);

CREATE TABLE if not exists "roles" (
  "role_id" serial PRIMARY KEY,
  "name" varchar(50) NOT NULL,
  "description" varchar(200)
);

CREATE TABLE if not exists "customers" (
  "customer_id" serial PRIMARY KEY,
  "first_name" varchar(50) NOT NULL,
  "last_name" varchar(50) NOT NULL,
  "email" varchar(50),
  "phone" varchar(50),
  "street" varchar(50),
  "housenumber" smallint,
  "postal_code" int,
  "city" varchar(50),
  "loyalty_points" smallint DEFAULT 0
);

CREATE TABLE if not exists "promotions" (
  "promo_id" serial PRIMARY KEY,
  "promo_name" varchar(50) NOT NULL,
  "description" varchar(200),
  "product_id" int,
  "discount_rate" numeric(5,2) NOT NULL DEFAULT 0.05,
  "start_date" date NOT NULL DEFAULT 'now()',
  "end_date" date NOT NULL DEFAULT 'now()'
);

CREATE TABLE if not exists "product_history" (
  "history_id" serial PRIMARY KEY,
  "product_id" int,
  "name_old" varchar(50) NOT NULL,
  "description_old" varchar(200),
  "price_old" numeric(10,2) NOT NULL,
  "category_old" varchar(50),
  "valid_from" timestamp NOT NULL,
  "valid_to" timestamp,
  "change_type" varchar
);

COMMENT ON TABLE "products" IS 'holds current product information';

COMMENT ON COLUMN "products"."supplier_id" IS 'fk to suppliers table';

COMMENT ON COLUMN "products"."name" IS 'holds product name';

COMMENT ON COLUMN "products"."price" IS 'current product price. check if > 0';

COMMENT ON COLUMN "products"."category_id" IS 'fk to categories table';

COMMENT ON TABLE "categories" IS 'holds product categories names. seperated for normalization purposes';

COMMENT ON COLUMN "categories"."name" IS '1: fruits, 2: vegi, 3: meat, 4: cheese, 5: others';

COMMENT ON COLUMN "categories"."description" IS 'additional product description if required';

COMMENT ON TABLE "suppliers" IS 'holds most relevant supplier information';

COMMENT ON COLUMN "suppliers"."supplier_name" IS 'holds supplier name';

COMMENT ON COLUMN "suppliers"."description" IS 'holds supplier description';

COMMENT ON COLUMN "suppliers"."contact_name" IS 'holds supplier employee name who is primary contact person to us';

COMMENT ON COLUMN "suppliers"."contact_details" IS 'holds contact person''s contact details, phone, email, etc.';

COMMENT ON COLUMN "suppliers"."account_manager" IS 'our employee managing the supplier';

COMMENT ON TABLE "inventory" IS 'holds current inventory information including limits';

COMMENT ON COLUMN "inventory"."product_id" IS 'fk to products';

COMMENT ON COLUMN "inventory"."quantity" IS 'holds current inventory quantity, check > 0';

COMMENT ON COLUMN "inventory"."last_updated" IS 'holds date and time of last inventory update';

COMMENT ON COLUMN "inventory"."min_stock" IS 'inventory quantity which is lower limit, check > 0, triggers email';

COMMENT ON COLUMN "inventory"."min_order" IS 'Minimum order quantity';

COMMENT ON TABLE "orders" IS 'holds information about all placed orders including total amount to have history information if product prices change. One order consists of one or many order items';

COMMENT ON COLUMN "orders"."order_id" IS 'Unique identifier for order records';

COMMENT ON COLUMN "orders"."order_date" IS 'holds date of placed order';

COMMENT ON COLUMN "orders"."fulfillment_method" IS 'fk to delivery_methods. describes fulfillment or order';

COMMENT ON COLUMN "orders"."fulfillment_date" IS 'holds delivery date. if null no home-delivery. check (delivery-method <> home-delivery';

COMMENT ON COLUMN "orders"."total_amount" IS 'check > 0 and if sum of all order items subtotal';

COMMENT ON COLUMN "orders"."payment_method_id" IS 'fk to payment_methods table';

COMMENT ON COLUMN "orders"."customer_id" IS 'fk to customers table';

COMMENT ON COLUMN "orders"."employee_id" IS 'fk to employees table';

COMMENT ON TABLE "fulfillment_methods" IS 'holds fulfillment methods. 0 - direct purchase. 1 - pre-order. delivery. 2- pre-order pick-up.';

COMMENT ON COLUMN "fulfillment_methods"."name" IS 'describes fulfillment or order';

COMMENT ON TABLE "payment_methods" IS 'holds payment method details';

COMMENT ON COLUMN "payment_methods"."payment_method_id" IS 'Unique identifier for every record';

COMMENT ON COLUMN "payment_methods"."name" IS '1 - cash, 2 - debit card, 3 - credit card, 4 - paypal';

COMMENT ON COLUMN "payment_methods"."description" IS 'holds additional description of payment method';

COMMENT ON TABLE "order_items" IS 'holds information about order details i.e. which products, which quantities, which product prices. per product in order one entry.';

COMMENT ON COLUMN "order_items"."order_item_id" IS 'Unique identifier for every record';

COMMENT ON COLUMN "order_items"."product_id" IS 'fk to products table, which product has been ordered';

COMMENT ON COLUMN "order_items"."quantity" IS 'holds quantity of ordered product. check > 0';

COMMENT ON COLUMN "order_items"."price_sold" IS 'holds price for which product was sold for historic accuracy. check > 0';

COMMENT ON COLUMN "order_items"."subtotal" IS 'quantity * price_sold. check > 0';

COMMENT ON TABLE "employees" IS 'Stores our employees data';

COMMENT ON COLUMN "employees"."employee_id" IS 'Unique identifier for every record';

COMMENT ON COLUMN "employees"."first_name" IS 'holds first name of our employee';

COMMENT ON COLUMN "employees"."last_name" IS 'holds last name of our employee';

COMMENT ON COLUMN "employees"."role_id" IS 'fk to roles table';

COMMENT ON COLUMN "employees"."hire_date" IS 'holds hiring date of employee';

COMMENT ON COLUMN "employees"."leave_date" IS 'holds last date of work of employee. check leave_date > hire_date.';

COMMENT ON COLUMN "employees"."salary" IS 'holds salary of employee. check > 15000';

COMMENT ON COLUMN "employees"."supervisor" IS 'fk to employees table. 1:m';

COMMENT ON TABLE "roles" IS 'Which roles can our employees have';

COMMENT ON COLUMN "roles"."role_id" IS 'Unique identifier for roles';

COMMENT ON COLUMN "roles"."name" IS 'Different job roles of our employees';

COMMENT ON TABLE "customers" IS 'Stores customer data including loyalty points';

COMMENT ON COLUMN "customers"."customer_id" IS 'Unique identifier of customers records';

COMMENT ON COLUMN "customers"."first_name" IS 'First name of customer';

COMMENT ON COLUMN "customers"."last_name" IS 'Last name of customer';

COMMENT ON COLUMN "customers"."email" IS 'Customer''s email';

COMMENT ON COLUMN "customers"."phone" IS 'Customer''s phone number';

COMMENT ON COLUMN "customers"."street" IS 'Customers adress data';

COMMENT ON COLUMN "customers"."housenumber" IS 'Customers adress data';

COMMENT ON COLUMN "customers"."postal_code" IS 'Customers adress data';

COMMENT ON COLUMN "customers"."city" IS 'Customers adress data';

COMMENT ON COLUMN "customers"."loyalty_points" IS 'Loyalta program points. check >= 0';

COMMENT ON TABLE "promotions" IS 'Stores our advertising promotions conditions';

COMMENT ON COLUMN "promotions"."promo_id" IS 'Unique identifier for promotions records';

COMMENT ON COLUMN "promotions"."promo_name" IS 'Name of promotion';

COMMENT ON COLUMN "promotions"."description" IS 'Optional promotion description';

COMMENT ON COLUMN "promotions"."product_id" IS 'References product on promotion (NULL if storewide)';

COMMENT ON COLUMN "promotions"."discount_rate" IS 'Discount percentage. check: <=0.5 max discount 50% defined';

COMMENT ON COLUMN "promotions"."start_date" IS 'Start date of promotion';

COMMENT ON COLUMN "promotions"."end_date" IS 'End date of promotion';

COMMENT ON TABLE "product_history" IS 'Stores historical product information. Fill will be triggered by update/delete on products table.';

COMMENT ON COLUMN "product_history"."history_id" IS 'Unique identifier for each history record';

COMMENT ON COLUMN "product_history"."product_id" IS 'References the product';

COMMENT ON COLUMN "product_history"."name_old" IS 'Name of product as it was';

COMMENT ON COLUMN "product_history"."description_old" IS 'Product description as it was';

COMMENT ON COLUMN "product_history"."price_old" IS 'Historical retail price';

COMMENT ON COLUMN "product_history"."category_old" IS 'Product category as it was';

COMMENT ON COLUMN "product_history"."valid_from" IS 'When this version became active';

COMMENT ON COLUMN "product_history"."valid_to" IS 'When this version was replaced, NULL if current';

COMMENT ON COLUMN "product_history"."change_type" IS 'Type of change (update, delete)';

ALTER TABLE "products" ADD CONSTRAINT "fk_supplier_id" FOREIGN KEY ("supplier_id") REFERENCES "suppliers" ("supplier_id");

ALTER TABLE "order_items" ADD CONSTRAINT "fk_product_id" FOREIGN KEY ("product_id") REFERENCES "products" ("product_id");

ALTER TABLE "order_items" ADD CONSTRAINT "fk_order_id" FOREIGN KEY ("order_id") REFERENCES "orders" ("order_id");

ALTER TABLE "orders" ADD CONSTRAINT "fk_employee_id" FOREIGN KEY ("employee_id") REFERENCES "employees" ("employee_id");

ALTER TABLE "products" ADD CONSTRAINT "fk_category_id" FOREIGN KEY ("category_id") REFERENCES "categories" ("category_id");

ALTER TABLE "inventory" ADD CONSTRAINT "fk_product_id" FOREIGN KEY ("product_id") REFERENCES "products" ("product_id");

ALTER TABLE "suppliers" ADD CONSTRAINT "fk_account_manager" FOREIGN KEY ("account_manager") REFERENCES "employees" ("employee_id");

ALTER TABLE "orders" ADD CONSTRAINT "fk_fulfillment_method" FOREIGN KEY ("fulfillment_method") REFERENCES "fulfillment_methods" ("method_id");

ALTER TABLE "orders" ADD CONSTRAINT "payment_method" FOREIGN KEY ("payment_method_id") REFERENCES "payment_methods" ("payment_method_id");

ALTER TABLE "employees" ADD CONSTRAINT "fk_supervisor" FOREIGN KEY ("supervisor") REFERENCES "employees" ("employee_id");

ALTER TABLE "employees" ADD CONSTRAINT "fk_role_id" FOREIGN KEY ("role_id") REFERENCES "roles" ("role_id");

ALTER TABLE "orders" ADD CONSTRAINT "fk_customer_id" FOREIGN KEY ("customer_id") REFERENCES "customers" ("customer_id");

ALTER TABLE "promotions" ADD CONSTRAINT "fk_product_id" FOREIGN KEY ("product_id") REFERENCES "products" ("product_id");
