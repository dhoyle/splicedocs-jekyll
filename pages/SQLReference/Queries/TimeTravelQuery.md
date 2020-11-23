---
title: TIME TRAVEL QUERY
summary: A Time Travel Query lets you query the content of a relational table as it existed at a past point in time.
keywords: time travel, time travel query, point in time query
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_queries_time_travel_query.html
folder: SQLReference/Queries
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Time Travel Query

A *Time Travel Query* enables you to query the content of a relational table as it existed at a past time. The past point in time can be specified by a Transaction ID or a timestamp expression.

## Time Travel Query using Transaction ID

In the following example, `GET_CURRENT_TRANSACTION` is used to retrieve the transaction ID after each operation, which can be used later to query the state of the table at that point in time.

<div class="preWrapperWide" markdown="1">

    splice> CREATE TABLE t(col1 INT, col2 CHAR);
    splice> INSERT INTO t VALUES(42, 'a');
    splice> CALL SYSCS_UTIL.SYSCS_GET_CURRENT_TRANSACTION();
    20224
    splice> INSERT INTO t VALUES(44, 'b');
    splice> CALL SYSCS_UTIL.SYSCS_GET_CURRENT_TRANSACTION();
    20992
    splice> UPDATE t SET col2='c' WHERE col1 = 44;
    splice> CALL SYSCS_UTIL.SYSCS_GET_CURRENT_TRANSACTION();
    21760
    splice> AUTOCOMMIT OFF;
    splice> DELETE FROM t WHERE col1 = 42;
    splice> INSERT INTO t VALUES(46, 'd');
    splice> COMMIT;
    splice> AUTOCOMMIT ON;
    splice> SELECT * FROM t AS OF 20224;
    COL1       |COL2
    ----------------
    42         |a
    splice> SELECT * FROM t AS OF 20992;
    COL1       |COL2
    ----------------
    42         |a
    44         |b
    splice> SELECT * FROM t AS OF 21760;
    COL1       |COL2
    ----------------
    42         |a
    44         |c
    splice> SELECT * FROM t;
    COL1       |COL2
    ----------------
    44         |c
    46         |d

{: .Example xml:space="preserve"}

</div>

After we insert the row (42,'a'); (line 4) we check the transaction ID, which was 20224. Subsequently we perform multiple CRUD operations, but if we use `AS OF` to query the table at that point in time (line 16), we get back the row (42,'a'), which is the state of the table at the point in time for that transaction ID.

Trying to query the table a bit earlier than that returns empty results. Subsequent normal queries without using `AS OF` return the current status of the table.

To better understand how time travel works, it is useful to look at how table data is versioned and stored in Splice Machine. The following illustration depicts a simplified overview of how the table data from the preceding example is stored, and how it progresses over time with respect to various CRUD operations on the table rows:

![](images/timetravel.png){: .indentedTightSpacing}
{: .spaceAbove}

* When a row is inserted into the table, it gets versioned and saved in HBase under that version.

* If the row is not updated nor deleted, it keeps its state over time.

* When a row gets updated, a new version (e.g. at version 12 in the image above) is stored in HBase and the old version is kept for a period of time.

* Finally, when a row is deleted, a new version of the row is created with a special mark (referred to as a tombstone) making it invisible for all subsequent transactions. The previous versions of the row are kept for a period of time.

## Time Travel Query using a Timestamp

In the following example we repeat the same steps as in the previous example, but this time we use timestamps to specify the previous points in time.

<div class="preWrapperWide" markdown="1">

    splice> CREATE TABLE t(col1 INT, col2 CHAR);
    splice> VALUES current_timestamp;
    2020-09-18 20:58:10.360366
    splice> INSERT INTO t VALUES(42, 'a');
    splice> VALUES current_timestamp;
    2020-09-18 20:58:19.330408
    splice> INSERT INTO t VALUES(44, 'b');
    splice> VALUES current_timestamp;
    2020-09-18 20:58:31.883391
    splice> UPDATE t SET col2='c' WHERE col1 = 44;
    splice> VALUES current_timestamp;
    2020-09-18 20:58:47.375416
    splice> AUTOCOMMIT OFF;
    splice> DELETE FROM t WHERE col1 = 42;
    splice> INSERT INTO t VALUES(46, 'd');
    splice> COMMIT;
    splice> AUTOCOMMIT ON;
    splice> SELECT * FROM t AS OF TIMESTAMP('2020-09-18 20:58:19.330408');
    COL1       |COL2
    ----------------
    42         |a
    splice> SELECT * FROM t AS OF TIMESTAMP('2020-09-18 20:58:31.883391');
    COL1       |COL2
    ----------------
    42         |a
    44         |b
    splice> SELECT * FROM t AS OF TIMESTAMP('2020-09-18 20:58:47.375416');
    COL1       |COL2
    ----------------
    42         |a
    44         |c
    splice> SELECT * FROM t;
    COL1       |COL2
    ----------------
    44         |c
    46         |d

