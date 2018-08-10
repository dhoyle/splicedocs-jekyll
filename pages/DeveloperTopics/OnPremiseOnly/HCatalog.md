---
title: Using HCatalog with Splice Machine
summary: How to access Splice Machine as a data source using HCatalog.
keywords: HCatalog, metadata, HDFS
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_fundamentals_hcatalog.html
folder: DeveloperTopics/OnPremiseOnly
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using Splice Machine with HCatalog

Apache HCatalog is a metadata and table management system for the
broader Hadoop platform. HCatalogs table abstraction presents users with
a relational view of data in the Hadoop distributed file system (HDFS)
and ensures that users need not worry about where or in what format
their data is stored. HCatalog supports reading and writing files in any
format for which a SerDe (serializer-deserializer) can be written.

{% include splice_snippets/onpremonlytopic.md %}

Splice Machine integrates with HCatalog, allowing any HiveQL statements
to read from (e.g. `SELECT`) and write to (e.g. `INSERT`) Splice Machine
tables. You can also use joins and unions to combine native Hive tables
with Splice Machine tables.

You can find extensive information about HCatalog on the [Apache Hive
web site][1]{: target="_blank"}.
{: .noteTip}

Also note that you can also take advantage of our HCatalog integration
to access your Splice Machine tables for reading and writing from any
database that features HCatalog integration, such as *MongoDB*.

## Using HCatalog with a Splice Machine Table

To use HCatalog with Splice Machine, you connect a Hive table with a
Splice Machine table using the HiveQL `CREATE EXTERNAL TABLE` statement.
In Hive, an external table can point to any HDFS location for its
storage; in this case, the table is located in your Splice Machine
database.

For example, here's a HiveQL statement that creates a table named
`extTest1` that is connected with the `hcattest` table in a Splice
Machine database:

<div class="preWrapperWide" markdown="1">
    hive> CREATE EXTERNAL TABLE extTest1(col1 int, col2 varchar(20))
       STORED BY 'com.splicemachine.mrio.api.hive.SMStorageHandler'
       TBLPROPERTIES ("splice.jdbc"="jdbc:splice://localhost:1527/splicedb\;user=yourUserId\;password=yourPassword", "splice.tableName"="TEST.hcattest");
{: .Example xml:space="preserve"}

</div>
Your table definition must include:

* The `STORED BY` clause as shown, which allows the table to connect
  with Splice Machine.
* The `TBLPROPERTIES` clause, which specifies:
  * The JDBC connection you are using. include your access <span
    class="HighlightedCode">user</span> ID and <span
    class="HighlightedCode">password</span>.

    If you are running Splice Machine on a cluster, connect from a
    machine that is NOT running an HBase RegionServer and specify the
    IP address of a <span class="HighlightedCode">regionServer</span>
    node, e.g. <span class="AppCommand">10.1.1.110</span>.

    Use `localhost` if you're running the standalone version of Splice
    Machine.
    {: .noteNote}

  * The name of the table in your Splice Machine database with which you
    are connecting the Hive table.
  {: .SecondLevel}

### How Splice Machine Maps Columns   {#How}

If your Hive table contains a different number of columns than does your
Splice Machine database table, Splice Machine maps the columns.

For example, if your Hive table has three columns defined, and your
Splice Machine table has four columns defined, then Splice Machine maps
the three Hive columns into the first three columns in the Splice
Machine table, as shown here:

![Diagram of how Splice Machine maps Hive tables](images/HiveMap.png){:
.indentedTightSpacing}

### Using HiveQL to Join Tables From Different Data Resources    {#Using}

You can use HiveQL to join tables that point to different data
resources. The Java class provided by Splice Machine allows you to
include tables from your Splice Machine database in such joins, as
illustrated here:

![Diagram of using HiveQL for joining tables](images/HiveJoin.png){:
.indentedTightSpacing}

For more information about Hive joins, see the Apache Hive
documentation.

## Examples

This section contains several simple examples of using HCatalog.

### Example 1: Simple Example

This is a simple example of creating an external table in Hive that maps
directly to a Splice Machine table.

<div class="opsStepsList" markdown="1">
1.  Create the Splice Machine table
    {: .topLevel}

    This example uses a very simple Splice Machine database table,
    `hcattest`, which we create with these statements:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        splice> create table hcattest(col1 int, col2 varchar(20));
        splice> insert into hcattest values(1, 'row1');
        splice> insert into hcattest values(2, 'row2');
        splice> insert into hcattest values(3, 'row3');
        splice> insert into hcattest values(4, 'row4');
    {: .AppCommand xml:space="preserve"}

    </div>

2.  Verify the table
    {: .topLevel}

    Verify that `hcattest` is set up correctly:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        splice> describe hcattest;
        COLUMN_NAME | TYPE_NAME | DES&|NUM&|COLUMN&|COLUMN_DEF|CHAR_OCTE&|IS_NULL&
        --------------------------------------------------------------------------
        COL1        |INTEGER    |0    |10  |10     |NULL      |NULL      |YES
        COL2        |VARCHAR    |NULL |NULL|20     |NULL      |40        |YES

        2 rows selected
        splice> select * from hcattest;
        COL1        |COL2
        -------------------------------
        1            row1
        2            row2
        3            row3
        4            row4

        4 rows selected
    {: .AppCommand xml:space="preserve"}

    </div>

