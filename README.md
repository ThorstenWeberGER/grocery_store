# Practice project for transactional databases

This project focuses on how to set up a transactional database. Contents are:
- [background](https://github.com/ThorstenWeberGER/grocery_store/blob/main/README.md#background) of project
- customer [requirements](https://github.com/ThorstenWeberGER/grocery_store/blob/main/README.md#customer-requirements)
- [guidelines](https://github.com/ThorstenWeberGER/grocery_store/blob/main/README.md#guideline-for-functional-design) for functional design
- [functional diagram](https://github.com/ThorstenWeberGER/grocery_store/blob/main/README.md#functional-diagram)
- [physical model](https://github.com/ThorstenWeberGER/grocery_store/blob/main/README.md#guideline-for-physical-model) and SQL DDL script
- [testing]() phase: data and test queries
- [final thoughts]()

## Background

The owner of a local grocery store wants to manage his day to day business with the use of a PostgreSQL database. He asked us to do the conceptual, functional,  physical modeling and the implementation of the database. Customers can come to the store and shop at location. Additionally, they can call and place orders to be delivered or be picked up by themselves at the store. Promotions help to increase sales or attract new customers. 

The **deliverables** of this project are:
- functional database model and functional diagram
- physical database model
- SQL script for creation of database
- SQL script for storing test data
- SQL script for testing database with simple to complex queries

## Customer requirements

The result of the first interview with the owner is showing following **entities** and **attributes**:
- employees: name, role in grocery store, hire date, salary
- customers: name, address, contact data, loyalty programm points
- orders: order date, ordered products, price, quantity, payment method, if applicable delivery date
- inventory: location in warehouse, product, stock quantity, re-order limit
- suppliers: name, supplied products, contact person, contact information, our employee who manages the vendor
- promotions: name, discount, start time, end time, products on discount (all or specific)

## Guideline for functional design

The next steps are systematically transforming the given information into normalized tables and adding additional columns or tables in order to make a stable and future proof database model. Some exemplary thoughts for the functional designs are:
- transform entities into third normal form, thus adding tables for product categories, employees roles, split name into first and lastname to create atomic values 
- add table for storing historic price and product information as the operative products table should only contain actual data
- 
- having price information in orders table is no violation to normalization as we will store agreed upon prices and current prices in products table can change
-
- for reasons of integrity and consistency we will implement diverse constraints; e.g. choice of data types, check and relational constraints, default values where applicable and not null constraints

## Functional diagram

This diagram shows the database design including relevant information about data type, constraints and relationships. 

<<implement img here>>

Take a look at a [interactive visualization](https://dbdiagram.io/d/grocery-store-681f60745b2fc4582f05719c). Tip: Hoover over aspects of the model and get more information.

## Guideline for physical model 

Make use of Postgres advanced datatypes, implement on delete actions for relations and make use of comments. 

One advantage of using dbdiagram is the good visualization and easy transformation into usable database specific SQL DDL code. But there is still work to do. Adding triggers, views and check constraints cannot be modeled in dbdiagram and have to be done by yourself. Still, I like using dbdiagram very much because it supports the whole process from first visuals to discuss with clients, creating the sql script and if you want you can also use dbdocs for documentation.

[SQL script for database creation](https://.....)

## Test phase

For this purpose we will first populate the tables with test data. SQL DDL script here.

I have used ChatGPT to create test data. See prompt here. 

Secondly I created some simple to complex queries which will test the capabilities and constraints of the database. SQL query script here.

# Final comments

At first, I thought it will be a very simple database structure with two or three tables. But more thoughts went into this project and particularly normalizing the database and thinking about later sales analysis the design required more tables. Example is the table *product history*. Without storing the former product information you will never get a chance to refer to it. The products table only contains current data. 

**Points for further improvements:** One can add further tables for storing all orders and promotion information of previous years. Employees table can also hold address information. And for data analysis we might want to include more qualitative information about our customer. Like a flag for b2b or b2c. 

For demonstration and learning purposes the project will conclude at this stage.
