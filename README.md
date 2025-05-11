# Practice project for transactional databases

This project focuses on how to set up a transactional database.

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

## Guideline for physical design

Make use of Postgres advanced datatypes, implement on delete actions for relations and make use of comments. 
