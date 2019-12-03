---
title: DELETE statement
summary: Deletes records from a table.
keywords: deleting records, hfile delete, delete hfile, bulk delete
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_statements_delete.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DELETE

The `DELETE` statement deletes records from a table.

Our [Bulk HFile Delete](#bulkdel) feature can be used to optimize
deletion of large amounts of data.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
{
  DELETE FROM <a href="sqlref_identifiers_types.html">correlation-Name</a>]
    [<a href="sqlref_clauses_where.html">WHERE clause</a>]
}</pre>

</div>
<div class="paramList" markdown="1">
table-Name
{: .paramName}

The name of the table from which you want to delete records.
{: .paramDefnFirst}

correlation-Name
{: .paramName}

The optional alias (alternate name) for the table.
{: .paramDefnFirst}

WHERE clause
{: .paramName}

The clause that specifies which record(s) to select for deletion.
{: .paramDefnFirst}

</div>
## Usage

The `DELETE` statement removes all rows identified by the table name and
[`WHERE`](sqlref_clauses_where.html) clause.

## Examples

<div class="preWrapperWide" markdown="1">
    splice> DELETE FROM Players WHERE Year(Birthdate) > 1990;
    8 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## Using our Bulk HFile Delete Feature   {#bulkdel}

Our Bulk Delete feature leverages HFile bulk deletion to significantly
speed things up when you are deleting a lot of data; it does so by
generating HFiles for the deletion and then bypasses the Splice Machine
write pipeline and HBase write path when deleting the data.

You simply add a
[`splice-properties`](bestpractices_optimizer_hints.html) hint
that specifies where to generate the HFiles. If you're specifying an S3
bucket on AWS, please review our [Configuring an S3 Bucket for Splice
Machine Access](developers_cloudconnect_configures3.html) topic; if you're specifying Azure Storage, please see our [Using Azure Storage](developers_cloudconnect_configureazure.html) topic.

<div class="preWrapperWide" markdown="1">
    splice> DELETE FROM my_table --splice-properties bulkDeleteDirectory='/bulkFilesPath'
    ;
{: .Example xml:space="preserve"}

</div>
We recommend performing a major compaction on your database after
deleting a large amount of data; you should also be aware of our new
[`SYSCS_UTIL.SET_PURGE_DELETED_ROWS`](sqlref_sysprocs_purgedeletedrows.html)
system procedure, which you can call before a compaction to specify that
you want the data physically (not just logically) deleted during
compaction.
{: .noteNote}

## Statement Dependency System

A searched delete statement depends on the table being updated, all of
its conglomerates (units of storage such as heaps or indexes), and any
other table named in the `WHERE` clause. A &nbsp;[`DROP
INDEX`](sqlref_statements_dropindex.html) statement for the target table
of a prepared searched delete statement invalidates the prepared
searched delete statement.

A `CREATE INDEX` or `DROP INDEX` statement for the target table of a
prepared positioned delete invalidates the prepared positioned delete
statement.

## See Also

* [`CREATE INDEX`](sqlref_statements_createindex.html) statement
* [`DROP INDEX`](sqlref_statements_dropindex.html) statement
* [`SELECT`](sqlref_expressions_select.html) statement
* [`WHERE`](sqlref_clauses_where.html) clause

</div>
</section>
