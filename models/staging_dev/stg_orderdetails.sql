{{ config(materialized = 'incremental', unique_key = (['OrderID', 'Lineno']), schema = env_var('DBT_STGSCHEMA_NAME', 'STAGING_DEV')) }}
 
select
 
od.orderid,
od.lineno,
od.productid,
od.quantity,
od.unitprice,
od.discount,
o.orderdate
 
from
{{ source("qwt_raw", "raw_orderdetails")}}  as od
inner join
{{source("qwt_raw", "raw_orders")}} as o
on od.orderid = o.orderid
 
{% if is_incremental() %}
 
where o.orderdate > (select max(orderdate) from {{this}} )
 
{% endif %}
 