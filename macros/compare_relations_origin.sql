{#- in dbt Develop -#}
{%- set old_etl_relation = ref("stg_jaffle_shop__customer_orders_ref") -%}
{%- set dbt_relation = ref("fct_customer_orders_ref") -%}
{{
    audit_helper.compare_relations(
        a_relation=old_etl_relation, b_relation=dbt_relation, primary_key="order_id"
    )
}}
