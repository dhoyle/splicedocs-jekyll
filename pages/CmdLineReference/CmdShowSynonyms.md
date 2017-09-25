---
title: Show Synonyms command
summary: Displays information about the synonyms that have been created in a database or schema.
keywords: synonym, show commands
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_showsynonyms.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Show Synonyms

The <span class="AppCommand">show synonyms</span> command displays all
of the synonyms that have been created with the
[`CREATE SYNONYM`](sqlref_statements_createsynonym.html) statement in
the database or specified schema.

### Syntax

<div class="fcnWrapperWide" markdown="1">
    SHOW SYNONYMS [ IN schemaName ] 
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

If you supply a schema name, only the synonyms in that schema are
displayed; otherwise, all synonyms in the database are displayed.
{: .paramDefnFirst}

</div>
### Results

The `show synonyms` command results contains the following columns:

<table summary="List of columns in the output of the show synonyms command.">
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
                        <td>The name of the synonym's schema</td>
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
    splice> show synonyms;
    TABLE_SCHEM  |TABLE_NAME         |CONGLOM_ID|REMARKS
    ---------------------------------------------------------------
    SPLICE       |HITTING            |NULL      |
    
    1 rows selected 
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>

