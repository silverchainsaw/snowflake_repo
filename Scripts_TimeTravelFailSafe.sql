/**************************Scripts for Time Travel*************************/


ALTER SESSION SET TIMEZONE = 'UTC';

CREATE DATABASE DEMO_DB;

CREATE TABLE CUSTOMER (
  Name STRING ,
  Email STRING ,
  Job STRING ,
  Phone STRING ,
  Age NUMBER
  );

--tracking parameters at different levels
  SHOW PARAMETERS in ACCOUNT;
  SHOW PARAMETERS IN DATABASE DEMO_DB;

  ALTER DATABASE DEMO_DB SET data_retention_time_in_days=4;




--sample data for the table above is present in AWS S3 at
--https://s3.ap-southeast-2.amazonaws.com/snowflake-essentials/sample_data_for_cloning.csv

create or replace stage my_s3_stage url='s3://snowflake-essentials/';


copy into CUSTOMER
  from s3://snowflake-essentials/sample_data_for_cloning.csv
  file_format = (type = csv field_delimiter = '|' skip_header = 1);

SELECT * FROM CUSTOMER;
SELECT COUNT(*) FROM CUSTOMER;

-- select the current time stamp so that we can use it in the time travel query
SELECT CURRENT_TIMESTAMP;

--2020-08-06 09:58:39.900

-- update the Job column setting all rows to the same value
update CUSTOMER set Job = 'Snowflake Developer';

SELECT * FROM CUSTOMER;

-- time travel to a time just before the update was run
select * from CUSTOMER before(timestamp => '2020-08-06 09:58:39.900'::timestamp);

-- time travel to 10 minutes ago (i.e. before we ran the update)
select * from CUSTOMER AT(offset => -60*14);

-- note down the query id of this query as we will use it in the time travel query as well
update CUSTOMER set Job = NULL;
--01961058-0066-7734-0000-0000350d4e95

-- time travel to the time before the update query was run
select * from CUSTOMER before(statement => '01961058-0066-7734-0000-0000350d4e95');

Create or replace table CUSTOMER_COPY as
select * from CUSTOMER AT(offset => -60*14);

select * from CUSTOMER_COPY;


/***********************Undropping Scripts for Demo*************************/

-- undropping a table
DROP TABLE CUSTOMER;
SELECT * FROM CUSTOMER;

UNDROP TABLE CUSTOMER;
SELECT * FROM CUSTOMER;
SELECT COUNT(*) FROM CUSTOMER;

-- undropping a schema
DROP SCHEMA DEMO_DB.PUBLIC;
SELECT * FROM CUSTOMER;

UNDROP SCHEMA DEMO_DB.PUBLIC;
SELECT * FROM CUSTOMER;
SELECT COUNT(*) FROM CUSTOMER;

-- undropping a database
DROP DATABASE DEMO_DB;
SELECT * FROM CUSTOMER;

UNDROP DATABASE DEMO_DB;
SELECT * FROM CUSTOMER;
SELECT COUNT(*) FROM CUSTOMER;



/***********************Failsafe Scripts for Demo*************************/

-- shift to Account_Admin role
-- you can check storage usage through the ACCOUNT_USAGE.STORAGE_USAGE
-- view which will give you information about storage used by data,
-- storage used by internal stages & storage used by failsafe

SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.STORAGE_USAGE ORDER BY USAGE_DATE DESC;

-- let's convert the above information into GBs
SELECT 	USAGE_DATE,
		STORAGE_BYTES / (1024*1024*1024) AS STORAGE_GB,
		STAGE_BYTES / (1024*1024*1024) AS STAGE_GB,
		FAILSAFE_BYTES / (1024*1024*1024) AS FAILSAGE_GB
FROM SNOWFLAKE.ACCOUNT_USAGE.STORAGE_USAGE ORDER BY USAGE_DATE DESC;



-- You can also check on failsafe storage usage by querying the
-- TABLE_STORAGE_METRICS view
SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.TABLE_STORAGE_METRICS;

--let's improve the result & convert to GBs as well
SELECT 	ID,
		TABLE_NAME,
		TABLE_SCHEMA,
		ACTIVE_BYTES / (1024*1024*1024) AS STORAGE_USED_GB,
		TIME_TRAVEL_BYTES / (1024*1024*1024) AS TIME_TRAVEL_STORAGE_USED_GB,
		FAILSAFE_BYTES / (1024*1024*1024) AS FAILSAFE_STORAGE_USED_GB
FROM SNOWFLAKE.ACCOUNT_USAGE.TABLE_STORAGE_METRICS
ORDER BY STORAGE_USED_GB DESC,TIME_TRAVEL_STORAGE_USED_GB DESC, FAILSAFE_STORAGE_USED_GB DESC;


/****************************End*********************************/
