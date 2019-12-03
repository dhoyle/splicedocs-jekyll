---
title: SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_SCHEMA built-in system procedure
summary: Built-in system procedure that performs a major compaction on a schema.
keywords: perform_major_compaction, compacting a schema
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_compactschema.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_SCHEMA

The `SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_SCHEMA` system
procedure performs a major compaction on a schema. The compaction is
performed on all of the tables in the schema, and on all of its index
and constraint tables for each table in the schema.

A *major compaction* actually reads every block of data from the every store file in a Region, and rewrites only the live data to a single store file. This permanently deletes the rows that were previously marked as deleted. HBase runs major compactions on a scheduled interval, which is specified in the `hbase.hregion.majorcompaction` property; the default value for this property in Splice Machine is 7 days.

Splice Machine recommends running a major compaction on a schema after you've imported an entire database.

For more information about compactions, see [Best Practices: Using Compaction ](bestpractices_optimizer_compacting.html).

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_SCHEMA(schemaName)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

A string that specifies the Splice Machine schema name to which the
table belongs.
{: .paramDefnFirst}

</div>
## Usage

Major compaction is synchronous, which means that when you invoke this
procedure from the command line, your command line prompt won't be
available again until the compaction completes, which can take a little
time.
{: .body}

## Results

This procedure does not return a result.

## Example

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_SCHEMA('SPLICE');
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE`](sqlref_sysprocs_compacttable.html)

</div>
</section>
