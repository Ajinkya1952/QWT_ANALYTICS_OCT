{{config(materialized= 'table', transient = false, schema = env_var('DBT_STGSCHEMA_NAME', 'STAGING_DEV'),
pre_hook = "use warehouse compute_wh;", 
sql_header = "use role accountadmin;",
post_hook = "create or replace table QWT_DEV.STAGING_DEV.STG_SHIPMENTS_TEST CLONE QWT_DEV.STAGING_DEV.STG_SHIPMENTS")}}
select 
OrderID,
LineNo,
ShipperID,
CustomerID,
ProductID,
EmployeeID,
to_date(SPLIT_PART(SHIPMENTDATE,' ',1)) as SHIPMENTDATE,
Status
from 
{{source("qwt_raw","raw_shipments")}}