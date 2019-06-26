---
title: INSERT statement
summary: Inserts records into a table.
keywords: inserting records, insert into, record insertion
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_statements_insert.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# INSERT

An `INSERT` statement creates rows or columns and stores them in the
named table. The number of values assigned in an `INSERT` statement must
be the same as the number of specified or implied columns.

Whenever you insert into a table which has generated columns, Splice
Machine calculates the values of those columns.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
    INSERT INTO <a href="sqlref_identifiers_types.html#TableName">table-Name</a>
       [ (<a href="sqlref_identifiers_types.html#SimpleColumnName">Simple-column-Name</a>]* ) ]
       Query [ <a href="sqlref_clauses_orderby.html">ORDER BY clause</a> ]
       [ <a href="sqlref_clauses_resultoffset.html">result offset clause</a> ]
       [ <a href="sqlref_clauses_resultoffset.html">fetch first clause</a> ];</pre>

</div>
<div class="paramList" markdown="1">
table-Name
{: .paramName}

The table into which you are inserting data.
{: .paramDefnFirst}

Simple-column-Name*
{: .paramName}

An optional list of names of the columns to populate with data.
{: .paramDefnFirst}

Query [ORDER BY clause]
{: .paramName}

A `SELECT` or `VALUES` command that provides the columns and rows of
data to insert. The query can also be a `UNION` expression.
{: .paramDefnFirst}

See the [Using the `ORDER BY` Clause](#OrderBy) section below for
information about using the `ORDER BY` clause.
{: .paramDefn}

Single-row and multiple-row `VALUES` expressions can include the keyword
`DEFAULT`. Specifying `DEFAULT` for a column inserts the column's
default value into the column. Another way to insert the default value
into the column is to omit the column from the column list and only
insert values into other columns in the table. For more information, see
[`VALUES` expression](sqlref_expressions_values.html)
{: .paramDefn}

result offset and fetch first clauses
{: .paramName}

The &nbsp;[`fetch first` clause](sqlref_clauses_resultoffset.html), which can
be combined with the `result offset` clause, limits the number of rows
added to the table.
{: .paramDefnFirst}

</div>
## Using the ORDER BY Clause   {#OrderBy}

When you want insertion to happen with a specific ordering (for example,
in conjunction with auto-generated keys), it can be useful to specify an
`ORDER BY` clause on the result set to be inserted.

If the Query is a `VALUES` expression, it cannot contain or be followed
by an `ORDER BY`, result offset, or fetch first clause. However, if the
`VALUES` expression does not contain the `DEFAULT` keyword, the `VALUES`
clause can be put in a subquery and ordered, as in the following
statement:

<div class="preWrapperWide" markdown="1">
    INSERT INTO t SELECT * FROM (VALUES 'a','c','b') t ORDER BY 1;
{: .Example}

</div>
For more information about queries, see
[Query](sqlref_queries_query.html).

## Using Bulk Insertion  {#BulkInsert}

For very performant insertion of large datasets, you can use [query optimization hints](developers_tuning_queryoptimization.html#Insert) to specify that you want to use bulk import technology for the insertion.

To understand how bulk import works, please review the [Bulk Importing Flat Files](bestpractices_ingest_bulkimport.html) topic in our *Best Practices Guide.*
{: .noteIcon}

You need to combine two hints together for bulk insertion, and can add a third hint in your `INSERT` statement:

* The `bulkImportDirectory` hint is used just as it is with the `BULK_HFILE_IMPORT` procedure: to specify where to store the temporary HFiles used for the bulk import.
* The `useSpark=true` hint tells Splice Machine to use the Spark engine for this insert. This is __required__ for bulk HFile inserts.
* The optional `skipSampling` hint is used just as it is with the `BULK_HFILE_IMPORT` procedure: to tell the bulk insert to compute the splits automatically or that the splits have been supplied manually.

Here's a simple example:

```
DROP TABLE IF EXISTS myUserTbl;
CREATE TABLE myUserTbl AS SELECT
    user_id,
    report_date,
    type,
    region,
    country,
    access,
    birth_year,
    gender,
    product,
    zipcode,
    licenseID
FROM licensedUserInfo
WITH NO DATA;

INSERT INTO myUserTbl --splice-properties bulkImportDirectory='/tmp', useSpark=true, skipSampling=false
SELECT * FROM licensedUserInfo;
```
{: .Example }



## Examples

These examples insert records with literal values:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> INSERT INTO Players
       VALUES( 99, 'Giants', 'Joe Bojangles', 'C', 'Little Joey', '07/11/1991');
    1 row inserted/updated/deleted

    splice> INSERT INTO Players
       VALUES (99, 'Giants', 'Joe Bojangles', 'C', 'Little Joey', '07/11/1991'),
              (73, 'Giants', 'Lester Johns', 'P', 'Big John', '06/09/1984'),
              (27, 'Cards', 'Earl Hastings', 'OF', 'Speedy Earl', '04/22/1982');
    3 rows inserted/updated/deleted
{: .Example xml:space="preserve"}
</div>

This example creates a table name `OldGuys` that has the same columns as
our `Players` table, and then loads that table with the data from `Players`
for all players born before 1980:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> CREATE TABLE OldGuys(
        ID           SMALLINT NOT NULL PRIMARY KEY,
        Team         VARCHAR(64) NOT NULL,
        Name         VARCHAR(64) NOT NULL,
        Position     CHAR(2),
        DisplayName  VARCHAR(24),
        BirthDate    DATE
        );

    splice> INSERT INTO OldGuys
       SELECT * FROM Players
       WHERE BirthDate < '01/01/1980';
{: .Example xml:space="preserve"}

</div>

### Bulk Insertion Example

This example includes hints that tell Splice Machine to use bulk insertion, bypassing the standard write pipeline:

```
DROP TABLE IF EXISTS myUserTbl;
CREATE TABLE myUserTbl AS SELECT
    user_id,
    report_date,
    type,
    region,
    country,
    access,
    birth_year,
    gender,
    product,
    zipcode,
    licenseID
FROM licensedUserInfo
WITH NO DATA;

INSERT INTO myUserTbl --splice-properties bulkImportDirectory='/tmp',
useSpark=true,
skipSampling=false
SELECT * FROM licensedUserInfo;
```
{: .Example}


## Statement dependency system

The `INSERT` statement depends on the table being inserted into, all of
the conglomerates (units of storage such as heaps or indexes) for that
table, and any other table named in the statement. Any statement that
creates or drops an index or a constraint for the target table of a
prepared `INSERT` statement invalidates the prepared `INSERT` statement.

## See Also

* [`FETCH FIRST`](sqlref_clauses_resultoffset.html) clause
* [`ORDER BY`](sqlref_clauses_orderby.html) clause
* [Queries](sqlref_queries_query.html)
* [`RESULT OFFSET`](sqlref_clauses_resultoffset.html) clause

</div>
</section>
