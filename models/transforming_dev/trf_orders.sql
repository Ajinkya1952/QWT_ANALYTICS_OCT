{{ config(materialized = 'table', schema = 'transforming_dev') }}

select 
o.orderid,
od.lineno,
o.customerid,
o.employeeid,
o.shipperid,
od.productid,
o.freight,
od.unitprice,
od.quantity,
od.discount,
o.orderdate,
round((od.UnitPrice * od.Quantity) * (1-od.Discount),2) as linesalesamount,
round(p.UnitCost * od.Quantity,2) as costofgoodsold,

round(((od.UnitPrice * od.Quantity) * (1-od.Discount)) - (p.UnitCost * od.Quantity),2) as margin

from 

{{ref('stg_orders')}} as o
inner join
{{ref("stg_orderdetails")}} as od
on o.orderid = od.orderid

inner join

{{ref("stg_products")}} as p

on p.productid = od.productid