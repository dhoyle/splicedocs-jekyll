---
title: Ingesting Data From an External Table
summary: Best practices and Troubleshooting
keywords: ingest, import
toc: false
product: all
sidebar: bestpractices_sidebar
permalink: bestpractices_ingest_externaltbl.html
folder: BestPractices/Database
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# ﻿Best Practices: Ingesting Data From an External Table

This topic describes how to ingest data stored in an external table into a Splice Machine database.

For an overview of best practices for data ingestion, see [Best Practices: Ingesting Data](bestpractices_ingest_overview.html.html).


## About External Tables

You can use Splice Machine external tables to query the contents of flat
files that are stored outside of your database. You query external
tables pretty much the same way as you do the tables in your database.

External tables reference files that are stored in a flat file format
such as Apache Parquet or Apache Orc, both of which are columnar storage
formats that are available in Hadoop. You can use the &nbsp;[`CREATE EXTERNAL
TABLE`](sqlref_statements_createexternaltable.html) statement to create
an external table that is connected to a specific flat file.

You can create external tables for files stored in these formats:
* `ORC`
* `PARQUET`
* `Avro`
* `TEXTFILE`

You can access `ORC` and `PARQUET` files that have been compressed with
either Snappy or ZLIb compression; however, you cannot use a compressed
plain text or Avro file.
{: .noteNote}

### Importing Data From an External Table

Once you've got an external table defined, you can import data from it into your Splice Machine database table by using the `INSERT INTO` statement. For example:

```
INSERT INTO myTable SELECT * FROM myExternalTable;
```

***********NOTE: RE: Cloud currently means S3*******************

## Example: Loading Data From an ORC File

This example loads data from an ORC file that is in `/tmp` into a table in your database, in these steps:

1.  __Create an external table named `LINEITEM_ext` in your database that points to an existing ORC file:__

    ```
    CREATE EXTERNAL TABLE LINEITEM_ext
        (
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
         L_COMMENT VARCHAR(44)
        )
    STORED AS ORC
    LOCATION '/tmp/lineitem/orc';
    ```
    {: .Example}

2.  __Create an internal table named `LINEITEM` in your database to load data into:__

    ```
    CREATE TABLE LINEITEM
        (
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
         L_COMMENT VARCHAR(44)
        );
    ```
    {: .Example}

3. __Insert all of the data from the external table into the internal table:__

    ```
    INSERT INTO LINEITEM SELECT * FROM LINEITEM_EXT;
    ```
    {: .Example}

4. __

## See Also

For an overview of best practices for data ingestion, see [Best Practices: Ingesting Data](bestpractices_ingest_overview.html.html).

For information about using external tables, see [Using External Tables](developers_fundamentals_externaltables.html).

The other topics in this *Best Practices: Ingestion* section provide examples of other ingestion scenarios:

* [Importing Flat Files](bestpractices_ingest_import.html)
* [Bulk Importing Flat Files](bestpractices_ingest_bulkimport.html)
* [Ingestion in Your Spark App](bestpractices_ingest_sparkapp.html)
* [Ingesting Streaming Data](bestpractices_ingest_streaming.html)
* [Troubleshooting Ingestion](bestpractices_ingest_troubleshooting.html)


</div>
</section>
