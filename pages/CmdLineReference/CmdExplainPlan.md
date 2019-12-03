---
title: Explain Plan command
summary: Displays the execution plan for an SQL statement.
keywords: execution plan, performance tuning
toc: false
product: all
sidebar: home_sidebar
permalink: cmdlineref_explainplan.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Explain Plan Command

The <span class="AppCommand">explain</span> command displays the
execution plan for a statement without actually executing the statement;
it parses and optimizes the SQL, then presents its execution plan.

You can use this to tune a query for improved performance.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    explain Statement
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
*Statement*
{: .paramName}

An SQL statement.
{: .paramDefnFirst}

</div>
## Usage

SQL Data Definition Language (DDL) statement have no known cost, and
thus do not require optimization. Because of this, the `explain` command
does not work with DDL statements; attempting to `explain` a DDL
statement such as `CREATE TABLE` will generate a syntax error.

For more information about using the explain command, including a number
of annotated examples, see [Explain
Plan](bestpractices_optimizer_explain.html).

## Examples

<div class="preWrapperWide" markdown="1">
    splice> explain select * from t t1 where t1.i < (select max(i) from t t1);
{: .AppCommand xml:space="preserve"}

</div>
The [Explain Plan](bestpractices_optimizer_explain.html) topic contains a
number of examples that are described in detail.

</div>
</section>
