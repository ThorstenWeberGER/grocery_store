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

The owner of a local grocery store wants to manage his day to day business with the use of a PostgreSQL database. He asks us to do the conceptual, functional and physical modeling and also the implementation of the database. Besides selling in the store the grocery store also does deliver orders and take order for pick-up by customers. Promotions help to increase sales or create new customers. As the food delivery and pre-order business of loyal customer increases and also local restaurants start ordering fresh produce the owner wants to digitalize.

The **deliverables** of this project are:
- functional database model and functional diagram
- physical database model
- SQL script for creation of database
- SQL script for storing test data
- SQL script for testing database with simple to complex queries

## Customer requirements

The result of the first interview with the owner is showing following **entities** and **attributes**:
- employees: name, role in grocery store, hire date, salary
- customers: name, adress, contact data, loyalty programm points
- orders: order date, ordered products, price, quantity, payment method, if applicable delivery date
- inventory: location in warehouse, product, stock quantity, re-order limit
- suppliers: name, supplied products, contact person, contact information, our employee who managers the vendor
- promotions: name, discount, start time, end time, products on discount (all or specific)

## Guideline for functional design

The next steps are systematically transforming the given information into normalized tables and adding additional columns or tables in order to make a stable and future proof database model. Some exemplary thoughts for the functional designs are:
- transform entities into third normal form, thus adding tables for product categories, employees roles, payments methods and more
- add table for storing historic price and product information as the operative products table should only contain actual data
- having price information in orders table is no violation to normalization as we will store agreed upon prices and current prices in products table can change
- to increate integrity and secure consistency we will implement diverse constraints by smart choice of data types, check constraints and of course relational constraints, adding default values where applicable and not null constraings

## Functional diagram

This diagram shows the database design including important information about data type, constraints and relationships. Also you will find comments for every column.

[Functional diagram](https://dbdiagram.io/d/grocery-store-681f60745b2fc4582f05719c). Tipp: hoover over relations and columns to find more information.

## Guideline for physical model 

Make use of Postgres advanced datatypes, implement on delete actions for relations and make use of comments. 

One advantage of using dbdiagram is the good visualization and easy transformation into usable database specific SQL DDL code. But there is still work to do. Adding triggers, views and check constraints cannot be modeled in dbdiagram and have to be done by yourself. Still, I like using dbdiagram very much because it supports the whole process from first visuals to discuss with clients, creating the sql script and if you want you can also use dbdocs for documentation.

[SQL script for database creation](https://.....)

## Populating some test data

## Running some test queries

# Final comments

At first, I thought it will be a very simple database structure with two or three tables. But the more thoughts went into this project and especially when normalizing the database and thinking about later sales analysis the design required more tables. Example is the table *product history*. Without storing the former product information you will never get a chance to reference to it. The products table only contains current data. 

**Points for further improvements:** One can add further tables for storing all orders and promotion information of last years. Employees table can also hold adress information. And for data analysis we might want to include some more qualitative information about our products and especcially customer information. Like a flag for b2b or b2c customer or birthday. Anyhow for demonstration and learning purposes I will finish the project at this stage. 
