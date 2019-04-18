---
title: SYSCS_UTIL.SET_STATS_EXTRAPOLATION_FOR_COLUMN built-in system procedure
summary: Built-in system procedure that specifies whether to use statistics extrapolation for the column.
keywords: statistics, extrapolation
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_setstatsextrapolation.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SET_STATS_EXTRAPOLATION_FOR_COLUMN

Use the `SYSCS_UTIL.SET_STATS_EXTRAPOLATION_FOR_COLUMN` system procedure to specify whether or not you want statistics extrapolation used for a specific column in a table.

## About Statistics Extrapolation
Statistics extrapolation allows the Splice Machine optimizer to extrapolate statistics for specific column values that have not yet been analyzed. This means that the optimizer can then estimate values for these columns in rows that have been added to a table since the most recent `ANALYZE` operation was run, which can yield better query plans.

With extrapolation enabled, the optimizer captures the growth pattern for each eligible column and then uses that pattern to create an algorithm for extrapolating missing values.

Extrapolation is only supported for columns with the following data types:
* `TINYINT`
* `SMALLINT`
* `INTEGER`
* `LONGINT`
* `REAL`
* `DOUBLE`
* `DECIMAL`
* `DATE`
* `TIMESTAMP`

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_SET_LOGGER_LEVEL( VARCHAR schema,
                                       VARCHAR table,
                                       VARCHAR column,
                                       SMALLINT useExtrapolation )
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

Specifies the schema of the table.
{: .paramDefnFirst}

tableName
{: .paramName}

Specifies the name of the table.
{: .paramDefnFirst}

column
{: .paramName}

Specifies the name of the column for which you are setting the `useExtrapolation` value.
{: .paramDefnFirst}

useExtrapolation
{: .paramName}

Specifies whether you want extrapolation enabled (value=`1`) or disabled (value=`0` or `NULL`) for the column. This value defaults to disabled.
{: .paramDefnFirst}

</div>
## Results

This procedure does not return a result.


## Example

This example enables extrapolation for column `A5` in `myTable`:
```
CREATE TABLE myTable (a5 INT, b5 DECIMAL(10,2), c5 DATE, d5 TIMESTAMP, e5 VARCHAR(10), a55 INT, c55 DATE);
CALL SYSCS_UTIL.SET_STATS_EXTRAPOLATION_FOR_COLUMN('SPLICE', 'myTable', 'A5', 1);
```
{: .Example}

And this call disables extrapolation for the same column:
{: .spaceAbove}

```
CALL SYSCS_UTIL.SET_STATS_EXTRAPOLATION_FOR_COLUMN('SPLICE', 'myTable', 'A5', 0);
```
{: .Example}


</div>
</section>
