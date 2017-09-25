---
title: Savepoint command
summary: Creates a savepoint within the current transaction.
keywords: savepoints, transactions
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_savepoint.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Savepoint Command

The <span class="AppCommand">savepoint</span> command issues a
`java.sql.Connection.setSavepoint` request, which sets a savepoint
within the current transaction.

Savepoints are only useful when autocommit is off.  
  
You can define multiple savepoints within a transaction.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    savepoint identifier;
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
*identifier*
{: .paramName}

An identifier name for the string.
{: .paramDefnFirst}

</div>
## Example

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
Now we roll back to our savepoint, and verify that the rollback worked:

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
And finally, we commit the transaction:

<div class="preWrapperWide" markdown="1">
    COMMIT;
{: .AppCommand}

</div>
## See Also

* [release savepoint](cmdlineref_releasesavepoint.html) command
* [rollback to savepoint](cmdlineref_rollbacktosavepoint.html) command
* The *[Running
  Transactions](developers_fundamentals_transactions.html)* topic
  contains includes a discussion of using savepoints.

</div>
</section>

