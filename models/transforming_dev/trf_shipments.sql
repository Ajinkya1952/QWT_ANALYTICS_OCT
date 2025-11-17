{{ config(materialized = 'table', schema = env_var('DBT_TRANSSCHEMA_NAME','TRANSFORMING_DEV')) }}
 
select
ss.orderid,
ss.lineno,
ss.ShipmentDate,
ss.Status,
sh.companyname as shipmentcompany
 
from
 
{{ ref('shipments_snapshot') }} as ss inner join
 
{{ ref('lkp_shippers') }} as sh on
 
ss.ShipperID = sh.ShipperID

where ss.dbt_valid_to is null