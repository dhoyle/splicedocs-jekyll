---
title: Running Transactions
summary: Introduces you to the basics of running transactions with Splice Machine.
keywords: transactions, running transcations, ACID, MVCC, Snapshot isolation
toc: false
product: all
sidebar: home_sidebar
permalink: developers_fundamentals_transactions.html
folder: DeveloperTopics/Fundamentals
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Running Transactions In Splice Machine

Splice Machine is a fully transactional database that supports
ACID transactions. This allows you to perform actions such as *commit*
and *rollback*; in a transactional context, this means that the database
does not make changes visible to others until a *commit* has been
issued.

This topic includes brief overview information about transaction
processing with Splice Machine, in these sections:

* [Transactions Overview](#Transact)
  * [ACID Transactions](#ACIDTra) describes what ACID transactions are
    and why they're important.
  * [MVCC and Snapshot Isolation](#Snapshot) describes what snapshot
    isolation is and how it works in Splice Machine.
  {: .SecondLevel}

* [Using Transactions](#Using2)
  * [Committing and Rolling Back Transaction Changes](#Committi)
    introduces autocommit, commit, and rollback of transactions.
  * [A Simple Transaction Example](#Simple) presents an example of a
    transaction using the <span
    class="AppCommand">splice&gt;</span> command line interface.
  * [Using Savepoints](#Using) describes how to use savepoints within
    transactions.
  {: .SecondLevel}

## Transactions Overview   {#Transact}

A transaction is a unit of work performed in a database; to maintain the
integrity of the database, each transaction must:

* complete in its entirety or have no effect on the database
* be isolated from other transactions that are running concurrently in
  the database
* produce results that are consistent with existing constraints in the
  database
* write its results to durable storage upon successful completion

### ACID Transactions   {#ACIDTra}

The properties that describe how transactions must maintain integrity
are *A*tomicity, *C*onsistency, *I*solation, and *D*urability.
Transactions adhering to these properties are often referred to as
*ACID* transactions. Here's a summary of ACID transaction properties:

<table summary="Properties of ACID transactions">
    <col />
    <col />
    <thead>
        <tr>
            <th>Property</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><em>Atomicity</em></td>
            <td>Requires that each transaction be atomic, i.e. all-or-nothing: if one part of the transaction fails, the entire transaction fails, and the database state is left unchanged. Splice Machine guarantees atomicity in each and every situation, including power failures, errors, and crashes.</td>
        </tr>
        <tr>
            <td><em>Consistency</em></td>
            <td>Ensures that any transaction will bring the database from one valid state to another. Splice Machine makes sure that any data written to the database must be valid according to all defined rules, including constraints, cascades, triggers, and any combination thereof.</td>
        </tr>
        <tr>
            <td><em>Isolation</em></td>
            <td>Ensures that the concurrent execution of transactions results in a system state that would be obtained if transactions were executed serially. Splice Machine implements snapshot isolation using MVCC to guarantee that this is true.</td>
        </tr>
        <tr>
            <td><em>Durability</em></td>
            <td>Ensures that once a transaction has been committed, it will remain so, even in the event of power loss, crashes, or errors. Splice Machine stores changes in durable storage when they are committed.</td>
        </tr>
    </tbody>
</table>
### MVCC and Snapshot Isolation   {#Snapshot}

Splice Machine employs a lockless *snapshot isolation design* that uses
*Multiple Version Concurrency Control (MVCC)* to create a new version of
the record every time it is updated and enforce consistency. Database
systems use concurrency control systems to manage concurrent access. The
simplest control method is to use locks that make sure that the writer
is finished before any reader can proceed; however, this approach can be
very slow. With snapshot isolation, each transaction has its own virtual
snapshot of the database, which means that multiple transactions can
operate concurrently without creating deadlock conditions.

When Splice Machine needs to update an item in the database, it doesn't
actually overwrite the old data value. Instead, it creates a new version
with a new timestamp. Which means that readers have access to the data
that was available when they began reading, even if that data has been
updated by a writer in the meantime. This is referred to as
*point-in-time consistency* and ensures that:

* Every transaction runs in its own *transactional context*, which
  includes a snapshot of the database from when the transaction began.
* Every read made during a transaction will see a consistent snapshot of
  the database.
* A transaction can only commit its changes if they do not conflict with
  updates that have been committed while the transaction was running.

#### Additional Information About Snapshot Isolation

This web page provides an overview of isolation levels and MVCC. <a href="https://vladmihalcea.com/a-beginners-guide-to-the-phantom-read-anomaly-and-how-it-differs-between-2pl-and-mvcc/" target="_blank">https://vladmihalcea.com/a-beginners-guide-to-the-phantom-read-anomaly-and-how-it-differs-between-2pl-and-mvcc/</a>. Some specifics that apply to Splice Machine:

* Our implementation does not have the Phantom Reads anomaly, when you apply the strict interpretation of that anomaly: in Splice Machine, if you execute the same query twice on the same transaction, you will get the same results.

* Splice Machine does not, however, protect against one form of this anomaly in its broadest interpretation; this has to do with how additions or modifications of rows in a predicate interact between transactions. This is described in the MVCC section of this document.

For additional information about isolation levels in SQL, see this technical paper: <a href="https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/tr-95-51.pdf" target="_blank">https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/tr-95-51.pdf</a>. Of particular interest:

* The diagram and table (Table 4) in the summary section of this paper, which summarize the different isolation levels and which anomalies they allow or disallow. Splice Machine allows: *Write skew* and *a specific type of phantom reads (as noted above), but not phantom reads in general*.

#### Reading and Writing Database Values During a Transaction

When you begin a transaction, you start working within a *transactional
context* that includes a snapshot of the database. The operations that
read and write database values for your transaction modify your
transactional context. When your transaction is complete, you can commit
those modifications to the database.

The commit of your transaction's changes succeeds unless a *write-write conflict* occurs,
which happens when your transaction attempts to commit an update to a value, and
another update to that value has already been committed by a transaction
that started before your transaction.

This means that the following statements are true with regard to reading
values from and writing values to the database during a transaction:

* When you read a value during a transaction, you get the value that was
  most recently set within your transactional context. If you've not
  already set the value within your context, then this is the value that
  had been most recently committed in the database before your
  transaction began (and before your transactional context was
  established).
* When you write a value during a transaction, the value is set within
  your transactional context. It is only written to the database when
  you commit the transaction; that time is referred to as the *commit
  timestamp* for your transaction. The value changes that you commit
  then become visible to transactions that start after your
  transaction's commit timestamp (until another transaction modifies the
  value).
* If two parallel transactions attempt to change the same value, then a
  *write-write conflict* occurs, and the commit of the transaction that
  started later fails.

  When a transaction fails due to a write-write conflict, your application
  must restart the transaction; Splice Machine does not automatically restart such transactions.
  {: .noteIcon}

#### A Snapshot Isolation Example

The following diagram shows an example of snapshot isolation for a set
of transactions, some of which are running in parallel.

In this example, the T3' transaction has to be retried by the user.
{: .noteNote}

![Snapshot Isolation](images/GS.SnapshotIsolation.png){: .indented}

Here's a tabular version of the same transactional timeline, showing the
values committed in the database over time, with added commentary:

<table summary="Snapshot isolation example transactional timeline">
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Time</th>
            <th colspan="3">Committed Values</th>
            <th colspan="4">Transactions<br /></th>
            <th>Comments</th>
        </tr>
        <tr>
            <th> </th>
            <th>A</th>
            <th>B</th>
            <th>C</th>
            <th>T1</th>
            <th>T2</th>
            <th>T3</th>
            <th>T3'</th>
            <th> </th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><em>t1</em></td>
            <td><code>10</code></td>
            <td><code>20</code></td>
            <td><code>0</code></td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td> </td>
        </tr>
        <tr>
            <td><em>t2</em></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td class="BoldBlueBG">T1 Start</td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td>T1 starts. The starting values within its transactional context are: <code>A=10, B=20, C=0</code>.</td>
        </tr>
        <tr>
            <td><em>t3</em></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td class="BoldBlueBG">A=A+10<br />[A=20]</td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td>T1 modifies the value of <code>A</code> within its context.</td>
        </tr>
        <tr>
            <td><em>t4</em></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td class="BoldBlueBG"> </td>
            <td class="BoldRedBG">T2 Start</td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td>T2 starts. The starting values within its transactional context are the same as for T1: <code>A=10, B=20, C=0</code>.</td>
        </tr>
        <tr>
            <td><em>t5</em></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td class="BoldBlueBG">A=A+10<br />[A=30]</td>
            <td class="BoldRedBG"> </td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td>T1 again modifies the value of <code>A</code> within its context</td>
        </tr>
        <tr>
            <td><em>t6</em></td>
            <td><code>30</code></td>
            <td><code>20</code></td>
            <td><code>0</code></td>
            <td class="BoldBlueBG">Commit</td>
            <td class="BoldRedBG"> </td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td>T1 commits its modifications to the database.</td>
        </tr>
        <tr>
            <td><em>t7</em></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td class="BoldBlueBG"> </td>
            <td class="BoldRedBG"> </td>
            <td class="BoldGreenBG">T3 Start</td>
            <td><strong> </strong></td>
            <td>T3 starts. The starting values within its transactional context include the commits from T1: <code>A=30, B=20, C=0</code>.</td>
        </tr>
        <tr>
            <td><em>t8</em></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td class="BoldBlueBG">T1 End</td>
            <td class="BoldRedBG"> </td>
            <td class="BoldGreenBG"> </td>
            <td><strong> </strong></td>
            <td> </td>
        </tr>
        <tr>
            <td><em>t9</em></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><strong> </strong></td>
            <td class="BoldRedBG">B=B+10<br />[B=30]</td>
            <td class="BoldGreenBG"> </td>
            <td><strong> </strong></td>
            <td>T2 modifies the value of <code>B</code> within its context.</td>
        </tr>
        <tr>
            <td><em>t10</em></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><strong> </strong></td>
            <td class="BoldRedBG">C=A+10<br />[C=20]</td>
            <td class="BoldGreenBG"> </td>
            <td><strong> </strong></td>
            <td>T2 modifies the value of <code>C</code> within its context; note that this computation correctly uses the value of <code>A</code> (<code>10</code>) that had been committed prior to the start of T2.</td>
        </tr>
        <tr>
            <td><em>t11</em></td>
            <td><code>30</code></td>
            <td><code>30</code></td>
            <td><code>20</code></td>
            <td><strong> </strong></td>
            <td class="BoldRedBG">Commit</td>
            <td class="BoldGreenBG"> </td>
            <td><strong> </strong></td>
            <td>T2 commits its changes.</td>
        </tr>
        <tr>
            <td><em>t12</em></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><strong> </strong></td>
            <td class="BoldRedBG">T2 End</td>
            <td class="BoldGreenBG"> </td>
            <td><strong> </strong></td>
            <td> </td>
        </tr>
        <tr>
            <td><em>t13</em></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td class="BoldGreenBG">B=B+10<br />[B=30]</td>
            <td><strong> </strong></td>
            <td>T3 modifies <code>B</code>; since its context includes the value of <code>B</code> before T2 committed, it modifies the original value of B <code>[B=20]</code> in its own context.</td>
        </tr>
        <tr>
            <td><em>t14</em></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td class="BoldGreenBG">Rollback</td>
            <td><strong> </strong></td>
            <td>
                <p>T3 attempts to commit its changes, which causes a <em>write-write conflict</em>, since T2 already committed an update to value <code>B</code> after T3 started. </p>
                <p>T3 rolls back and resets.</p>
            </td>
        </tr>
        <tr>
            <td><em>t15</em></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td class="BoldGreenBG">T3 End </td>
            <td><strong> </strong></td>
            <td> </td>
        </tr>
        <tr>
            <td><em>t16</em></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td class="BoldDarkGreenBG">T3' Start</td>
            <td>T3 reset (T3') is restarted by the application; remember that Splice Machine does not automatically restart transactions. The starting values within its transactional context include the commits from T1 and T2: <code>A=30, B=30, C=20</code>.</td>
        </tr>
        <tr>
            <td><em>t17</em></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td class="BoldDarkGreenBG">B=B+10<br />[B=40]</td>
            <td>T3 modifies the value of <code>B</code>, which has been updated and committed by T2.</td>
        </tr>
        <tr>
            <td><em>t18</em></td>
            <td><code>40</code></td>
            <td><code>40</code></td>
            <td><code>20</code></td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td class="BoldDarkGreenBG">Commit</td>
            <td>T3 commits its changes.</td>
        </tr>
        <tr>
            <td><em>t19</em></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><code> </code></td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td><strong> </strong></td>
            <td class="BoldDarkGreenBG">T3' End</td>
            <td> </td>
        </tr>
    </tbody>
</table>

#### The Isolation Guarantee

The Isolation guarantee makes sure that the resulting state of the database is consistent with a serial execution of the transactions that were completed even if they ran concurrently. Note, however, that this does not mean that you'll see the same results from all possible concurrent executions of transactions, even when they all complete successfully. What it does mean is this:

For a given start state *S*, if you run transactions T1, T2, and T3 concurrently, then the state at which you end up, *S'*, will be equivalent to the state generated by __a__ serial execution of those transactions.
{: .notePlain}

Those three transactions can execute in a number of different orders, yielding a different *S'*. For example, consider a starting state *S* in which `row A = 10`, and we'll be running these three transactions:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Transaction ID</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">T1</td>
            <td class="CodeFont">A += 10</td>
        </tr>
        <tr>
            <td class="CodeFont">T2</td>
            <td class="CodeFont">A = A*2</td>
        </tr>
        <tr>
            <td class="CodeFont">T3</td>
            <td class="CodeFont">A += 30</td>
        </tr>
    </tbody>
</table>

When you run these transactions concurrently, the possible resulting states include these:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Transaction Sequence</th>
            <th><em>S'</em> Value</th>
            <th>Comments</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">S + T1 + T3 + T2</td>
            <td class="CodeFont">A = 100</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="CodeFont">S + T3 + T2 + T1</td>
            <td class="CodeFont">A = 90</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="CodeFont">S + T3</td>
            <td class="CodeFont">A = 40</td>
            <td><code>T1</code> and <code>T2</code> were aborted due to Write-Write conflicts</td>
        </tr>
        <tr>
            <td class="CodeFont">S + T1 + T2</td>
            <td class="CodeFont">A = 40</td>
            <td><code>T3</code> was aborted due to Write-Write conflicts</td>
        </tr>
    </tbody>
</table>

As you can see, even when all transactions complete successfully, the end result depends on the order in which the transactions committed. And all of these results meet the Isolation guarantee. Splice Machine will enforce that guarantee by aborting a transaction when it detects a write-write conflict.

The Isolation guarantee would be violated by generating an ending state that *could not be generated by serially running the transactions.* For example, this sequence of actions is not valid because there is no serial sequence that could generate an end result of `A = 20` if all transactions successfully commit.

1. `T1` reads `A = 10`
2. `T2` reads `A = 10`
3. `T3` reads `A = 10`
4. `T3` writes `A = 10 + 30 = 40`
5. `T2` writes `A = 10 * 2 = 20`
6. `T1` writes `A = 10 + 10 = 20`
7. End result is `A = 20`

## Using Transactions   {#Using2}

This section describes using transactions in your database, in these
subsections:

* [Committing and Rolling Back Transaction Changes](#Committi)
  introduces autocommit, commit, and rollback of transactions.
* [A Simple Transaction Example](#Simple) presents an example of a
  transaction using the splice&gt; command line interface.
* [Using Savepoints](#Using) describes how to use savepoints within
  transactions.
* [Using Rollback versus Rollback to Savepoint](#Rollbacks) discusses
  the differences between rolling back a transaction, and rolling back
  to a savepoint.

### Committing and Rolling Back Transaction Changes   {#Committi}

Within a transactional context, how the changes that you make are
committed to the database depends on whether `autocommit` is enabled or
disabled:

<table summary="Using autocommit">
    <col />
    <col />
    <thead>
        <tr>
            <th><span class="CodeBoldFont">autocommit</span> status</th>
            <th>How changes are committed and rolled back</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>enabled</code></td>
            <td>
                <p>Changes are automatically committed whenever the operation completes successfully.</p>
                <p>If an operation reports any error, the changes are automatically rolled back.</p>
            </td>
        </tr>
        <tr>
            <td><code>disabled</code></td>
            <td>
                <p>Changes are only committed when you explicitly issue a <code>commit</code> command.</p>
                <p>Changes are rolled back when you explicitly issue a <code>rollback</code> command.</p>
            </td>
        </tr>
    </tbody>
</table>
Autocommit is enabled by default. You typically disable `autocommit`
when you want a block of operations to be committed atomically (all at
once) instead of committing changes to the database after each
operation.
{: .noteIcon}

You can turn `autocommit` on and off by issuing the `autocommit on` or
`autocommit off` commands at the `splice>` prompt.

For more information, see these topics in the *[Command Line
Reference](cmdlineref_intro.html)* section of this book:

* [`autocommit`](cmdlineref_autocommit.html) command
* [`commit`](cmdlineref_commit.html) command
* [`rollback`](cmdlineref_rollback.html) command

### A Simple Transaction Example   {#Simple}

Here is a simple example. Enter the following commands to see *commit*
and *rollback* in action:

<div class="preWrapperWide" markdown="1">
    splice> create table myTbl (i int);
    splice> autocommit off;                  - commits must be made explicitly
    splice> insert into myTbl  values 1,2,3; - inserted but not visible to others
    splice> commit;                          - now committed to the database
    splice> select * from myTbl;             - verify table contents
    splice> insert into myTbl  values 4,5;   - insert more datasplice> select * from myTbl;             - verify table contents
    splice> rollback;                        - roll back latest insertions
    splice> select * from myTbl;             - and verify again
    ...
{: .AppCommand xml:space="preserve"}

</div>
You can turn `autocommit` back on by issuing the command: <span
class="AppCommand">autocommit on;</span>

### Using Savepoints   {#Using}

Splice Machine supports the JDBC 3.0 Savepoint API, which adds methods
for setting, releasing, and rolling back to savepoints within a
transaction. Savepoints give you additional control over transactions by
allowing you to define logical rollback points within a transaction,
which effectively allows you to specify sub-transactions (also known as
nested transactions).

You can specify multiple savepoints within a transaction. Savepoints are
very useful when processing large transactions: you can implement error
recovery schemes that allow you to rollback part of a transaction
without having to abort the entire transaction.

You can use these commands to work with Savepoints:

* create a savepoint with the `savepoint` command
* release a savepoint with the `release savepoint` command
* roll a transaction back to an earlier savepoint with the `rollback to
  savepoint` command

#### Example

First we'll create a table, turn autocommit off, and insert some data
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
    55 rows selected
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
### Using Rollback Versus Rollback to Savepoint   {#Rollbacks}

There's one important distinction you should be aware of between rolling
back to a savepoint versus rolling back the entire transaction:

* When you perform a `rollback`, Splice Machine aborts the entire
  transaction and creates a new transaction,
* When you perform a `rollback to savepoint`, Splice Machine rolls back
  part of the changes, but does not create a new transaction.

<div class="notePlain" markdown="1">
Remember that this distinction also holds in a multi-tenant environment.
In other words:

* If two users are making modifications to the same table in separate
  transactions, and one user does a `rollback`, all changes made by that
  user prior to that rollback are no longer in the database.
* Similarly, if two users are making modifications to the same table in
  separate transactions, and one user does a `rollback to savepoint`,
  all changes made by that user since the savepoint was established are
  no longer in the database.

</div>
## See Also

* [`autocommit`](cmdlineref_autocommit.html) command
* [`commit`](cmdlineref_commit.html) command
* [`release savepoint`](cmdlineref_releasesavepoint.html) command
* [`rollback`](cmdlineref_rollback.html) command
* [`rollback to savepoint`](cmdlineref_rollbacktosavepoint.html) command
* [`savepoint`](cmdlineref_savepoint.html) command

</div>
</section>
