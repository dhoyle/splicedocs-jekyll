---
title: CREATE GLOBAL TEMPORARY TABLE statement
summary: Defines a temporary table for the current connection.
keywords: creating a temporary table
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_createtemptable.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CREATE TEMPORARY TABLE

The `CREATE TEMPORARY TABLE` statement defines a temporary table for the
current connection.

This statement is similar to the
[`DECLARE GLOBAL TEMPORARY TABLE`](sqlref_statements_globaltemptable.html) statements,
but uses different syntax to provide compatibility with external
business intelligence tools.

For general information and notes about using temporary tables, see the
[Using Temporary Tables](developers_fundamentals_temptables.html) topic
in our *Developer's Guide*.

Splice Machine does not currently support creating temporary tables
stored as external tables.
{: .noteRestriction}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    CREATE [LOCAL | GLOBAL] TEMPORARY TABLE table-Name {
          ( {column-definition | Table-level constraint}
             [ , {column-definition} ] * )
          ( column-name [ , column-name ] * )
      }
      [NOLOGGING | ON COMMIT PRESERVE ROWS];
{: .FcnSyntax xml:space="preserve"}

</div>
Splice Machine generates a warning if you attempt to specify any other
modifiers other than the `NOLOGGING`and
`ON COMMIT PRESERVE ROWS` modifiers shown above.
{: .noteNote}

<div class="paramList" markdown="1">
LOCAL  \|  GLOBAL
{: .paramName}

These values are ignored by Splice Machine, and are in place simply to
provide compatibility with external tools that use this syntax.
{: .paramDefnFirst}

table-Name
{: .paramName}

Names the temporary table.
{: .paramDefnFirst}

Table-level constraint
{: .paramName}

A constraint that is applied to this table, as described in the
[Constraints](sqlref_clauses_constraint.html#TableConstraint) clause
topic.
{: .paramDefnFirst}

column-definition
{: .paramName}

Specifies a column definition. See
[column-definition](sqlref_statements_columndef.html) for more
information.
{: .paramDefnFirst}

You cannot use `generated-column-spec` in `column-definitions` for
temporary tables.
{: .noteNote}

column-name
{: .paramName}

A *[SQL Identifier](sqlref_identifiers_intro.html)* that names a column
in the table.
{: .paramDefnFirst}

NOLOGGING
{: .paramName}

If you specify this, operations against the temporary table will not be
logged; otherwise, logging will take place as usual.
{: .paramDefnFirst}

ON COMMIT PRESERVE ROWS
{: .paramName}

Specifies that the data in the temporary table is to be preserved until
the session terminates.
{: .paramDefnFirst}

</div>
## Restrictions on Temporary Tables

You can use temporary tables just like you do permanently defined
database tables, with several important exceptions and restrictions that
are noted in this section.

### Operational Limitations

Temporary tables have the following operational limitations:

* exist only while a user session is alive
* are not visible to other sessions or transactions
* cannot be altered using the
 &nbsp;[`RENAME COLUMN`](sqlref_statements_renamecolumn.html) statements
* do not get backed up
* cannot be used as data providers to views
* cannot be referenced by foreign keys in other tables
* are not displayed by the &nbsp;[`SHOW
  TABLES`](cmdlineref_showtables.html) command

Also note that temporary tables persist across transactions in a session
and are automatically dropped when a session terminates.

### Table Persistence

Here are two important notes about temporary table persistence.
Temporary tables:

* persist across transactions in a session
* are automatically dropped when a session terminates or expires

## Examples

<div class="preWrapper" markdown="1">
    splice> CREATE GLOBAL TEMPORARY TABLE FirstAndLast(
          id INT NOT NULL PRIMARY KEY,
          firstName VARCHAR(8) NOT NULL,
          lastName VARCHAR(10) NOT NULL )
       ON COMMIT PRESERVE ROWS;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [`DECLARE GLOBAL TEMPORARY TABLE`](sqlref_statements_globaltemptable.html) statement
* [Using Temporary Tables](developers_fundamentals_temptables.html) in
  the *Developer's Guide*.

</div>
</section>
