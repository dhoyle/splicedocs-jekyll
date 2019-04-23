---
title: Interactions with Dependency System
summary: Information about how Splice Machine internally tracks the dependencies of prepared statements.
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_statements_interactions.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Interaction with the Dependency System

Splice Machine internally tracks the dependencies of prepared
statements, which are SQL statements that are precompiled before being
executed. Typically they are prepared (precompiled) once and executed
multiple times.

Prepared statements depend on the dictionary objects and statements they
reference. (Dictionary objects include tables, columns, constraints,
indexes, and views, and triggers. Removing or modifying the dictionary
objects or statements on which they depend invalidates them internally,
which means that Splice Machine will automatically try to recompile the
statement when you execute it. If the statement fails to recompile, the
execution request fails. However, if you take some action to restore the
broken dependency (such as restoring the missing table), you can execute
the same prepared statement, because Splice Machine will recompile it
automatically at the next execute request.

Statements depend on one another-an `UPDATE WHERE CURRENT` statement
depends on the statement it references. Removing the statement on which
it depends invalidates the `UPDATE WHERE CURRENT` statement.

In addition, prepared statements prevent execution of certain DDL
statements if there are open results sets on them.

Manual pages for each statement detail what actions would invalidate
that statement, if prepared. Here is an example using The Splice Machine
command line interface:

<div class="preWrapperWide" markdown="1">

    splice> CREATE TABLE mytable (mycol INT);
      0 rows inserted/updated/deleted
    splice> INSERT INTO mytable VALUES (1), (2), (3);
      3 rows inserted/updated/deleted  -- this example uses the
    ij command prepare, which prepares a statement
    splice> prepare p1 AS 'INSERT INTO MyTable VALUES (4)';
       -- p1 depends on mytable;
    splice> execute p1;
       1 row inserted/updated/deleted
         -- Splice Machine  executes it without recompiling
    splice> CREATE INDEX i1 ON mytable(mycol);
       0 rows inserted/updated/deleted
         -- p1 is temporarily invalidated because of new index
    splice> execute p1;
       1 row inserted/updated/deleted
         -- Splice Machine automatically recompiles and executes p1
    splice> DROP TABLE mytable;
       0 rows inserted/updated/deleted
         -- Splice Machine  permits you to drop table
         -- because result set of p1 is closed
         -- however, the statement p1 is temporarily invalidated
    splice> CREATE TABLE mytable (mycol INT);
       0 rows inserted/updated/deleted
    splice> INSERT INTO mytable VALUES (1), (2), (3);
       3 rows inserted/updated/deleted
    splice> execute p1;
       1 row inserted/updated/deleted
         -- p1 is invalid, so Splice Machine tries to recompile it
         -- before executing.
         -- It is successful and executes.
    splice> DROP TABLE mytable;
      0 rows inserted/updated/deleted
         -- statement p1 is now invalid
         -- and this time the attempt to recompile it
         -- upon execution will fail
    splice> execute p1;
      ERROR 42X05: Table/View 'MYTABLE' does not exist.
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CREATE INDEX`](sqlref_statements_createindex.html) statement
* [`CREATE TABLE`](sqlref_statements_createindex.html) statement
* [`DROP TABLE`](sqlref_statements_droptable.html) statement
* [`INSERT`](sqlref_statements_insert.html) statement
* [Using the `splice>` prompt](cmdlineref_using_cli.html)

</div>
</section>
