---
title: Show Tables command
summary: Displays all of the tables in a database or schema.
keywords: table, show commands
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_showtables.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Show Tables

The <span class="AppCommand">show tables</span> command displays all of
the tables in the current or specified schema.

<div class="paramList" markdown="1">
schemaName
{: .paramName}

If you supply a schema name, only the tables in that schema are
displayed; otherwise, the tables in the current schema are displayed.
{: .paramDefnFirst}

</div>
### Syntax

<div class="fcnWrapperWide" markdown="1">
    SHOW TABLES [ IN schemaName ] 
{: .FcnSyntax xml:space="preserve"}

</div>
### Results

The `show tables` command results contains the following columns:

<table summary="Listing of columns displayed by the Show Tables command.">
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
    splice> show tables;
    TABLE_SCHEM  |TABLE_NAME         |CONGLOM_ID|REMARKS
    ------------------------------------------------------
    SYS          |SYSALIASES         |352       |
    SYS          |SYSBACKUP          |1040      |
    SYS          |SYSBACKUPFILESET   |1056      |
    SYS          |SYSBACKUPITEMS     |1136      |
    SYS          |SYSBACKUPJOBS      |1200      |
    SYS          |SYSCHECKS          |368       |
    SYS          |SYSCOLPERMS        |704       |
    SYS          |SYSCOLUMNS         |64        |
    SYS          |SYSCOLUMNSTATS     |1216      |
    SYS          |SYSCONGLOMERATES   |80        |
    SYS          |SYSCONSTRAINTS     |320       |
    SYS          |SYSDEPENDS         |240       |
    SYS          |SYSFILES           |256       |
    SYS          |SYSFOREIGNKEYS     |288       |
    SYS          |SYSKEYS            |272       |
    SYS          |SYSPERMS           |784       |
    SYS          |SYSPHYSICALSTATS   |1232      |
    SYS          |SYSPRIMARYKEYS     |384       |
    SYS          |SYSROLES           |736       |
    SYS          |SYSROUTINEPERMS    |720       |
    SYS          |SYSSCHEMAPERMS     |1392      |
    SYS          |SYSSCHEMAS         |32        |
    SYS          |SYSSEQUENCES       |752       |
    SYS          |SYSSTATEMENTS      |304       |
    SYS          |SYSTABLEPERMS      |688       |
    SYS          |SYSTABLES          |48        |
    SYS          |SYSTABLESTATS      |1248      |
    SYS          |SYSTRIGGERS        |656       |
    SYS          |SYSUSERS           |816       |
    SYS          |SYSVIEWS           |336       |
    SYSIBM       |SYSDUMMY1          |1344      |
    SPLICE       |MYTABLE            |1536      |
    
    32 rows selected
    
    splice>show tables in SPLICE;
    TABLE_SCHEM  |TABLE_NAME         |CONGLOM_ID|REMARKS
    -----------------------------------------------------
    SPLICE       |MYTABLE            |1536      |
    
    1 row selected
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>

