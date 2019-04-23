---
title: "Importing the TPCH Data into Splice Machine"
summary: Importing TPCH data into your database.
keywords: import, ingest, tpch
toc: false
product: all
sidebar: home_sidebar
permalink: bestpractices_ingest_tpch.html
folder: BestPractices/Database
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Importing the TPCH Data into Your Database

This topic shows you how to import the TPCH Data into your Splice Machine database, and then includes the SQL for [the TPCH queries](#theQueries).

You can use the following steps to import TPCH data into your Splice
Machine database:

<div class="opsStepsList" markdown="1">
1.  Create the schema and tables
    {: .topLevel}

    You can copy/paste the following SQL statements to create the schema
    and tables for importing the sample data:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        CREATE SCHEMA TPCH;

        CREATE TABLE TPCH.LINEITEM (
         L_ORDERKEY BIGINT NOT NULL,
         L_PARTKEY INTEGER NOT NULL,
         L_SUPPKEY INTEGER NOT NULL,
         L_LINENUMBER INTEGER NOT NULL,
         L_QUANTITY DECIMAL(15,2),
         L_EXTENDEDPRICE DECIMAL(15,2),
         L_DISCOUNT DECIMAL(15,2),
         L_TAX DECIMAL(15,2),
         L_RETURNFLAG VARCHAR(1),
         L_LINESTATUS VARCHAR(1),
         L_SHIPDATE DATE,
         L_COMMITDATE DATE,
         L_RECEIPTDATE DATE,
         L_SHIPINSTRUCT VARCHAR(25),
         L_SHIPMODE VARCHAR(10),
         L_COMMENT VARCHAR(44),
         PRIMARY KEY(L_ORDERKEY,L_LINENUMBER)
         );

        CREATE TABLE TPCH.ORDERS (
         O_ORDERKEY BIGINT NOT NULL PRIMARY KEY,
         O_CUSTKEY INTEGER,
         O_ORDERSTATUS VARCHAR(1),
         O_TOTALPRICE DECIMAL(15,2),
         O_ORDERDATE DATE,
         O_ORDERPRIORITY VARCHAR(15),
         O_CLERK VARCHAR(15),
         O_SHIPPRIORITY INTEGER ,
         O_COMMENT VARCHAR(79)
         );

        CREATE TABLE TPCH.CUSTOMER (
         C_CUSTKEY INTEGER NOT NULL PRIMARY KEY,
         C_NAME VARCHAR(25),
         C_ADDRESS VARCHAR(40),
         C_NATIONKEY INTEGER NOT NULL,
         C_PHONE VARCHAR(15),
         C_ACCTBAL DECIMAL(15,2),
         C_MKTSEGMENT VARCHAR(10),
         C_COMMENT VARCHAR(117)
         );

        CREATE TABLE TPCH.PARTSUPP (
         PS_PARTKEY INTEGER NOT NULL ,
         PS_SUPPKEY INTEGER NOT NULL ,
         PS_AVAILQTY INTEGER,
         PS_SUPPLYCOST DECIMAL(15,2),
         PS_COMMENT VARCHAR(199),
         PRIMARY KEY(PS_PARTKEY,PS_SUPPKEY)
         );

        CREATE TABLE TPCH.SUPPLIER (
         S_SUPPKEY INTEGER NOT NULL PRIMARY KEY,
         S_NAME VARCHAR(25) ,
         S_ADDRESS VARCHAR(40) ,
         S_NATIONKEY INTEGER ,
         S_PHONE VARCHAR(15) ,
         S_ACCTBAL DECIMAL(15,2),
         S_COMMENT VARCHAR(101)
         );

        CREATE TABLE TPCH.PART (
         P_PARTKEY INTEGER NOT NULL PRIMARY KEY,
         P_NAME VARCHAR(55) ,
         P_MFGR VARCHAR(25) ,
         P_BRAND VARCHAR(10) ,
         P_TYPE VARCHAR(25) ,
         P_SIZE INTEGER ,
         P_CONTAINER VARCHAR(10) ,
         P_RETAILPRICE DECIMAL(15,2),
         P_COMMENT VARCHAR(23)
         );

        CREATE TABLE TPCH.REGION (
         R_REGIONKEY INTEGER NOT NULL PRIMARY KEY,
         R_NAME VARCHAR(25),
         R_COMMENT VARCHAR(152)
         );

        CREATE TABLE TPCH.NATION (
         N_NATIONKEY INTEGER NOT NULL,
         N_NAME VARCHAR(25),
         N_REGIONKEY INTEGER NOT NULL,
         N_COMMENT VARCHAR(152),
         PRIMARY KEY (N_NATIONKEY)
         );
    {: .Example}

    </div>

2.  Import data
    {: .topLevel}

    We've put a copy of the TPCH data in an AWS S3 bucket for
    convenient retrieval. See the [Configuring an S3 Bucket for Splice Machine Access](developers_cloudconnect_configures3.html) topic for information about accessing data on S3.

    You can copy/paste the following
    `SYSCS_UTIL.IMPORT_DATA` statements to quickly pull that data into
    your database:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        call SYSCS_UTIL.IMPORT_DATA ('TPCH', 'LINEITEM', null, 's3a:/splice-benchmark-data/flat/TPCH/1/lineitem', '|', null, null, null, null, 0, '/tmp/BAD', true, null);

        call SYSCS_UTIL.IMPORT_DATA ('TPCH', 'ORDERS',   null, 's3a:/splice-benchmark-data/flat/TPCH/1/orders',   '|', null, null, null, null, 0, '/tmp/BAD', true, null);

        call SYSCS_UTIL.IMPORT_DATA ('TPCH', 'CUSTOMER', null, 's3a:/splice-benchmark-data/flat/TPCH/1/customer', '|', null, null, null, null, 0, '/tmp/BAD', true, null);

        call SYSCS_UTIL.IMPORT_DATA ('TPCH', 'PARTSUPP', null, 's3a:/splice-benchmark-data/flat/TPCH/1/partsupp', '|', null, null, null, null, 0, '/tmp/BAD', true, null);

        call SYSCS_UTIL.IMPORT_DATA ('TPCH', 'SUPPLIER', null, 's3a:/splice-benchmark-data/flat/TPCH/1/supplier', '|', null, null, null, null, 0, '/tmp/BAD', true, null);

        call SYSCS_UTIL.IMPORT_DATA ('TPCH', 'PART',     null, 's3a:/splice-benchmark-data/flat/TPCH/1/part',     '|', null, null, null, null, 0, '/tmp/BAD', true, null);

        call SYSCS_UTIL.IMPORT_DATA ('TPCH', 'REGION',   null, 's3a:/splice-benchmark-data/flat/TPCH/1/region',   '|', null, null, null, null, 0, '/tmp/BAD', true, null);

        call SYSCS_UTIL.IMPORT_DATA ('TPCH', 'NATION',   null, 's3a:/splice-benchmark-data/flat/TPCH/1/nation',   '|', null, null, null, null, 0, '/tmp/BAD', true, null);
    {: .Example}

    </div>

    You need to supply your AWS credentials in each URL or in your `core-site.xml` configuration file to read data from S3, as [described here](tutorials_ingest_importinput.html#AWSPath).

3.  Run a query
    {: .topLevel}

    You can now copy/paste *TPCH Query 01* against the imported data to
    verify that all's well:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        -- QUERY 01
        select
            l_returnflag,
            l_linestatus,
            sum(l_quantity) as sum_qty,
            sum(l_extendedprice) as sum_base_price,
            sum(l_extendedprice * (1 - l_discount)) as sum_disc_price,
            sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) as sum_charge,
            avg(l_quantity) as avg_qty,
            avg(l_extendedprice) as avg_price,
            avg(l_discount) as avg_disc,
            count(*) as count_order
        from
            TPCH.lineitem
        where
            l_shipdate <= date({fn TIMESTAMPADD(SQL_TSI_DAY, -90, cast('1998-12-01 00:00:00' as timestamp))})
        group by
            l_returnflag,
            l_linestatus
        order by
            l_returnflag,
            l_linestatus
        -- END OF QUERY
    {: .Example}

    </div>

    We've also included the SQL for most of the other [TPCH
    queries](#Addition) in this topic, should you want to try others.
    {: .indentLevel1}
{: .boldFont}

</div>

## The TPCH Queries   {#theQueries}

Here are a number of additional queries you might want to run against
the TPCH data:


### TPCH Query 01
```
-- QUERY 01
select
	l_returnflag,
	l_linestatus,
	sum(l_quantity) as sum_qty,
	sum(l_extendedprice) as sum_base_price,
	sum(l_extendedprice * (1 - l_discount)) as sum_disc_price,
	sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) as sum_charge,
	avg(l_quantity) as avg_qty,
	avg(l_extendedprice) as avg_price,
	avg(l_discount) as avg_disc,
	count(*) as count_order
from
	lineitem
where
	l_shipdate <= date({fn TIMESTAMPADD(SQL_TSI_DAY, -90, cast('1998-12-01 00:00:00' as timestamp))})
group by
	l_returnflag,
	l_linestatus
order by
	l_returnflag,
	l_linestatus
-- END OF QUERY
;
```
{: .Example}


<br />
### TPCH Query 02
```
-- QUERY 02
select
	s_acctbal,
	s_name,
	n_name,
	p_partkey,
	p_mfgr,
	s_address,
	s_phone,
	s_comment
from
	part,
	supplier,
	partsupp,
	nation,
	region
where
	p_partkey = ps_partkey
	and s_suppkey = ps_suppkey
	and p_size = 15
	and p_type like '%BRASS'
	and s_nationkey = n_nationkey
	and n_regionkey = r_regionkey
	and r_name = 'EUROPE'
	and ps_supplycost = (
		select
			min(ps_supplycost)
		from
			partsupp,
			supplier,
			nation,
			region
		where
			p_partkey = ps_partkey
			and s_suppkey = ps_suppkey
			and s_nationkey = n_nationkey
			and n_regionkey = r_regionkey
			and r_name = 'EUROPE'
	)
order by
	s_acctbal desc,
	n_name,
	s_name,
	p_partkey
{limit 100}
-- END OF QUERY
;
```
{: .Example}


<br />
### TPCH Query 03
```
-- QUERY 03
select
	l_orderkey,
	sum(l_extendedprice * (1 - l_discount)) as revenue,
	o_orderdate,
	o_shippriority
from
	customer,
	orders,
	lineitem
where
	c_mktsegment = 'BUILDING'
	and c_custkey = o_custkey
	and l_orderkey = o_orderkey
	and o_orderdate < date('1995-03-15')
	and l_shipdate > date('1995-03-15')
group by
	l_orderkey,
	o_orderdate,
	o_shippriority
order by
	revenue desc,
	o_orderdate
{limit 10}
-- END OF QUERY
;
```
{: .Example}

<br />
### TPCH Query 04
```
-- QUERY 04
select
	o_orderpriority,
	count(*) as order_count
from
	orders
where
	o_orderdate >= date('1993-07-01')
	and o_orderdate < add_months('1993-07-01',3)
	and exists (
		select
			*
		from
			lineitem
		where
			l_orderkey = o_orderkey
			and l_commitdate < l_receiptdate
	)
group by
	o_orderpriority
order by
	o_orderpriority
-- END OF QUERY
;
```
{: .Example}

<br />
### TPCH Query 05
```
-- QUERY 05
select
	n_name,
	sum(l_extendedprice * (1 - l_discount)) as revenue
from
	customer,
	orders,
	lineitem,
	supplier,
	nation,
	region
where
	c_custkey = o_custkey
	and l_orderkey = o_orderkey
	and l_suppkey = s_suppkey
	and c_nationkey = s_nationkey
	and s_nationkey = n_nationkey
	and n_regionkey = r_regionkey
	and r_name = 'ASIA'
	and o_orderdate >= date('1994-01-01')
	and o_orderdate < date({fn TIMESTAMPADD(SQL_TSI_YEAR, 1, cast('1994-01-01 00:00:00' as timestamp))})
group by
	n_name
order by
	revenue desc
-- END OF QUERY
;
```
{: .Example}

<br />
### TPCH Query 06
```
-- QUERY 06
select
	sum(l_extendedprice * l_discount) as revenue
from
	lineitem
where
	l_shipdate >= date('1994-01-01')
	and l_shipdate < date({fn TIMESTAMPADD(SQL_TSI_YEAR, 1, cast('1994-01-01 00:00:00' as timestamp))})
	and l_discount between .06 - 0.01 and .06 + 0.01
	and l_quantity < 24
-- END OF QUERY
;
```
{: .Example}


<br />
### TPCH Query 07
```
-- QUERY 07
select
	supp_nation,
	cust_nation,
	l_year,
	sum(volume) as revenue
from
	(
		select
			n1.n_name as supp_nation,
			n2.n_name as cust_nation,
			year(l_shipdate) as l_year,
			l_extendedprice * (1 - l_discount) as volume
		from
			supplier,
			lineitem,
			orders,
			customer,
			nation n1,
			nation n2
		where
			s_suppkey = l_suppkey
			and o_orderkey = l_orderkey
			and c_custkey = o_custkey
			and s_nationkey = n1.n_nationkey
			and c_nationkey = n2.n_nationkey
			and (
				(n1.n_name = 'FRANCE' and n2.n_name = 'GERMANY')
				or (n1.n_name = 'GERMANY' and n2.n_name = 'FRANCE')
			)
			and l_shipdate between date('1995-01-01') and date('1996-12-31')
	) as shipping
group by
	supp_nation,
	cust_nation,
	l_year
order by
	supp_nation,
	cust_nation,
	l_year
-- END OF QUERY
;
```
{: .Example}

<br />
### TPCH Query 08
```
-- QUERY 08
select
	o_year,
	sum(case
		when nation = 'BRAZIL' then volume
		else 0
	end) / sum(volume) as mkt_share
from
	(
		select
			year(o_orderdate) as o_year,
			l_extendedprice * (1 - l_discount) as volume,
			n2.n_name as nation
		from
			part,
			supplier,
			lineitem,
			orders,
			customer,
			nation n1,
			nation n2,
			region
		where
			p_partkey = l_partkey
			and s_suppkey = l_suppkey
			and l_orderkey = o_orderkey
			and o_custkey = c_custkey
			and c_nationkey = n1.n_nationkey
			and n1.n_regionkey = r_regionkey
			and r_name = 'AMERICA'
			and s_nationkey = n2.n_nationkey
			and o_orderdate between date('1995-01-01') and date('1996-12-31')
			and p_type = 'ECONOMY ANODIZED STEEL'
	) as all_nations
group by
	o_year
order by
	o_year
-- END OF QUERY
;
```
{: .Example}

<br />
### TPCH Query 09
```
-- QUERY 09
select
	nation,
	o_year,
	sum(amount) as sum_profit
from
	(
		select
			n_name as nation,
			year(o_orderdate) as o_year,
			l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity as amount
		from
			part,
			supplier,
			lineitem,
			partsupp,
			orders,
			nation
		where
			s_suppkey = l_suppkey
			and ps_suppkey = l_suppkey
			and ps_partkey = l_partkey
			and p_partkey = l_partkey
			and o_orderkey = l_orderkey
			and s_nationkey = n_nationkey
			and p_name like '%green%'
	) as profit
group by
	nation,
	o_year
order by
	nation,
	o_year desc
-- END OF QUERY
;
```
{: .Example}

<br />
### TPCH Query 10
```
-- QUERY 10
select
	c_custkey,
	c_name,
	sum(l_extendedprice * (1 - l_discount)) as revenue,
	c_acctbal,
	n_name,
	c_address,
	c_phone,
	c_comment
from
	customer,
	orders,
	lineitem,
	nation
where
	c_custkey = o_custkey
	and l_orderkey = o_orderkey
	and o_orderdate >= date('1993-10-01')
	and o_orderdate < ADD_MONTHS('1993-10-01',3)
	and l_returnflag = 'R'
	and c_nationkey = n_nationkey
group by
	c_custkey,
	c_name,
	c_acctbal,
	c_phone,
	n_name,
	c_address,
	c_comment
order by
	revenue desc
{limit 20}
-- END OF QUERY
;
```
{: .Example}


<br />
### TPCH Query 11
```
-- QUERY 11
select
	ps_partkey,
	sum(ps_supplycost * ps_availqty) as value
from
	partsupp,
	supplier,
	nation
where
	ps_suppkey = s_suppkey
	and s_nationkey = n_nationkey
	and n_name = 'GERMANY'
group by
	ps_partkey having
		sum(ps_supplycost * ps_availqty) > (
			select
				sum(ps_supplycost * ps_availqty) * 0.0000010000
			from
				partsupp,
				supplier,
				nation
			where
				ps_suppkey = s_suppkey
				and s_nationkey = n_nationkey
				and n_name = 'GERMANY'
		)
order by
	value desc
-- END OF QUERY
;
```
{: .Example}


<br />
### TPCH Query 12
```
-- QUERY 12
select
	l_shipmode,
	sum(case
		when o_orderpriority = '1-URGENT'
			or o_orderpriority = '2-HIGH'
			then 1
		else 0
	end) as high_line_count,
	sum(case
		when o_orderpriority <> '1-URGENT'
			and o_orderpriority <> '2-HIGH'
			then 1
		else 0
	end) as low_line_count
from
	orders,
	lineitem
where
	o_orderkey = l_orderkey
	and l_shipmode in ('MAIL', 'SHIP')
	and l_commitdate < l_receiptdate
	and l_shipdate < l_commitdate
        and l_receiptdate >= date('1994-01-01')
        and l_receiptdate < date({fn TIMESTAMPADD(SQL_TSI_YEAR, 1, cast('1994-01-01 00:00:00' as timestamp))})
group by
	l_shipmode
order by
	l_shipmode
-- END OF QUERY
;
```
{: .Example}


<br />
### TPCH Query 13
```
-- QUERY 13
select
	c_count,
	count(*) as custdist
from
	(
		select
			c_custkey,
			count(o_orderkey)
		from
			customer left outer join orders on
				c_custkey = o_custkey
				and o_comment not like '%special%requests%'
		group by
			c_custkey
	) as c_orders (c_custkey, c_count)
group by
	c_count
order by
	custdist desc,
	c_count desc
-- END OF QUERY
;
```
{: .Example}


<br />
### TPCH Query 14
```
-- QUERY 14
select
	100.00 * sum(case
		when p_type like 'PROMO%'
			then l_extendedprice * (1 - l_discount)
		else 0
	end) / sum(l_extendedprice * (1 - l_discount)) as promo_revenue
from
	lineitem,
	part
where
	l_partkey = p_partkey
	and l_shipdate >= date('1995-09-01')
	and l_shipdate < add_months('1995-09-01',1)
-- END OF QUERY
;
```
{: .Example}



<br />
### TPCH Query 15
```
-- QUERY 15
create view revenue0 (supplier_no, total_revenue) as
	select
		l_suppkey,
		sum(l_extendedprice * (1 - l_discount))
	from
		lineitem
	where
		l_shipdate >= date('1996-01-01')
		and l_shipdate < add_months('1996-01-01',3)
	group by
		l_suppkey;

select
	s_suppkey,
	s_name,
	s_address,
	s_phone,
	total_revenue
from
	supplier,
	revenue0
where
	s_suppkey = supplier_no
	and total_revenue = (
		select
			max(total_revenue)
		from
			revenue0
	)
order by
	s_suppkey;

drop view revenue0
-- END OF QUERY
;
```
{: .Example}


<br />
### TPCH Query 16
```
-- QUERY 16
select
	p_brand,
	p_type,
	p_size,
	count(distinct ps_suppkey) as supplier_cnt
from
	partsupp,
	part
where
	p_partkey = ps_partkey
	and p_brand <> 'Brand#45'
	and p_type not like 'MEDIUM POLISHED%'
	and p_size in (49, 14, 23, 45, 19, 3, 36, 9)
	and ps_suppkey not in (
		select
			s_suppkey
		from
			supplier
		where
			s_comment like '%Customer%Complaints%'
	)
group by
	p_brand,
	p_type,
	p_size
order by
	supplier_cnt desc,
	p_brand,
	p_type,
	p_size
-- END OF QUERY
;
```
{: .Example}



<br />
### TPCH Query 17
```
-- QUERY 17
select
	sum(l_extendedprice) / 7.0 as avg_yearly
from
	lineitem,
	part
where
	p_partkey = l_partkey
	and p_brand = 'Brand#23'
	and p_container = 'MED BOX'
	and l_quantity < (
		select
			0.2 * avg(l_quantity)
		from
			lineitem
		where
			l_partkey = p_partkey
	)
-- END OF QUERY
;
```
{: .Example}



<br />
### TPCH Query 18
```
-- QUERY 18
select
	c_name,
	c_custkey,
	o_orderkey,
	o_orderdate,
	o_totalprice,
	sum(l_quantity)
from
	customer,
	orders,
	lineitem
where
	o_orderkey in (
		select
			l_orderkey
		from
			lineitem
		group by
			l_orderkey having
				sum(l_quantity) > 300
	)
	and c_custkey = o_custkey
	and o_orderkey = l_orderkey
group by
	c_name,
	c_custkey,
	o_orderkey,
	o_orderdate,
	o_totalprice
order by
	o_totalprice desc,
	o_orderdate
{limit 100}
-- END OF QUERY
;
```
{: .Example}



<br />
### TPCH Query 19
```
-- QUERY 19
select
	sum(l_extendedprice* (1 - l_discount)) as revenue
from
	lineitem,
	part
where
	(
		p_partkey = l_partkey
		and p_brand = 'Brand#12'
		and p_container in ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG')
		and l_quantity >= 1 and l_quantity <= 1 + 10
		and p_size between 1 and 5
		and l_shipmode in ('AIR', 'AIR REG')
		and l_shipinstruct = 'DELIVER IN PERSON'
	)
	or
	(
		p_partkey = l_partkey
		and p_brand = 'Brand#23'
		and p_container in ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK')
		and l_quantity >= 10 and l_quantity <= 10 + 10
		and p_size between 1 and 10
		and l_shipmode in ('AIR', 'AIR REG')
		and l_shipinstruct = 'DELIVER IN PERSON'
	)
	or
	(
		p_partkey = l_partkey
		and p_brand = 'Brand#34'
		and p_container in ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
		and l_quantity >= 20 and l_quantity <= 20 + 10
		and p_size between 1 and 15
		and l_shipmode in ('AIR', 'AIR REG')
		and l_shipinstruct = 'DELIVER IN PERSON'
	)
-- END OF QUERY
;
```
{: .Example}



<br />
### TPCH Query 20
```
-- QUERY 20
select
	s_name,
	s_address
from
	supplier,
	nation
where
	s_suppkey in (
		select
			ps_suppkey
		from
			partsupp
		where
			ps_partkey in (
				select
					p_partkey
				from
					part
				where
					p_name like 'forest%'
			)
			and ps_availqty > (
				select
					0.5 * sum(l_quantity)
				from
					lineitem
				where
					l_partkey = ps_partkey
					and l_suppkey = ps_suppkey
					and l_shipdate >= date('1994-01-01')
					and l_shipdate < date({fn TIMESTAMPADD(SQL_TSI_YEAR, 1, cast('1994-01-01 00:00:00' as timestamp))})
			)
	)
	and s_nationkey = n_nationkey
	and n_name = 'CANADA'
order by
	s_name
-- END OF QUERY
;
```
{: .Example}


<br />
### TPCH Query 21
```
-- QUERY 21
select
	s_name,
	count(*) as numwait
from
	supplier,
	lineitem l1,
	orders,
	nation
where
	s_suppkey = l1.l_suppkey
	and o_orderkey = l1.l_orderkey
	and o_orderstatus = 'F'
	and l1.l_receiptdate > l1.l_commitdate
	and exists (
		select
			*
		from
			lineitem l2
		where
			l2.l_orderkey = l1.l_orderkey
			and l2.l_suppkey <> l1.l_suppkey
	)
	and not exists (
		select
			*
		from
			lineitem l3
		where
			l3.l_orderkey = l1.l_orderkey
			and l3.l_suppkey <> l1.l_suppkey
			and l3.l_receiptdate > l3.l_commitdate
	)
	and s_nationkey = n_nationkey
	and n_name = 'SAUDI ARABIA'
group by
	s_name
order by
	numwait desc,
	s_name
{limit 100}
-- END OF QUERY
;
```
{: .Example}


<br />
### TPCH Query 22
```
-- QUERY 22
select
	cntrycode,
	count(*) as numcust,
	sum(c_acctbal) as totacctbal
from
	(
		select
			SUBSTR(c_phone, 1, 2) as cntrycode,
			c_acctbal
		from
			customer
		where
			SUBSTR(c_phone, 1, 2) in
				('13', '31', '23', '29', '30', '18', '17')
			and c_acctbal > (
				select
					avg(c_acctbal)
				from
					customer
				where
					c_acctbal > 0.00
					and SUBSTR(c_phone, 1, 2) in
						('13', '31', '23', '29', '30', '18', '17')
			)
			and not exists (
				select
					*
				from
					orders
				where
					o_custkey = c_custkey
			)
	) as custsale
group by
	cntrycode
order by
	cntrycode
-- END OF QUERY
;
```
{: .Example}


</div>
</section>
