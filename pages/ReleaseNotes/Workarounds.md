---
title: Known Limitations and Workarounds
summary: Limitations and workarounds in our database.
keywords: on-premise limitations, work arounds, limits,
toc: false
product: all
sidebar:  releasenotes_sidebar
permalink: releasenotes_workarounds.html
folder: ReleaseNotes
---
# Limitations and Workarounds in Release {{splvar_basic_SpliceReleaseVersion}} of the Splice Machine Database

{% include splice_snippets/onpremonlytopic.md %}
This topic describes workarounds for known limitations in this release of the Splice Machine Database. These can include previously unstated limitations or workarounds for problems that will be fixed in a future release.

These are the notes and workarounds for known issues in our current release:

* [With Clauses and Temporary Tables](#with-clauses-and-temporary-tables)

* [Temporary Tables and Backups](#temporary-tables-and-backups)

* [Natural Self Joins Not Supported](#natural-self-joins-not-supported)

* [Columnar Screen Output Gets Truncated](#columnar-screen-output-gets-truncated)

* [TimeStamp Date Value Limitations](#timestamp-date-value-limitations)

* [ToDate Function Problem With DD Designator](#todate-function-problem-with-dd-designator)

* [Dropping Foreign Keys](#dropping-foreign-keys)

* [Compaction Queue Issue](#compaction-queue-issue)

* [Alter Table Issues](#alter-table-issues)

* [Default Value for Lead and Lag Functions](#default-value-for-lead-and-lag-functions)

* [CREATE TABLE AS with RIGHT OUTER JOIN](#create-table-as-with-right-outer-join)

* [Import Performance Issues With Many Foreign Key References](#import-performance-issues-with-many-foreign-key-references)


## With Clauses and Temporary Tables

You cannot currently use temporary tables in ``WITH`` clauses.


## Natural Self Joins Not Supported

Splice Machine does not currently support ``NATURAL SELF JOIN`` operations.


## Temporary Tables and Backups

There's a subtle issue with performing a backup when you're using a temporary table in your session: although the temporary table is (correctly) not backed up, the temporary table's entry in the system tables will be backed up. When the backup is restored, the table entries will be restored, but the temporary table will be missing.

There's a simple workaround:
1. Exit your current session, which will automatically delete the temporary table and its system table entries.
2. Start a new session (reconnect to your database).
3. Start your backup job.


## Columnar Screen Output Gets Truncated

When using ``Explain Plan`` and other commands that generate lengthy output lines, you may see some output columns truncated on the screen.

**WORKAROUND:** Use the `maximumdisplaywidth=0` command to force all column contents to be displayed.


## TimeStamp Date Value limitations

Dates in [TIMESTAMP Data Type](sqlref_builtinfcns_timestamp.html) values only work correctly when limited to this range of date values:
~~~~
    1678-01-01 to 2261-12-31
~~~~


## ToDate Function Problem With DD Designator

The [TO_DATE](sqlref_builtinfcns_date.html) function currently returns the wrong date if you specify ``DD`` for the day field; however, specifying ``dd`` instead works properly.

**WORKAROUND:** Use `dd` instead of `DD`.


## Dropping Foreign Keys

The ``DROP FOREIGN KEY`` clause of the [ALTER TABLE](sqlref_statements_altertable.html) statement is currently unavailable in Splice Machine.

**WORKAROUND:** Re-create the table without the foreign key constraint.


## Compaction Queue Issue

We have seen a problem in which the compaction queue grows quite large after importing large amounts of data, and are investigating a solution; for now, please use the following workaround.

Run a full compaction on tables into which you have imported a large amount of data, using the [SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE](sqlref_sysprocs_compacttable.html) system procedure.</div>


## Alter Table Issues

Using ``ALTER TABLE`` against ``PRIMARY KEY`` columns does not currently work properly.


## Default Value for Lead and Lag Functions

This release of Splice Machine features several new window functions, including [LAG](sqlref_builtinfcns_lag.html) do not support the default value parameter that you can specify in some other implementations. We expect to add this parameter in future releases.


## CREATE TABLE AS with RIGHT OUTER JOIN

There is a known problem using the ``CREATE TABLE AS`` form of the [RIGHT OUTER JOIN](sqlref_joinops_rightouterjoin.html) operation. For example, the following statement currently produces a table with all ``NULL`` values:
~~~ sql
CREATE TABLE t3 AS
   SELECT t1.a,t1.b,t2.c,t2.d
   FROM t1 RIGHT OUTER JOIN t2 ON t1.b = t2.c
   WITH DATA;
~~~

There's a simple workaround for now: create the table without inserting the data, and then insert the data; for example:
~~~ sql
CREATE TABLE t3 AS
   SELECT t1.a,t1.b,t2.c,t2.d
   FROM t1 RIGHT OUTER JOIN t2 ON t1.b = t2.c
   WITH NO DATA;

INSERT INTO t3
   SELECT t1.a,t1.b,t2.c,t2.d
   FROM t1 RIGHT OUTER JOIN t2 ON t1.b = t2.c;
~~~


## Import Performance Issues With Many Foreign Key References

The presence of many foreign key references on a table will slow down imports of data into that table.


</div>
</section>
