## From BulkImport Tutorial Page
======================================
### Configuration Settings {#ConfigSettings}

Due to how Yarn manages memory, you need to modify your YARN configuration when bulk-importing large datasets. Make these two changes in your Yarn configuration, `ResourceManager Advanced Configuration Snippet (Safety Valve) for yarn-site.xml`:

<div class="preWrapperWide" markdown="1">
    yarn.nodemanager.pmem-check-enabled=false
    yarn.nodemanager.vmem-check-enabled=false
{: .Example}
</div>

#### Extra Configuration Steps for KMS-Enabled Clusters

If you are a Splice Machine On-Premise Database customer and want to use bulk import on a cluster with Cloudera Key Management Service (KMS) enabled, you must complete a few extra configuration steps, which are described in [this troubleshooting note](bestpractices_ingest_troubleshooting.html#BulkImportKMS) for details.
{: .noteIcon}

### Importing Data From the Cloud  {#CloudAccess}

If you are importing data that is stored in an S3 bucket on AWS, you
need to specify the data location in an `s3a` URL that includes access
key information. Our [Configuring an S3 Bucket for Splice Machine Access](developers_cloudconnect_configures3.html) walks you through using your AWS dashboard to generate and apply the necessary credentials.

==============================================

## From Error and Logging Page

This topic describes the logging and error handling features of Splice Machine data imports.

## Logging

Each of these import procedures includes a logging facility:

*  [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
*  [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)
*  [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)
*  [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)

Errors are logged to a file in the directory that you specify in the `badRecordDirectory` parameter when you call one of the procedures.

The `badRecordDirectory` parameter is a string that specifies the directory in which bad record information is logged. The default value is the directory in which the import files are found.

Splice Machine logs information to the `<import_file_name>.bad` file in this directory; for example, bad records in an input file named `foo.csv` would be logged to a file named *badRecordDirectory*`/foo.csv.bad`.

The `badRecordDirectory` directory must be writable by the hbase user,
either by setting the user explicity, or by opening up the permissions;
for example:

<div class="preWrapper" markdown="1">
    sudo -su hdfs hadoop fs -chmod 777 /badRecordDirectory
{: .ShellCommand}
</div>

On a cluster, the `badRecordDirectory` directory **MUST be on S3, HDFS (or
MapR-FS)**. If you're using our Database Service product, this directory must be on S3.
{: .noteNote}

## Stopping the Import Due to Too Many Errors

All of the import procedures also take a `badRecordsAllowed` or `maxBadRecords` parameter, the value of which determines how many erroneous input data record errors are allowed before the import is stopped. If this count of rejected records is reached, the import fails, and any successful record imports are rolled back.

These `badRecordsAllowed` values have special meaning:

* If you specify `-1`, all record import failures are tolerated and logged.
* If you specify `0`, the import will fail as soon as one bad record is detected.

## Managing Logging When Importing Multiple Files

In addition to importing a single file, the &nbsp;[`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html) and
  &nbsp;[`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html) procedures can import all of the files in a directory.

When you are importing a large amount of data and have divided the files
you are importing into groups, then it's a good idea to change the
location of the bad record directory for each group; this will make
debugging bad records a lot easier for you.

You can change the value of the `badRecordDirectory` to include your
group name; for example, we typically use a strategy like the following:

<table style="width: 100%;">
    <col />
    <col />
    <thead>
        <tr>
            <th>Group Files Location</th>
            <th><span class="CodeBoldFont">badRecordDirectory</span> Parameter Value</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>/data/mytable1/group1</code></td>
            <td><code>/BAD/mytable1/group1</code></td>
        </tr>
        <tr>
            <td><code>/data/mytable1/group2</code></td>
            <td><code>/BAD/mytable1/group2</code></td>
        </tr>
        <tr>
            <td><code>/data/mytable1/group3</code></td>
            <td><code>/BAD/mytable1/group3</code></td>
        </tr>
    </tbody>
</table>
You'll then be able to more easily discover where the problem record is
located.

==============================================

## From ImportExamples Page

## Example 1: Importing data into a table with fewer columns than in the file   {#Example1}

If the table into which you're importing data has less columns than the
data file that you're importing, how the "extra" data columns in the
input data are handled depends on whether you specify an
`insertColumnList`:

* If you don't specify a specify an `insertColumnList` and your input file
  contains more columns than are in the table, then the the extra
  columns at the end of each line in the input file are ignored. For
  example, if your table contains columns `(a, b, c)` and your file
  contains columns `(a, b, c, d, e)`, then the data in your file's `d` and `e`
  columns will be ignored.
* If you do specify an `insertColumnList` to `IMPORT_DATA` or `MERGE_DATA`, and the number of columns
  in your input file doesn't match the number in your table, then any other columns in your table will be
  replaced by the default value for the table column (or `NULL` if there
  is no default for the column). For example, if your table contains
  columns (a, b, c) and you only want to import columns (a, c), then the
  data in table's b column will be replaced with the default value (or `NULL`) for
  that column.

Here's an example that does not specify a column list. If you create a
table with this statement:

<div class="preWrapper" markdown="1">
    CREATE TABLE playerTeams(ID int primary key, Team VARCHAR(32));
{: .Example xml:space="preserve"}

</div>
And your data file looks like this:

<div class="preWrapper" markdown="1">
    1,Cards,Molina,Catcher2,Giants,Posey,Catcher3,Royals,Perez,Catcher
{: .Example xml:space="preserve"}

</div>
When you import the file into `playerTeams`, only the first two columns
are imported:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA('SPLICE','playerTeams',null, 'myData.csv',
       null, null, null, null, null, 0, 'importErrsDir', true, null);
    SELECT * FROM playerTeams ORDER by ID;

    ID   |TEAM
    --------------
    1    |Cards2    |Giants
    3    |Royals3 rows selected
{: .Example xml:space="preserve"}

</div>

### How Missing Columns are Handled With an Insert Column List   {#Example2}

In this example, we\'ll illustrate how the different data importation
procedures modify columns in your table when you\'ve specified an
`insertColumnList` that is not 1-to-1 with the columns in your table.

The `SYSCS_UTIL.IMPORT_DATA` and `SYSCS_UTIL.UPSERT_DATA_FROM_FILE`
procedures handle this situation in the same way, assigning default
values (or NULL if no default is defined) to any table column that is
not being inserted or updated from the input data file. The
`SYSCS_UTIL.MERGE_DATA_FROM_FILE` handles this differently: it does not overwrite generated values
when updating records.

This distinction is particularly important when loading record updates
into a table with auto-generated column values that you do not want
overwritten.
{: .noteNote}

We\'ll create two sample tables, populate each with the same data, and
load the same input file data into each to illustrate the differences
between how the `Upsert` and `Merge` procedures.

<div class="preWrap" markdown="1">
    CREATE SCHEMA test;
    SET SCHEMA test;
    CREATE TABLE testUpsert (
             a1 INT,
             b1 INT,
             c1 INT GENERATED BY DEFAULT AS IDENTITY(start with 1, increment by 1),
             d1 INT DEFAULT 999,
             PRIMARY KEY (a1)
     );

    CREATE TABLE testMerge (
             a1 INT,
             b1 INT,
             c1 INT GENERATED BY DEFAULT AS IDENTITY(start with 1, increment by 1),
             d1 INT DEFAULT 999,
             PRIMARY KEY (a1)
     );

    INSERT INTO testUpsert(a1,b1) VALUES (1,1), (2,2), (3,3), (6,6);
    splice> select * from testUpsert;
    A1         |B1         |C1         |D1
    -----------------------------------------------
    1          |1          |1          |999
    2          |2          |2          |999
    3          |3          |3          |999
    6          |6          |4          |999

    4 rows selected

    INSERT INTO testMerge (a1,b1) VALUES (1,1), (2,2), (3,3), (6,6);
    splice> select * from testMerge;
    A1         |B1         |C1         |D1
    -----------------------------------------------
    1          |1          |1          |999
    2          |2          |2          |999
    3          |3          |3          |999
    6          |6          |4          |999

    4 rows selected
{: .Example}

</div>
Note that column `c1` contains auto-generated values, and that column `
d1` has the default value 999.
{: .spaceAbove}

Here\'s the data that we\'re going to import from file `ttest.csv`\:

<div class="preWrap" markdown="1">
    0|0
    1|2
    2|4
    3|6
    4|8
{: .Example}

</div>
Now, let\'s call `UPSERT_DATA_FROM_FILE` and `MERGE_DATA_FROM_FILE` and see how the results differ:
{: .spaceAbove}

<div class="preWrap" markdown="1">

    CALL SYSCS_UTIL.UPSERT_DATA_FROM_FILE('TEST','testUpsert','a1,b1','/Users/garyh/Documents/ttest.csv','|',null,null,null,null,0,'/var/tmp/bad/',false,null);
    rowsImported        |failedRows          |files      |dataSize            |failedLog
    -------------------------------------------------------------------------------------
    5                   |0                   |1          |20                  |NONE

    splice> SELECT * FROM testUpsert;
    A1         |B1         |C1         |D1
    -----------------------------------------------
    0          |0          |10001      |999
    1          |2          |10002      |999
    2          |4          |10003      |999
    3          |6          |10004      |999
    4          |8          |10005      |999
    6          |6          |4          |999

    6 rows selected

    CALL SYSCS_UTIL.MERGE_DATA_FROM_FILE('TEST','testMerge','a1,b1','/Users/garyh/Documents/ttest.csv','|',null,null,null,null,0,'/var/tmp/bad/',false,null);
    rowsUpdated         |rowsInserted        |failedRows          |files      |dataSize            |failedLog
    ---------------------------------------------------------------------------------------------------------
    3                   |2                   |0                   |1          |20                  |NONE

    splice> select * from testMerge;
    A1         |B1         |C1         |D1
    -----------------------------------------------
    0          |0          |10001      |999
    1          |2          |1          |999
    2          |4          |2          |999
    3          |6          |3          |999
    4          |8          |10002      |999
    6          |6          |4          |999

    6 rows selected
{: .Example}

</div>
You\'ll notice that:
{: .spaceAbove}

* The generated column (`c1`) is not included in the `insertColumnList`
  parameter in these calls.
* The results are identical except for the values in the generated
  column.
* The generated values in `c1` are not updated in existing records when
  merging data, but are updated when upserting data.

### Example 3: Importing a subset of data from a file into a table   {#Example3}

This example uses the same table and import file as does the previous
example, and it produces the same results. The difference between these
two examples is that this one explicitly imports only the first two
columns (which are named `ID` and `TEAM`) of the file and uses the `IMPORT_DATA` procedure:

<div class="preWrapper" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA('SPLICE','playerTeams', 'ID, TEAM', 'myData.csv',
     null, null, null, null, null, 0, 'importErrsDir', true, null);SELECT * FROM playerTeams ORDER by ID;ID   |TEAM
    --------------
    1    |Cards
    2    |Giants
    3    |Royal
    s3 rows selected
{: .Example xml:space="preserve"}

</div>
### Example 4: Specifying a timestamp format for an entire table   {#Example4}

This examples demonstrates how you can use a single timestamp format for the entire table by explicitly
specifying a single `timeStampFormat`. Here's the data:

<div class="preWrapper" markdown="1">
    Mike,2013-04-21 09:21:24.98-05
    Mike,2013-04-21 09:15:32.78-04
    Mike,2013-03-23 09:45:00.68-05
{: .Example xml:space="preserve"}

</div>
You can then import the data with the following call:

<div class="preWrapper" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA('app','tabx','c1,c2',
        '/path/to/ts3.csv',
        ',', '''',
        'yyyy-MM-dd HH:mm:ss.SSZ',
        null, null, 0, null, true, null);
{: .Example xml:space="preserve"}

</div>
Note that the time shown in the imported table depends on the timezone setting in the server timestamp.
In other words, given the same csv file, if imported on different
servers with timestamps set to different time zones, the value in the
table shown will be different. Additionally, daylight savings time may
account for a 1-hour difference if timezone is specified.
{: .noteIcon}

### Example 5: Importing strings with embedded special characters    {#Example5}

This example imports a csv file that includes newline (`Ctrl-M`)
characters in some of the input strings. We use the default double-quote character
as our character delimiter to import data such as the following:

<div class="preWrapperWide" markdown="1">
    1,This field is one line,Able
    2,"This field has two lines
    This is the second line of the field",Baker
    3,This field is also just one line,Charlie
{: .Example xml:space="preserve"}

</div>
We then use the following call to import the data:

<div class="preWrapperWide" markdown="1">
    SYSCS_UTIL.IMPORT_DATA('SPLICE', 'MYTABLE', null, 'data.csv' , '\t', null, null, null, null, 0, 'importErrsDir', false, null);
{: .Example xml:space="preserve"}

</div>
We can also explicitly specify double quotes (or any other character) as
our delimiter character for strings:

<div class="preWrapperWide" markdown="1">
    SYSCS_UTIL.IMPORT_DATA('SPLICE', 'MYTABLE', null, 'data.csv', '\t', '"', null, null, null, 0, 'importErrsDir', false, null);
{: .Example xml:space="preserve"}

</div>
### Example 6: Using single quotes to delimit strings   {#Example6}

This example performs the same import as the previous example, simply
substituting single quotes for double quotes as the character delimiter
in the input:

<div class="preWrapperWide" markdown="1">
    1,This field is one line,Able
    2,'This field has two lines
    This is the second line of the field',Baker
    3,This field is also just one line,Charlie
{: .Example xml:space="preserve"}

</div>
Note that you must escape single quotes in SQL, which means that you
actually define the character delimiter parameter with four single
quotes, as shown here:

<div class="preWrapperWide" markdown="1">
    SYSCS_UTIL.IMPORT_DATA('SPLICE', 'MYTABLE', null, 'data.csv', '\t', '''', null, null, null, 0, 'importErrsDir', false, null);
{: .Example xml:space="preserve"}

</div>

================================================================

## From ImportTPCH Page

## Import TPCH Data   {#Import}

You can use the following steps to import TPCH data into your new Splice
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
## Importing Your Own Data   {#Importin}

You can follow similar steps to import your own data. Setting up your
import requires some precision; we encourage you to look through our
[Importing Your Data Tutorial](tutorials_ingest_importoverview.html) for
guidance and tips to make that process go smoothly.

## The TPCH Queries   {#Addition}

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

=======================================================================

## From ImportInput Page

# Importing Data: Input Considerations

This topic provides detailed information about how the parameter values you specify when importing data are handled by Splice Machine's built-in import procedures.

For a summary of our import procedures and determining which to use, please see [Importing Data: Overview](tutorials_ingest_importoverview.html).

For reference descriptions of the parameters used by those import procedures, please see [Importing Data: Parameter Usage](tutorials_ingest_importparams.html).

This topic includes the following sections:

<table>
  <col width="35%"/>
  <col />
  <thead>
    <tr>
        <th>Section</th>
        <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
        <td><a href="#Location">Specifying Your Input Data Location</a></td>
        <td>Describes how to specify the location of your input data when importing.</td>
    </tr>
    <tr>
        <td><a href="#InputFiles">Input Data File Format</a></td>
        <td>Information about input data files, including importing compressed files and multi-line records.</td>
    </tr>
    <tr>
        <td><a href="#Delimiters">Delimiters in Your Input Data</a></td>
        <td>Discusses the use of column and characters delimiters in your input data.</td>
    </tr>
    <tr>
        <td><a href="#DateFormats">Time and Date Formats in Input Records</a></td>
        <td>All about the date, time, and timestamp values in your input data.</td>
    </tr>
    <tr>
        <td><a href="#Updating">Importing and Updating Records</a></td>
        <td>Discusses importing new records and updating existing database records, handling missing values in the input data, and handling of generated and default values.</td>
    </tr>
    <tr>
        <td><a href="#LOBs">Importing CLOBs and BLOBs</a></td>
        <td>Discussion of importing CLOBs and BLOBs into your Splice Machine database.</td>
    </tr>
    <tr>
        <td><a href="#Scripting">Scripting Your Imports</a></td>
        <td>Shows you how to script your import processes.</td>
    </tr>
  </tbody>
</table>

## Specifying Your Input Data Location    {#Location}

Some customers get confused by the the `fileOrDirectoryName` parameter that's used in our import procedures.
How you use this depends on whether you are importing a single file or a
directory of files, and whether you're importing data into a standalone version or cluster version of Splice Machine. This section contains these three subsections:

* [Standalone Version Input File Path](#StandalonePath)
* [HBase Input File Path](#HBasePath)
* [AWS Input File Path](#AWSPath)

### Standalone Version Input File Path  {#StandalonePath}

If you are running a stand alone environment, the name or path will be
to a file or directory on the file system. For example:

<div class="preWrapperWide" markdown="1">
    /users/myname/mydata/mytable.csv/users/myname/mydatadir
{: .Example}

</div>

### HBase Input File Path  {#HBasePath}

If you are running this on a cluster, the path is to a file on
HDFS (or the MapR File system). For example:

<div class="preWrapperWide" markdown="1">
    /data/mydata/mytable.csv/data/myname/mydatadir
{: .Example}

</div>

### AWS S3 Input File Path {#AWSPath}

Finally, if you're importing data from an S3 bucket, you need to supply
your AWS access and secret key codes, and you need to specify an s3a
URL. This is also true for logging bad record information to an S3 bucket
directory, as will be the case when using our Database-as-Service
product.

For information about configuring Splice Machine access on AWS, please review our [Configuring an S3 Bucket for Splice Machine Access](developers_cloudconnect_configures3.html) topic, which walks you through using your AWS dashboard to generate and apply the necessary credentials.

Once you've established your access keys, you can include them inline; for example:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA ('TPCH', 'REGION', null, 's3a://(access key):(secret key)@splice-benchmark-data/flat/TPCH/100/region', '|', null, null, null, null, -1, 's3a://(access key):(secret key)@splice-benchmark-data/flat/TPCH/100/importLog', true, null);
{: .Example}

</div>
Alternatively, you can specify the keys once in the `core-site.xml` file
on your cluster, and then simply specify the `s3a` URL; for example:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA ('TPCH', 'REGION', null, 's3a://splice-benchmark-data/flat/TPCH/100/region', '|', null, null, null, null, 0, '/BAD', true, null);
{: .Example}

</div>
To add your access and secret access keys to the `core-site.xml` file,
define the `fs.s3a.awsAccessKeyId` and `fs.s3a.awsSecretAccessKey`
properties in that file:

<div class="preWrapperWide" markdown="1">
    <property>
       <name>fs.s3a.awsAccessKeyId</name>
       <value>access key</value>
    </property>
    <property>
       <name>fs.s3a.awsSecretAccessKey</name>
       <value>secret key</value>
    </property>
{: .Example}

</div>

## Input Data File Format {#InputFiles}

This section contains the following information about the format of the input data files that you're importing:

* [Importing Compressed Files](#CompressedFiles)
* [Importing Multi-line Records](#Multiline)
* [Importing Large Datasets in Groups of Files](#FileGroups)

### Importing Compressed Files {#CompressedFiles}

We recommend importing files that are either uncompressed, or have been
compressed with <span class="CodeBoldFont">bz2</span> or <span
class="CodeBoldFont">lz4</span> compression.

If you import files compressed with `gzip`, Splice Machine cannot
distribute the contents of your file across your cluster nodes to take
advantage of parallel processing, which means that import performance
will suffer significantly with `gzip` files.

### Importing Multi-line Records {#Multiline}

If your data contains line feed characters like `CTRL-M`, you need to
set the `oneLineRecords` parameter to `false`. Splice Machine will
accommodate to the line feeds; however, the import will take longer
because Splice Machine will not be able to break the file up and
distribute it across the cluster.

To improve import performance, avoid including line feed characters in
your data and set the `oneLineRecords` parameter to `true`.
{: .notePlain}

### Importing Large Datasets in Groups of Files {#FileGroups}

If you have a lot of data (100s of millions or billions of records), you
may be tempted to create one massive file that contains all of your
records and import that file; Splice Machine recommends against this;
instead, we urge you to manage your data in smaller files. Specifically,
we suggest that you split your data into files that are:

* approximately 40 GB
* have approximately 50 million records, depending on how wide your
  table is

If you have a lot of files, group them into multiple directories, and
import each directory individually. For example, here is a structure our
Customer Success engineers like to use:

* /data/mytable1/group1
* /data/mytable1/group2
* /data/mytable1/group3
{: .codeList}

If you are importing a lot of data, our [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html) bulk import procedure greatly improves data loading performance by splitting the data into HFiles, doing the import, and then deleting the HFiles. You can have `SYSCS_UTIL.BULK_IMPORT_HFILE` use sampling to determine the keys to use for splitting your data by, or you can use the [`SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX`](sqlref_sysprocs_splittable.html) procedure to compute the splits, and then call the bulk import procedure. For more information, see the [Importing Data: Using Bulk HFile Import](tutorials_ingest_importbulkhfile.html) topic of this tutorial.

## Delimiters in Your Input Data {#Delimiters}

This section discusses the delimiters that you use in your input data, in these subsections:

* [Using Special Characters for Delimiters](#DelimSpecials)
* [Column Delimiters](#DelimColumn)
* [Character Delimiters](#DelimChar)

### Use Special Characters for Delimiters {#DelimSpecials}

One common gotcha we see with customer imports is when the data you're
importing includes a special character that you've designated as a
column or character delimiter. You'll end up with records in your bad
record directory and can spend hours trying to determine the issue, only
to discover that it's because the data includes a delimiter character.
This can happen with columns that contain data such as product
descriptions.

### Column Delimiters {#DelimColumn}

The standard column delimiter is a comma (`,`); however, we've all
worked with string data that contains commas, and have figured out to
use a different column delimiter. Some customers use the pipe (`|`)
character, but frequently discover that it is also used in some
descriptive data in the table they're importing.

In addition to using plain text characters, you can specify the following
special characters as delimiters:

<table summary="Special characters that can be used as column delimiters in imported files.">
    <col />
    <col />
    <thead>
        <tr>
            <th>Special character</th>
            <th>Display</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>\t</code></td>
            <td>Tab </td>
        </tr>
        <tr>
            <td><code>\f</code></td>
            <td>Formfeed</td>
        </tr>
        <tr>
            <td><code>\b</code></td>
            <td>Backspace</td>
        </tr>
        <tr>
            <td><code>\\</code></td>
            <td>Backslash</td>
        </tr>
        <tr>
            <td><code>^a (or ^A)</code></td>
            <td>
                <p>Control-a</p>
                <p class="noteIndent">If you are using a script file from the <code>splice&gt;</code> command line, your script can contain the actual <code>Control-a</code> character as the value of this parameter.</p>
            </td>
        </tr>
    </tbody>
</table>

We recommend using a control character like `CTRL-A` for your column
delimiter. This is known as the SOH character, and is represented by
0x01 in hexadecimal. Unfortunately, there's no way to enter this
character from the keyboard in the Splice Machine command line
interface; instead, you need to [create a script file](#Scripting) and type the control character using a text editor like *vi* or *vim*:

* Open your script file in vi or vim.
* Enter into INSERT mode.
* Type `CTRL-V` then `CTRL-A` for the value of the column delimiter
  parameter in your procedure call. Note that this typically echoes as
  `^A` when you type it in vi or vim.

### Character Delimiters {#DelimChar}

By default, the character delimiter is a double quote. This can produce
the same kind of problems that we see with using a comma for the column
delimiter: columns values that include embedded quotes or use the double
quote as the symbol for inches. You can use escape characters to include
the embedded quotes, but it's easier to use a special character for your
delimiter.

We recommend using a control character like `CTRL-A` for your column
delimiter. Unfortunately, there's no way to enter this
character from the keyboard in the Splice Machine command line
interface; instead, you need to [create a script file](#Scripting) and type the control character using a text editor like *vi* or *vim*:

* Open your script file in vi or vim.
* Enter into INSERT mode.
* Type `CTRL-V` then `CTRL-G` for the value of the character delimiter
  parameter in your procedure call. Note that this typically echoes as
  `^G` when you type it in vi or vim.

## Time and Date Formats in Input Records {#DateFormats}

Perhaps the most common difficulty that customers have with importing
their data is with date, time, and timestamp values.

Splice Machine adheres to the Java `SimpleDateFormat` syntax for all
date, time, and timestamp values, `SimpleDateFormat` is described here:

<a href="https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html" target="_blank">https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html</a>
{: .indentLevel1}

Splice Machine's implementation of `SimpleDateFormat` is case-sensitive;
this means, for example, that a lowercase `h` is used to represent an
hour value between 0 and 12, whereas an uppercase `H` is used to
represent an hour between 0 and 23.

### All Values Must Use the Same Format

Splice Machine's Import procedures only allow you to specify one format
each for the date, time, and timestamp columns in the table data you are
importing. This means that, for example, every date in the table data
must be in the same format.

<div class="notePlain" markdown="1">
All of the `Date` values in the file (or group of files) you are
importing must use the same date format.

All of the `Time` values in the file (or group of files) you are
importing must use the same time format.

All of the `Timestamp` values in the file (or group of files) you are
importing must use the same timestamp format.

</div>

### Converting Out-of-Range Timestamp Values Upon Import  {#TSConvert}

{% include splice_snippets/importtimestampfix.md %}

### Additional Notes

A few additional notes:

* Splice Machine suggests that, if your data contains any date or
  timestamp values that are not in the format `yyyy-MM-dd HH:mm:ss`, you
  create a simple table that has just one or two columns and test
  importing the format. This is a simple way to confirm that the
  imported data is what you expect.
* Detailed information about each of these data types is found in our SQL Reference Manual:
    * [Timestamp Data Type](#sqlref_datatypes_timestamp.html)
    * [Date Data Type](#sqlref_datatypes_date.html)
    * [Time Data Type](#sqlref_datatypes_time.html)

## Importing and Updating Records {#Updating}

This section describes certain aspects of how records are imported and updated when you import data into your database, including these subsections:

* [Inserting and Updating Column Values When Importing Data](#ImportColVals)
* [Inserting and Updated Generated or Default Values](#GeneratedUpdate)
* [Handling Missing Values](#MissingValues)

### Inserting and Updating Column Values When Importing Data   {#ImportColVals}

This section summarizes what happens when you are importing, upserting,
or merging records into a database table, based on:

* Whether you are importing a new record or updating an existing record.
* If the column is specified in your `insertColumnList` parameter.
* If the table column is a generated value or has a default value.

The important difference in actions taken when importing data occurs
when you are updating an existing record with the UPSERT or MERGE and
your column list does not contain the name of a table column:

* For newly inserted records, the default or auto-generated value is
  always inserted, as usual.
* If you are updating an existing record in the table with `UPSERT`, the
  default auto-generated value in that record is overwritten with a new
  value.
* If you are updating an existing record in the table with `MERGE`, the
  column value is not updated.

#### Importing a New Record Into a Database Table

The following table shows the actions taken when you are importing new
records into a table in your database. These actions are the same for
all three importation procedures (IMPORTing, UPSERTing, or MERGEing):

<table>
            <col />
            <col />
            <col />
            <thead>
                <tr>
                    <th>Column included in <span class="CodeFont">importColumnList</span>?</th>
                    <th>Table column conditions</th>
                    <th>Action Taken</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>YES</td>
                    <td>N/A</td>
                    <td>Import value inserted into table column if valid; if not valid, a bad record error is logged.</td>
                </tr>
                <tr>
                    <td rowspan="3">NO</td>
                    <td>Has Default Value</td>
                    <td>Default value is inserted into table column.</td>
                </tr>
                <tr>
                    <td>Is Generated Value</td>
                    <td>Generated value is inserted into table column.</td>
                </tr>
                <tr>
                    <td>None</td>
                    <td>NULL is inserted into table column.</td>
                </tr>
            </tbody>
        </table>

The table below shows what happens with default and generated column
values when adding new records to a table using one of our import
procedures; we use an example database table created with this
statement:

    CREATE TABLE myTable (
                    colA INT,
                    colB CHAR(12) DEFAULT 'myDefaultVal',
                    colC INT);
{: .Example}

<table summary="Detailed example of what gets imported for different input values in a new record">
            <col />
            <col />
            <col />
            <col />
            <thead>
                <tr>
                    <th><span class="CodeBoldFont">insertColumnList</span>
                    </th>
                    <th>Values in import record</th>
                    <th>Values inserted into database</th>
                    <th>Notes</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>"colA,colB,colC"</code></td>
                    <td><code>1,,2</code></td>
                    <td><code>[1,NULL,2]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colB,colC"</code></td>
                    <td><code>3,de,4</code></td>
                    <td><code>[3,de,4]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colB,colC"</code></td>
                    <td><code>1,2,</code></td>
                    <td><code>Error: column B wrong type</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colB,colC"</code></td>
                    <td><code>1,DEFAULT,2</code></td>
                    <td><code>[1,"DEFAULT",2]</code></td>
                    <td><code>DEFAULT</code> is imported as a literal value</td>
                </tr>
                <tr>
                    <td><code>Empty</code></td>
                    <td><code>1,,2</code></td>
                    <td><code>[1,myDefaultVal,2]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>Empty</code></td>
                    <td><code>3,de,4</code></td>
                    <td><code>[3,de,4]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>Empty</code></td>
                    <td><code>1,2,</code></td>
                    <td><code>Error: column B wrong type</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colC"</code></td>
                    <td><code>1,2</code></td>
                    <td><code>[1,myDefaultVal,2]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colC"</code></td>
                    <td><code>3,4</code></td>
                    <td><code>[3,myDefaultVal,4]</code></td>
                    <td> </td>
                </tr>
            </tbody>
        </table>

Note that the value \`DEFAULT\` in the imported file **is not
interpreted** to mean that the default value should be applied to that
column; instead:

* If the target column in your database has a string data type, such as
  `CHAR` or `VARCHAR`, the literal value `"DEFAULT"` is inserted into
  your database..
* If the target column is not a string data type, an error will occur.

### Importing Into a Table that Contains Generated or Default Values

When you export a table with generated columns to a file, the actual
column values are exported, so importing that same file into a different
database will accurately replicate the original table values.

If you are importing previously exported records into a table with a
generated column, and you want to import some records with actual values
and apply generated or default values to other records, you need to
split your import file into two files and import each:

* Import the file containing records with non-default values with the
  column name included in the `insertColumnList`.
* Import the file containing records with default values with the column
  name excluded from the `insertColumnList`.

#### Updating a Table Record with UPSERT

The following table shows the action taken when you are using the
`SYSCS_UTIL.UPSERT_DATA_FROM_FILE` procedure to update an existing
record in a database table:

<table>
            <col />
            <col />
            <col />
            <thead>
                <tr>
                    <th>Column included in <em>importColumnList</em>?</th>
                    <th>Table column conditions</th>
                    <th>Action Taken</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>YES</td>
                    <td>N/A</td>
                    <td>Import value updated in table column if valid; if not valid, a bad record error is logged.</td>
                </tr>
                <tr>
                    <td rowspan="3">NO</td>
                    <td>Has Default Value</td>
                    <td>Table column is overwritten with default value.</td>
                </tr>
                <tr>
                    <td>Is Generated Value</td>
                    <td>Table column is overwritten with newly generated value.</td>
                </tr>
                <tr>
                    <td>None</td>
                    <td>Table column is overwritten with NULL value.</td>
                </tr>
            </tbody>
        </table>

#### Updating a Table Record with MERGE

The following table shows the action taken when you are using the
`SYSCS_UTIL.MERGE_DATA_FROM_FILE` procedure to update an existing record
in a database table:

<table>
            <col />
            <col />
            <col />
            <thead>
                <tr>
                    <th>Column included in <em>importColumnList</em>?</th>
                    <th>Table column conditions</th>
                    <th>Action Taken</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>YES</td>
                    <td>N/A</td>
                    <td>Import value updated in table column if valid; if not valid, a bad record error is logged.</td>
                </tr>
                <tr>
                    <td rowspan="3">NO</td>
                    <td>N/A</td>
                    <td>Table column is not updated.</td>
                </tr>
            </tbody>
        </table>

## Importing CLOBs and BLOBs {#LOBs}

When importing `CLOB`s, be sure to review these tips to avoid common problems:

* Be sure that the data you’re importing *does not* includes a special character that you’ve designated as a column or character delimiter. Otherwise, you’ll end up with records in your bad record directory and can spend hours trying to determine the issue, only to discover that it’s because the data includes a delimiter character.
* If your data contains line feed characters like `CTRL-M`, you need to set the `oneLineRecords` parameter to `false` to allow Splice Machine to properly handle the data; however, the import will take longer because Splice Machine will not be able to break the file up and distribute it across the cluster. To improve import performance, avoid including line feed characters in your data and set the `oneLineRecords` parameter to `true`.

At this time, the Splice Machine import procedures do not work
with columns of type `BLOB`. You can, however, create a virtual table interface
(VTI) that reads the `BLOB`s and inserts them into your database.

## Scripting Your Imports   {#Scripting}

You can make import tasks much easier and convenient by creating *import
scripts*. An import script is simply a call to one of the import
procedures; once you've verified that it works, you can use and clone
the script and run unattended imports.

An import script is simply a file in which you store `splice>` commands
that you can execute with the `run` command. For example, here's an
example of a text file named `myimports.sql` that we can use to import
two csv files into our database:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA ('SPLICE','mytable1',null,'/data/mytable1/data.csv',null,null,null,null,null,0,'/BAD/mytable1',null,null);call SYSCS_UTIL.IMPORT_DATA ('SPLICE','mytable2',null,'/data/mytable2/data.csv',null,null,null,null,null,0,'/BAD/mytable2',null,null);
{: .Example}

</div>
To run an import script, use the `splice> run` command; for example:

<div class="preWrapper" markdown="1">
    splice> run 'myimports.sql';
{: .Example}

</div>
You can also start up the `splice>` command line interpreter with the
name of a file to run; for example:

<div class="preWrapper" markdown="1">
    sqlshell.sh -f myimports.sql
{: .Example}

</div>
In fact, you can script almost any sequence of Splice Machine commands
in a file and run that script within the command line interpreter or
when you start the interpreter.



======================================================

## From the ImportParameters topic

This topic first shows you the syntax of each of the four import procedures, and then provides detailed information about the input parameters you need to specify when calling one of the Splice Machine data ingestion procedures.

## Import Procedures Syntax {#Syntax}

Three of our four data import procedures use identical parameters:

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.IMPORT_DATA (
    SYSCS_UTIL.UPSERT_DATA_FROM_FILE (
    SYSCS_UTIL.MERGE_DATA_FROM_FILE (
        schemaName,
        tableName,
        insertColumnList | null,
        fileOrDirectoryName,
        columnDelimiter | null,
        characterDelimiter | null,
        timestampFormat | null,
        dateFormat | null,
        timeFormat | null,
        badRecordsAllowed,
        badRecordDirectory | null,
        oneLineRecords | null,
        charset | null
      );
{: .FcnSyntax xml:space="preserve"}

</div>

The fourth procedure, `SYSCS_UTIL.BULK_IMPORT_HFILE`, adds a couple extra parameters at the end:

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.BULK_IMPORT_HFILE
      ( schemaName,
        tableName,
        insertColumnList | null,
        fileName,
        columnDelimiter | null,
        characterDelimiter | null,
        timestampFormat | null,
        dateFormat | null,
        timeFormat | null,
        maxBadRecords,
        badRecordDirectory | null,
        oneLineRecords | null,
        charset | null,
        bulkImportDirectory,
        skipSampling
      );
{: .FcnSyntax xml:space="preserve"}

</div>

## Overview of Parameters Used in Import Procedures

All of the Splice Machine data import procedures share a number of parameters that describe the table into which you're importing data, a number of input data format details, and how to handle problematic records.

The following table summarizes these parameters. Each parameter name links to its reference description, found below the table:

<table>
    <col />
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Category</th>
            <th>Parameter</th>
            <th>Description</th>
            <th>Example Value</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowspan="2" class="BoldFont">Table Info</td>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#schemaName">schemaName</a></td>
            <td>The name of the schema of the table into which to import.</td>
            <td class="CodeFont">SPLICE</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#tableName">tableName</a></td>
            <td>The name of the table into which to import.</td>
            <td class="CodeFont">playerTeams</td>
        </tr>
        <tr>
            <td rowspan="2" class="BoldFont">Data Location</td>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#insertColumnList">insertColumnList</a></td>
            <td>The names, in single quotes, of the columns to import. If this is <code>null</code>, all columns are imported.</td>
            <td class="CodeFont">'ID, TEAM'</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#fileOrDirectoryName">fileOrDirectoryName</a></td>
            <td><p>Either a single file or a directory. If this is a single file, that file is imported; if this is a directory, all of the files in that directory are imported. You can import compressed or uncompressed files.</p>
            <p class="notePlain">The <code>SYSCS_UTIL.MERGE_DATA_FROM_FILE</code> procedure only works with single files; <strong>you cannot specify a directory name</strong> when calling <code>SYSCS_UTIL.MERGE_DATA_FROM_FILE</code>.</p>
            <p>On a cluster, the files to be imported <code>MUST be on S3, HDFS (or
            MapR-FS)</code>. If you're using our Database Service product, files can only be imported from S3.</p>
            <p>See the <a href="developers_cloudconnect_configures3.html">Configuring an S3 Bucket for Splice Machine Access</a> topic for information about accessing data on S3.</p>
            </td>
            <td class="CodeFont">
                <p>/data/mydata/mytable.csv</p>
                <p>'s3a://splice-benchmark-data/flat/TPCH/100/region'</p>
            </td>
        </tr>
        <tr>
            <td rowspan="7" class="BoldFont">Data Formats</td>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#oneLineRecords">oneLineRecords</a></td>
            <td>A Boolean value that specifies whether (<code>true</code>) each record in the import file is contained in one input line, or (<code>false</code>) if a record can span multiple lines.
            </td>
            <td class="CodeFont">true</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#charset">charset</a></td>
            <td>The character encoding of the import file. The default value is UTF-8.
            </td>
            <td class="CodeFont">null</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#columnDelimiter">columnDelimiter</a></td>
            <td>The character used to separate columns, Specify <code>null</code> if using the comma (<code>,</code>) character as your delimiter. </td>
            <td class="CodeFont">'|', '\t'</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#characterDelimiter">characterDelimiter</a></td>
            <td>The character used to delimit strings in the imported data.
            </td>
            <td class="CodeFont">'"', ''''</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#timestampFormat">timestampFormat</a></td>
            <td><p>The format of timestamps stored in the file. You can set this to <code>null</code> if there are no time columns in the file, or if the format of any timestamps in the file match the <code>Java.sql.Timestamp</code> default format, which is: "<em>yyyy-MM-dd HH:mm:ss</em>".</p>
            <p class="noteIcon">All of the timestamps in the file you are importing must use the same format.</p>
            </td>
            <td class="CodeFont">
                <p>'yyyy-MM-dd HH:mm:ss.SSZ'</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#dateFormat">dateFormat</a></td>
            <td>The format of datestamps stored in the file. You can set this to <code>null</code> if there are no date columns in the file, or if the format of any dates in the file match pattern: "<em>yyyy-MM-dd</em>".</td>
            <td class="CodeFont">yyyy-MM-dd</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#timeFormat">timeFormat</a></td>
            <td>The format of time values stored in the file. You can set this to null if there are no time columns in the file, or if the format of any times in the file match pattern: "<em>HH:mm:ss</em>".
            </td>
            <td class="CodeFont">HH:mm:ss</td>
        </tr>
        <tr>
            <td rowspan="2" class="BoldFont">Problem Logging</td>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#badRecordsAllowed">badRecordsAllowed</a></td>
            <td>The number of rejected (bad) records that are tolerated before the import fails. If this count of rejected records is reached, the import fails, and any successful record imports are rolled back. Specify 0 to indicate that no bad records are tolerated, and specify -1 to indicate that all bad records should be logged and allowed.
            </td>
            <td class="CodeFont">25</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#badRecordDirectory">badRecordDirectory</a></td>
            <td><p>The directory in which bad record information is logged. Splice Machine logs information to the <code>&lt;import_file_name&gt;.bad</code> file in this directory; for example, bad records in an input file named <code>foo.csv</code> would be logged to a file named <code><em>badRecordDirectory</em>/foo.csv.bad</code>.</p>
            <p>On a cluster, this directory <span class="BoldFont">MUST be on S3, HDFS (or MapR-FS)</span>. If you're using our Database Service product, files can only be imported from S3.</p>
            </td>
            <td class="CodeFont">'importErrsDir'</td>
        </tr>
        <tr>
            <td rowspan="2" class="BoldFont">Bulk HFile Import</td>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#bulkImportDirectory">bulkImportDirectory</a></td>
            <td>For <code>SYSCS_UTIL.BULK_IMPORT_HFILE</code>, this is the name of the  directory into which the generated HFiles are written prior to being imported into your database.</td>
            <td class="CodeFont"><code>hdfs:///tmp/test_hfile_import/</code></td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_ingest_importparams.html#skipSampling">skipSampling</a></td>
            <td><p>The <code>skipSampling</code> parameter is a Boolean value that specifies how you want the split keys used for the bulk HFile import to be computed. Set to <code>false</code> to have <code>SYSCS_UTIL.BULK_IMPORT_HFILE</code> automatically determine splits for you.</p>
            <p>This parameter is only used with the <code>SYSCS_UTIL.BULK_IMPORT_HFILE</code> system procedure.</p>
            </td>
            <td class="CodeFont">false</td>
        </tr>
    </tbody>
</table>

## Import Parameters Reference

This section provides reference documentation for all of the data importation parameters.

### `schemaName` {#schemaName}

The `schemaName` is a string that specifies the name of the schema of the table into which you are importing data.

**Example:** <span class="Example">`SPLICE`</span>

### `tableName` {#tableName}

The `tableName` is a string that specifies the name of the table into which you are importing data.

**Example:** <span class="Example">`playerTeams`</span>

### `insertColumnList` {#insertColumnList}

The `insertColumnList` parameter is a string that specifies the names, in single quotes, of the columns you wish to import. If this is `null`, all columns are imported.

* If you don\'t specify an `insertColumnList` and your input file contains
more columns than are in the table, then the the extra columns at the
end of each line in the input file **are ignored**. For example, if your
table contains columns `(a, b, c)` and your file contains columns `(a,
b, c, d, e)`, then the data in your file\'s `d` and `e` columns will be
ignored.
{: indentLevel1}

* If you do specify an `insertColumnList`, and the number of columns
doesn\'t match your table, then any other columns in your table will be
replaced by the default value for the table column (or `NULL` if there
is no default for the column). For example, if your table contains
columns `(a, b, c)` and you only want to import columns `(a, c)`, then
the data in table\'s `b` column will be replaced with the default value
for that column.
{: indentLevel1}

**Example:** <span class="Example">`ID, TEAM`</span>

See [*Importing and Updating Records*](tutorials_ingest_importinput.html#Updating) for additional information about handling of missing, generated, and default values during data importation.
{: .notePlain}

### `fileOrDirectoryName` {#fileOrDirectoryName}

The `fileOrDirectoryName` (or `fileName`) parameter is a string that specifies the location of the data that you're importing. This parameter is slightly different for different procedures:

* For the `SYSCS_UTIL.UPSERT_DATA_FROM_FILE` or
`SYSCS_UTIL.UPSERT_DATA_FROM_FILE` procedures, this is either a single
file or a directory. If this is a single file, that file is imported; if
this is a directory, all of the files in that directory are imported.

* For the `SYSCS_UTIL.MERGE_DATA_FROM_FILE` and `SYSCS_UTIL.BULK_IMPORT_HFILE` procedure, this can only be a single file (directories are not allowed).

<div class="noteNote" markdown="1">
On a cluster, the files to be imported **MUST be on S3, HDFS (or
MapR-FS)**, as must the `badRecordDirectory` directory. If you're using
our Database Service product, files can only be imported from S3. The files must also be readable by the `hbase` user.
</div>

**Example:** <span class="Example">`data/mydata/mytable.csv`</span>

#### Importing from S3

If you are importing data that is stored in an S3 bucket on AWS, you
need to specify the data location in an `s3a` URL that includes access
key information.

**Example:** <span class="Example">`s3a://splice-benchmark-data/flat/TPCH/100/region`</span>

See [*Specifying Your Input Data Location*](tutorials_ingest_importinput.html#Location) for additional information about specifying your input data location.
{: .notePlain}

#### Importing Compressed Files

Note that files can be compressed or uncompressed, including BZIP2
compressed files.

<div class="notePlain" markdown="1">
Importing multiple files at once improves parallelism, and thus speeds
up the import process. Uncompressed files can be imported faster than
compressed files. When using compressed files, the compression algorithm
makes a difference; for example,

* `gzip`-compressed files cannot be split during importation, which
  means that import work on such files cannot be performed in parallel.
* In contrast, `bzip2`-compressed files can be split and thus can be
  imported using parallel tasks. Note that `bzip2` is CPU intensive
  compared to `LZ4` or `LZ0`, but is faster than gzip because files can
  be split.
</div>

### `oneLineRecords` {#oneLineRecords}

The `oneLineRecords` parameter is a Boolean value that specifies whether each line in the import file contains one complete record:

* If you specify `true` or `null`, then each record is expected to be
  found on a single line in the file.
* If you specify `false`, records can span multiple lines in the file.

Multi-line record files are slower to load, because the file cannot be
split and processed in parallel; if you import a directory of multiple
line files, each file as a whole is processed in parallel, but no
splitting takes place.

**Example:** <span class="Example">`true`</span>

### `charset` {#charset}

The `charset` parameter is a string that specifies the character encoding of the import file. The default value is `UTF-8`.

Currently, any value other than `UTF-8` is ignored, and `UTF-8` is used.
{: .noteNote}

**Example:** <span class="Example">`null`</span>

### `columnDelimiter` {#columnDelimiter}

The `columnDelimiter` parameter is a string that specifies the character used to separate columns, You can specify `null` if using the comma (`,`) character as your delimiter.

In addition to using plain text characters, you can specify the following
special characters as delimiters:

<table summary="Special characters that can be used as character delimiters in imported files.">
    <col />
    <col />
    <thead>
        <tr>
            <th>Special character</th>
            <th>Display</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>'\t'</code></td>
            <td>Tab </td>
        </tr>
        <tr>
            <td><code>'\f'</code></td>
            <td>Formfeed</td>
        </tr>
        <tr>
            <td><code>'\b'</code></td>
            <td>Backspace</td>
        </tr>
        <tr>
            <td><code>'\\'</code></td>
            <td>Backslash</td>
        </tr>
        <tr>
            <td><code>'^a'</code><br />(or <code>'^A'</code>)</td>
            <td>
                <p>Control-a</p>
                <p class="noteIndent">If you are using a script file from the <code>splice&gt;</code> command line, your script can contain the actual <code>Control-a</code> character as the value of this parameter.</p>
            </td>
        </tr>
        <tr>
            <td><code>''''</code></td>
            <td>Single Quote (<code>'</code>)</td>
        </tr>
    </tbody>
</table>
<div class="indented" markdown="1">
#### Notes:
* To use the single quote (`'`) character as your column delimiter, you
need to escape that character. This means that you specify four quotes
(`''''`) as the value of this parameter. This is standard SQL syntax.
</div>

**Example:** <span class="Example">`'|'`</span>

### `characterDelimiter` {#characterDelimiter}

The `characterDelimiter` parameter is a string that specifies which character is used to delimit strings in the imported data. You can specify `null` or the empty string to use the default string delimiter, which is the double-quote (`"`).

In addition to using plain text characters, you can specify the following
special characters as delimiters:

<table summary="Special characters that can be used as character delimiters in imported files.">
    <col />
    <col />
    <thead>
        <tr>
            <th>Special character</th>
            <th>Display</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>'\t'</code></td>
            <td>Tab </td>
        </tr>
        <tr>
            <td><code>'\f'</code></td>
            <td>Formfeed</td>
        </tr>
        <tr>
            <td><code>'\b'</code></td>
            <td>Backspace</td>
        </tr>
        <tr>
            <td><code>'\\'</code></td>
            <td>Backslash</td>
        </tr>
        <tr>
            <td><code>'^a'</code><br />(or <code>'^A'</code>)</td>
            <td>
                <p>Control-a</p>
                <p class="noteIndent">If you are using a script file from the <code>splice&gt;</code> command line, your script can contain the actual <code>Control-a</code> character as the value of this parameter.</p>
            </td>
        </tr>
        <tr>
            <td><code>''''</code></td>
            <td>Single Quote (<code>'</code>)</td>
        </tr>
    </tbody>
</table>

<div class="indented" markdown="1">
#### Notes:
* If your input contains control characters such as newline characters,
make sure that those characters are embedded within delimited strings.

* To use the single quote (`'`) character as your string delimiter, you
need to escape that character. This means that you specify four quotes
(`''''`) as the value of this parameter. This is standard SQL syntax.
</div>

**Example:** <span class="Example">`'"'`</span>

### `timestampFormat` {#timestampFormat}

The `timestampFormat` parameter specifies the format of timestamps in your input data. You can set this to `null` if either:

* there are no time columns in the file
* all time stamps in the input match the `Java.sql.Timestamp` default format,
which is: \"*yyyy-MM-dd HH:mm:ss*\".

All of the timestamps in the file you are importing must use the same
format.
{: .noteIcon}

Splice Machine uses the following Java date and time pattern letters to
construct timestamps:

<table summary="Timestamp format pattern letter descriptions">
    <col />
    <col />
    <col style="width: 330px;" />
    <thead>
        <tr>
            <th>Pattern Letter</th>
            <th>Description</th>
            <th>Format(s)</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>y</code></td>
            <td>year</td>
            <td><code>yy or yyyy</code></td>
        </tr>
        <tr>
            <td><code>M</code></td>
            <td>month</td>
            <td><code>MM</code></td>
        </tr>
        <tr>
            <td><code>d</code></td>
            <td>day in month</td>
            <td><code>dd</code></td>
        </tr>
        <tr>
            <td><code>h</code></td>
            <td>hour (0-12)</td>
            <td><code>hh</code></td>
        </tr>
        <tr>
            <td><code>H</code></td>
            <td>hour (0-23)</td>
            <td><code>HH</code></td>
        </tr>
        <tr>
            <td><code>m</code></td>
            <td>minute in hour</td>
            <td><code>mm</code></td>
        </tr>
        <tr>
            <td><code>s</code></td>
            <td>seconds</td>
            <td><code>ss</code></td>
        </tr>
        <tr>
            <td><code>S</code></td>
            <td>tenths of seconds</td>
            <td class="CodeFont">
                <p>S, SS, SSS, SSSS, SSSSS or SSSSSS<span class="important">*</span></p>
                <p><span class="important">*</span><span class="bodyFont">Specify </span>SSSSSS <span class="bodyFont">to allow a variable number (any number) of digits after the decimal point.</span></p>
            </td>
        </tr>
        <tr>
            <td><code>z</code></td>
            <td>time zone text</td>
            <td><code>e.g. Pacific Standard time</code></td>
        </tr>
        <tr>
            <td><code>Z</code></td>
            <td>time zone, time offset</td>
            <td><code>e.g. -0800</code></td>
        </tr>
    </tbody>
</table>
The default timestamp format for Splice Machine imports is: `yyyy-MM-dd
HH:mm:ss`, which uses a 24-hour clock, does not allow for decimal digits
of seconds, and does not allow for time zone specification.

The standard Java library does not support microsecond precision, so you
**cannot** specify millisecond (`S`) values in a custom timestamp format
and import such values with the desired precision.
{: .noteNote}

#### Converting Out-of-Range Timestamp Values Upon Import

{% include splice_snippets/importtimestampfix.md %}

#### Timestamps and Importing Data at Different Locations {#TSConvert}

Note that timestamp values are relative to the geographic location at
which they are imported, or more specifically, relative to the timezone
setting and daylight saving time status where the data is imported.

This means that timestamp values from the same data file may appear
differently after being imported in different timezones.

#### Examples

The following tables shows valid examples of timestamps and their
corresponding format (parsing) patterns:

<table>
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Timestamp value</th>
            <th>Format Pattern</th>
            <th>Notes</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>2013-03-23 09:45:00</code></td>
            <td><code>yyyy-MM-dd HH:mm:ss</code></td>
            <td>This is the default pattern.</td>
        </tr>
        <tr>
            <td><code>2013-03-23 19:45:00.98-05</code></td>
            <td><code>yyyy-MM-dd HH:mm:ss.SSZ</code></td>
            <td>This pattern allows up to 2 decimal digits of seconds, and requires a time zone specification.</td>
        </tr>
        <tr>
            <td><code>2013-03-23 09:45:00-07</code></td>
            <td><code>yyyy-MM-dd HH:mm:ssZ</code></td>
            <td>This patterns requires a time zone specification, but does not allow for decimal digits of seconds.</td>
        </tr>
        <tr>
            <td><code>2013-03-23 19:45:00.98-0530</code></td>
            <td><code>yyyy-MM-dd HH:mm:ss.SSZ</code></td>
            <td>This pattern allows up to 2 decimal digits of seconds, and requires a time zone specification.</td>
        </tr>
        <tr>
            <td class="CodeFont">
                <p>2013-03-23 19:45:00.123</p>
                <p>2013-03-23 19:45:00.12</p>
            </td>
            <td><code>yyyy-MM-dd HH:mm:ss.SSS</code></td>
            <td>
                <p>This pattern allows up to 3 decimal digits of seconds, but does not allow a time zone specification.</p>
                <p>Note that if your data specifies more than 3 decimal digits of seconds, an error occurs.</p>
            </td>
        </tr>
        <tr>
            <td><code>2013-03-23 19:45:00.1298</code></td>
            <td><code>yyyy-MM-dd HH:mm:ss.SSSS</code></td>
            <td>This pattern allows up to 4 decimal digits of seconds, but does not allow a time zone specification.</td>
        </tr>
    </tbody>
</table>

See [*Time and Date Formats in Input Records*](tutorials_ingest_importinput.html#DateFormats) for additional information about date, time, and timestamp values.
{: .notePlain}

### `dateFormat` {#dateFormat}

The `dateFormat` parameter specifies the format of datestamps stored in the file. You can set this to `null` if either:

* there are no date columns in the file
* the format of any dates in the input match this pattern: \"*yyyy-MM-dd*\".

**Example:** <span class="Example">`yyyy-MM-dd`</span>

See [*Time and Date Formats in Input Records*](tutorials_ingest_importinput.html#DateFormats) for additional information about date, time, and timestamp values.
{: .notePlain}

### `timeFormat` {#timeFormat}

The `timeFormat` parameter specifies the format of time values in your input data. You can set this to null if either:

* there are no time columns in the file
* the format of any times in the input match this pattern: \"*HH:mm:ss*\".

**Example:** <span class="Example">`HH:mm:ss`</span>

See [*Time and Date Formats in Input Records*](tutorials_ingest_importinput.html#DateFormats) for additional information about date, time, and timestamp values.
{: .notePlain}

### `badRecordsAllowed` {#badRecordsAllowed}

The `badRecordsAllowed` parameter is integer value that specifies the number of rejected (bad) records that are tolerated before the import fails. If this count of rejected records is reached, the import fails, and any successful record imports are rolled back.

These values have special meaning:

* If you specify `-1` as the value of this parameter, all record import
  failures are tolerated and logged.
* If you specify `0` as the value of this parameter, the import will
  fail if even one record is bad.

**Example:** <span class="Example">`25`</span>

### `badRecordDirectory` {#badRecordDirectory}

The `badRecordDirectory` parameter is a string that specifies the directory in which bad record information is logged. The default value is the directory in which the import files are found.

Splice Machine logs information to the `<import_file_name>.bad` file in this directory; for example, bad records in an input file named `foo.csv` would be
logged to a file named *badRecordDirectory*`/foo.csv.bad`.

The `badRecordDirectory` directory must be writable by the hbase user,
either by setting the user explicity, or by opening up the permissions;
for example:

<div class="preWrapper" markdown="1">
    sudo -su hdfs hadoop fs -chmod 777 /badRecordDirectory
{: .ShellCommand}
</div>

**Example:** <span class="Example">`'importErrsDir'`</span>

### `bulkImportDirectory` {#bulkImportDirectory}

This parameter is only used with the `SYSCS_UTIL.BULK_IMPORT_HFILE` system procedure.
{: .noteNote}

The `bulkImportDirectory` parameter is a string that specifies the name of the  directory into which the generated HFiles are written prior to being
imported into your database. The generated files are automatically removed after they've been imported.

**Example:** <span class="Example">`'hdfs:///tmp/test_hfile_import/'`</span>

If you're using this procedure with our On-Premise database product, on a cluster with Cloudera Key Management Service (KMS) enabled, there are a few extra configuration steps required. Please see [this troubleshooting note](bestpractices_ingestion_troubleshooting.html#BulkImportKMS) for details.
{: .noteIcon}

Please review the [Importing Data: Using Bulk HFile Import](tutorials_ingest_importbulkhfile.html) topic to understand how importing bulk HFiles works.

### `skipSampling` {#skipSampling}

This parameter is only used with the `SYSCS_UTIL.BULK_IMPORT_HFILE` system procedure.
{: .noteNote}

The `skipSampling` parameter is a Boolean value that specifies how you want the split keys used for the bulk HFile import to be computed:

* If `skipSampling` is `true`, you need to use our &nbsp;&nbsp;[SYSCS_UTIL.SYSCS_SPLIT_TABLE_OR_INDEX](sqlref_sysprocs_splittable.html) system procedure to compute splits for your table before calling `SYSCS_UTIL.BULK_IMPORT_HFILE`. This allows you more control over the splits, but adds a layer of complexity. You can learn about computing splits for your input data in the [Importing Data: Using Bulk HFile Import](tutorials_ingest_importbulkhfile.html) topic of this tutorial.

* If `skipSampling` is `false`, then `SYSCS_UTIL.BULK_IMPORT_HFILE`
samples your input data and computes the table splits for you, in the following steps. It:

    1. Scans (sample) the data
    2. Collects a rowkey histogram
    3. Uses that histogram to calculate the split key for the table
    4. Uses the calculated split key to split the table into HFiles

**Example:** <span class="Example">`false`</span>

Please review the [Bulk HFile Import Walkthrough](tutorials_ingest_importexampleshfile.html) topic to understand how importing bulk HFiles works.
