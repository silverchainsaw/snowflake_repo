--Use this schema
USE SCHEMA OUR_TEST_DB.OUR_TEST_SCHEMA;

--Create Table
CREATE TABLE OUR_TEST_DB.OUR_TEST_SCHEMA.CUSTOMER_NEW (
  Name STRING ,
  Email STRING ,
  Job STRING ,
  Phone STRING ,
  Age NUMBER
  );

insert into OUR_TEST_DB.OUR_TEST_SCHEMA.CUSTOMER_NEW values('Robert','ab233c@hotmail.com','DE2','86000965',32);
insert into OUR_TEST_DB.OUR_TEST_SCHEMA.CUSTOMER_NEW values('Ravish','qwerabc@hotmail.com','Admin','8900065',33);

insert into OUR_TEST_DB.OUR_TEST_SCHEMA.CUSTOMER values('Robert','ab233c@hotmail.com','DE2','86000965',32);
insert into OUR_TEST_DB.OUR_TEST_SCHEMA.CUSTOMER values('Ravish','qwerabc@hotmail.com','Admin','8900065',33);

Update OUR_TEST_DB.OUR_TEST_SCHEMA.CUSTOMER
set Name='James Bond'
where Name='Javed';
