---
title: Rollback to Savepoint command
summary: Rolls the current transaction back to the specified savepoint.
keywords: savepoints, rolling back, transactions
toc: false
product: all
sidebar: home_sidebar
permalink: cmdlineref_rollbacktosavepoint.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Rollback to Savepoint Command

The <span class="AppCommand">rollback to savepoint</span> command issues
a `java.sql.Connection.rollback` request that has been overloaded to
work with a savepoint within the current transaction and rolls all the work in the currently active transaction back to the specified savepoint.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    rollback to savepoint identifier;
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
*identifier*
{: .paramName}

The name of the savepoint to which the transaction should be rolled
back. All savepoints up to and including this one are rolled back.
{: .paramDefnFirst}

</div>
## Usage Notes

When you roll back a transaction to a savepoint, that savepoint and any
others created after it within the transaction are automatically
released.

In contrast to the &nbsp;[`Rollback`](cmdlineref_rollback.html) command, the
`Rollback to Savepoint` command rolls back all of the work in the current transaction, but does
not start a new transaction.

## Examples

Create a table, turn autocommit off, and insert some data
into the table. Then create a savepoint, and verify the contents of
the table:

<div class="preWrapperWide" markdown="1">
    splice> CREATE TABLE myTbl(i int);
    0 rows inserted/updated/deleted
    splice> AUTOCOMMIT OFF;
    splice> INSERT INTO myTbl VALUES 1,2,3;
    3 rows inserted/updated/deleted
    splice> SAVEPOINT savept1;
    0 rows inserted/updated/deleted
    splice> SELECT * FROM myTbl;
    I
    -----------
    1
    2
    3
    
    3 rows selected
{: .AppCommand}

</div>
Next, add new values to the table and again verify its contents:

<div class="preWrapperWide" markdown="1">
    splice> INSERT INTO myTbl VALUES 4,5;
    2 rows inserted/updated/deleted
    splice> SELECT * FROM myTbl;
    I
    -----------
    1
    2
    3
    4
    5
    5 rows selected
{: .AppCommand}

</div>
Now roll back to the savepoint, and verify that the rollback worked:

<div class="preWrapperWide" markdown="1">
    splice> ROLLBACK TO SAVEPOINT savept1;
    0 rows inserted/updated/deleted
    splice> SELECT * FROM myTbl;
    I
    -----------
    1
    2
    3
    
    3 rows selected
{: .AppCommand}

</div>
Finally, commit the transaction:

<div class="preWrapperWide" markdown="1">
    COMMIT;
{: .AppCommand}

</div>
## See Also

* [savepoint](cmdlineref_savepoint.html) command
* [release savepoint](cmdlineref_releasesavepoint.html) command
* The *[Running
  Transactions](developers_fundamentals_transactions.html)* topic
  contains includes a discussion of using savepoints.

</div>
</section>

