select 
C_CUSTKEY customer_id,
C_NAME customer_name,
C_ADDRESS,
C_NATIONKEY,
C_PHONE,
C_ACCTBAL,
C_MKTSEGMENT,
C_COMMENT
from {{ source('jaffle_shop', 'customer')}}
-- from snowflake_sample_data.tpch_sf1.customer