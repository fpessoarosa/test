select  
	O_ORDERKEY order_id,
	O_CUSTKEY customer_id,
	O_ORDERSTATUS,
	O_TOTALPRICE,
	O_ORDERDATE order_date,
	O_ORDERPRIORITY,
	O_CLERK,
	O_SHIPPRIORITY,
	O_COMMENT
from {{ source('jaffle_shop', 'orders')}}
--from snowflake_sample_data.tpch_sf1.orders