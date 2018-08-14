---
title: CREATE FUNCTION statement
summary: Creates Java functions that you can then use in expressions.
keywords: creating functions
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_createfunction.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CREATE FUNCTION

The `CREATE FUNCTION` statement allows you to create Java {% if site.build_type != "Doc" %}
or Python {% endif %}functions,
which you can then use in expressions.

For details on how Splice Machine matches functions to Java methods, see
[Argument matching](sqlref_sqlargmatching.html).

## Syntax

<div class="fcnWrapperWide" markdown="1">
    CREATE FUNCTION functionName (
        [  functionParameter ]
        [, functionParameter] ] *
        )
        RETURNS returnDataType [ functionElement ] *
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
functionName
{: .paramName}

<div class="fcnWrapperWide"><pre class="FcnSyntax">
<a href="sqlref_identifiers_intro.html">SQL Identifier</a></pre>

</div>
If `schemaName` is not provided, then the current schema is the default
schema. If a qualified procedure name is specified, the schema name
cannot begin with `SYS`.
{: .paramDefn}

functionParameter
{: .paramName}

<div class="fcnWrapperWide"><pre class="FcnSyntax">
[ parameterName ] <a href="sqlref_datatypes_intro.html">DataType</a></pre>

</div>
`parameterName` is an identifier that must be unique within the
function's parameter names.
{: .paramDefnFirst}

Data-types such as `BLOB, CLOB, LONG VARCHAR` are not allowed as
parameters in a `CREATE FUNCTION` statement.
{: .noteNote}

returnDataType
{: .paramName}

<div class="fcnWrapperWide"><pre class="FcnSyntax">
<a href="sqlref_datatypes_intro.html">DataType</a> |
<a href="sqlref_statements_createfunction.html#TableType">TableType</a></pre>

</div>
functionElement
{: .paramName}

