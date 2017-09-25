---
title: Execute command
summary: Executes an SQL&#160;prepared statement or SQL&#160;command string.
keywords: prepared statement, command string
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_execute.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Execute Command

The <span class="AppCommand">execute</span> command executes an
SQL command string or a prepared statement.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    EXECUTE { SQLString | PreparedStatementIdentifier }
    [ USING { String | Identifier } ]
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
SQLString
{: .paramName}

The SQL command string to execute; this string is passed to the
connection without further processing by the command line interpreter.
{: .paramDefnFirst}

PreparedStatementIdentifier
{: .paramName}

The identifier of the prepared statement to execute; this must be the
name associated with a prepared statement when created by the
[Prepare](cmdlineref_prepare.html) command.
{: .paramDefnFirst}

String
{: .paramName}

Use this or *Identifier* to supply values for dynamic parameters, if the
command being executed contains them.
{: .paramDefnFirst}

Identifier
{: .paramName}

Use this or *String* to supply values for dynamic parameters, if the
command being executed contains them. This identifier must have a result
set as its result:
{: .paramDefnFirst}

* Each row of the result set is applied to the input parameters of the
  command to be executed, so the number of columns in the `Using`
  clause's result set must match the number of input parameters in the
  statement being executed.
* The command line interpreter displays the results of each execution of
  the statement as they are created.
* If the Using clause's result set contains zero rows, the statement is
  not executed.

</div>
## Examples

<div class="preWrapperWide" markdown="1">
    splice> autocommit off;
    splice> prepare menuInsert as 'INSERT INTO menu VALUES (?, ?, ?)';
    splice> execute menuInsert using 'VALUES
    (''entree'', ''lamb chop'', 14),
    (''dessert'', ''creme brulee'', 6)';
    1 row inserted/updated/deleted
    1 row inserted/updated/deleted
    splice> commit;
    splice> connect 'jdbc:splice://abc:1527/splicedb;user=me;password=mypswd';
    splice> create table firsttable (id int primary key,
    name varchar(12));
    0 rows inserted/updated/deleted
    splice> insert into firsttable values
    10,'TEN'),(20,'TWENTY'),(30,'THIRTY');
    3 rows inserted/updated/deleted
    splice> select * from firsttable;
    ID         |NAME
    ------------------------
    10         |TEN
    20         |TWENTY
    30         |THIRTY
    
    3 rows selected
    splice> connect 'jdbc:splice://xyz:1527/splicedb';
    splice(CONNECTION1)> create table newtable (newid int primary key,
    newname varchar(12));
    0 rows inserted/updated/deleted
    splice(CONNECTION1)> prepare src@connection0 as 'select * from firsttable';
    splice(CONNECTION1)> autocommit off;
    splice(CONNECTION1)> execute 'insert into newtable(newid, newname)
    values(?,?)' using src@connection0;
    1 row inserted/updated/deleted
    1 row inserted/updated/deleted
    1 row inserted/updated/deleted
    splice(CONNECTION1)> commit;
    splice(CONNECTION1)> select * from newtable;
    NEWID      |NEWNAME
    ------------------------
    10         |TEN
    20         |TWENTY
    30         |THIRTY
    
    3 rows selected
    splice(CONNECTION1)> show connections;
    CONNECTION0 -   jdbc:splice://abc:1527/splicedb
    CONNECTION1* -  jdbc:splice://xyz:1527/splicedb
    splice(CONNECTION1)> disconnect connection0;
    splice> 
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>

