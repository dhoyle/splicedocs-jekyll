## From BulkImport Tutorial Page
======================================

==============================================

## From Error and Logging Page

This topic describes the logging and error handling features of Splice Machine data imports.

## Logging

Each of these import procedures includes a logging facility:

*  [`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html)
*  [`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html)
*  [`SYSCS_UTIL.MERGE_DATA_FROM_FILE`](sqlref_sysprocs_mergedata.html)
*  [`SYSCS_UTIL.BULK_IMPORT_HFILE`](sqlref_sysprocs_importhfile.html)

Errors are logged to a file in the directory that you specify in the `badRecordDirectory` parameter when you call one of the procedures.

The `badRecordDirectory` parameter is a string that specifies the directory in which bad record information is logged. The default value is the directory in which the import files are found.

Splice Machine logs information to the `<import_file_name>.bad` file in this directory; for example, bad records in an input file named `foo.csv` would be logged to a file named *badRecordDirectory*`/foo.csv.bad`.

The `badRecordDirectory` directory must be writable by the hbase user,
either by setting the user explicity, or by opening up the permissions;
for example:

<div class="preWrapper" markdown="1">
    sudo -su hdfs hadoop fs -chmod 777 /badRecordDirectory
{: .ShellCommand}
</div>

On a cluster, the `badRecordDirectory` directory **MUST be on S3, HDFS (or
MapR-FS)**. If you're using our Database Service product, this directory must be on S3.
{: .noteNote}

## Stopping the Import Due to Too Many Errors

All of the import procedures also take a `badRecordsAllowed` or `maxBadRecords` parameter, the value of which determines how many erroneous input data record errors are allowed before the import is stopped. If this count of rejected records is reached, the import fails, and any successful record imports are rolled back.

These `badRecordsAllowed` values have special meaning:

* If you specify `-1`, all record import failures are tolerated and logged.
* If you specify `0`, the import will fail as soon as one bad record is detected.

## Managing Logging When Importing Multiple Files

In addition to importing a single file, the &nbsp;[`SYSCS_UTIL.IMPORT_DATA`](sqlref_sysprocs_importdata.html) and
  &nbsp;[`SYSCS_UTIL.UPSERT_DATA_FROM_FILE`](sqlref_sysprocs_upsertdata.html) procedures can import all of the files in a directory.

When you are importing a large amount of data and have divided the files
you are importing into groups, then it's a good idea to change the
location of the bad record directory for each group; this will make
debugging bad records a lot easier for you.

You can change the value of the `badRecordDirectory` to include your
group name; for example, we typically use a strategy like the following:

<table style="width: 100%;">
    <col />
    <col />
    <thead>
        <tr>
            <th>Group Files Location</th>
            <th><span class="CodeBoldFont">badRecordDirectory</span> Parameter Value</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>/data/mytable1/group1</code></td>
            <td><code>/BAD/mytable1/group1</code></td>
        </tr>
        <tr>
            <td><code>/data/mytable1/group2</code></td>
            <td><code>/BAD/mytable1/group2</code></td>
        </tr>
        <tr>
            <td><code>/data/mytable1/group3</code></td>
            <td><code>/BAD/mytable1/group3</code></td>
        </tr>
    </tbody>
</table>
You'll then be able to more easily discover where the problem record is
located.

==============================================

## From ImportExamples Page

## Example 1: Importing data into a table with fewer columns than in the file   {#Example1}

If the table into which you're importing data has less columns than the
data file that you're importing, how the "extra" data columns in the
input data are handled depends on whether you specify an
`insertColumnList`:

* If you don't specify a specify an `insertColumnList` and your input file
  contains more columns than are in the table, then the the extra
  columns at the end of each line in the input file are ignored. For
  example, if your table contains columns `(a, b, c)` and your file
  contains columns `(a, b, c, d, e)`, then the data in your file's `d` and `e`
  columns will be ignored.
* If you do specify an `insertColumnList` to `IMPORT_DATA` or `MERGE_DATA`, and the number of columns
  in your input file doesn't match the number in your table, then any other columns in your table will be
  replaced by the default value for the table column (or `NULL` if there
  is no default for the column). For example, if your table contains
  columns (a, b, c) and you only want to import columns (a, c), then the
  data in table's b column will be replaced with the default value (or `NULL`) for
  that column.

Here's an example that does not specify a column list. If you create a
table with this statement:

<div class="preWrapper" markdown="1">
    CREATE TABLE playerTeams(ID int primary key, Team VARCHAR(32));
{: .Example xml:space="preserve"}

