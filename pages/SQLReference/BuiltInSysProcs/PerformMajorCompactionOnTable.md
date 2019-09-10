---
title: SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE built-in system procedure
summary: Built-in system procedure that performs a major compaction on a table.
keywords: major compaction, table compaction, compacting a table, perform_major_compaction
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_compacttable.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE

The `SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE` system
procedure performs a major compaction on a table. The compaction is
performed on the table and on all of its index and constraint tables.

A *major compaction* actually reads every block of data from the every store file in a Region, and rewrites only the live data to a single store file. This permanently deletes the rows that were previously marked as deleted. HBase runs major compactions on a scheduled interval, which is specified in the `hbase.hregion.majorcompaction` property; the default value for this property in Splice Machine is 7 days.

Splice Machine recommends running a major compaction on a table after you've imported a large dataset into the table or deleted a large number of rows from the table in your database.

For more information about compactions, see [Best Practices: Using Compaction ](developers_bestpractices_compacting.html).

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE(
                 	schemaName, tableName)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

A string that specifies the Splice Machine schema name to which the
table belongs.
{: .paramDefnFirst}

tableName
{: .paramName}

A string that specifies name of the Splice Machine table on which to
perform the compaction.
{: .paramDefnFirst}

</div>
<div markdown="1">
## Usage

Major compaction is synchronous, which means that when you invoke this
procedure from the command line, your command line prompt won't be
available again until the compaction completes, which can take a little
time.
{: .body}

</div>
## Results

This procedure does not return a result.

## Example

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE('SPLICE','Pitching');
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_SCHEMA`](sqlref_sysprocs_compactschema.html)

</div>
</section>
