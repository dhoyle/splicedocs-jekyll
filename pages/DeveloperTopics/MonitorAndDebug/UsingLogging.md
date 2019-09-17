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
* [Configure Individual Logger Objects to Log](#SpliceLoggers)
* [SQL Logger Functions](#LoggerFunctions)


## Using Logging  {#Using}

Splice Machine uses the open source [Apache log4j Logging API][1]{:
target="_blank"}, which allows you to associate a logger object with any
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

You can configure _log4j_ to prevent sensitive information such as passwords and credit card information from being logged in log messages. To do so, you:

* Use the `com.splicemachine.utils.logging.MaskPatternLayout` log4j layout pattern.
* Specify a regular expression in `MaskPattern` that matches the part of log messages you want matched.
*
When logging with this layout, log4j will replace any text that matches the filter with this text:

```
_MASKED SENSITIVE INFO_
```
{: .Example}

For example:
```
log4j.appender.spliceDerby.layout=com.splicemachine.utils.logging.MaskPatternLayoutlog4j.appender.spliceDerby.layout.ConversionPattern=%d{ISO8601} Thread[%t] %m%nlog4j.appender.spliceDerby.layout.MaskPattern=insert (?:.*) ([0-9]+),([0-9]+)
```
{: .Example}

Given that layout, the following statement:

```
splice> INSERT INTO a VALUES myName, myPassword
```
{: .Example}

will be logged as:

```
INSERT INTO a VALUES MASKED SENSITIVE INFO, MASKED SENSITIVE INFO
```
{: .Example}

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



[1]: http://logging.apache.org/log4j/1.2/manual.html
