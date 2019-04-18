---
title: Rollback command
summary: Rolls back the currently active transaction and initiates a new transaction.
keywords: rolling back, transactions
toc: false
product: all
sidebar: home_sidebar
permalink: cmdlineref_rollback.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Rollback Command

The <span class="AppCommand">rollback</span> command issues a
`java.sql.Connection.rollback` request, which rolls back (undoes) the
currently active transaction and initiates a new transaction.

You should only use this command when auto-commit mode is disabled.
{: .noteNote}

## Usage Notes

In contrast to the &nbsp;[`Rollback to
Savepoint`](cmdlineref_rollbacktosavepoint.html) command, the `Rollback`
command aborts the current transaction and starts a new one.
{: .body}

## Examples

<div class="preWrapperWide" markdown="1">
    splice> autocommit off;
    splice> INSERT INTO menu VALUES ('dessert', 'rhubarb pie', 4);
    1 row inserted/updated/deleted
    splice> SELECT * from menu;
    COURSE    |ITEM                |PRICE
    -----------------------------------------------
    entree    |lamb chop           |14
    dessert   |creme brulee        |7
    appetizer |baby greens         |7
    dessert   |rhubarb pie         |4
    
    4 rows selected
    splice> rollback;
    splice> SELECT * FROM menu;
    COURSE    |ITEM                |PRICE
    -----------------------------------------------
    entree    |lamb chop           |14
    dessert   |creme brulee        |7
    appetizer |baby greens         |7
    
    3 rows selected
    splice>
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>

