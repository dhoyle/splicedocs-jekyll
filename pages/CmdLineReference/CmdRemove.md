---
title: Remove command
summary: Removes a previously prepared statement.
keywords: prepared statements
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_remove.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Remove Command

The <span class="AppCommand">remove</span> command removes a previously
prepared statement from the command line interpreter.

The statement is closed, releasing its database resources.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    REMOVE Identifier
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
Identifier
{: .paramName}

The name assigned to the prepared statement when it was prepared with
the [Prepare](cmdlineref_prepare.html) statement.
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
    
    2 rows selected
    splice> remove seeMenu;
    splice> execute seeMenu;
    splice ERROR: Unable to establish prepared statement SEEMENU
    splice>
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>

