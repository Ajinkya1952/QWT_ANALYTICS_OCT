{% macro alter_warehouse(warehouse) -%}
 
{% set vsetwarehouse %}

ALTER WAREHOUSE {{warehouse}} SET warehouse_size=MEDIUM;

{% endset %}

{% do run_query(vsetwarehouse) %}

{% endmacro %}