</div>
And your data file looks like this:

<div class="preWrapper" markdown="1">
    1,Cards,Molina,Catcher2,Giants,Posey,Catcher3,Royals,Perez,Catcher
{: .Example xml:space="preserve"}

</div>
When you import the file into `playerTeams`, only the first two columns
are imported:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA('SPLICE','playerTeams',null, 'myData.csv',
       null, null, null, null, null, 0, 'importErrsDir', true, null);
    SELECT * FROM playerTeams ORDER by ID;

    ID   |TEAM
    --------------
    1    |Cards2    |Giants
    3    |Royals3 rows selected
{: .Example xml:space="preserve"}

</div>

### How Missing Columns are Handled With an Insert Column List   {#Example2}

In this example, we\'ll illustrate how the different data importation
procedures modify columns in your table when you\'ve specified an
`insertColumnList` that is not 1-to-1 with the columns in your table.

The `SYSCS_UTIL.IMPORT_DATA` and `SYSCS_UTIL.UPSERT_DATA_FROM_FILE`
procedures handle this situation in the same way, assigning default
values (or NULL if no default is defined) to any table column that is
not being inserted or updated from the input data file. The
`SYSCS_UTIL.MERGE_DATA_FROM_FILE` handles this differently: it does not overwrite generated values
when updating records.

This distinction is particularly important when loading record updates
into a table with auto-generated column values that you do not want
overwritten.
{: .noteNote}

We\'ll create two sample tables, populate each with the same data, and
load the same input file data into each to illustrate the differences
between how the `Upsert` and `Merge` procedures.

<div class="preWrap" markdown="1">
    CREATE SCHEMA test;
    SET SCHEMA test;
    CREATE TABLE testUpsert (
             a1 INT,
             b1 INT,
             c1 INT GENERATED BY DEFAULT AS IDENTITY(start with 1, increment by 1),
             d1 INT DEFAULT 999,
             PRIMARY KEY (a1)
     );

    CREATE TABLE testMerge (
             a1 INT,
             b1 INT,
             c1 INT GENERATED BY DEFAULT AS IDENTITY(start with 1, increment by 1),
             d1 INT DEFAULT 999,
             PRIMARY KEY (a1)
     );

    INSERT INTO testUpsert(a1,b1) VALUES (1,1), (2,2), (3,3), (6,6);
    splice> select * from testUpsert;
    A1         |B1         |C1         |D1
    -----------------------------------------------
    1          |1          |1          |999
    2          |2          |2          |999
    3          |3          |3          |999
    6          |6          |4          |999

    4 rows selected

    INSERT INTO testMerge (a1,b1) VALUES (1,1), (2,2), (3,3), (6,6);
    splice> select * from testMerge;
    A1         |B1         |C1         |D1
    -----------------------------------------------
    1          |1          |1          |999
    2          |2          |2          |999
    3          |3          |3          |999
    6          |6          |4          |999

    4 rows selected
{: .Example}

</div>
Note that column `c1` contains auto-generated values, and that column `
d1` has the default value 999.
{: .spaceAbove}

Here\'s the data that we\'re going to import from file `ttest.csv`\:

<div class="preWrap" markdown="1">
    0|0
    1|2
    2|4
    3|6
    4|8
{: .Example}

</div>
Now, let\'s call `UPSERT_DATA_FROM_FILE` and `MERGE_DATA_FROM_FILE` and see how the results differ:
{: .spaceAbove}

<div class="preWrap" markdown="1">

    CALL SYSCS_UTIL.UPSERT_DATA_FROM_FILE('TEST','testUpsert','a1,b1','/Users/garyh/Documents/ttest.csv','|',null,null,null,null,0,'/var/tmp/bad/',false,null);
    rowsImported        |failedRows          |files      |dataSize            |failedLog
    -------------------------------------------------------------------------------------
    5                   |0                   |1          |20                  |NONE

    splice> SELECT * FROM testUpsert;
    A1         |B1         |C1         |D1
    -----------------------------------------------
    0          |0          |10001      |999
    1          |2          |10002      |999
    2          |4          |10003      |999
    3          |6          |10004      |999
    4          |8          |10005      |999
    6          |6          |4          |999

    6 rows selected

    CALL SYSCS_UTIL.MERGE_DATA_FROM_FILE('TEST','testMerge','a1,b1','/Users/garyh/Documents/ttest.csv','|',null,null,null,null,0,'/var/tmp/bad/',false,null);
    rowsUpdated         |rowsInserted        |failedRows          |files      |dataSize            |failedLog
    ---------------------------------------------------------------------------------------------------------
    3                   |2                   |0                   |1          |20                  |NONE

    splice> select * from testMerge;
    A1         |B1         |C1         |D1
    -----------------------------------------------
    0          |0          |10001      |999
    1          |2          |1          |999
    2          |4          |2          |999
    3          |6          |3          |999
    4          |8          |10002      |999
    6          |6          |4          |999

    6 rows selected
{: .Example}

