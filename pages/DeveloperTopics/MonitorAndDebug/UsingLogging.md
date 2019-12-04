---
title: Using Splice Machine's Logging
summary: Introduction to using logging in Splice Machine
keywords: logging, tracing, debugging, loggers
toc: false
product: all
sidebar: home_sidebar
permalink: developers_tuning_logging.html
folder: DeveloperTopics/MonitorAndDebug
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice Machine Logging

This topic describes the logging facility used in Splice Machine. Splice
Machine also allows you to exercise direct control over logging in your
database. This topic contains these sections:

* [Using Logging](#Using)
* [Splice Machine Security Audit Logging](#securityaudit)
* [Configure Individual Logger Objects to Log](#SpliceLoggers)
* [SQL Logger Functions](#LoggerFunctions)


## Using Logging  {#Using}

Splice Machine uses the open source <a href="http://logging.apache.org/log4j/1.2/manual.html" target="_blank">Apache log4j Logging API</a>, which allows you to associate a logger object with any
java class, among other features. Loggers can be set to capture
different levels of information.

Splice Machine enables statement logging by default.
{: .noteIcon}

Logging too much information can slow your system down, but not logging
enough information makes it difficult to debug certain issues. The
[Splice Machine Loggers](#SpliceLoggers) section below summarizes the
loggers used by Splice Machine and the system components that they use.
You can use the SQL logging functions described in the [SQL Logger
Functions](#LoggerFunctions) section below to retrieve or modify the
logging level of any logger used in Splice Machine.

The remainder of this section shows you how to:

* [Mask Sensitive Information in Log Messages](#Filtering)
* [Manually Disable Logging](#Manually)
* [Set Logger Levels](#Levels)

### Masking Sensitive Information  {#Filtering}

{% include splice_snippets/logobfuscation.md %}


### Manually Disabling Logging   {#Manually}

Logging of SQL statements is automatically enabled in Splice Machine; to
disable logging of statements, you can do so in either of these ways:

* You can pass an argument to your Splice Machine JVM startup script, as
  follows:

  ```
  -Dderby.language.logStatementText=false
  ```
  {: .Example }


* You can add the following property definition to your
  `hbase-default.xml`, `hbase-site.xml`, or `splice-site.xml` file:

  ```
  <property>
  <name>splice.debug.logStatementContext</name>
  <value>false</value>
  <description>Property to enable logging of all statements.</description>
  </property>
  ```
  {: .Example}

You can examine the logged data in your region server's logs; if you
want to change the location where events are logged, see the
instructions in the Installation Guide for your platform (Cloudera,
Hortonworks, or MapR).

### Logger Levels   {#Levels}

The `log4j` API defines six logger levels:

* If the logger is currently configured to record messages at the specified level, the message is added to the log; otherwise, the logger ignores the message.
* Logger levels are ordered hierarchically: any message with a level equal to or greater than the hierarchical level for which logging is enabled is recorded into the log.

The following table displays the logger levels from lowest level to the highest:

<table summary="Table of the available logging levels.">
    <col />
    <col />
    <thead>
        <tr>
            <th>Logger Level</th>
            <th>What gets logged for a logger object set to this level</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>TRACE</code></td>
            <td>Captures all messages.</td>
        </tr>
        <tr>
            <td><code>DEBUG</code></td>
            <td>Captures any message whose level is <code>DEBUG</code>, <code>INFO</code>, <code>WARN</code>, <code>ERROR</code>, or <code>FATAL</code>.</td>
        </tr>
        <tr>
            <td><code>INFO</code></td>
            <td>Captures any message whose level is <code>INFO</code>, <code>WARN</code>, <code>ERROR</code>, or <code>FATAL</code>.</td>
        </tr>
        <tr>
            <td><code>WARN</code></td>
            <td>Captures any message whose level is <code>WARN</code>, <code>ERROR</code>, or <code>FATAL</code>.</td>
        </tr>
        <tr>
            <td><code>ERROR</code></td>
            <td>Captures any message whose level is <code>ERROR</code> or <code>FATAL</code>.</td>
        </tr>
        <tr>
            <td><code>FATAL</code></td>
            <td>Captures only messages whose level is <code>FATAL</code>.</td>
        </tr>
    </tbody>
</table>

## Splice Machine Security Audit Logging  {#securityaudit}

Whenever a user creates a connection or executes one of the following system procedures, Splice Machine records the action in your audit log files.

```
SYSCS_UTIL.SYSCS_CREATE_USER
SYSCS_UTIL.SYSCS_DROP_USER
SYSCS_UTIL.SYSCS_MODIFY_PASSWORD
SYSCS_UTIL.SYSCS_RESET_PASSWORD
```
{: .Example}

Each record in the audit log contains the following information:

<table>
    <thead>
        <tr>
            <th>Item</th>
            <th>Explanation</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">userid</td>
            <td>Username of action executor</td>
        </tr>
        <tr>
            <td class="CodeFont">event</td>
            <td>Name of </td>
        </tr>
        <tr>
            <td class="CodeFont">status</td>
            <td>Success or Failure</td>
        </tr>
        <tr>
            <td class="CodeFont">ip</td>
            <td>The IP address of the executor of the action</td>
        </tr>
        <tr>
            <td class="CodeFont">statement</td>
            <td><p>The statement that executed.</p>
                <p>Note that no statement is recorded for the <code>LOGIN</code> action.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">reason</td>
            <td>The reason for failure, if the statement failed (<code>status=Failure</code>).</td>
        </tr>
    </tbody>
</table>

### Modifying the Audit Log File Location

You can modify where Splice Machine stores the audit log by adding the following snippet to the *RegionServer Logging
Advanced Configuration Snippet (Safety Valve)* section of your HBase Configuration:

```
log4j.appender.spliceAudit=org.apache.log4j.FileAppender
log4j.appender.spliceAudit.File=${hbase.log.dir}/splice-audit.log
log4j.appender.spliceAudit.layout=org.apache.log4j.PatternLayout
log4j.appender.spliceAudit.layout.ConversionPattern=%d{ISO8601} %m%n

log4j.logger.splice-audit=INFO, spliceAudit
log4j.additivity.splice-audit=false
```
{: .Example}

Splice Machine logs to a separate audit log file on each region server; each file stores only the events that were active on that region server.
{: .noteIcon}


## Splice Machine Loggers   {#SpliceLoggers}

The following table summarizes the loggers used in the Splice Machine
environment that might interest you if you're trying to debug
performance issues in your database:
{: .spaceAbove}

<table summary="Table of the loggers used in Splice Machine.">
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Logger Name</th>
            <th>Default Level</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>org.apache</code></td>
            <td><code>ERROR</code></td>
            <td>Logs all Apache software messages</td>
        </tr>
        <tr>
            <td><code>com.splicemachine.db</code></td>
            <td><code>WARN</code></td>
            <td>Logs all Derby software messages</td>
        </tr>
        <tr>
            <td><code>com.splicemachine.db.shared.common.sanity</code></td>
            <td><code>ERROR</code></td>
            <td>Logs all Derby Sanity Manager messages</td>
        </tr>
        <tr>
            <td><code>com.splicemachine.derby.impl.sql.catalog</code></td>
            <td><code>WARN</code></td>
            <td>Logs Derby SQL catalog/dictionary messages</td>
        </tr>
        <tr>
            <td><code>com.splicemachine.db.impl.sql.execute.operations</code></td>
            <td><code>WARN</code></td>
            <td>Logs Derby SQL operation messages</td>
        </tr>
        <tr>
            <td><code>org.apache.zookeeper.server.ZooKeeperServer</code></td>
            <td><code>INFO</code></td>
            <td>Used to determine when Zookeeper is started</td>
        </tr>
        <tr>
            <td><code>org.apache.zookeeper.server.persistence.FileTxnSnapLog</code></td>
            <td><code>INFO</code></td>
            <td>Logs Zookeeper transactions</td>
        </tr>
        <tr>
            <td><code>com.splicemachine</code></td>
            <td><code>WARN</code></td>
            <td>By default, controls all Splice Machine logging</td>
        </tr>
        <tr>
            <td><code>com.splicemachine.derby.hbase.SpliceDriver</code></td>
            <td><code>INFO</code></td>
            <td>Prints start-up and shutdown messages to the log and to the console</td>
        </tr>
        <tr>
            <td><code>com.splicemachine.derby.management.StatementManager</code></td>
            <td><code>ERROR</code></td>
            <td>Set the level of this logger to <code>TRACE</code> to record execution time for SQL statements</td>
        </tr>
    </tbody>
</table>

To see a full list of loggers, use the [`SYSCS_UTIL.SYSCS_GET_LOGGERS`](sqlref_sysprocs_getloggers.html) system procedure:
```
   CALL SYSCS_UTIL.SYSCS_GET_LOGGERS();
```

## SQL Logger Functions   {#LoggerFunctions}

Splice Machine SQL includes the following built-in system procedures,
all documented in our [*SQL Reference Manual*](sqlref_intro.html), for
interacting with the Splice Machine logs:

<table summary="Table of Splice Machine system procedures for interacting with logs.">
    <col />
    <col />
    <thead>
        <tr>
            <th>System Procedure</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_getloggers.html">SYSCS_UTIL.SYSCS_GET_LOGGERS</a>
            </td>
            <td>Displays a list of the active loggers.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_getloggerlevel.html">SYSCS_UTIL.SYSCS_GET_LOGGER_LEVEL</a>
            </td>
            <td>Displays the current logging level of the specified logger.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_setloggerlevel.html">SYSCS_UTIL.SYSCS_SET_LOGGER_LEVEL</a>
            </td>
            <td>Sets the current logging level of the specified logger.</td>
        </tr>
    </tbody>
</table>

## See Also

* [`SYSCS_UTIL.SYSCS_GET_LOGGERS`](sqlref_sysprocs_getloggers.html)
* [`SYSCS_UTIL.SYSCS_GET_LOGGER_LEVEL`](sqlref_sysprocs_getloggerlevel.html)
* [`SYSCS_UTIL.SYSCS_SET_LOGGER_LEVEL`](sqlref_sysprocs_setloggerlevel.html)

</div>
</section>
