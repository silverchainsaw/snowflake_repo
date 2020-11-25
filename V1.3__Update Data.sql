--Use this schema
USE SCHEMA OUR_TEST_DB.OUR_TEST_SCHEMA;



insert into OUR_TEST_DB.OUR_TEST_SCHEMA.CUSTOMER_NEW values('Jayesh','33c@hotmail.com','DEP','86000965',34);
insert into OUR_TEST_DB.OUR_TEST_SCHEMA.CUSTOMER_NEW values('Roxy','werabc@hotmail.com','Clerk','8900065',33);



Update OUR_TEST_DB.OUR_TEST_SCHEMA.CUSTOMER
set Name='Robert Downey'
where Name='Javed';
