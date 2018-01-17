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

Use the optional `SPLITKEYS` section to create indexes using HFile Bulk Loading, which is described in the [Using Bulk Hfile Indexing](#BulkIndex) section, below. Using bulk HFiles improves performance for large datasets, and is related to our [Bulk HFile Import procedure](tutorials_ingest_importexampleshfile.html).
{: .paramDefnFirst}

You can specify `AUTO` to have Splice Machine scan the data and determine the splits automatically. Or you can specify your own split keys in a CSV file; if you're using a CSV file, you can optionally include delimiter and format specifications, as described in the following parameter definitions. Each parameter name links to a fuller description of the possible parameter values, which are the similar to those used in our [Import Parameters Tutorial](tutorials_ingest_importparams.html).
{: .paramDefn}

   <div class="paramList" markdown="1">
   [colDelimiter](tutorials_ingest_importparams.html#columnDelimiter)
   {: .paramName}

   The character used to separate columns. You don't need to specify this if using the comma (,) character as your delimiter.
   {: .paramDefnFirst}

   [charDelimiter](tutorials_ingest_importparams.html#characterDelimiter)
   {: .paramName}

   The character is used to delimit strings in the imported data. You don't need to specify this if using the double-quote (`\"`) character as your delimiter.
   {: .paramDefnFirst}

   [timeStampFormat](tutorials_ingest_importparams.html#timestampFormat)
   {: .paramName}

   The format of timestamps stored in the file. You don't need to specify this if no time columns in the file, or if the format of any timestamps in the file match the Java.sql.Timestamp default format, which is: "*yyyy-MM-dd HH:mm:ss*".
   {: .paramDefnFirst}

   [dateFormat](tutorials_ingest_importparams.html#dateFormat)
   {: .paramName}

   The format of datestamps stored in the file. You don't need to specify this if there are no date columns in the file, or if the format of any dates in the file match the pattern: "*yyyy-MM-dd*".
   {: .paramDefnFirst}

   [timeFormat](tutorials_ingest_importparams.html#timeFormat)
   {: .paramName}

   The format of time values stored in the file. You can set this to null if there are no time columns in the file, or if the format of any times in the file match pattern: "*HH:mm:ss*".
   {: .paramDefnFirst}
   </div>

hFileLocation
{: .paramName}

The location (full path) in which the temporary HFiles will be created. These files will automatically be deleted after the index creation process completes. This parameter is required when specifying split keys.
{: .paramDefnFirst}

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

## Using Bulk HFiles to Create an Index  {#BulkIndex}

Bulk HFile indexing improves performance when indexing very large datasets. The table you're indexing is temporarily converted into HFiles to take advantage of HBase bulk loading; once the indexing operation is complete, the temporary HFiles are automatically deleted. This is very similar to using HFile Bulk Loading for importing large datasets, which is described in our [Bulk HFile Import Tutorial](tutorials_ingest_importexampleshfile.html).

You can have Splice Machine automatically determine the splits by scanning the data, or you can define the split keys in a CSV file. In the following example, we use our understanding of the `Orders` table to first create a CSV file named `ordersKey.csv` that contains the split keys we want, and then use the following `CREATE INDEX` statement to create the index:

<div class="preWrapperWide" markdown="1"><pre class="Example">
CREATE INDEX o_Cust_Idx on Orders(
   o_custKey,
   o_orderKey
)
SPLITKEYS LOCATION '/tmp/ordersKey.csv'
          COLDELIMITER '|'
          HFILE LOCATION '/tmp/HFiles';
</pre></div>

The `/tmp/ordersKey.csv` file specifies the index keys; it uses the `|` character as a column delimiter. The temporary HFiles are created in the `/tmp/HFiles` directory.

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

## Example

<div class="preWrapper" markdown="1">
    splice> CREATE TABLE myTable (ID INT NOT NULL, NAME VARCHAR(32) NOT NULL );
    0 rows inserted/updated/deleted

    splice> CREATE INDEX myIdx ON myTable(ID);
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [`DELETE`](sqlref_statements_delete.html) statement
* [`DROP INDEX`](sqlref_statements_dropindex.html) statement
* [`INSERT`](sqlref_statements_insert.html) statement
* [`SELECT`](sqlref_expressions_select.html) statement
* [`UPDATE`](sqlref_statements_update.html) statement

</div>
</section>
