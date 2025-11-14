{{ config(materialized = 'view', schema = 'reporting_dev')}}
 
{% set v_linenumbers = get_line_numbers() %}
 
select
orderid,
 
{% for lineno in v_linenumbers %}
sum(case when lineno = {{lineno}} then linesalesamount end) as lineno{{lineno}}_sales,
{% endfor %}
 
 
sum(linesalesamount) as total_sales
 
from {{ref('fct_orders')}}
 
group by 1