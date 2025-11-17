{{ config(materialized = 'table', schema = env_var('DBT_TRANSSCHEMA_NAME','TRANSFORMING_DEV')) }}

select 
p.productid,
p.productname,
c.categoryname,
s.companyname as suppliercompany,
s.ContactName as suppliercontact,
s.city as suppliercity,
s.country as suppliercountry,
p.quantityperunit,
p.UnitCost,
p.unitprice,
p.unitsinstock,
p.unitsonorder,
iff (p.unitsinstock>p.unitsonorder, 'ProductAvailable', 'ProductNotAvailable') as ProductAvailability
from 

{{ref('stg_products')}} as p
inner join {{ref('stg_suppliers')}} as s
on p.SupplierID = s.SupplierID
inner join
{{ref('lkp_categories')}} as c
 on p.categoryid = c.categoryid