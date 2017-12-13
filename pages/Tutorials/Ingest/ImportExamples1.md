---
title: "Importing Data 5: Usage Examples"
summary: Walk-throughs of using the built-in import, upsert, and merge procedures.
keywords: import, upsert, merge
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_ingest_importexamples1.html
folder: Tutorials/Ingest
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Importing Data: Examples of Using the Import, Upsert, and Merge Procedures

This topic provides several examples of importing data into Splice
Machine using our *standard* import procedures (`IMPORT_DATA`, `UPSERT_DATA_FROM_FILE`, and `MERGE_DATA_FROM_FILE`):

  * [Example 1: Importing data into a table with fewer columns than in the
  file](#Example1)
  * [Example 2: How Upsert and Merge handle missing columns
  differently](#Example2)
  * [Example 3: Importing a subset of data from a file into a
  table](#Example3)
  * [Example 4: Specifying a timestamp format for an entire
  table](#Example4)
  * [Example 5: Importing strings with embedded special characters
  ](#Example5)
  * [Example 6: Using single quotes to delimit strings](#Example6)

The [6: Bulk HFile Examples](tutorials_ingest_importexampleshfile.html) topic contains examples of using the Bulk HFile import mechanism, which increases performance but lacks constraint checking.

The [1: Import Overview](tutorials_ingest_importoverview.html) topic provides the information you need to decide which of our import procedures best meets your needs.

### Example 1: Importing data into a table with fewer columns than in the file   {#Example1}

If the table into which you're importing data has less columns than the
data file that you're importing, how the "extra" data columns in the
input data are handled depends on whether you specify an
`insertColumnList`:

* If you don't specify a specify an insertColumnList and your input file
  contains more columns than are in the table, then the the extra
  columns at the end of each line in the input file are ignored. For
  example, if your table contains columns (a, b, c) and your file
  contains columns (a, b, c, d, e), then the data in your file's d and e
  columns will be ignored.
* If you do specify an insertColumnList, and the number of columns
  doesn't match your table, then any other columns in your table will be
  replaced by the default value for the table column (or NULL if there
  is no default for the column). For example, if your table contains
  columns (a, b, c) and you only want to import columns (a, c), then the
  data in table's b column will be replaced with the default value for
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
       null, null, null, null, null, 0, 'importErrsDir', true, null);SELECT * FROM playerTeams ORDER by ID;ID   |TEAM
    --------------
    1    |Cards2    |Giants
    3    |Royals3 rows selected
{: .Example xml:space="preserve"}

</div>
### How Missing Columns are Handled With an Insert Column List   {#Example2}

{% include splice_snippets/importprocsexample.md %}

### Example 3: Importing a subset of data from a file into a table   {#Example3}

This example uses the same table and import file as does the previous
example, and it produces the same results, The difference between these
two examples is that this one explicitly imports only the first two
columns (which are named `ID` and `TEAM`) of the file:

<div class="preWrapper" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA('SPLICE','playerTeams', 'ID, TEAM', 'myData.csv',
     null, null, null, null, null, 0, 'importErrsDir', true, null);SELECT * FROM playerTeams ORDER by ID;ID   |TEAM
    --------------
    1    |Cards2    |Giants
    3    |Royals3 rows selected
{: .Example xml:space="preserve"}

</div>
### Example 4: Specifying a timestamp format for an entire table   {#Example4}

Use a single timestamp format for the entire table by explicitly
specifying a single `timeStampFormat`.

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
Note that for any import use case shown above, the time shown in the
imported table depends on the timezone setting in the server timestamp.
In other words, given the same csv file, if imported on different
servers with timestamps set to different time zones, the value in the
table shown will be different. Additionally, daylight savings time may
account for a 1-hour difference if timezone is specified.

### Example 5: Importing strings with embedded special characters    {#Example5}

This example imports a csv file that includes newline (`Ctrl-M`)
characters in some of the input strings. We use the default double-quote
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
quotes, as follow

<div class="preWrapperWide" markdown="1">
    SYSCS_UTIL.IMPORT_DATA('SPLICE', 'MYTABLE', null, 'data.csv', '\t', '''', null, null, null, 0, 'importErrsDir', false, null);
{: .Example xml:space="preserve"}

</div>
