---
title: Prepare command
summary: Creates a prepared statement for use by other commands.
keywords: prepared statement
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_prepare.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Prepare Command

The <span class="AppCommand">prepare</span> command creates a
`java.sql.PreparedStatement` using the value of the specified
SQL command *String*, and assigns an identifier to the prepared
statement so that other <span
class="AppCommand">splice&gt;</span> commands can use the statement.

If a prepared statement with the specified *Identifier* name already
exists in the command interpreter, an error is returned, and the
previous prepared statement is left unchanged. If there are any errors
in preparing the statement, no prepared statement is created.

If the *Identifier* specifies a connection Name, the statement is
prepared on the specified connection.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    PREPARE Identifier AS String
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
Identifier
{: .paramName}

The identifier to assign to the prepared statement.
{: .paramDefnFirst}

String
{: .paramName}

The command string to prepare.
{: .paramDefnFirst}

</div>
## Examples

<div class="preWrapperWide" markdown="1">
    splice> prepare seeMenu as 'SELECT * FROM menu';
    splice> execute seeMenu;
    COURSE    |ITEM                |PRICE
    -----------------------------------------------
    entree    |lamb chop           |14
    dessert   |creme brulee        |6
    
    splice> prepare addYears as 'update children set age = age + ? where name = ?';
    splice> execute addYears using 'values (10, ''Abigail'')';
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>

