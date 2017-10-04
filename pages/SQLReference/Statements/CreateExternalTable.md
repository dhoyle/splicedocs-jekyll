---
title: CREATE EXTERNAL TABLE statement
summary: Allows you to query data stored in a flat file as if that data were stored in a Splice Machine table.
keywords: external tables, orc, avro, parquet, textfile, compression, encoding, separator
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_createexternaltable.html
folder: SQLReference/Statements
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CREATE EXTERNAL TABLE

A `CREATE EXTERNAL TABLE` statement creates a table in Splice Machine
that you can use to query data that is stored externally in a flat file,
such as a file in Parquet, ORC, or plain text format. External tables
are largely used as a convenient means of moving data into and out of
your database.

You can query external tables just as you would a regular Splice Machine
table; however, you cannot perform any DML operations on an external
table, once it has been created. That also means that you cannot create
an index on an external table.

If the schema of the external file that you are querying is modified
outside of Splice, you need to manually refresh the Splice Machine table
by calling the
[`REFRESH EXTERNAL TABLE`](sqlref_sysprocs_refreshexttable.html) built-in
system procedure.
{: .noteImportant}

If a qualified table name is specified, the schema name cannot begin
with `SYS`.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
CREATE EXTERNAL TABLE <a href="sqlref_identifiers_types.html#TableName">table-Name</a>
  {
    ( <a href="sqlref_statements_columndef.html">column-definition</a>* )
    [ COMPRESSED WITH compression-format ]
    [ PARTITIONED BY (column-name ) ]}
    [ ROW FORMAT DELIMITED 
         [ FIELDS TERMINATED BY char [ESCAPED BY char] ]
         [ LINES TERMINATED BY char ]
    ]
    STORED AS file-format LOCATION location
  }</pre>

</div>
<div class="paramList" markdown="1">
table-Name
{: .paramName}

The name to assign to the new table.
{: .paramDefnFirst}

compression-format
{: .paramName}

The compression algorithm used to compress the flat file source of this
external table. You can specify one of the following values:
{: .paramDefnFirst}

* `ZLIB`
* `SNAPPY`
{: .bulletNested}

If you don't specify a compression format, the default is uncompressed.
You cannot specify a <span
class="CodeItalicFont">compression-format</span> when using the
`TEXTFILE `<span class="CodeItalicFont">file-format</span>; doing so
generates an error.
{: .paramDefn}

column-definition
{: .paramName}

A column definition.
{: .paramDefnFirst}

The maximum number of columns allowed in a table is
`{{splvar_limit_MaxColumnsInTable}}`.
{: .paramDefn}

column-name
{: .paramName}

The name of a column.
{: .paramDefnFirst}

char
{: .paramName}

A single character used as a delimiter or escape character. Enclose this
character in single quotes; for example, ','.
{: .paramDefnFirst}

To specify a special character that includes the backslash character,
you must escape the backslash character itself. For example:
{: .paramDefn}

* `\\` to indicate a backslash character
* `\n` to indicate a newline character
* `\t` to indicate a tab character
{: .bulletNested}

file-format
{: .paramName}

The format of the flat file source of this external table. This is
currently one of these values:
{: .paramDefnFirst}

* `ORC` is a columnar storage format
* `PARQUET` is a columnar storage format
* `Avro` is a data serialization system
* `TEXTFILE` is a plain text file
{: .bulletNested}

location
{: .paramName}

The location at which the file is stored.
{: .paramDefnFirst}

</div>
## Usage Notes

Here are some notes about using external tables:
{: .body}

* If the data types in the table schema you specify do not match the
  schema of the external file, an error occurs and the table is not
  created.
* You cannot define indexes or constraints on external tables
* The `ROW FORMAT` parameter is only applicable to plain text
  (`TextFile`) not supported for columnar storage format files (`ORC` or
  `PARQUET` files)
  <!-- or row-based storage format files (AVRO).-->

* If you specify the location of a non-existent file when you create an
  external table, Splice Machine automatically creates an external file
  at that location.
* `AVRO` external tables do not currently work with compressed files;
  any compression format you specify will be ignored.
* Splice Machine isn't able to know when the schema of the file
  represented by an external table is updated; when this occurs, you
  need to update the external table in Splice Machine by calling the
 &nbsp;[`SYSCS_UTIL.SYSCS_REFRESH_EXTERNAL_TABLE`](sqlref_sysprocs_refreshexttable.html)
  built-in system procedure.
* You cannot specify a <span
  class="CodeItalicFont">compression-format</span> when using the
  `TEXTFILE `<span class="CodeItalicFont">file-format</span>; doing so
  generates an error.

## Examples

This section presents examples of the `CREATE EXTERNAL TABLE` statement.

This example creates an external table for a `PARQUET` file:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> CREATE EXTERNAL TABLE myParquetTable(
                        col1 INT, col2 VARCHAR(24))
                        PARTITIONED BY (col1)
                        STORED AS PARQUET
                        LOCATION '/users/myName/myParquetFile'
            );
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

This example creates an external table for an `AVRO` file:
{: .body}

<div class="preWrapper" markdown="1">
    splice> CREATE EXTERNAL TABLE myAvroTable(
                        col1 INT, col2 VARCHAR(24))
                        PARTITIONED BY (col1)
                        STORED AS AVRO
                        LOCATION '/users/myName/myAvroFile'
            );
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
This example creates an external table for an `ORC` file and inserts
data into it:
{: .body}

<div class="preWrapper" markdown="1">
    splice> CREATE EXTERNAL TABLE myOrcTable(
                        col1 INT, col2 VARCHAR(24))
                        PARTITIONED BY (col1)
                        STORED AS ORC
                        LOCATION '/users/myName/myOrcFile'
            );
    0 rows inserted/updated/deleted
    splice> INSERT INTO myOrcTable VALUES (1, 'One'), (2, 'Two'), (3, 'Three');
    3 rows inserted/updated/deleted
    splice> SELECT * FROM myOrcTable;
    COL1        |COL2------------------------------------
    3           |Three
    2           |Two
    1           |One
{: .Example xml:space="preserve"}

</div>
This example creates an external table for a plain text file:
{: .body}

<div class="preWrapper" markdown="1">
    splice> CREATE EXTERNAL TABLE myTextTable(
                        col1 INT, col2 VARCHAR(24))
                        PARTITIONED BY (col1)
                        ROW FORMAT DELIMITED FIELDS
                        TERMINATED BY ','
                        ESCAPED BY '\\' 
                        LINES TERMINATED BY '\\n'
                        STORED AS TEXTFILE
                        LOCATION '/users/myName/myTextFile'
            );
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
This example creates an external table for a `PARQUET` file that was
compressed with Snappy compression:
{: .body}

<div class="preWrapper" markdown="1">
    splice> CREATE EXTERNAL TABLE mySnappyParquetTable(
                        col1 INT, col2 VARCHAR(24))
                        COMPRESSED WITH SNAPPY
                        PARTITIONED BY (col1)
                        STORED AS PARQUET
                        LOCATION '/users/myName/mySnappyParquetFile'
    );
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
</div>
## See Also

* [`CREATE TABLE`](sqlref_statements_createtable.html)
* [`PIN TABLE`](sqlref_statements_pintable.html)
* [`DROP TABLE`](sqlref_statements_droptable.html)
* [`REFRESH EXTERNAL TABLE`](sqlref_sysprocs_refreshexttable.html)
* [Foreign Keys](developers_fundamentals_foreignkeys.html)
* [Triggers](developers_fundamentals_triggers.html)

</div>
</section>
