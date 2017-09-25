---
title: Autocommit command
summary: Turns the connection's auto-commit mode on or off.
keywords: autocommit, transactions, auto-commit
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_autocommit.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Autocommit Command

The <span class="AppCommand">autocommit</span> command enables or
disables auto-commit mode.

JDBC specifies that the default auto-commit mode is enabled; however,
certain types of processing require that auto-commit mode be disabled.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    AUTOCOMMIT {ON | OFF}
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
ON
{: .paramName}

Enables auto-commit mode.
{: .paramDefnFirst}

If auto-commit mode is changed from disabled (`off`) to enabled
(`on`) when there is a transaction outstanding, that work is committed
when the current transaction commits, not at the time auto-commit is
enabled. Thus, if you are enabling auto-commit when a transaction is
outstanding, first use either the [Rollback](cmdlineref_rollback.html)
command to ensure that all prior work is completed before the return to
auto-commit mode.
{: .paramDefn}

OFF
{: name="paramName" .paramName}

Disables auto-commit mode.
{: .paramDefnFirst}

</div>
## Examples

<div class="preWrapperWide" markdown="1">
    splice> autocommit off;
    splice> DROP TABLE menu;
    0 rows inserted/updated/deleted
    splice> CREATE TABLE menu (course CHAR(10), item CHAR(20), price INT);
    0 rows inserted/updated/deleted
    splice> INSERT INTO menu VALUES ('entree', 'lamb chop', 14),
    ('dessert', 'creme brulee', 6),
    ('appetizer', 'baby greens', 7);
    3 rows inserted/updated/deleted
    splice> commit;
    splice> autocommit on;
    splice>
{: .AppCommand}

</div>
</div>
</section>

