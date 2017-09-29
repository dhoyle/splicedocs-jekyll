---
title: Release Savepoint command
summary: Releases a savepoint.
keywords: savepoints, release, transactions
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_releasesavepoint.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Release Savepoint Command

The <span class="AppCommand">release savepoint</span> command issues a
`java.sql.Connection.releaseSavepoint` request, which releases a
savepoint within the current transaction. Once a savepoint has been
released, attempting to reference it in a rollback operation will cause
an `SQLException` to be thrown.

When you commit a transaction, any savepoints created in that
transaction are automatically released and invalidated when the
transaction is committed or the entire transaction is rolled back.

When you rollback a transaction to a savepoint, that savepoint and any
others created after it within the transaction are automatically
released.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    release savepoint identifier;
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
*identifier*
{: .paramName}

The name of the savepoint to release.
{: .paramDefnFirst}

</div>
## Examples

#### Example

First we'll create a table, turn `autocommit` off, and insert some data
into the table. We then create a savepoint, and verify the contents of
our table:

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
Next we add new values to the table and again verify its contents:

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
Now we release our original savepoint, insert a few more values, and
create a new savepoint, `savept2`.

<div class="preWrapperWide" markdown="1">
    splice> RELEASE SAVEPOINT savept1;
    0 rows inserted/updated/deletedsplice> INSERT INTO myTbl VALUES 6,7;
    2 rows inserted/updated/deleted
    splice> SELECT * FROM myTbl;
    I
    -----------
    1
    2
    3
    4
    5
    6
    7

    7 rows selected
    splice> SAVEPOINT savept2;
    0 rows inserted/updated/deleted
{: .AppCommand}

</div>
We again insert data into the table, display its contents, and then do a
rollback:

<div class="preWrapperWide" markdown="1">
    splice> INSERT INTO myTbl VALUES 8,9;
    2 rows inserted/updated/deleted
    splice> SELECT * FROM myTbl;
    I
    -----------
    1
    2
    3
    4
    5
    6
    7
    8
    9

    9 rows selected
    splice> ROLLBACK TO SAVEPOINT savept1;
    ERROR 3B001: Savepoint SAVEPT1 does not  exist or is not active in the current transaction.
    splice> ROLLBACK TO SAVEPOINT savept2;
    0 rows inserted/updated/deleted
    splice> SELECT * FROM myTbl;
    I
    -----------
    1
    2
    3
    4
    5
    6
    7

    7 rows selected
{: .AppCommand}

</div>
And finally, we commit the transaction:

<div class="preWrapperWide" markdown="1">
    COMMIT;
{: .AppCommand}

</div>
## See Also

* [savepoint](cmdlineref_savepoint.html) command
* [rollback to savepoint](cmdlineref_rollbacktosavepoint.html) command
* The *[Running
  Transactions](developers_fundamentals_transactions.html)* topic
  contains includes a discussion of using savepoints.

</div>
</section>
