--Create Database
CREATE DATABASE IF NOT EXISTS OUR_TEST_DB;

--Create schema for our POC
CREATE SCHEMA OUR_TEST_DB.OUR_TEST_SCHEMA;

--Use this schema
USE SCHEMA OUR_TEST_DB.OUR_TEST_SCHEMA;

--Create Table
CREATE TABLE OUR_TEST_DB.OUR_TEST_SCHEMA.CUSTOMER (
  Name STRING ,
  Email STRING ,
  Job STRING ,
  Phone STRING ,
  Age NUMBER
  );

insert into OUR_TEST_DB.OUR_TEST_SCHEMA.CUSTOMER values('Javed','abc@hotmail.com','DE','8965',32);
insert into OUR_TEST_DB.OUR_TEST_SCHEMA.CUSTOMER values('Ramesh','abc@gmail.com','Admin','998965',35);
insert into OUR_TEST_DB.OUR_TEST_SCHEMA.CUSTOMER values('John','abc45@hotmail.com','SSE','897865',27);
insert into OUR_TEST_DB.OUR_TEST_SCHEMA.CUSTOMER values('Robert','ab233c@hotmail.com','DE2','86000965',32);
insert into OUR_TEST_DB.OUR_TEST_SCHEMA.CUSTOMER values('Ravish','qwerabc@hotmail.com','Admin','8900065',33);