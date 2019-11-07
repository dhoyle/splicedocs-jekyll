---
title: Show Aliases command
summary: Displays information about the aliases that have been created in a database or schema.
keywords: alias, show commands
toc: false
product: all
sidebar: home_sidebar
permalink: cmdlineref_showaliases.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Show Aliases

The <span class="AppCommand">show aliases</span> command displays all
of the aliases that have been created in the database or specified schema with the [`CREATE ALIAS`](sqlref_statements_createalias.html) or [`CREATE SYNONYM`](sqlref_statements_createsynonym.html) statements.

<p class="noteIcon">Aliases and synonyms are exactly the same and can be used interchangeably.</p>

### Syntax

<div class="fcnWrapperWide" markdown="1">
    SHOW ALIASES [ IN schemaName ]
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

If you supply a schema name, only the synonyms/aliases in that schema are
displayed; otherwise, all synonyms/aliases in the database are displayed.
{: .paramDefnFirst}

</div>
### Results

The `show aliases` command results contains the following columns:

<table summary="List of columns in the output of the show aliases command.">
    <col />
    <col />
    <thead>
        <tr>
            <th>Column Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>TABLE_SCHEMA</code></td>
            <td>The name of the alias/synonym's schema</td>
        </tr>
        <tr>
            <td><code>TABLE_NAME</code></td>
            <td>The name of the table</td>
        </tr>
        <tr>
            <td><code>CONGLOM_ID</code></td>
            <td>The conglomerate number, which points to the corresponding table in HBase</td>
        </tr>
        <tr>
            <td><code>REMARKS</code></td>
            <td>Any remarks associated with the table</td>
        </tr>
    </tbody>
</table>

### Examples

<div class="preWrapperWide" markdown="1">
    splice> show aliases;
    TABLE_SCHEM  |TABLE_NAME         |CONGLOM_ID|REMARKS
    ---------------------------------------------------------------
    SPLICE       |HITTING            |NULL      |

    1 rows selected
{: .AppCommand xml:space="preserve"}

</div>

## See Also

* [`CREATE ALIAS`](sqlref_statements_createalias.html) statement
* [`CREATE SYNONYM`](sqlref_statements_createsynonym.html) statement
* [`DROP ALIAS`](sqlref_statements_dropalias.html) statement
* [`DROP SYNONYM`](sqlref_statements_dropsynonym.html) statement
* [`SHOW SYNONYMS`](cmdlineref_showsynonyms.html) command

</div>
</section>
