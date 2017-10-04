---
title: Call (Procedure) statement
summary: Calls a stored procedure.
keywords: call procedure
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_callprocedure.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CALL (Procedure)

The `CALL (PROCEDURE)` statement is used to call stored procedures.

When you call a stored procedure, the default schema and role are the
same as were in effect when the procedure was created.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    
    CALL procedure-Name (
            [ expression [, expression]* ]
    )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
procedure-Name
{: .paramName}

The name of the procedure that you are calling.
{: .paramDefnFirst}

expression(s)
{: .paramName}

Arguments passed to the procedure.
{: .paramDefnFirst}

</div>
## Example

The following example depends on a fictionalized java class. For
functional examples of using `CREATE PROCEDURE`, please see the [Using
Functions and Stored Procedures](developers_fcnsandprocs_intro.html)
section in our *Developer's Guide*.

<div class="preWrapper" markdown="1">
    splice> CREATE PROCEDURE SALES.TOTAL_REVENUE(IN S_MONTH INTEGER,
        IN S_YEAR INTEGER, OUT TOTAL DECIMAL(10,2))
        PARAMETER STYLE JAVA
          READS SQL DATA LANGUAGE JAVA EXTERNAL NAME
           'com.example.sales.calculateRevenueByMonth';
    splice> CALL SALES.TOTAL_REVENUE(?,?,?);
{: .Example xml:space="preserve"}

</div>
## See Also

* [`CREATE PROCEDURE`](sqlref_statements_createprocedure.html) statement

</div>
</section>