See the description of [Function Elements](#FunctionElements) in the
next section.
{: .paramDefnFirst}

</div>
## TableType   {#TableType}

<div class="fcnWrapperWide" markdown="1">
    TABLE( ColumnElement [,ColumnElement]* )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
ColumnElement
{: .paramName}

A *[SQL Identifier](sqlref_identifiers_intro.html)*.
{: .paramDefnFirst}

</div>
Table functions return `TableType` results. Currently, only Splice
Machine-style table functions are supported, which are functions that
return JDBC *ResultSets.*
{% if site.build_type != "Doc" %}
You cannot currently write table functions in Python.
{: .noteIcon}
{% endif %}

When values are extracted from a *ResultSet*, the data types of the
values are coerced to match the data types declared in the
`CREATE FUNCTION `statement. Here are a few coercion rules you should
know about:

* values that are too long are truncated to the maximum declared length
* if a string value is returned in the *ResultSet* for a column of type
  `CHAR`, and the string is shorter than the column length, the string
  is padded with spaces

## Function Elements   {#FunctionElements}

<div class="fcnWrapperWide" markdown="1">
     {
{% if site.build_type != "Doc" %}        LANGUAGE { JAVA | PYTHON }
      | { EXTERNAL NAME javaMethodName | AS ' pythonScript ' }{% else %}        LANGUAGE { JAVA }
      | EXTERNAL NAME javaMethodName{% endif %}
      | DeterministicCharacteristic
      | PARAMETER STYLE parameterStyle
      | sqlStatementType
      | nullInputAction
    }
{: .FcnSyntax xml:space="preserve"}

</div>
The function elements may appear in any order, but each type of element
can only appear once.

These function elements are required:

* *LANGUAGE*
* *EXTERNAL NAME*
* *PARAMETER STYLE*

<div class="paramList" markdown="1">
LANGUAGE
{: .paramName}

Specify the language in which your function is written; this must be `JAVA`{% if site.build_type != "Doc" %}
 or `PYTHON`{% endif %}.
{: .paramDefnFirst}

DeterministicCharacteristic
{: .paramName}

<div class="fcnWrapperWide" markdown="1">
    DETERMINISTIC | NOT DETERMINISTIC
{: .FcnSyntax}

</div>
The default value is `NOT DETERMINISTIC`.
{: .paramDefnFirst}

Specifying `DETERMINISTIC` indicates that the function always returns
the same result, given the same input values. This allows Splice Machine
to call the function with greater efficiency; however, specifying this
for a function that is actually non-deterministic will have the opposite
effect -- efficiency of calls to the function will be reduced.
{: .paramDefn}

javaMethodName
{: .paramName}

<div class="fcnWrapperWide" markdown="1">
    class_name.method_name
{: .FcnSyntax}

</div>
This is the name of the Java method to call when this function executes.
{: .paramDefnFirst}

{% if site.build_type != "Doc" %}pythonScript
{: .paramName}

<div class="fcnWrapperWide"><pre class="FcnSyntax">def run(<em>scriptArgs</em>): <em>scriptCode</em></pre>
</div>
This is the Python script, enclosed in single quotes (`'`). Here are a few important notes about Python scripts in functions, which are described more fully in the [Using
Functions and Stored Procedures](developers_fcnsandprocs_intro.html)
section of our *Developer's Guide*:
{: .paramDefnFirst}

* The entire script must be enclosed in single quotes.
* Use double quotes (`"`) around strings within the script; if you must use a single quote within the script, specify it as two single quotes (`''`).
* Use spaces instead of tabs within your scripts; the command line processor will convert tabs to a single space in your script, *even within a string.*
* Write the script under the `run` function.
* The arguments you specify for your script in the `CREATE FUNCTION` statement should match the order specified in your method definition.
{: .nested}
{% endif %}

parameterStyle
{: .paramName}

<div class="fcnWrapperWide" markdown="1">
    JAVA | DERBY_JDBC_RESULT_SET
{: .FcnSyntax}

</div>
Only use `DERBY_JDBC_RESULT_SET` if this is a Splice Machine-style table
function that returns a [TableType](#TableType) result, and is mapped to
a Java method that returns a JDBC *ResultSet*.
{: .paramDefnFirst}

Otherwise, use `JAVA`-style parameters, which means that a
parameter-passing convention is used that conforms to the Java language
and SQL Routines specification. `INOUT` and `OUT` parameters are passed
as single entry arrays to facilitate returning values. Result sets can
be returned through additional parameters to the Java method of type
`java.sql.ResultSet[]` that are passed single entry arrays.
{: .paramDefn}

Splice Machine does not support long column types such as
`LONG VARCHAR`or `BLOB`; an error will occur if you try to use one of
these long column types.
{: .paramDefn}

sqlStatementType
{: .paramName}

<div class="paramListNested" markdown="1">
CONTAINS SQL
{: .paramName}

Indicates that SQL statements that neither read nor modify SQL data can
be executed by the function. Statements that are not supported in any
function return a different error.
{: .paramDefnFirst}

NO SQL
{: .paramName}

Indicates that the function cannot execute any SQL statements
{: .paramDefnFirst}

READS SQL DATA
{: .paramName}

Indicates that some SQL statements that do not modify SQL data can be
included in the function. Statements that are not supported in any
stored function return a different error. This is the default value.
{: .paramDefnFirst}

</div>
nullInputAction
{: .paramName}

<div class="paramListNested" markdown="1">
RETURNS NULL ON NULL INPUT
{: .paramName}

If any input argument is null, the function is not invoked, and the
result is null.
{: .paramDefnFirst}

CALLED ON NULL INPUT
{: .paramName}

This is the default value.
{: .paramDefnFirst}

The function is invoked even if all input arguments are null, which
means that the invoked function must test for null argument values.The
result may be null or not null.
{: .paramDefn}

</div>
</div>
## Example of declaring a scalar function {% if site.build_type != "Doc" %}(JAVA or Python){% endif %}

For more complete examples of using `CREATE FUNCTION`, please see the
[Using Functions and Stored
Procedures](developers_fcnsandprocs_intro.html) section of our
*Developer's Guide*.

### JAVA Example

<div class="preWrapper" markdown="1">
    splice> CREATE FUNCTION TO_DEGREES( RADIANS DOUBLE )
      RETURNS DOUBLE
      PARAMETER STYLE JAVA
      NO SQL LANGUAGE JAVA
      EXTERNAL NAME 'java.lang.Math.toDegrees';

    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>

{% if site.build_type != "Doc" %}
### Python Example

<div class="preWrapper" markdown="1">
    splice> CREATE FUNCTION SPLICE.PYSAMPLE_FUNC( a VARCHAR(50) )
      RETURNS VARCHAR(50)
      PARAMETER STYLE JAVA
      READS SQL DATA
      SQL LANGUAGE PYTHON
      AS ' def run(inputStr):
            import re
            result = inputStr.strip().split(",")[0]
            return result ';
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}
</div>

You can now use this function as follows:
<div class="preWrapper" markdown="1">
    splice> VALUES SPLICE.PYSAMPLE_FUNC('Splice,Machine');

    1
    -----------------------------------------------------
    Splice
{: .Example xml:space="preserve"}
</div>

{% endif %}

## Example of declaring a table function {% if site.build_type != "Doc" %}(JAVA only){% endif %}

This example reads data from a mySql database and inserts it into a
Splice Machine database.
{: .body}
{% if site.build_type != "Doc" %}
You cannot currently write table functions in Python.
{: .noteIcon}
{% endif %}

We first implement a class that contains a public static method that
connects to an external (foreign) database, uses a prepared statement to
pull results from it, and returns those results as a JDBC `ResultSet`:

<div class="preWrapperWide" markdown="1">
    package splicemachine.example.vti;
    import java.sql.*;
    public class EmployeeTable{
        public static ResultSet read()  throws SQLException {
            Connection conn DriverManager.getConnection(
                    "jdbc:mysql://localhost/hr?user=myName&password=myPswd" );
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT * FROM hrSchema.EmployeeTable" );
            return ps.executeQuery();
        }
    }
{: .Example}

</div>
Next we use the &nbsp;[`CREATE FUNCTION`](#) .statement to declare a table
function to read data from our external database and insert it into our
Splice Machine database:

<div class="preWrapperWide" markdown="1">
    CREATE FUNCTION externalEmployees()
       RETURNS TABLE
         (
          employeeId    INT,
          lastName      VARCHAR( 50 ),
          firstName     VARCHAR( 50 ),
          birthday      DATE
         )
       LANGUAGE JAVA
       PARAMETER STYLE SPLICE_JDBC_RESULT_SET   READS SQL DATA   EXTERNAL NAME 'com.splicemachine.example.vti.readEmployees';
{: .Example}

</div>
Now we're ready to invoke our table function to read data from the
external database and insert it into a table in our Splice Machine
database.

To invoke a table function, you must wrap it in a `TABLE` constructor in
the `FROM` list of a query. For example, we could insert employee data
from that database into a table named `employees` in our Splice Machine
database:

<div class="preWrapperWide" markdown="1">
    INSERT INTO employees
      SELECT myExtTbl.*
        FROM TABLE (externalEmployees() ) myExtTbl;
{: .Example}

</div>
You **MUST** specify the table alias when using a virtual table; for
example, `myExtTbl` in the above example.
{: .noteNote}

## See Also

* [`CREATE_PROCEDURE`](sqlref_statements_createprocedure.html) statement
* [`CURRENT_USER`](sqlref_builtinfcns_currentuser.html) function
* [Data Types](sqlref_datatypes_numerictypes.html)
* [`DROP FUNCTION`](sqlref_statements_dropfunction.html) statement
* [Schema Name](sqlref_identifiers_types.html#SchemaName)
* [SQL Identifier](sqlref_identifiers_intro.html)
* [`SESSION_USER`](sqlref_builtinfcns_sessionuser.html) function
* [`USER`](sqlref_builtinfcns_user.html) function

</div>
</section>
