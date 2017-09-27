---
title: SYSCS_UTIL.SYSCS_GET_LOGGER_LEVEL built-in system procedure
summary: Built-in system procedure that displays the log level of the specified logger.
keywords: get_logger_level
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_getloggerlevel.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_GET_LOGGER_LEVEL   {#BuiltInSysProcs.GetLoggerLevel}

The `SYSCS_UTIL.SYSCS_GET_LOGGER_LEVEL` system procedure displays the
logging level of the specified logger.

You can read more about Splice  Machine loggers and logging levels in
the [Logging](developers_tuning_logging.html) topic of our *Developer's
Guide*.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_GET_LOGGER_LEVEL(loggerName)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
loggerName
{: .paramName}

A string specifying the name of the logger whose logging level you want
to find.
{: .paramDefnFirst}

You can find all of the available loggers by using the
[`SYSCS_UTIL.SYSCS_GET_LOGGERS`](sqlref_sysprocs_getloggers.html) system
procedure.
{: .paramDefn}

</div>
## Results

The displayed results of calling `SYSCS_UTIL.SYSCS_GET_LOGGER_LEVEL`
include these values:

<table summary=" summary=&quot;Columns in Get_Logger_Level results display&quot;">
                <col />
                <col />
                <thead>
                    <tr>
                        <th> </th>
                        <th> </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>Value</strong>
                        </td>
                        <td><strong>Description</strong>
                        </td>
                    </tr>
                    <tr>
                        <td class="CodeFont">LOGLEVEL
                    </td>
                        <td>
                            <p class="noSpaceAbove">The level of the logger. This is one of the following values, which are described in the <a href="developers_tuning_logging.html">Logging</a> topic:</p>
                            <ul>
                                <li class="CodeFont" value="1">TRACE</li>
                                <li class="CodeFont" value="2">DEBUG</li>
                                <li class="CodeFont" value="3">INFO</li>
                                <li class="CodeFont" value="4">WARN</li>
                                <li class="CodeFont" value="5">ERROR</li>
                                <li class="CodeFont" value="6">FATAL</li>
                            </ul>
                        </td>
                    </tr>
                </tbody>
            </table>
## Example

Here are two examples of using this procedure:
{: .body}

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_GET_LOGGER_LEVEL('com.splicemachine.utils.SpliceUtilities');
    LOG&
    ----
    WARN

    1 row selected

    splice> CALL SYSCS_UTIL.SYSCS_GET_LOGGER_LEVEL('com.splicemachine.mrio.api');
    LOGL&
    -----
    DEBUG

    1 row selected
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.SYSCS_GET_LOGGERS`](sqlref_sysprocs_getloggers.html)
* [`SYSCS_UTIL.SYSCS_SET_LOGGER_LEVEL`](sqlref_sysprocs_setloggerlevel.html)
* *[Splice Machine Logging](developers_tuning_logging.html)* in our
  *Developer's Guide*.

</div>
</section>
