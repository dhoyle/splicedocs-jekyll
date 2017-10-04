---
title: SYSCS_UTIL.SYSCS_SET_LOGGER_LEVEL built-in system procedure
summary: Built-in system procedure that changes the log level of the specified logger.
keywords: loggers, logs, set_logger_level
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_setloggerlevel.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_SET_LOGGER_LEVEL

The `SYSCS_UTIL.SYSCS_SET_LOGGER_LEVEL` system procedure changes the
logging level of the specified logger.

You can read more about Splice  Machine loggers and logging levels in
the [Logging](developers_tuning_logging.html) topic.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_SET_LOGGER_LEVEL(loggerName, logLevel)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
loggerName
{: .paramName}

A string specifying the name of the logger whose log level you want to
find.
{: .paramDefnFirst}

loggerLevel
{: .paramName}

A string specifying the new level to assign to the named logger. This
must be one of the following level values, which are described in the
[Logging](developers_tuning_logging.html) topic:
{: .paramDefnFirst}

* `TRACE`
* `DEBUG`
* `INFO`
* `WARN`
* `ERROR`
* `FATAL`
{: .bulletNested}

</div>
## Results

This procedure does not return a result.

## Usage Notes

You can use the `TRACE` option of the Splice Machine `StatementManager`
log to record the execution time of each statement:

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_SET_LOGGER_LEVEL ( 'com.splicemachine.utils.SpliceUtilities', 'TRACE');
    Statement executed
{: .Example xml:space="preserve"}

</div>
You can find all of the available loggers by using the
[`SYSCS_UTIL.SYSCS_GET_LOGGERS`](sqlref_sysprocs_getloggers.html) system
procedure.

## Example

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_SET_LOGGER_LEVEL( 'com.splicemachine.mrio.api', 'DEBUG' );
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.SYSCS_GET_LOGGERS`](sqlref_sysprocs_getloggers.html)
* [`SYSCS_UTIL.SYSCS_SET_LOGGER_LEVEL`](#)
* *[Splice Machine Logging](developers_tuning_logging.html)*

</div>
</section>
