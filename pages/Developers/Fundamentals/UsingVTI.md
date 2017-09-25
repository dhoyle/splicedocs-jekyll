---
title: Using the Splice Machine VTI
summary: How to use the Splice Machine Virtual Table Interface (VTI) to access other data sources.
keywords: VTI, virtual tables, table functions
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_fundamentals_vti.html
folder: Developers/Fundamentals
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using the Splice Machine Virtual Table Interface (VTI)   {#top}

The Virtual Table Interface (VTI) allows you to use an SQL interface
with data that is external to your database. This topic introduces the
Splice Machine VTI in these sections:

* [About VTI](#About) describes the virtual table interface.
* [Splice Machine Built-in Virtual Table Interfaces](#Splice) describes
  the virtual table interfaces built into Splice Machine, and provides
  examples of using each.
* [Creating a Custom Virtual Table Interface](#Creating) walks you
  through the steps required to create a custom virtual table interface,
  and demonstrates how to simplify its use with a table function.
* [The Splice Machine Built-in VTI Classes](#VirtualFile) provides
  reference descriptions of the virtual table interface classes built
  into by Splice Machine.

## About VTI   {#About}

You can use the Splice Machine Virtual Table Interface (*VTI*) to access
data in external files, libraries, and databases.

A virtual table is a view of data stored elsewhere; the data itself is
not duplicated in your Splice Machine database.
{: .noteNote}

The external data source can be any information source, including:

* XML formatted reports and logs.
* Queries that run in external databases that support JDBC, such as
  Oracle and DB2.
* RSS feeds.
* Flat files in formats such as comma-separated value (csv) format.

### About Table Functions

A *table function* returns `ResultSet` values that you can query like
you do tables that live in your Splice Machine database. A table
function is bound to a constructor for a custom VTI class. Here's an
example of a declaration for a table function that is bound to the
`PropertiesFileVTI` class, which we walk you through implementing later
in this topic:

<div class="preWrapperWide" markdown="1">
    CREATE FUNCTION propertiesFile(propertyFilename VARCHAR(200))    RETURNS TABLE       (         KEY_NAME varchar(100)         VALUE varchar(200)       )    LANGUAGE JAVA    PARAMETER STYLE SPLICE_JDBC_RESULT_SET    READS SQL DATA    EXTERNAL NAME 'com.splicemachine.tutorials.vti.PropertiesFIleVTI.getPropertiesFileVTI';
{: .Example}

</div>
## Splice Machine Built-in Virtual Table Interfaces   {#Splice}

Splice Machine provides two built-in VTI classes that you can use:

<table>
                <col />
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Class</th>
                        <th>Description</th>
                        <th>Implemented by</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>SpliceFileVTI</code></td>
                        <td>For querying delimited flat files, such as CSV files.</td>
                        <td><code>com.splicemachine.derby.vti.SpliceFileVTI</code></td>
                    </tr>
                    <tr>
                        <td><code>SpliceJDBCVTI</code></td>
                        <td>For querying data from external sources that support the JDBC API.</td>
                        <td><code>com.splicemachine.derby.vti.SpliceJDBCVTI</code></td>
                    </tr>
                </tbody>
            </table>
Each of these classes implements the `DatasetProvider` interface, which
is used by Spark for creating execution trees, and the `VTICosting`
interface, which is used by the Splice Machine optimizer.

#### SpliceFileVTI Example

For example, if we have an input file named `vtiInfile.csv` that
contains this information:

<div class="preWrapperWide" markdown="1">
    sculligan,Relief Pitcher,27,08-27-2015,2015-08-27 08:08:08,06:08:08
    jpeepers,Catcher,37,08-26-2015,2015-08-21 08:09:08,08:08:08
    mbamburger,Manager,47,08-25-2015,2015-08-20 08:10:08,10:08:08
    gbrown,Batting Coach,46,08-24-2015,2015-08-21 08:11:08,11:08:08
    jardson,Left Fielder,34,08-23-2015,2015-08-22 08:12:08,11:08:08
{: .Example}

</div>
We can use the `SpliceFileVTI` class to select and display the contents
of our input file:

<div class="preWrapperWide" markdown="1">
    SELECT * FROM new com.splicemachine.derby.vti.SpliceFileVTI(
      '/<path>/data/vtiInfile.csv','',',') AS b
       (name VARCHAR(10), title VARCHAR(30), age INT, something VARCHAR(12), date_hired TIMESTAMP, clock TIME);NAME        |TITLE             |AGE   |SOMETHING   |DATE_HIRED             |CLOCK
    ---------------------------------------------------------------------------------------
    sculligan   |Relief Pitcher    |27    |08X-27-2015 |2015-08-27 08:08:08.0  |06:08:08
    jpeepers    |Catcher           |37    |08-26-2015  |2015-08-21 08:09:08.0  |08:08:08
    mbamburger  |Manager           |47    |08-25-2015  |2015-08-20 08:10:08.0  |10:08:08
    gbrown      |Batting Coach     |46    |08-24-2015  |2015-08-21 08:11:08.0  |11:08:08
    jardson     |Left Fielder      |34    |08-23X-2015 |2015-08-22 08:12:08.0  |11:08:08
    
    5 rows selected
{: .Example}

</div>
#### SpliceJDBCVTI Example

We can use the `SpliceJDBCVTI` class to select and display the contents
a table in a JDBC-compliant database. For example, here we query a table
stored in a MySQL database:

<div class="preWrapperWide" markdown="1">
    SELECT * FROM new com.splicemachine.derby.vti.SpliceJDBCVTI(
      'jdbc:mysql://localhost/hr?user=root&password=mysql-passwd','mySchema','myTable') AS b
       (name VARCHAR(10), title VARCHAR(30), age INT, something VARCHAR(12), date_hired TIMESTAMP, clock TIME);NAME        |TITLE             |AGE   |SOMETHING   |DATE_HIRED             |CLOCK
    ---------------------------------------------------------------------------------------
    sculligan   |Relief Pitcher    |27    |08X-27-2015 |2015-08-27 08:08:08.0  |06:08:08
    jpeepers    |Catcher           |37    |08-26-2015  |2015-08-21 08:09:08.0  |08:08:08
    mbamburger  |Manager           |47    |08-25-2015  |2015-08-20 08:10:08.0  |10:08:08
    gbrown      |Batting Coach     |46    |08-24-2015  |2015-08-21 08:11:08.0  |11:08:08
    jardson     |Left Fielder      |34    |08-23X-2015 |2015-08-22 08:12:08.0  |11:08:08
    
    5 rows selected
{: .Example}

</div>
## Creating a Custom Virtual Table Interface   {#Creating}

You can create a custom virtual table interface by creating a class that
implements the `DatasetProvider` and `VTICosting` interfaces, which are
described below.

You can then use your custom VTI within SQL queries by using VTI syntax,
as shown in the examples in the previous section. You can also create a
table function for your custom VTI, and then call that function in your
queries, which simplifies using your interface.

This section walks you through creating a custom virtual table interface
that reads and displays the property keys and values in a properties
file. This interface can be executed using a table function or by
specifying its full method name in SQL statements.

The full code for this example is in the Splice [Community Sample Code
Repository on Github.][1]{: target="_blank"}
{: .noteIcon}

The remainder of this section is divided into these subsections:

* [Declare Your Class](#Declare)
* [Implement the Constructors](#Implemen)
* [Implement Your Method to Generate Results](#Implemen2)
* [Implement Costing Methods](#Implemen3)
* [Implement Other DatasetProvider Methods](#Implemen4)
* [Use Your Custom Virtual Table Interface](#Use)

### Declare Your Class   {#Declare}

The first thing you need to do is to declare your public class; since
we're creating an interface to read property files, we'll call our class
`PropertiesFileVTI`. To create a custom VTI interface, you need to
implement the following classes:
{: .body}

<table>
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Class</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>DatasetProvider</code></td>
                        <td>Used by Spark to construct execution trees.</td>
                    </tr>
                    <tr>
                        <td><code>VTICosting</code></td>
                        <td>Used by the Splice Machine optimizer to estimate the cost of operations.</td>
                    </tr>
                </tbody>
            </table>
Here's the declaration:
{: .body}

<div class="preWrapperWide" markdown="1">
    
    public class PropertiesFileVTI implements DatasetProvider, VTICosting {
    
        //Used for logging (and optional)
        private static final Logger LOG = Logger.getLogger(PropertiesFileVTI.class);
    
        //Instance variable that will store the name of the properties file that is being read
        private String fileName;
    
        //Provide external context which can be carried with the operation
        protected OperationContext operationContext;
{: .Example}

</div>
### Implement the Constructors   {#Implemen}

This section describes the constructors that we implement for our custom
class:
{: .body}

* You need to implement an empty constructor if you want to use your
  class in table functions:
  
  <div class="preWrapperWide" markdown="1">
      public PropertiesFileVTI()<![CDATA[
      ]]>
  {: .Example}
  
  </div>

* This is the signature used by invoking the VTI using the class name in
  SQL queries:
  
  <div class="preWrapperWide" markdown="1">
      public PropertiesFileVTI(String pfileName)<![CDATA[
      ]]>
  {: .Example}
  
  </div>

* This static constructor is called by the VTI - Table Function.
  
  <div class="preWrapperWide" markdown="1">
      public static DatasetProvider getPropertiesFileVTI(String fileName)<![CDATA[
      ]]>
  {: .Example}
  
  </div>

Here's our implementation of the constructors for the
`PropertiesFileVTI` class:
{: .body}

<div class="preWrapperWide" markdown="1">
    
    public PropertiesFileVTI() {}
    public PropertiesFileVTI(String pfileName) {
        this.fileName = pfileName;
    }
    
    public static DatasetProvider getPropertiesFileVTI(String fileName) {
        return new PropertiesFileVTI(fileName);
    }
{: .Example}

</div>
### Implement Your Method to Generate Results   {#Implemen2}

The heart of your virtual table interface is the `DatasetProvider`
method `getDataSet`, which you override to generate and return a
`DataSet`. It's declaration looks like this:
{: .body}

<div class="preWrapperWide" markdown="1">
    DataSet<LocatedRow> getDataSet(        SpliceOperation op,       // References the op at the top of the stack        DataSetProcessor dsp,     // Mechanism for constructing the execution tree        ExecRow execRow ) throws StandardException;
{: .Example}

</div>
The `VTIOperation` process calls this method to compute the `ResultSet`
that it should return. Our `PropertiesFileVTI` implementation is shown
here:
{: .body}

<div class="preWrapperWide" markdown="1">
    @Override
    public DataSet<LocatedRow> getDataSet(SpliceOperation op, DataSetProcessor dsp, ExecRow execRow) throws StandardException {
        operationContext = dsp.createOperationContext(op);
    
            //Create an arraylist to store the key-value pairs
        ArrayList<LocatedRow> items = new ArrayList<LocatedRow>();
    
        try {
            Properties properties = new Properties();
    
            //Load the properties file
            properties.load(getClass().getClassLoader().getResourceAsStream(fileName));
    
            //Loop through the properties and create an array
            for (String key : properties.stringPropertyNames()) {
                String value = properties.getProperty(key);
                ValueRow valueRow = new ValueRow(2);
                valueRow.setColumn(1, new SQLVarchar(key));
                valueRow.setColumn(2, new SQLVarchar(value));
                items.add(new LocatedRow(valueRow));
            }
        } catch (FileNotFoundException e) {
            LOG.error("File not found: " + this.fileName, e);
        } catch (IOException e) {
            LOG.error("Unexpected IO Exception: " + this.fileName, e);
        } finally {
            operationContext.popScope();
        }
        return new ControlDataSet<>(items);
    }
{: .Example}

</div>
### Implement Costing Methods   {#Implemen3}

The Splice Machine optimizer uses costing estimates to determine the
optimal execution plan for each query. You need to implement several
costing methods in your VTI class:
{: .body}

* `getEstimatedCostPerInstantiation` returns the estimated cost to
  instantiate and iterate through your table function. Unless you have
  an accurate means of estimating this cost, simply return `0` in your
  implementation.
  
  <div class="preWrapperWide" markdown="1">
      public double getEstimatedCostPerInstantiation( VTIEnvironment vtiEnv) throws SQLException;
  {: .Example}
  
  </div>

* `getEstimatedRowCount` returns the estimated row count for a single
  scan of your table function. Unless you have an accurate means of
  estimating this cost, simply return `0` in your implementation.
  
  <div class="preWrapperWide" markdown="1">
      public double getEstimatedCostPerInstantiation( VTIEnvironment vtiEnv) throws SQLException;
  {: .Example}
  
  </div>

* `supportsMultipleInstantiations` returns a Boolean value indicating
  whether your table function's `ResultSet` can be instantiated multiple
  times in a single query. For our `PropertiesFileVTI` implementation of
  this method, we simply return `False`, since there's no reason for our
  function to be used that way.
  
  <div class="preWrapperWide" markdown="1">
      public double supportsMultipleInstantiations( VTIEnvironment vtiEnv) throws SQLException;
  {: .Example}
  
  </div>

The VTICosting methods each take a `VTIEnvironment` argument; this is a
state variable created by the Splice Machine optimizer, which methods
can use to pass information to each other or to learn other details
about the operating environment..
{: .noteNote}

Here is the implementation of costing methods for our
`PropertiesFileVTI` class:
{: .body}

<div class="preWrapperWide" markdown="1">
    
    @Override
    public double getEstimatedCostPerInstantiation(VTIEnvironment arg0) throws SQLException {
        return 0;
    }
    
    @Override
    public double getEstimatedRowCount(VTIEnvironment arg0) throws SQLException {
        return 0;
    }<![CDATA[
    ]]>
    @Override
    public boolean supportsMultipleInstantiations(VTIEnvironment arg0) throws SQLException {
        return false;
    }
{: .Example}

</div>
### Implement Other DatasetProvider Methods   {#Implemen4}

You also need to implement two additional `DatasetProvider` methods:
{: .body}

* `getOperationContext` simply returns the current operation context
  (this.`operationContext`).
  
  <div class="preWrapperWide" markdown="1">
      OperationContext getOperationContext();
  {: .Example}
  
  </div>

* `getMetaData` returns metadata that is used to dynamically bind your
  table function; this metadata includes a column descriptor for each
  column in your virtual table, including the name of the column, its
  type, and its size. In our `PropertiesFileVTI`, we assign the
  descriptors to a static variable, and our implementation of this
  method simply returns that value.
  
  <div class="preWrapperWide" markdown="1">
      ResultSetMetaData getMetaData() throws SQLException;
  {: .Example}
  
  </div>

Here is the implementation of these methods for our
`PropertiesFileVTI` class:
{: .body}

<div class="preWrapperWide" markdown="1">
    
    @Override
    public OperationContext getOperationContext() {
        return this.operationContext;
    }@Override
    public ResultSetMetaData getMetaData() throws SQLException {
        return metadata;
    }
    
    private static final ResultColumnDescriptor[] columnInfo = {
            EmbedResultSetMetaData.getResultColumnDescriptor("KEY1", Types.VARCHAR, false, 200),
            EmbedResultSetMetaData.getResultColumnDescriptor("VALUE", Types.VARCHAR, false, 200),
    };
    
    private static final ResultSetMetaData metadata = new EmbedResultSetMetaData(columnInfo);
    }
{: .Example}

</div>
### Use Your Custom Virtual Table Interface   {#Use}

You can create a table function in your Splice Machine database to
simplify use of your custom VTI. Here's a table declaration for our
custom interface:
{: .body}

<div class="preWrapperWide" markdown="1">
    CREATE FUNCTION propertiesFile(propertyFilename VARCHAR(200))    RETURNS TABLE       (         KEY_NAME varchar(100)         VALUE varchar(200)       )    LANGUAGE JAVA    PARAMETER STYLE SPLICE_JDBC_RESULT_SET    READS SQL DATA    EXTERNAL NAME 'com.splicemachine.tutorials.vti.PropertiesFIleVTI.getPropertiesFileVTI';
{: .Example}

</div>
You can now use your interface with table function syntax; for example:
{: .body}

<div class="preWrapperWide" markdown="1">
    select * from table (propertiesFile('sample.properties')) b;
{: .Example}

</div>
You can also use your interface by using VTI syntax in an SQL query; for
example:
{: .body}

<div class="preWrapperWide" markdown="1">
    select * from new com.splicemachine.tutorials.vti.PropertiesFileVTI('sample.properties')    as b (KEY_NAME VARCHAR(20), VALUE VARCHAR(100));
{: .Example}

</div>
## The Splice Machine Built-in VTI Classes   {#VirtualFile}

This section describes the built-in VTI classes:

* [The `SpliceFileVTI` class ](#The)
* [The `SpliceJDBCVTI` class ](#Using)

### The SpliceFileVTI Class   {#The}

You can use the `SpliceFileVTI` class to apply SQL queries to a file,
such as a csv file, as shown in the examples below.

#### Constructors

You can use the following constructor methods with the
`SpliceFileVTI` class. Each creates a virtual table from a file:

<div class="fcnWrapperWide" markdown="1">
    public SpliceFileVTI(String fileName)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="fcnWrapperWide" markdown="1">
    
    public SpliceFileVTI(String fileName,                     String characterDelimiter,                     String columnDelimiter)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="fcnWrapperWide" markdown="1">
    
    public SpliceFileVTI(String fileName,                     String characterDelimiter,                     String columnDelimiter,                     boolean oneLineRecords)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
fileName
{: .paramName}

The name of the file that you are reading.
{: .paramDefnFirst}

characterDelimiter
{: .paramName}

Specifies which character is used to delimit strings in the imported
data. You can specify `null` or the empty string (`''`) to use the
default string delimiter, which is the double-quote (`"`). If your input
contains control characters such as newline characters, make sure that
those characters are embedded within delimited strings.
{: .paramDefnFirst}

columnDelimiter
{: .paramName}

The character used to separate columns, Specify `null` if using the
comma (`,`) character as your delimiter. Note that the backslash
(`\`) character is not allowed as the column delimiter.
{: .paramDefnFirst}

oneLineRecords
{: .paramName}

A Boolean value that specifies whether each line in the import file
contains one complete record; if you specify false, records can span
multiple lines in the input file.
{: .paramDefnFirst}

</div>
### The SpliceJDBCVTI Class    {#Using}

You can use the `SpliceJDBCVTI` class to access external databases that
provide JDBC connections.

#### Constructors

You can use the following constructor methods with the
`SpliceJDBCVTI` class.

<div class="fcnWrapperWide" markdown="1">
    
    public SpliceJDBCVTI(String connectionUrl,                     String schemaName,                     String tableName)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
connectionURL
{: .paramName}

The URL of the database connection you are using.
{: .paramDefnFirst}

schemaName
{: .paramName}

The name of the database schema.
{: .paramDefnFirst}

tableName
{: .paramName}

The name of the table in the database schema.
{: .paramDefnFirst}

</div>
<div class="fcnWrapperWide" markdown="1">
    
    public SpliceJDBCVTI(String connectionUrl,                     String sql)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
connectionURL
{: .paramName}

The URL of the database connection you are using.
{: .paramDefnFirst}

sql
{: .paramName}

The SQL string to execute in that database.
{: .paramDefnFirst}

</div>
## See Also

We recommend visiting the [Derby VTI documentation][2]{:
target="_blank"}, which provides full reference documentation for the
VTI class hierarchy.
{: .body}

</div>
</section>



[1]: https://github.com/splicemachine/splice-community-sample-code
[2]: http://db.apache.org/derby/docs/10.9/publishedapi/jdbc3/org/apache/derby/vti/package-summary.html
