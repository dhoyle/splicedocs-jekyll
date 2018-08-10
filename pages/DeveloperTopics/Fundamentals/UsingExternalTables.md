---
title: Using External Tables
summary: How to use external tables with Splice Machine
keywords: external tables, orc format, parquet, textfile, external file, compression
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_fundamentals_externaltables.html
folder: DeveloperTopics/Fundamentals
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using the Splice Machine External Table Feature

This topic covers the use of external tables in Splice Machine. An
external table references a file stored in a flat file format. You can
use flat files that are stored in one of these formats:

* `ORC` is a columnar storage format
* `PARQUET` is a columnar storage format
* `Avro` is a data serialization system
* `TEXTFILE` is a plain text file

You can access `ORC` and `PARQUET` files that have been compressed with
either Snappy or ZLIb compression; however, you cannot use a compressed
plain text file.

## About External Tables

You can use Splice Machine external tables to query the contents of flat
files that are stored outside of your database. You query external
tables pretty much the same way as you do the tables in your database.

External tables reference files that are stored in a flat file format
such as Apache Parquet or Apache Orc, both of which are columnar storage
formats that are available in Hadoop. You can use the &nbsp;[`CREATE EXTERNAL
TABLE`](sqlref_statements_createexternaltable.html) statement to create
an external table that is connected to a specific flat file.

## Using External Tables

This section presents information about importing data into an external
table, and includes several examples of using external tables with
Splice Machine.

### Importing Data Into an External Table

You cannot import data directly into an external table; if you already
have an external table in a compatible format, you can use &nbsp;[`CREATE
EXTERNAL TABLE`](sqlref_statements_createexternaltable.html) statement
to point at the external file and query against it.

If you want to create an external file from within Splice Machine,
follow these steps:

1.  Create (or use) a table in your Splice Machine database (your
    internal table).
2.  Use &nbsp;[`CREATE EXTERNAL
    TABLE`](sqlref_statements_createexternaltable.html) to create your
    empty external table, specifying the location where you want that
    data stored externally.
3.  Use &nbsp;[`INSERT INTO`](sqlref_statements_insert.html) (your external
    table) `SELECT` (from your internal table) to populate the external
    file with your data.
4.  You can now query the external table.

### Accessing a Parquet File

The following statement creates an external table for querying a
`PARQUET` file (or set of `PARQUET` files in a directory) stored on your computer:

<div class="preWrapperWide" markdown="1">
    splice> CREATE EXTERNAL TABLE myExtTbl (
      col1 INT, col2 VARCHAR(24))
        PARTITIONED BY (col1)
        STORED AS PARQUET
        LOCATION '/users/myname/myParquetFile';

    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
The call to `CREATE EXTERNAL TABLE` associates a Splice Machine external
table with the data files in the directory named `myparquetfile`, and tells Splice Machine
that:

* The table should be partitioned based on the values in `col1`.
* The file is stored in PARQUET format.
* The file is located in `/users/myname/myParquetFile`.

After you create the external table, you can query `myExtTbl` just as
you would any other table in your database.

#### External Table Schema Evolution for PARQUET Data Files
If your external data is stored in `PARQUET` format, you can specify the `MERGE SCHEMA` option when creating your external table. This is useful when your data has schema evolution: ordinarily (without the option), Splice Machine infers the schema for your data by examining the column data types of one of the data files in the directory of files specified in the `LOCATION` parameter. This works fine except when the schema of the external data changes; for schema evolution cases, you can specify `MERGE SCHEMA` to tell Splice Machine to infer the schema from all of the data files.

To use schema merging with the previous example, simply add the `MERGE SCHEMA` clause:

<div class="preWrapperWide" markdown="1">
    splice> CREATE EXTERNAL TABLE myExtTbl (
      col1 INT, col2 VARCHAR(24))
        PARTITIONED BY (col1)
        STORED AS PARQUET
        LOCATION '/users/myname/myParquetFile'
        MERGE SCHEMA;

    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}
</div>

Merging schemas from a large set of external files is expensive in terms of performance, so you should only use this option when necessary.

This option is only available for data in `PARQUET` format, due to Spark restrictions.
{: .noteIcon}

### Accessing and Updating an ORC File

The following statement creates an external table for the `ORC` file stored in an AWS S3 bucket and inserts data into it:

<div class="preWrapperWide" markdown="1">

    splice> CREATE EXTERNAL TABLE myExtTbl2
      (col1 INT, col2 VARCHAR(24))
       PARTITIONED BY (col1)
       STORED AS ORC
       LOCATION 's3a://myOrcData/myName/myOrcFile';
    0 rows inserted/updated/deleted
    splice> INSERT INTO myExtTbl2 VALUES (1, 'One'), (2, 'Two'), (3, 'Three');
    3 rows inserted/updated/deletedsplice
    > SELECT * FROM myExtTbl2;
    COL1        |COL2
    ------------------------------------
    3           |Three
    2           |Two
    1           |One
{: .Example xml:space="preserve"}

</div>
The call to `CREATE EXTERNAL TABLE` associates a Splice Machine external
table with the file named `myOrcFile`, and tells Splice Machine that:

* The table should be partitioned based on the values in `col1`.
* The file is stored in ORC format.
* The file is located in `/users/myname/myOrcFile`.

The call to `INSERT INTO ` demonstrates that you can insert values into
the external table just as you would with an ordinary table.

### Accessing a Plain Text File

You can specify a table constraint on an external table; for example:
{: .body}

<div class="preWrapperWide" markdown="1">

    splice> CREATE EXTERNAL TABLE myTextTable(
         col1 INT, col2 VARCHAR(24))
       PARTITIONED BY (col1)
       ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' ESCAPED BY '\\'
       LINES TERMINATED BY '\\n'
       STORED AS TEXTFILE
       LOCATION 'hdfs:///tmp/myTables/myTextFile';
     0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
The call to `CREATE EXTERNAL TABLE` associates a Splice Machine external
table with the file named `myOrcFile`, and tells Splice Machine that:

* The table should be partitioned based on the values in `col1`.
* Each field in each row is terminated by a comma.
* Each line in the file is terminated by a line-end character.
* The file is stored in plain text format.
* The file is located in `/users/myName/myTextFile`.

### Accessing a Compressed File

This example is exactly the same as our first example, except that the
source file has been compressed with Snappy compression:

<div class="preWrapperWide" markdown="1">
    splice> CREATE EXTERNAL TABLE myExtTbl (
          col1 INT, col2 VARCHAR(24))
        COMPRESSED WITH SNAPPY
        PARTITIONED BY (col1)
        STORED AS PARQUET
        LOCATION '/users/myname/myParquetFile';
     0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## Manually Refreshing an External Tables

If the schema of the file represented by an external table is updated,
Splice Machine needs to refresh its representation. When you use the
external table, Spark caches its schema in memory to improve
performance; as long as you are using Spark to modify the table, it is
smart enough to refresh the cached schema. However, if the table schema
is modified outside of Spark, you need to call the
[`SYSCS_UTIL.SYSCS_REFRESH_EXTERNAL_TABLE`](sqlref_sysprocs_refreshexttable.html)
built-in system procedure. For example:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_REFRESH_EXTERNAL_TABLE('APP', 'myExtTable');
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

The
[`CREATE EXTERNAL TABLE`](sqlref_statements_createexternaltable.html)
statement.

The
[`SYSCS_UTIL.SYSCS_REFRESH_EXTERNAL_TABLE`](sqlref_sysprocs_refreshexttable.html)
built-in system procedure.

</div>
</section>
