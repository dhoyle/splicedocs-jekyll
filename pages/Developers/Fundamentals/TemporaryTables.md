---
title: Using Temporary Tables
summary: Describes how to use temporary tables with Splice Machine.
keywords: temp tables
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_fundamentals_temptables.html
folder: Developers/Fundamentals
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using Temporary Database Tables

This topic describes how to use temporary tables with Splice Machine.

## About Temporary Tables

You can use temporary tables when you want to temporarily save a result
set for further processing. One common case for doing so is when you've
constructed a result set by running multiple queries. You can also use
temporary tables when performing complex queries that require extensive
operations such as repeated multiple joins or sub-queries. Storing
intermediate results in a temporary table can reduce overall processing
time.

An example of using a temporary table to store intermediate results is a
web-based application for travel reservations that allows customers to
create several alternative itineraries, compare them, and then select
one for purchase. Such an app could store each itinerary in a row in a
temporary table, using table updates whenever the itinerary changes.
When the customer decides upon a final itinerary, that temporary row is
copied into a persistent table. And when the customer session ends, the
temporary table is automatically dropped.

Creating and operating with temporary tables does consume resources, and
can affect performance of your queries.
{: .noteNote}

## Creating Temporary Tables

Splice Machine provides two statements you can use to create a temporary
table; we provide multiple ways to create temporary tables to maintain
compatibility with third party Business Intelligence tools.

Splice Machine does not currently support creating temporary tables
stored as external tables.
{: .noteRestriction}

Each of these statements creates the same kind of temporary table, using
different syntax

<table summary="Statements for creating temporary tables">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Statement</th>
                        <th>Syntax</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><a href="sqlref_statements_createtemptable.html"><code>CREATE TEMPORARY TABLE</code></a>
                        </td>
                        <td>
                            <div class="fcnWrapperWide"><pre class="FcnSyntaxCell" xml:space="preserve">CREATE [LOCAL | GLOBAL] TEMPORARY TABLE <em><a href="sqlref_identifiers_types.html#TableName">table-Name</a></em> {
      ( {<em>column-definition</em> | <em>Table-level constraint</em>}
         [ , {<em>column-definition</em>} ] * )
      ( <em>column-name</em> [ , <em>column-name</em> ] * )
  }
  [NOLOGGING | ON COMMIT PRESERVE ROWS];</pre>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><a href="sqlref_statements_globaltemptable.html"><code>DECLARE GLOBAL TEMPORARY TABLE</code></a>
                        </td>
                        <td>
                            <div class="fcnWrapperWide"><pre class="FcnSyntaxCell" xml:space="preserve">DECLARE GLOBAL TEMPORARY TABLE <em><a href="sqlref_identifiers_types.html#TableName">table-Name</a></em>
   { <em>column-definition</em>[ , <em>column-definition</em>] * }
    [ON COMMIT PRESERVE ROWS ]
    [NOT LOGGED];
</pre>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
Splice Machine generates a warning if you attempt to specify any other
modifiers other than the `NOLOGGING`, `NOT LOGGED`, and
`ON COMMIT PRESERVE ROWS` modifiers shown above.
{: .noteNote}

## Restrictions on Temporary Tables

You can use temporary tables just like you do permanently defined
database tables, with several important exceptions and restrictions that
are noted in this section, including these:

* [Operational Limitations](#Operatio)
* [Table Persistence](#Table)

### Operational Limitations   {#Operatio}

Temporary tables have the following operational limitations; they:

* exist only while a user session is alive
* are visible in system tables, but are otherwise not visible to other
  sessions or transactions
* cannot be altered using the
  [`RENAME COLUMN`](sqlref_statements_renamecolumn.html) statements
* do not get backed up
* cannot be used as data providers to views
* cannot be referenced by foreign keys in other tables
* are not displayed by the [`show tables`](cmdlineref_showtables.html)
  command

Also note that temporary tables persist across transactions in a session
and are automatically dropped when a session terminates.

### Table Persistence   {#Table}

Here are two important notes about temporary table persistence.
Temporary tables:

* persist across transactions in a session
* are automatically dropped when a session terminates or expires
* can also be dropped with the
  [`DROP TABLE`](sqlref_statements_droptable.html) statement

## Example

    create local temporary table temp_num_dt (
       smallint_col smallint not null,
       int_col int,
       primary key(smallint_col)) on commit preserve rows;
    insert into temp_num_dt values (1,1);
    insert into temp_num_dt values (3,2),(4,2),(5,null),(6,4),(7,8);
    insert into temp_num_dt values (13,2),(14,2),(15,null),(16,null),(17,8);
    select * from temp_num_dt;
{: .Example xml:space="preserve"}

## See Also

* [`ALTER TABLE`](sqlref_statements_altertable.html) in the
  *SQL Reference Manual*
* [`CREATE TEMPORARY TABLE`](sqlref_statements_createtemptable.html)
  statement in the *SQL Reference Manual*
* [`DECLARE GLOBAL TEMPORARY TABLE`](sqlref_statements_globaltemptable.html)
  statement in the *SQL Reference Manual*
* [`DROP TABLE`](sqlref_statements_droptable.html) statement in the
  *SQL Reference Manual*
* [`RENAME COLUMN`](sqlref_statements_renamecolumn.html) statement in
  the *SQL Reference Manual*
* [`RENAME TABLE`](sqlref_statements_renametable.html) statement in the
  *SQL Reference Manual*

</div>
</section>

