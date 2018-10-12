---
title: CREATE INDEX statement
summary: Creates an index on a table.
keywords: creating index, primary key, unique
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_createindex.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CREATE INDEX

A `CREATE INDEX` statement creates an index on a table. Indexes can be
on one or more columns in the table.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
CREATE [UNIQUE] INDEX <a href="sqlref_identifiers_types.html#IndexName">indexName</a>
   ON <a href="sqlref_identifiers_types.html#TableName">tableName</a> (
      <a href="sqlref_identifiers_types.html#SimpleColumnName">simpleColumnName</a>
      [ ASC  | DESC ]
      [ , <a href="sqlref_identifiers_types.html#SimpleColumnName">simpleColumnName</a> [ ASC | DESC ]] *
     )
   [ SPLITKEYS splitKeyInfo HFILE hfileLocation ]
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

A simple column name.
{: .paramDefnFirst}

You cannot use the same column name more than once in a single `CREATE
INDEX` statement. Note, however, that a single column name can be used
in multiple indexes.
{: .paramDefn}

hFileLocation
{: .paramName}

The location (full path) in which the temporary HFiles will be created. These files will automatically be deleted after the index creation process completes. This parameter is required when specifying split keys.
{: .paramDefnFirst}

splitKeyInfo
{: .paramName}

<div class="fcnWrapperWide"><pre class="FcnSyntax">
AUTO |
{ LOCATION filePath
    [ colDelimiter ]
    [ charDelimiter ]
    [ timestampFormat ]
    [ dateFormat ]
    [ timeFormat ]
}</pre>
</div>

  <div class="indented" markdown="1" >

  Use the optional `SPLITKEYS` clause of `CREATE INDEX` to create indexes using HFile Bulk Loading, which is described, along with examples, in the [Importing Data: Bulk HFile Index Creation](tutorials_ingest_importbulkindex.html) tutorial topic.

  Bulk HFile indexing improves performance when indexing very large datasets.This is very similar to using HFile Bulk Loading for importing large datasets, which is described in our [Importing Data: Using Bulk HFile Import](tutorials_ingest_importbulkhfile.html) topic.

  You can specify `AUTO` to have Splice Machine scan the data and determine the splits automatically. Or you can create a CSV file in which you specify your own split keys, which is explained in the [Importing Data: Bulk HFile Index Creation](tutorials_ingest_importbulkindex.html) tutorial topic. When specifying your keys in a CSV file, you need to include the `SPLITKEYS` clause, which has the following parameters:

  filePath
  {: .paramName}

  The path to the CSV file that contains the split key values.
  {: .paramDefnFist}

  colDelimiter
  {: .paramName}

  The character used to separate columns. Specify `null` if using the comma (`,`) character as your delimiter.
  {: .paramDefnFist}

  charDelimiter
  {: .paramName}

  The character used to delimit strings in the imported data.Specify `null` if using the double-quote (`"`) character as your delimiter.
  {: .paramDefnFist}

  timestampFormat
  {: .paramName}

  The format of timestamps stored in the file. You can set this to `null` if there are no time columns in the file, or if the format of any timestamps in the file match the `Java.sql.Timestamp` default format, which is: "*yyyy-MM-dd HH:mm:ss*".
  {: .paramDefnFirst}
  All of the timestamps in the file you are importing must use the same format.
  {: .noteIcon}

  dateFormat
  {: .paramName}

  The format of datestamps stored in the file. You can set this to `null` if there are no date columns in the file, or if the format of any dates in the file match pattern: "*yyyy-MM-dd*".

  timeFormat
  {: .paramName}

  The format of time values stored in the file. You can set this to null if there are no time columns in the file, or if the format of any times in the file match pattern: "*HH:mm:ss*()".
  {: .paramDefnFirst}
  </div>
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

## Examples

Here's a simple example of creating an index on a table:

<div class="preWrapper" markdown="1">
    splice> CREATE TABLE myTable (ID INT NOT NULL, NAME VARCHAR(32) NOT NULL );
    0 rows inserted/updated/deleted

    splice> CREATE INDEX myIdx ON myTable(ID);
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}
</div>

### Example of Using Bulk HFile Index Creation
This example creates an index using Bulk HFile loading; Splice Machine defines the split keys automatically by sampling the data:
```
splice> CREATE INDEX l_shipdate_idx
  ON lineitem( l_shipdate, l_partkey, l_extendedprice, l_discount )
  SPLITKEYS AUTO
  HFILE LOCATION '/hbase/tmp/hbase-staging/tmp_bulk_clm_line_idx';
```
{: .Example}

This example creates an index using Bulk HFile loading, with the split keys specified in a CSV file
{: .spaceAbove}
```
splice> CREATE INDEX l_shipdate_idx
  ON lineitem( l_shipdate, l_partkey, l_extendedprice, l_discount )
  SPLITKEYS LOCATION '/tmp/shipDateIndex.csv'
  COLUMNDELIMITER '|'
  HFILE LOCATION '/tmp/test_hfile_import';
```
{: .Example}

See the [Importing Data: Bulk HFile Index Creation](tutorials_ingest_importbulkindex.html) tutorial topic for more information about bulk HFile indexing and split key files.
{: .spaceAbove}

### Example of Using the EXCLUDE Clause
This example uses the EXCLUDE DEFAULT KEYS clause, and shows you how the optimizer determines the applicability of the index with that clause.

<div class="preWrapper" markdown="1">
    splice> CREATE TABLE myTable2 (col1 int, col2 int default 5);
    0 rows inserted/updated/deleted

    splice> CREATE INDEX myIdx2 ON myTable2(col2) EXCLUDE DEFAULT KEYS;
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
* [Importing Data: Bulk HFile Index Creation](tutorials_ingest_importbulkindex.html)
* [Importing Data: Bulk HFile Import](tutorials_ingest_importbulkhfile.html)
* [`DELETE`](sqlref_statements_delete.html) statement
* [`DROP INDEX`](sqlref_statements_dropindex.html) statement
* [`INSERT`](sqlref_statements_insert.html) statement
* [`SELECT`](sqlref_expressions_select.html) statement
* [`UPDATE`](sqlref_statements_update.html) statement

</div>
</section>
