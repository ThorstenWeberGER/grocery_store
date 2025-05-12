# Practice project for transactional databases

<p align="left">
  <img src="grocery_store_man%20with%20notebook.jpg" alt="man with notebook in grocery store" width="30%">
  <br>Picture generated with ChatGPT
</p>

This project focuses on how to set up a transactional database. **Contents** are:
- [background](https://github.com/ThorstenWeberGER/grocery_store/blob/main/README.md#background) of project
- customer [requirements](https://github.com/ThorstenWeberGER/grocery_store/blob/main/README.md#customer-requirements)
- [guidelines](https://github.com/ThorstenWeberGER/grocery_store/blob/main/README.md#guideline-for-functional-design) for functional design
- [functional diagram](https://github.com/ThorstenWeberGER/grocery_store/blob/main/README.md#functional-diagram)
- [physical model](https://github.com/ThorstenWeberGER/grocery_store/blob/main/README.md#guideline-for-physical-model) and SQL DDL script
- [testing]() phase: data and test queries
- [final thoughts]()

### Scope of project

Main goal of this project is to demonstrate the main steps of a database design and to illustrate some of the important decisions made on the way. Thus said, we will go the full way but focus strongly on the main aspects and decisions made.

Generally a database project from scratch will have **three major phases** before coding:
1. *conceptual model*: collect customer requirements, create entity relationship models and diagrams for discussion with clients
2. *functional model*: transform requirements into tables, columns, datatypes, keys, normalization
3. *physical model*: create database specific implementation plan, partitioning, indexing
In our approach we will skip parts of the first phase and directly begin showing functional models.

Let's jump right in ;-)

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
- *employees*: name, role in grocery store, hire date, salary
- *customers*: name, address, contact data, loyalty programm points
- *orders*: order date, ordered products, price, quantity, payment method, if applicable delivery date
- *inventory*: location in warehouse, product, stock quantity, re-order limit
- *suppliers*: name, supplied products, contact person, contact information, our employee who manages the vendor
- *promotions*: name, discount, start time, end time, products on discount (all or specific)

## Guidelines for functional design

The next steps include transforming entities into tables, attributes into columns, define their datatypes and cadinality of their relationships. 

Some **exemplary thoughts** for the functional designs were:
- *primary keys*: generate surrogate primary keys 
- *atomic values*: some attributes need to be further split into multiple columns like the name attribute will be stored as firstname and lastname
- *normalization*: transform entities into third normal form, eventually adding tables for product categories, employees roles 
- *constraints*: choice of correct data types, keys constraints, default values where applicable and not null constraints
- *historic values*: add a separate table with no relationships to store historic price and product information seperate from the operative products table which will hold only actual data

**Pragmatic de-normalization**
Saving total bill of an order and its individual product prices can be seen as a violation against third normal form. That is true for the total of the order table, as it can be calculated by quantity of order and price. But sometimes you compromise as it is pragmatic to store the total simply aside the order number. And the individual products prices are required if there are individual agreements besides the list prices. That is the case for b2b customers especially. And also: the prices are changing over time. So you need a place where to store the prices valid at the point of time. This will the done in the order items table for each individual product

That said, above thoughts are all means to an end, meaning database integrity and consistency over its lifecycle.

## Functional diagram

This diagram shows the resulting database design including relevant information about data type, constraints and relationships. 

![Functional diagram](functional%20diagram.png)

Take a look at the [interactive visualization](https://dbdiagram.io/d/grocery-store-681f60745b2fc4582f05719c) where you get more information via hoovering over aspects of the model.

## Guideline for physical model 

Make use of Postgres advanced datatypes, implement on delete actions for relations and make use of comments. 

One advantage of using *dbdiagram* besides good visualization is easy transformation into usable database specific SQL DDL code. But there is still work to do. Adding triggers, views and check constraints cannot be modeled in *dbdiagram* and have to be done by yourself. Still, I like using dbdiagram very much because it supports the whole process from first visuals to discuss with clients, creating the sql script and if you want you can also use dbdocs for documentation.

[SQL script for database creation](https://.....)

## Test phase

For this purpose we will first populate the tables with test data. SQL DDL script here.

I have used ChatGPT to create test data. See prompt here. 

Secondly I created some simple to complex queries which will test the capabilities and constraints of the database. SQL query script here.

# Final comments

At first, I thought it will be a very simple database structure with two or three tables. But more thoughts went into this project and particularly normalizing the database and thinking about later sales analysis the design required more tables. Example is the table *product history*. Without storing the former product information you will never get a chance to refer to it. The products table only contains current data. 

**Points for further improvements:** One can add further tables for storing all orders and promotion information of previous years. Employees table can also hold address information. And for data analysis we might want to include more qualitative information about our customer. Like a flag for b2b or b2c. 

For demonstration and learning purposes the project will conclude at this stage.
