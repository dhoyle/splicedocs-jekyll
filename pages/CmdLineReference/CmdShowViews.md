---
title: Show Views command
summary: Displays information about all of the views in a schema.
keywords: view,, show commands
toc: false
product: all
sidebar: home_sidebar
permalink: cmdlineref_showviews.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Show Views

The <span class="AppCommand">show views</span> command displays all of
the views in the current or specified schema.

### Syntax

<div class="fcnWrapperWide" markdown="1">
    SHOW VIEWS [ IN schemaName ] 
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

If you supply a schema name, only the views in that schema are
displayed; otherwise, the views in the current schema are displayed.
{: .paramDefnFirst}

</div>
### Results

The <span class="AppCommand">show views</span> command results contains
the following columns:

<table summary="Listing of columns displayed by the show views command.">
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
                        <td>The name of the table's schema</td>
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
    splice> show views;
    TABLE_SCHEM  |TABLE_NAME         |CONGLOM_ID|REMARKS
    ---------------------------------------------------------------
    SPLICE       |GUITAR_BRANDS      |4321      |
    0 rows selected 
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>

