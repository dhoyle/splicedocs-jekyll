---
title: SSYSCS_UTIL.SET_MIN_RETENTION_PERIOD built-in system procedure
summary: Built-in system procedure that sets the minimum retention period for time travel data.
keywords: time travel, retention period, set_minimum_retention_period
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_setminretentionperiod.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SSYSCS_UTIL.SET_MIN_RETENTION_PERIOD

The `SSYSCS_UTIL.SET_MIN_RETENTION_PERIOD` system procedure sets the minimum retention period for time travel data.


## Syntax

<div class="fcnWrapperWide" markdown="1">
    SSYSCS_UTIL.SET_MIN_RETENTION_PERIOD(schema, table, timeInSeconds)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schema
{: .paramName}

The schema name.
{: .paramDefnFirst}

table
{: .paramName}

The table name.
{: .paramDefnFirst}

timeInSeconds
{: .paramName}

The minimum retention period in seconds.
{: .paramDefnFirst}


</div>
## Results

This procedure does not return a result.

## Examples

Set the minimum retention period for table T1 in schema SPLICE to 300 seconds:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SET_MIN_RETENTION_PERIOD('SPLICE', 'T1', 300);
    Statement executed.
{: .Example xml:space="preserve"}

</div>

Set the minimum retention period for all user tables in schema SPLICE to 250 seconds:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SET_PURGE_DELETED_ROWS('SPLICE', NULL, 250);
    Statement executed.
{: .Example xml:space="preserve"}

</div>

## See Also

* [`AS OF` clause ](sqlref_clauses_asof.html)

</div>
</section>