{: .Example xml:space="preserve"}

</div>

Time travel with timestamp expects a server time, and does not currently support time zones.
{: .noteIcon}

## Retention Period

As is the case with other database systems, Splice Machine recycles deleted data from time to time to free up resources. This is done behind the scenes using flushing, minor compactions, and major compactions. During these operations, Splice Machine performs several optimizations that remove obsolete data such as rows marked as deleted, which are not visible by subsequent transactions.

Performing a time travel query on a table that is optimized using these techniques may return incorrect results. For example:

<div class="preWrapperWide" markdown="1">

    splice> CALL SYSCS_UTIL.SET_PURGE_DELETED_ROWS('SPLICE', 'T', false);
    splice> CALL SYSCS_UTIL.SYSCS_FLUSH_TABLE('SPLICE', 'T');
    splice> CALL SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE('SPLICE', 'T');
    splice> select * from t as of 20224;
    COL1       |COL2
    ----------------

    0 rows selected
    splice> select * from t as of 21760;
    COL1       |COL2
    ----------------
    44         |c


{: .Example xml:space="preserve"}

</div>

In this example, a flush and compaction is performed on table `T`. If we attempt to run the same queries as in the first example, different results are returned. Namely, the row (42,a) is missing.

You could incorrectly conclude that at the past transaction ID 20224 no row was inserted, but what actually happened is that the row was (rightfully) recycled during flush and compaction, as it was already deleted from the table and no active transaction is referencing it.

To address this issue, we can define a safe window for time travel. Within this safe time window, flushing and compaction are prevented from recycling obsolete data, which ensures consistent time travel results for time travel queries that fall within the window.

This window is referred to as a minimum retention period (MRP). You can think of it as a moving window of time that is defined per table. You can set the MRP using the built-in system procedure `SET_MIN_RETENTION_PERIOD`, which assigns a given MRP (in seconds) to a schema, or to a specific table.

The following example sets the MRP for table `T` to 5 minutes (300 seconds). Even if flushing and compaction are performed, consistent time travel results are returned for `AS OF` queries up to 300 seconds in the past as compared to the current time.

<div class="preWrapperWide" markdown="1">

    splice> CALL SYSCS_UTIL.SET_MIN_RETENTION_PERIOD('SPLICE','T', 300);
    Statement executed.

{: .Example xml:space="preserve"}

</div>

A table MRP is stored as a column in the `SYSTABLES` table:

<div class="preWrapperWide" markdown="1">

    splice> SELECT tablename, min_retention_period FROM sys.systables;
    TABLENAME|MIN_RETENTION_PERIOD
    ------------------------------
    SYSCONGLOMERATES|604800
    T|300
    SYSTABLES|604800
    SYSCOLUMNS|604800
    ...
    SYSALIASTOTABLEVIEW|NULL

{: .Example xml:space="preserve"}

</div>

* The minimum retention period is set to 604800 seconds (7 days) by default for all system tables. This value can be configured by setting the `splice.sys.tables.retention.period` configuration parameter.

* Use caution when choosing the MRP value. A very large value could consume a large amount of system resources and cause significant performance overhead.  Setting this value properly for a table requires understanding how fast the table is changing and how critical it is to get consistent time travel results.

* The built-in system procedure `SYSCS_UTIL.SET_PURGE_DELETED_ROWS` forces purging deleted rows regardless of the MRP. Be sure to set it to FALSE for any table you plan to perform time travel on.
{: .noteIcon}

You should also note that flushing and compaction runs periodically. Therefore, it is possible to get accurate time travel results even outside of the specified MRP, but this is not guaranteed. For example:

<div class="preWrapperWide" markdown="1">

    splice> CREATE TABLE t(col1 INT, col2 CHAR);
    splice> CALL SYSCS_UTIL.SET_MIN_RETENTION_PERIOD('SPLICE','T', 300);
    splice> INSERT INTO t VALUES(48, 'y');
    splice> INSERT INTO t VALUES(50, 'z');
    splice> VALUES current_timestamp;
    2020-09-18 22:20:41.024397
    splice> DELETE FROM t WHERE col1 = 48;
    splice> CALL SYSCS_UTIL.SYSCS_FLUSH_TABLE('SPLICE', 'T');
    splice> CALL SYSCS_UTIL.SET_PURGE_DELETED_ROWS('SPLICE', 'T', false);
    splice> CALL SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE('SPLICE', 'T');
    splice> SELECT * FROM T AS OF TIMESTAMP('2020-09-18 22:20:41.024397');
    COL1|COL2
    ---------
    50|z
    48|y

{: .Example xml:space="preserve"}

</div>


## See Also

* [AS OF](sqlref_clauses_asof.html) clause
* [SET_MIN_RETENTION_PERIOD](sqlref_sysprocs_setminretentionperiod.html) system procedure


</div>
</section>
