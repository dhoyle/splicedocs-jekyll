---
title: CREATE INDEX statement
summary: Creates an index on a table.
keywords: creating index, primary key, unique
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_statements_createindex.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CREATE INDEX

A `CREATE INDEX` statement creates an index on a table. Indexes can be
on one or more columns in the table. You can optionally create indexes using bulk HFiles, which can improve index creation performance for large tables.

## Syntax
<div class="fcnWrapperWide"><pre class="FcnSyntax">
CREATE [UNIQUE] INDEX <a href="sqlref_identifiers_types.html#IndexName">indexName</a>
   ON <a href="sqlref_identifiers_types.html#TableName">tableName</a> (
      <a href="sqlref_identifiers_types.html#SimpleColumnName">simpleColumnName</a>
      [ASC | DESC]
      [ , <a href="sqlref_identifiers_types.html#SimpleColumnName">simpleColumnName</a> [ASC | DESC] ] *
     )
   [  AUTO  SPLITKEYS [ SAMPLEFRACTION fractionVal ]
    | [LOGICAL | PHYSICAL] SPLITKEYS LOCATION filePath
          [colDelimiter] [charDelimiter] [timestampFormat] [dateFormat] [timeFormat] ]
   [ HFILE hfileLocation ]
   [ EXCLUDE ( NULL | DEFAULT ) KEYS ]
</pre>
</div>

<div class="paramList" markdown="1">
indexName
{: .paramName}
An identifier, the length of which cannot exceed 128 characters.
{: .paramDefnFirst}

tableName
{: .paramName}
A table name, which can optionally be qualified by a schema name.
{: .paramDefnFirst}

simpleColumnName
{: .paramName}
A simple column name.
{: .paramDefnFirst}
You cannot use the same column name more than once in a single `CREATE
INDEX` statement. Note, however, that a single column name can be used
in multiple indexes.
{: .paramDefn}

