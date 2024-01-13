create schema datalake.sample WITH (location = 's3a://datalake/sample')
create table datalake.sample.customer as select * from tpch.tiny.customer
create table datalake.sample.lineitem as select * from tpch.tiny.lineitem
create table datalake.sample.nation as select * from tpch.tiny.nation
create table datalake.sample.orders as select * from tpch.tiny.orders
create table datalake.sample.part as select * from tpch.tiny.part
create table datalake.sample.partsupp as select * from tpch.tiny.partsupp
create table datalake.sample.region as select * from tpch.tiny.region
create table datalake.sample.supplier as select * from tpch.tiny.supplier