3.  Create an external table in Hive
    {: .topLevel}

    You need to create an external table in Hive, and connect that table
    with the Splice Machine table you just created. Type the following
    command into the Hive shell, substituting your <span
    class="HighlightedCode">user</span> ID and <span
    class="HighlightedCode">password</span>.
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        hive> CREATE EXTERNAL TABLE extTest1(col1 int, col2 varchar(20))
           STORED BY 'com.splicemachine.mrio.api.hive.SMStorageHandler'
           TBLPROPERTIES ("splice.jdbc"="jdbc:splice://localhost:1527/splicedb\;user=yourUserId\;password=yourPassword", "splice.tableName"="SPLICE.hcattest");
    {: .AppCommand xml:space="preserve"}

    </div>

4.  Use HiveQL to select data in the Splice Machine table
    {: .topLevel}

    Once you've created your external table, you can use `SELECT`
    statements in the Hive shell to retrieve data from Splice Machine
    table. For example:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        hive> select * from extTest1;
        OK
        1row 1
        2row 2
        3row 3
        4row 4
    {: .AppCommand xml:space="preserve"}

    </div>

    If the external table that you created does not have the same number
    of columns as are in your Splice Machine table, then the Hive
    table's columns are mapped to columns in the Splice Machine table,
    as described in [How Splice Machine Maps Columns](#How), above.
    {: .indentLevel1}
{: .boldFont}

</div>
### Example 2: Table with Primary Key

This example uses a Splice Machine table, `tblA`, that has only string
types and a primary key.

<div class="opsStepsList" markdown="1">
1.  Create and verify the Splice Machine table
    {: .topLevel}

    This example uses a simple Splice Machine database table that we've
    created, `tblA`, which we verify:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        splice> describe tblA;
        COLUMN_NAME | TYPE_NAME | DES&|NUM&|COLUMN&|COLUMN_DEF|CHAR_OCTE&|IS_NULL&
        --------------------------------------------------------------------------
        COL1        |CHAR       |NULL |NULL|20     |NULL      |40        |YES
        COL2        |VARCHAR    |NULL |NULL|56     |NULL      |112       |YES

        2 rows selected
        splice> select * from tblA;
        COL1        |COL2
        -------------------------------
        char         varchar 2
        char 1       varchar 1

        2 rows selected
    {: .AppCommand xml:space="preserve"}

    </div>

2.  Create an external table in Hive
    {: .topLevel}

    You need to create an external table in Hive, and connect that table
    with the Splice Machine table you just created. Type the following
    command into the Hive shell, substituting your <span
    class="HighlightedCode">user</span> ID and <span
    class="HighlightedCode">password</span>.
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        hive> CREATE EXTERNAL TABLE extTest2(col1 String, col2 varchar(56))
           STORED BY 'com.splicemachine.mrio.api.hive.SMStorageHandler'
           TBLPROPERTIES ("splice.jdbc"="jdbc:splice://localhost:1527/splicedb\;user=yourUserId\;password=yourPassword", "splice.tableName"="SPLICE.tblA");
    {: .AppCommand xml:space="preserve"}

    </div>

3.  Use HiveQL to select data in the Splice Machine table
    {: .topLevel}

    Once you've created your external table, you can use `SELECT`
    statements in the Hive shell to retrieve data from Splice Machine
    table. For example:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        hive> select * from extTest2;
        OK
        char  varchar 2
        char 1varchar 1
    {: .AppCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>
### Example 3: Table with No Primary Key

This example uses a Splice Machine table, `tblB`, that has a primary key
and uses integer columns.

<div class="opsStepsList" markdown="1">
1.  Create and verify the Splice Machine table
    {: .topLevel}

    This example uses a simple Splice Machine database table that we've
    created, `tblA`, which we verify:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        splice> describe tblA;
        COLUMN_NAME | TYPE_NAME | DES&|NUM&|COLUMN&|COLUMN_DEF|CHAR_OCTE&|IS_NULL&
        --------------------------------------------------------------------------
        COL1        |INTEGER    |0    |10  |10     |NULL      |NULL      |NO
        COL2        |INTEGER    |0    |10  |10     |NULL      |NULL      |YES
        COL3        |INTEGER    |0    |10  |10     |NULL      |NULL      |NO

        3 rows selected
        splice> select * from tblB;
        COL1        |COL2       |COL3
        -------------------------------
        1           |1          |1
        2           |2          |2

        2 rows selected
    {: .AppCommand xml:space="preserve"}

    </div>

2.  Create an external table in Hive
    {: .topLevel}

    You need to create an external table in Hive, and connect that table
    with the Splice Machine table you just created. Type the following
    command into the Hive shell, substituting your <span
    class="HighlightedCode">user</span> ID and <span
    class="HighlightedCode">password</span>.
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        hive> CREATE EXTERNAL TABLE extTest3(col1 String, col2 varchar(56))
           STORED BY 'com.splicemachine.mrio.api.hive.SMStorageHandler'
           TBLPROPERTIES ("splice.jdbc"="jdbc:splice://localhost:1527/splicedb\;user=yourUserId\;password=yourPassword", "splice.tableName"="SPLICE.tblB");
    {: .AppCommand xml:space="preserve"}

    </div>

3.  Select data from the Splice Machine input table
    {: .topLevel}

    Once you've created your external table, you can use `SELECT`
    statements in the Hive shell to retrieve data from Splice Machine
    input table. table. For example:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        hive> select * from extTest3;
        OK
        111
        122
    {: .AppCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>
</div>
</section>



[1]: https://hive.apache.org/