</div>
You\'ll notice that:
{: .spaceAbove}

* The generated column (`c1`) is not included in the `insertColumnList`
  parameter in these calls.
* The results are identical except for the values in the generated
  column.
* The generated values in `c1` are not updated in existing records when
  merging data, but are updated when upserting data.

### Example 3: Importing a subset of data from a file into a table   {#Example3}

This example uses the same table and import file as does the previous
example, and it produces the same results. The difference between these
two examples is that this one explicitly imports only the first two
columns (which are named `ID` and `TEAM`) of the file and uses the `IMPORT_DATA` procedure:

<div class="preWrapper" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA('SPLICE','playerTeams', 'ID, TEAM', 'myData.csv',
     null, null, null, null, null, 0, 'importErrsDir', true, null);SELECT * FROM playerTeams ORDER by ID;ID   |TEAM
    --------------
    1    |Cards
    2    |Giants
    3    |Royal
    s3 rows selected
{: .Example xml:space="preserve"}

</div>
### Example 4: Specifying a timestamp format for an entire table   {#Example4}

This examples demonstrates how you can use a single timestamp format for the entire table by explicitly
specifying a single `timeStampFormat`. Here's the data:

<div class="preWrapper" markdown="1">
    Mike,2013-04-21 09:21:24.98-05
    Mike,2013-04-21 09:15:32.78-04
    Mike,2013-03-23 09:45:00.68-05
{: .Example xml:space="preserve"}

</div>
You can then import the data with the following call:

<div class="preWrapper" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA('app','tabx','c1,c2',
        '/path/to/ts3.csv',
        ',', '''',
        'yyyy-MM-dd HH:mm:ss.SSZ',
        null, null, 0, null, true, null);
{: .Example xml:space="preserve"}

</div>
Note that the time shown in the imported table depends on the timezone setting in the server timestamp.
In other words, given the same csv file, if imported on different
servers with timestamps set to different time zones, the value in the
table shown will be different. Additionally, daylight savings time may
account for a 1-hour difference if timezone is specified.
{: .noteIcon}

### Example 5: Importing strings with embedded special characters    {#Example5}

This example imports a csv file that includes newline (`Ctrl-M`)
characters in some of the input strings. We use the default double-quote character
as our character delimiter to import data such as the following:

<div class="preWrapperWide" markdown="1">
    1,This field is one line,Able
    2,"This field has two lines
    This is the second line of the field",Baker
    3,This field is also just one line,Charlie
{: .Example xml:space="preserve"}

</div>
We then use the following call to import the data:

<div class="preWrapperWide" markdown="1">
    SYSCS_UTIL.IMPORT_DATA('SPLICE', 'MYTABLE', null, 'data.csv' , '\t', null, null, null, null, 0, 'importErrsDir', false, null);
{: .Example xml:space="preserve"}

</div>
We can also explicitly specify double quotes (or any other character) as
our delimiter character for strings:

<div class="preWrapperWide" markdown="1">
    SYSCS_UTIL.IMPORT_DATA('SPLICE', 'MYTABLE', null, 'data.csv', '\t', '"', null, null, null, 0, 'importErrsDir', false, null);
{: .Example xml:space="preserve"}

</div>
### Example 6: Using single quotes to delimit strings   {#Example6}

This example performs the same import as the previous example, simply
substituting single quotes for double quotes as the character delimiter
in the input:

<div class="preWrapperWide" markdown="1">
    1,This field is one line,Able
    2,'This field has two lines
    This is the second line of the field',Baker
    3,This field is also just one line,Charlie
{: .Example xml:space="preserve"}

</div>
Note that you must escape single quotes in SQL, which means that you
actually define the character delimiter parameter with four single
quotes, as shown here:

<div class="preWrapperWide" markdown="1">
    SYSCS_UTIL.IMPORT_DATA('SPLICE', 'MYTABLE', null, 'data.csv', '\t', '''', null, null, null, 0, 'importErrsDir', false, null);
{: .Example xml:space="preserve"}

</div>

================================================================

## From ImportTPCH Page
