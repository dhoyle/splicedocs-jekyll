---
title: SYSCS_UTIL.CHECK_TABLE built-in system procedure
summary: Built-in system procedure that reports on inconsistencies between a table and its indexes.
keywords: table, index
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_checktable.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.CHECK_TABLE

The `SYSCS_UTIL.CHECK_TABLE`  system procedure reports on inconsistencies between a table and its indexes; it reports these categories of problems:
* Unmatched row and index count
* Missing indexes
* Invalid indexes that do not refer to a base table row
* Duplicate indexes that refer to the same base table row

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.CHECK_TABLE( VARCHAR schemaName,
                            VARCHAR tableName,
                            VARCHAR indexName,
                            INTEGER level,
                            VARCHAR outputFile)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

Specifies the schema of the table that you want to check.
{: .paramDefnFirst}

tableName
{: .paramName}

Specifies the name of the table that you want to check. You can specify `NULL` to check all tables in the named schema.
{: .paramDefnFirst}

indexName
{: .paramName}

Specifies the name of the index that you want to check. You can specify `NULL` to check all indexes on the named table.
{: .paramDefnFirst}

level
{: .paramName}

Specifies the level of error checking that you want performed. There are two possible values:
{: .paramDefnFirst}

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Level</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>1</code></td>
            <td><code>SYSCS_UTIL.CHECK_TABLE</code> counts the number of tables and indexes, and reports an error if they do not match.</td>
        </tr>
        <tr>
            <td><code>2</code></td>
            <td><code>SYSCS_UTIL.CHECK_TABLE</code> reports invalid indexes, missing indexes, and duplicate indexes.</td>
        </tr>
    </tbody>
</table>

outputFile
{: .paramName}

The name of a file to which the reported information is written.
{: .paramDefnFirst}

</div>
## Results

This procedure writes a report to an output file; if no inconsistencies are found, the output file is not created. Several example results files are displayed in the *Examples* section below.

## Examples

#### Example 1: No Inconsistencies  Found
In this example, no inconsistencies are found in the specified table:
<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.CHECK_TABLE('sys', 'systables', null, 2, '/Users/MyName/tmp/checksystables.out');
    RESULT
    -----------------------------------------
    No inconsistencies were found.

    1 row selected
{: .Example xml:space="preserve"}
</div >

#### Example 2: Inconsistencies Reported at Level 1
In this example, the examined table contains some level 1 inconsistencies:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.CHECK_TABLE('SPLICE', 'MyTableA', null, 1, '/Users/MyName/tmp/checkmytableA.1.out');
    RESULT
    ---------------------------------------------------------------
    Found inconsistencies. Check /Users/MyName/tmp/checkmytableA.Level1.out for details.

    1 row selected
{: .Example xml:space="preserve"}
</div>

The report in `/Users/MyName/tmp/checkmytableA.Level1.out` displays row counts for the base table  `MyTableA` and the index `MyTableAI`:

<div class="preWrapperWide" markdown="1">
    MyTableA:
    	count = 2
    MyTableAI:
    	count = 4
{: .Example}
</div>

#### Example 2: Inconsistencies Reported at Level 2
In this example, we examine the same table and report the inconsistencies at Level 2:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.CHECK_TABLE('SPLICE', 'MyTableA', null, 2, '/Users/MyName/tmp/checkmytableA.Level2.out');
    RESULT
    ---------------------------------------------------------------
    Found inconsistencies. Check /Users/MyName/tmp/checkmytableA.Level2.out for details.

    1 row selected
{: .Example xml:space="preserve"}
</div>


The report in `/Users/MyName/tmp/checkmytableA.Level2.out` displays three inconsistencies for the base table  `MyTableA` and the index `MyTableAI`:

<div class="preWrapperWide" markdown="1">
    AI:
        The following 2 rows from base table SPLICE.MyTableA are not indexed:
        { 4, 4 }
        { 5, 5 }
        The following 2 indexes are invalid:
        { 2 }=>820082
        { 1 }=>810081
        The following 2 indexes are duplicates:
        { 7 }=>870087
        { 8 }=>870087
{: .Example}
</div>

* The first message indicates that two rows with primary keys `(4,4)` and `(5,5)` are not indexed. Note that `SYSCS_UTIL.CHECK_TABLE` only reports primary key vales; if a table does not have a primary key, it reports the row ID instead.
* Two indexes with index column values `2` and `1` do not index any rows: there are no rows with row ID `820082` or `810081` in the base table.
* Two indexes are indexing the same base table row, `87007`.

</div>
</section>
