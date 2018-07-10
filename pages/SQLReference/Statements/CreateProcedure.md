---
title: CREATE PROCEDURE statement
summary: Creates Java stored procedures, which you can then call using the CallProcedure statement.
keywords: creating a procedure
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_createprocedure.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CREATE PROCEDURE

The `CREATE PROCEDURE` statement allows you to create Java procedures,
which you can then call using the `CALL PROCEDURE` statement.

For details on how Splice Machine matches procedures to Java methods,
see [Argument matching](sqlref_sqlargmatching.html).

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
CREATE PROCEDURE procedureName (
     [ procedureParameter
     [, procedureParameter] ] *
    )
     [ <a href="sqlref_statements_createprocedure.html#FunctionElements">ProcedureElement</a> ] *</pre>

</div>
<div class="paramList" markdown="1">
procedureName
{: .paramName}

<div class="fcnWrapperWide"><pre class="FcnSyntax">
[ <a href="sqlref_identifiers_intro.html">SQL Identifier</a> ]</pre>

</div>
If `schemaName` is not provided, then the current schema is the default
schema. If a qualified procedure name is specified, the schema name
cannot begin with `SYS`.
{: .paramDefn}

procedureParameter
{: .paramName}

<div class="fcnWrapperWide"><pre class="FcnSyntax">
[ { IN | OUT | INOUT } ] [ parameterName ] <a href="sqlref_datatypes_intro.html">DataType</a></pre>

</div>
`parameterName` is an identifier that must be unique within the
procedure's parameter names.
{: .paramDefnFirst}

By default, parameters are `IN` parameters unless you specify otherwise.
{: .paramDefn}

Data-types such as `BLOB, CLOB, LONG VARCHAR` are not allowed as
parameters in a `CREATE PROCEDURE` statement.
{: .paramDefn}

Also: At this time, Splice Machine will return only one `ResultSet` from
a stored procedure.
{: .noteNote}

procedureElement
{: .paramName}

See the description of [procedure Elements](#FunctionElements) in the
next section.
{: .paramDefnFirst}

</div>
## Procedure Elements   {#FunctionElements}

<div class="fcnWrapperWide" markdown="1">
     {
        LANGUAGE { JAVA }
      | DeterministicCharacteristic
      | EXTERNAL NAME javaMethodName
      | PARAMETER STYLE parameterStyle
      | DYNAMIC RESULT SETS integer
      | sqlStatementType
    }
{: .FcnSyntax xml:space="preserve"}

</div>
The procedure elements may appear in any order, but each type of element
can only appear once. These procedure elements are required:

*  *LANGUAGE*
* *EXTERNAL NAME*
* *PARAMETER STYLE*

<div class="paramList" markdown="1">
LANGUAGE
{: .paramName}

Only `JAVA` is accepted at this time. Splice Machine will call the
procedure as a public static method in a Java class.
{: .paramDefnFirst}

DeterministicCharacteristic
{: .paramName}

<div class="fcnWrapperWide" markdown="1">
    DETERMINISTIC | NOT DETERMINISTIC
{: .FcnSyntax}

</div>
The default value is `NOT DETERMINISTIC`.
{: .paramDefnFirst}

Specifying `DETERMINISTIC` indicates that the procedure always returns
the same result, given the same input values. This allows Splice Machine
to call the procedure with greater efficiency; however, specifying this
for a procedure that is actually non-deterministic will have the
opposite effect -- efficiency of calls to the procedure will be reduced.
{: .paramDefn}

javaMethodName
{: .paramName}

<div class="fcnWrapperWide" markdown="1">
    class_name.method_name
{: .FcnSyntax}

</div>
This is the name of the Java method to call when this procedure
executes.
{: .paramDefnFirst}

parameterStyle
{: .paramName}

<div class="fcnWrapperWide" markdown="1">
    JAVA
{: .FcnSyntax}

</div>
Stored procedures use a parameter-passing convention is used that
conforms to the Java language and SQL Routines specification. `INOUT`
and `OUT` parameters are passed as single entry arrays to facilitate
returning values. Result sets can be returned through additional
parameters to the Java method of type `java.sql.ResultSet[]` that are
passed single entry arrays.
{: .paramDefn}

Splice Machine does not support long column types such as
`LONG VARCHAR`or `BLOB`; an error will occur if you try to use one of
these long column types.
{: .paramDefn}

DYNAMIC RESULT SETS integer
{: .paramName}

Specifies the number of dynamic result sets produced by the procedure.
{: .paramDefnFirst}

Currently, Splice Machine only supports `0` or `1` dynamic result sets.
{: .paramDefn}

sqlStatementType
{: .paramName}

<div class="paramList" markdown="1">
CONTAINS SQL
{: .paramName}

Indicates that SQL statements that neither read nor modify SQL data can
be executed by the procedure.
{: .paramDefnFirst}

NO SQL
{: .paramName}

Indicates that the procedure cannot execute any SQL statements
{: .paramDefnFirst}

READS SQL DATA
{: .paramName}

Indicates that some SQL statements that do not modify SQL data can be
included in the procedure. This is the default value.
{: .paramDefnFirst}

MODIFIES SQL DATA
{: .paramName}

Indicates that the procedure can execute any SQL statement.
{: .paramDefnFirst}

</div>
</div>
## Example

The following example depends on a fictionalized java class. For
functional examples of using `CREATE PROCEDURE`, please see the [Using
Functions and Stored Procedures](developers_fcnsandprocs_intro.html)
section of our *Developer's Guide*.

<div class="preWrapper" markdown="1">
    splice> CREATE PROCEDURE SALES.TOTAL_REVENUE (
        IN S_MONTH INTEGER,
        IN S_YEAR INTEGER, OUT TOTAL DECIMAL(10,2))
        PARAMETER STYLE JAVA
        DYNAMIC RESULT SETS 1
        READS SQL DATA LANGUAGE
        JAVA EXTERNAL NAME 'com.example.sales.calculateRevenueByMonth';
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [Writing Functions and Stored Procedures](developers_fcnsandprocs_writing.html)
* [Argument matching](sqlref_sqlargmatching.html)
* [`CREATE_FUNCTION`](sqlref_statements_createfunction.html) statement
* [`CURRENT_USER`](sqlref_builtinfcns_currentuser.html) function
* [Data Types](sqlref_datatypes_numerictypes.html)
* [Schema Name](sqlref_identifiers_types.html#SchemaName)
* [SQL Identifier](sqlref_identifiers_intro.html)
* [`SESSION_USER`](sqlref_builtinfcns_sessionuser.html) function
* [`USER`](sqlref_builtinfcns_user.html) function

</div>
</section>