fractionVal
{: .paramName}
You can optionally use split keys for index creation, as described below, in the [Using Split Keys](#splitkeys) section; split keys can be computed automatically, or can be specified in a file.
{: .paramDefnFirst}
When using automatic (`AUTO`) splitting, you can specify the sampling fraction in this parameter; this is  a decimal value in the range `0` to `1`. If you leave this unspecified, the default value stored in the `splice.bulkImport.sample.fraction` configuration property is used as the sampling fraction.
{: .paramDefn}

filePath
{: .paramName}
You can also supply either `LOGICAL` (primary key) or `PHYSICAL` (encoded hbase) split keys yourself in a CSV file, instead of using automatic splitting. See the [Using Split Keys](#splitkeys) section for more information.
{: .paramDefnFirst}
This parameter value is the path to the CSV file that contains the split key values when using non-automatic splitting.
{: .paramDefn}

colDelimiter
{: .paramName}
The character used to separate columns in the CSV file. You don't need to specify this if using the comma (`,`) character as your delimiter.
{: .paramDefnFirst}
For additional information about column delimiters, please see the description in our [Importing Data: Input Parameters](bestpractices_ingest_params.html#columnDelimiter) tutorial page.
{: .paramDefn}

charDelimiter
{: .paramName}
The character used to delimit strings in the CSV file. You don't need to specify this if using the double-quote (`"`) character as your delimiter.
{: .paramDefnFirst}
For additional information about character delimiters, please see the description in our [Importing Data: Input Parameters](bestpractices_ingest_params.html#characterDelimiter) tutorial page.
{: .paramDefn}

timeStampFormat
{: .paramName}
The format of timestamps stored in the CSV file. You don't need to specify this if there are not any time columns in the file, or if the format of any timestamps in the file match the Java.sql.Timestamp default format, which is: "*yyyy-MM-dd HH:mm:ss*".
{: .paramDefnFirst}
For additional information about timestamp formats, please see the description in our [Importing Data: Input Parameters](bestpractices_ingest_params.html#timestampFormat) tutorial page.
{: .paramDefn}

dateFormat
{: .paramName}
The format of datestamps stored in the CSV file. You don't need to specify this if there are no date columns in the file, or if the format of any dates in the file match the pattern: "*yyyy-MM-dd*".
{: .paramDefnFirst}
For additional information about date formats, please see the description in our [Importing Data: Input Parameters](bestpractices_ingest_params.html#dateFormat) tutorial page.
{: .paramDefn}

timeFormat
{: .paramName}
The format of time values stored in the CSV file. You can set this to null if there are no time columns in the file, or if the format of any times in the file match pattern: "*HH:mm:ss*".
{: .paramDefnFirst}
For additional information about time formats, please see the description in our [Importing Data: Input Parameters](bestpractices_ingest_params.html#timeFormat) tutorial page.
{: .paramDefn}

hFileLocation
{: .paramName}

To use the bulk HFile index creation process, you __must__ specify this value, which is the location (full path) in which the temporary HFiles will be created. These files will automatically be deleted after the index creation process completes. If you leave this parameter out, the index will be created without using HFile Bulk loading.
{: .paramDefnFirst}

HFile Bulk Loading of indexes is described in the [Using Bulk Hfile Indexing](#BulkIndex) section, below. Using bulk HFiles improves performance for large datasets, and is related to our [Bulk HFile Import procedure](bestpractices_ingest_bulkimport.html).
{: .paramDefn}

</div>

## Usage

Splice Machine can use indexes to improve the performance of data
manipulation statements. In addition, `UNIQUE` indexes provide a form of
data integrity checking.

**Index names are unique within a schema**. (Some database systems allow
different tables in a single schema to have indexes of the same name,
but Splice Machine does not.) Both index and table are assumed to be in
the same schema if a schema name is specified for one of the names, but
not the other. If schema names are specified for both index and table,
an exception will be thrown if the schema names are not the same. If no
schema name is specified for either table or index, the current schema
is used.

You cannot create an index that has the same index columns as an
existing index; if you attempt to do so, Splice Machine issues a warning
and does not create the index, as you can see in this example:

<div class="preWrapperWide" markdown="1">
    splice> CREATE INDEX idx1 ON myTable(id, eventType);
    0 rows inserted/updated/deleted
    splice> CREATE INDEX idx2 ON myTable(id, eventType);
    WARNING 01504: The new index is a duplicate of an existing index: idx1.
    splice> DROP INDEX idx2;
    ERROR 42X65: Index 'idx2' does not exist.
{: .Example}
</div>

By default, Splice Machine uses the ascending order of each column to
create the index. Specifying `ASC` after the column name does not alter
the default behavior. <span>The `DESC` keyword after the column name
causes Splice Machine to use descending order for the column to create
the index. Using the descending order for a column can help improve the
performance of queries that require the results in mixed sort order or
descending order and for queries that select the minimum or maximum
value of an indexed column.</span>

If a qualified index name is specified, the schema name cannot begin
with `SYS`.

## Using Split Keys  {#splitkeys}
You can optionally include a file of split keys for the new index; these specify how you want the index to be split over HBase Regions. You can have Splice Machine automatically determine the splits by scanning the data, or you can define the split keys in a CSV file.

The split keys file you provide can specify either `LOGICAL` or `PHYSICAL` keys:
* Logical keys are the primary key column values that you want to define the splits.
* Physical keys are actual split keys for the HBase table, in encoded HBase format.

### Automatic Sampling or Specifying Split Keys
When you specify `AUTO` sampling for index creation, Splice Machine samples the data you're indexing and determines the best region splits for your index. You can specify the sampling rate to use, as shown below, in [Example 2: Bulk HFile Index Creation with Automatic Split Keys](#exbulkauto).

If you know how your data should be split into regions, you can specify those region split keys in a CSV file, as shown below, in [Example 3: Bulk HFile Index creation with Logical Split Keys](#exbulklogical). Alternatively, if you're an expert user, you can specify the split keys for the physical HBase table, as shown below, in [Example 4: Bulk HFile Index creation with Physical Split Keys](#exbulkphysical).

You can define logical *or* physical split keys for the index whether or not you're using Bulk HFile loading to create the index. The [Indexing Tables](bestpractices_optimizer_indexes.html) topic in the *Best Practices - Optimizer* section of this documentation page provides detailed information about using automatic sampling and providing your own region split keys.
{: .noteIcon}

### Using Bulk HFiles to Create an Index  {#BulkIndex}

Bulk HFile indexing improves performance when indexing very large datasets. The table you're indexing is temporarily converted into HFiles to take advantage of HBase bulk loading; once the indexing operation is complete, the temporary HFiles are automatically deleted.

To learn more about bulk HFile index creation, see the [Indexing Tables](bestpractices_optimizer_indexes.html) topic in the *Best Practices - Optimizer* section of this documentation.

Bulk HFile index creation is related to using Bulk HFiles to import data, which is described in our [Importing Data: Bulk HFile Import](bestpractices_ingest_bulkimport.html) best practices page.

## Excluding NULL and Default Values

You can include the optional `EXCLUDE` clause to specify that you want to exclude from the index either default values or NULL values for the column. This can be desirable for a large table in which the index column is largely populated with the same (default or NULL) value; excluding these values in the index can mean:

* avoiding a large amount of wasted storage space for the index
* a significant reduction of system resources needed to maintain a very large index

For an index with multiple columns, only rows with NULL or default values on the leading index column are excluded.
{: .noteIcon}

Excluding NULL or default values is not applicable for all queries; the Splice Machine optimizer will automatically determine automatically whether or not such an index can be applied in a specific query. The optimizer determines this based on both the cost of using the index, and whether the predicates in the query can guarantee that no rows with NULL or default values could be qualified.

## Indexes and constraints

Unique and primary key constraints generate indexes that enforce or
"back" the constraint (and are thus sometimes called *backing indexes*).
If a column or set of columns has a `UNIQUE` or `PRIMARY KEY` constraint
on it, you can not create an index on those columns.

Splice Machine has already created it for you with a system-generated
name. System-generated names for indexes that back up constraints are
easy to find by querying the system tables if you name your constraint.
Adding a `PRIMARY KEY` or `UNIQUE` constraint when an existing `UNIQUE`
index exists on the same set of columns will result in two physical
indexes on the table for the same set of columns. One index is the
original `UNIQUE` index and one is the backing index for the new
constraint.

## Statement Dependency System

Prepared statements that involve `SELECT, INSERT, UPDATE`, and `DELETE`
on the table referenced by the `CREATE INDEX` statement are invalidated
when the index is created.

## Indexes on Expressions {#indexonexpression}

You can create an index on an expression, which is also referred to as a key-expression.

Each key-expression must contain as least one reference to a column of the table specified in the ON clause of the index. Referenced columns cannot be LOB, XML, or DECFLOAT data types, or a distinct type that is based on one of these data types. Referenced columns cannot include any FIELDPROCs and cannot include a SECURITY LABEL.

The key-expression also cannot include any of the following:

* A subquery
* An aggregate function
* A non-deterministic function
* A function that has an external action
* A user-defined function
* A sequence reference
* A host variable
* A parameter marker
* A special register
* A CASE expression
* An OLAP specification

Unlike a simple index, the index key of an index on an expression is composed by concatenating the result (also known as a key-target) of the expression that is specified in the ON clause. An index that is created on an expression lets a query take advantage of index access (if the index is chosen by the optimizer) and avoid a table space scan.

### Index on Expression Example

The following example creates an index on the LAST_NAME column of the EMP table, but indexes the data after applying the UPPER function. This is useful if you store the data in mixed case, but submit queries with parameter markers (or host variables) only in upper case. By indexing the data as upper case, the index better matches your queries.

<div class="preWrapper" markdown="1">
    CREATE INDEX XUPLN
    ON EMP
    (UPPER(LAST_NAME, 'En_US'))
    USING STOGROUP DSN8G910
    PRIQTY 360 SECQTY 36
    ERASE NO
    COPY YES;
{: .Example xml:space="preserve"}
</div>

## Examples
This section includes these examples of index creation:
* [Example 1: Simple Index Creation](#exsimple)
* [Example 2: Bulk HFile Index Creation with Automatic Split Keys](#exbulkauto)
* [Example 3: Bulk HFile Index creation with Logical Split Keys](#exbulklogical)
* [Example 4: Bulk HFile Index creation with Physical Split Keys](#exbulkphysical)
* [Example 5: Using the EXCLUDE Clause](#exexclude)

### Example 1: Simple Index Creation {#exsimple}
Here's a simple example of creating an index on a table:

<div class="preWrapper" markdown="1">
    splice> CREATE TABLE myTable (ID INT NOT NULL, NAME VARCHAR(32) NOT NULL );
    0 rows inserted/updated/deleted

    splice> CREATE INDEX myIdx ON myTable(ID);
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}
</div>

### Example 2: Bulk HFile Index Creation with Automatic Split Keys {exbulkauto}
This example creates an index using `AUTO` sampling, with a sampling rate of `0.001`:

<div class="preWrapper" markdown="1">
    CREATE INDEX l_part_idx ON lineitem(
        l_partkey,
        l_orderkey,
        l_suppkey,
        l_shipdate,
        l_extendedprice,
        l_discount,
        l_quantity,
        l_shipmode,
        l_shipinstruct
    ) AUTO SPLITKEYS SAMPLE FRACTION 0.001 HFILE LOCATION '/tmp/hfile';
{: .Example xml:space="preserve"}
</div>

### Example 3: Bulk HFile Index creation with Logical Split Keys {exbulklogical}
This example creates an index using logical (primary key column values) split keys that are stored in a CSV file:

<div CLASS="preWrapper" markdown="1">
    CREATE INDEX L_PART_IDX ON lineitem(
         l_partkey,
         l_orderkey,
         l_suppkey,
         l_shipdate,
         l_extendedprice,
         l_discount,
         l_quantity,
         l_shipmode,
         l_shipinstruct
     ) LOGICAL SPLITKEYS LOCATION '/tmp/l_part_idx.csv' HFILE LOCATION '/tmp/hfile';
{: .Example xml:space="preserve"}
</div>

### Example 4: Bulk HFile Index creation with Physical Split Keys {exbulkphysical}
This example creates an index using physical split keys, which are split keys for the HBase table, in encoded HBase format.

<div class="preWrapper" markdown="1">
    CREATE INDEX l_part_idx ON lineitem(
         l_partkey,
         l_orderkey,
         l_suppkey,
         l_shipdate,
         l_extendedprice,
         l_discount,
         l_quantity,
         l_shipmode,
         L_SHIPINSTRUCT
     ) PHYSICAL SPLITKEYS LOCATION '/tmp/l_part_idx.txt' HFILE LOCATION '/tmp/hfile';
{: .Example xml:space="preserve"}
</div>


### Example 5: Using the EXCLUDE Clause  {#exexclude}
This example uses the EXCLUDE DEFAULT KEYS clause, and shows you how the optimizer determines the applicability of the index with that clause.

<div class="preWrapper" markdown="1">
    splice> CREATE TABLE myTable2 (col1 int, col2 int default 5);
    0 rows inserted/updated/deleted

    splice> CREATE INDEX myIdx2 ON myTable2(col2) EXCLUDE DEFAULT KEYS;
    0 rows inserted/updated/deleted

    splice> insert into myTable2 values (1,1), (2,2);
    2 rows inserted/updated/deleted

    splice> insert into myTable2(col1) values 3,4,5;
    3 rows inserted/updated/deleted
{: .Example xml:space="preserve"}
</div>

Now the table contains 5 rows, 3 of which have default values in `col2`.

<div class="preWrapper" markdown="1">
    splice> select * from myTable2;
    COL1       |COL2
    -----------------------
    1          |1
    2          |2
    3          |5
    4          |5
    5          |5

    5 rows selected
{: .Example xml:space="preserve"}
</div>

As you can see from the generated plan, the optimizer determines that the following query can use the index `myIdx2` because it can tell for sure that the rows with default values on `col2` will not be qualified:

<div class="preWrapper" markdown="1">
    splice> explain select col2 from mytable2 where col2 < 5;
    Plan
    ------------------------------------------------------------------------------------------------
    Cursor(n=3,rows=18,updateMode=READ_ONLY (1),engine=control)
      ->  ScrollInsensitive(n=2,totalCost=8.207,outputRows=18,outputHeapSize=18 B,partitions=1)
        ->  IndexScan[MYIDX2(1713)](n=1,totalCost=4.027,scannedRows=18,outputRows=18,outputHeapSize=18 B,partitions=1,baseTable=MYTABLE2(1696),preds=[(COL2[0:1] < 5)])

    3 rows selected
    splice> select col2 from mytable2 where col2 < 5;
    COL2
    -----------
    1
    2

    2 rows selected
{: .Example}
</div>

The optimizer determines that the following query *cannot* use `myIdx2`, because rows with the default value in `col2` could survive the predicate `col2 > 3`:

<div class="preWrapper" markdown="1">
    splice> explain select col2 from mytable2 where col2 > 3;
    Plan
    ----------------------------------------------------------------------------------------------------
    Cursor(n=3,rows=18,updateMode=READ_ONLY (1),engine=control)
      ->  ScrollInsensitive(n=2,totalCost=8.22,outputRows=18,outputHeapSize=18 B,partitions=1)
        ->  TableScan[MYTABLE2(1696)](n=1,totalCost=4.04,scannedRows=20,outputRows=18,outputHeapSize=18 B,partitions=1,preds=[(COL2[0:1] > 3)])

    3 rows selected

    COL2
    -----------
    5
    5
    5

    3 rows selected
{: .Example}
</div>

Now, if we force the index to be used in the above case, you'll see an error:

<div class="preWrapper" markdown="1">
    splice> explain select col2 from mytable2 --splice-properties index=myIdx2
    > where col2 > 3;
    ERROR 42Y69: No valid execution plan was found for this statement. This is usually because an infeasible join strategy was chosen, or because an index was chosen which prevents the chosen join strategy from being used.
{: .Example}
</div>

## See Also

* [`DELETE`](sqlref_statements_delete.html) statement
* [`DROP INDEX`](sqlref_statements_dropindex.html) statement
* [`INSERT`](sqlref_statements_insert.html) statement
* [`SELECT`](sqlref_expressions_select.html) statement
* [`UPDATE`](sqlref_statements_update.html) statement
* [Indexing Large Tables](bestpractices_optimizer_indexes.html)
* [Importing Data: Bulk HFile Import](bestpractices_ingest_bulkimport.html)

</div>
</section>
