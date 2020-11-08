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

--Create stage for data upload
create or replace stage my_s3_stage url='s3://snowflake-essentials/';


--Copy data to Table from Stage 
copy into CUSTOMER_NEW
  from s3://snowflake-essentials/sample_data_for_cloning.csv
  file_format = (type = csv field_delimiter = '|' skip_header = 1);
