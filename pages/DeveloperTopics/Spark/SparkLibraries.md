---
title: Using Spark Libraries with Splice Machine
summary: Provides an example of using a Spark library in Splice Machine.
keywords: spark, libraries, collect statistics
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_spark_libs.html
folder: DeveloperTopics/Spark
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using Spark Libraries with Splice Machine

One of the great features of Spark is that a large number of libraries
have been and continue to be developed for use with Spark. This topic
provides an example of interfacing to the Spark Machine Learning library
(MLlib).

You can follow a similar path to interface with other Spark libraries,
which involves these steps:

1.  Create a class with an API that leverages functionality in the Spark
    library you want to use.
2.  Write a custom procedure in your Splice Machine database that
    converts a Splice Machine result set into a Spark Resilient
    Distributed Dataset (RDD).
3.  Use the Spark library with the RDD.

<div markdown="1">
## Example: Using Spark MLlib with Splice Machine Statistics

This section presents the sample code for interfacing Splice Machine
with the Spark Machine Learning Library (MLlib), in these subsections:

* [About the Splice Machine SparkMLibUtils Class API](#About) describes
  the SparkMLibUtils class that Splice Machine provides for interfacing
  with this library.
* [Creating our SparkStatistics Example Class](#Create) summarizes the
  `SparkStatistics` Java class that we created for this example.
* [Run a Sample Program to Use Our Class](#Run) shows you how to define
  a custom procedure in your database to interface to the
  `SparkStatistics` class.

### About the Splice Machine SparkMLibUtils Class API   {#About}

Our example makes use of the Splice Machine
`com.splicemachine.example.SparkMLibUtils` class, which you can use to
interface between your Splice Machine database and the Spark Machine
Learning library.

Here's are the public methods from the `SparkMLibUtils` class:

<div class="preWrapperWide" markdown="1">
    public static JavaRDDLocatedRow> resultSetToRDD(ResultSet rs)
       throws StandardException;

    public static JavaRDDVector> locatedRowRDDToVectorRDD(JavaRDDLocatedRow> locatedRowJavaRDD, int[] fieldsToConvert)
       throws StandardException;

    public static Vector convertExecRowToVector(ExecRow execRow,int[] fieldsToConvert)
       throws StandardException;

    public static Vector convertExecRowToVector(ExecRow execRow)
       throws StandardException;
{: .Example}

</div>
> resultSetToRDD
> {: .paramName}
>
> Converts a Splice Machine result set into a Spark Resilient
> Distributed Dataset (RDD) object.
> {: .paramDefnFirst}
>
> locatedRowRDDToVectorRDD
> {: .paramName}
>
> Transforms an RDD into a vector for use with the Machine Learning
> library. The `fieldsToConvert` parameter specifies which column
> positions to include in the vector.
> {: .paramDefnFirst}
>
> convertExecRowToVector
> {: .paramName}
>
> Converts a Splice Machine `execrow` into a vector. The
> `fieldsToConvert` parameter specifies which column positions to
> include in the vector.
> {: .paramDefnFirst}

### Creating our SparkStatistics Example Class   {#Create}

For this example, we define a Java class named SparkStatistics that can
query a Splice Machine table, convert that results into a Spark JavaRDD,
and then use the Spark MLlib to calculate statistics.

Our class, `SparkStatistics`, defines one public interface:

<div class="preWrapperWide" markdown="1">
    public class SparkStatistics {

        public static void getStatementStatistics(String statement, ResultSet[] resultSets) throws SQLException {
            try {
                // Run sql statement
                Connection con = DriverManager.getConnection("jdbc:default:connection");
                PreparedStatement ps = con.prepareStatement(statement);
                ResultSet rs = ps.executeQuery();

                // Convert result set to Java RDD
                JavaRDDLocatedRow> resultSetRDD = ResultSetToRDD(rs);

                // Collect column statistics
                int[] fieldsToConvert = getFieldsToConvert(ps);
                MultivariateStatisticalSummary summary = getColumnStatisticsSummary(resultSetRDD, fieldsToConvert);

                IteratorNoPutResultSet resultsToWrap = wrapResults((EmbedConnection) con,  getColumnStatistics(ps, summary, fieldsToConvert));
                resultSets[0] = new EmbedResultSet40((EmbedConnection)con, resultsToWrap, false, null, true);
           } catch (StandardException e) {
                throw new SQLException(Throwables.getRootCause(e));
            }
        }
    }
{: .Example}

</div>
We call the `getStatementStatistics` from custom procedure in our
database, passing it an SQL query . `getStatementStatistics` performs
the following operations:

<div class="opsStepsList" markdown="1">
1.  Query your database
    {: .topLevel}

    The first step is to use our JDBC driver to connect to your database
    and run the query:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        Connection con = DriverManager.getConnection("jdbc:default:connection");PreparedStatement ps = con.prepareStatement(statement);
        ResultSet rs = ps.executeQuery();
    {: .Example}

    </div>

2.  Convert the query results into a Spark RDD
    {: .topLevel}

    Next, we convert the query's result set into a Spark RDD:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        JavaRDD<LocatedRow> resultSetRDD = ResultSetToRDD(rs);
    {: .Example}

    </div>

3.  Calculate statistics
    {: .topLevel}

    Next, we use Spark to collect statistics for the query, using
    private methods in our `SparkStatistics` class:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        int[] fieldsToConvert = getFieldsToConvert(ps);MultivariateStatisticalSummary summary = getColumnStatisticsSummary(resultSetRDD, fieldsToConvert);
    {: .Example}

    </div>

    You can view the implementations of the `getFieldsToConvert` and
    `getColumnStatisticsSummary` methods in the *[Appendix](#Appendix)*
    at the end of this topic.
    {: .indentLevel1}

4.  Return the results
    {: .topLevel}

    Finally, we return the results:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        IteratorNoPutResultSet resultsToWrap = wrapResults((EmbedConnection) con, getColumnStatistics(ps, summary, fieldsToConvert));
        resultSets[0] = new EmbedResultSet40((EmbedConnection)con, resultsToWrap, false, null, true);
    {: .Example}

    </div>
{: .boldFont}

</div>
 

### Run a Sample Program to Use Our Class   {#Run}

Follow these steps to run a simple example program to use the Spark
MLlib library to calculate statistics for an SQL statement.

<div class="opsStepsList" markdown="1">
1.  Create Your API Class
    {: .topLevel}

    The first step is to create a Java class that uses Spark to generate
    and analyze statistics, as shown in the previous section, [Creating
    our SparkStatistics Example Class](#Create)
    {: .indentLevel1}

2.  Create your custom procedure
    {: .topLevel}

    First we create a procedure in our database that references the
    `getStatementStatistics` method in our API, which takes an SQL query
    as its input and uses Spark to calculate statistics for the query
    using MLlib:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        CREATE PROCEDURE getStatementStatistics(statement varchar(1024))
           PARAMETER STYLE JAVA
           LANGUAGE JAVA
           READS SQL DATA
           DYNAMIC RESULT SETS 1
           EXTERNAL NAME 'com.splicemachine.example.SparkStatistics.getStatementStatistics';
    {: .Example}

    </div>

3.  Create a table to use
    {: .topLevel}

    Let's create a very simple table to illustrate use of our procedure:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        create table t( col1 int, col2 double);
        insert into t values(1, 10);
        insert into t values(2, 20);
        insert into t values(3, 30);
        insert into t values(4, 40);
    {: .Example}

    </div>

4.  Call your custom procedure to get statistics
    {: .topLevel}

    Now call your custom procedure, which sends an SQL statement to the
    SparkStatistics class we created to generate a result set:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        call splice.getStatementStatistics('select * from t');
    {: .Example}

    </div>
{: .boldFont}

</div>
</div>
## Appendix: The SparkStatistics Class   {#Appendix}

Here's the full code for our SparkStatistics class:

<div class="preWrapperWide" markdown="1">
    package com.splicemachine.example;

    import com.google.common.base.Throwables;
    import com.google.common.collect.Lists;
    import com.splicemachine.db.iapi.error.StandardException;
    import com.splicemachine.db.iapi.sql.Activation;
    import com.splicemachine.db.iapi.sql.ResultColumnDescriptor;
    import com.splicemachine.db.iapi.sql.execute.ExecRow;
    import com.splicemachine.db.iapi.types.DataTypeDescriptor;
    import com.splicemachine.db.iapi.types.SQLDouble;
    import com.splicemachine.db.iapi.types.SQLLongint;
    import com.splicemachine.db.iapi.types.SQLVarchar;
    import com.splicemachine.db.impl.jdbc.EmbedConnection;
    import com.splicemachine.db.impl.jdbc.EmbedResultSet40;
    import com.splicemachine.db.impl.sql.GenericColumnDescriptor;
    import com.splicemachine.db.impl.sql.execute.IteratorNoPutResultSet;
    import com.splicemachine.db.impl.sql.execute.ValueRow;
    import com.splicemachine.derby.impl.sql.execute.operations.LocatedRow;
    import org.apache.spark.api.java.JavaRDD;
    import org.apache.spark.mllib.linalg.Vector;
    import org.apache.spark.mllib.stat.MultivariateStatisticalSummary;
    import org.apache.spark.mllib.stat.Statistics;
    import java.sql.*;
    import java.sql.PreparedStatement;
    import java.sql.ResultSet;
    import java.sql.Types;
    import java.util.List;

    public class SparkStatistics {

        private static final ResultColumnDescriptor[] STATEMENT_STATS_OUTPUT_COLUMNS = new GenericColumnDescriptor[]{
                new GenericColumnDescriptor("COLUMN_NAME", DataTypeDescriptor.getBuiltInDataTypeDescriptor(Types.VARCHAR)),
                new GenericColumnDescriptor("MIN", DataTypeDescriptor.getBuiltInDataTypeDescriptor(Types.DOUBLE)),
                new GenericColumnDescriptor("MAX", DataTypeDescriptor.getBuiltInDataTypeDescriptor(Types.DOUBLE)),
                new GenericColumnDescriptor("NUM_NONZEROS", DataTypeDescriptor.getBuiltInDataTypeDescriptor(Types.DOUBLE)),
                new GenericColumnDescriptor("VARIANCE", DataTypeDescriptor.getBuiltInDataTypeDescriptor(Types.DOUBLE)),
                new GenericColumnDescriptor("MEAN", DataTypeDescriptor.getBuiltInDataTypeDescriptor(Types.DOUBLE)),
                new GenericColumnDescriptor("NORML1", DataTypeDescriptor.getBuiltInDataTypeDescriptor(Types.DOUBLE)),
                new GenericColumnDescriptor("MORML2", DataTypeDescriptor.getBuiltInDataTypeDescriptor(Types.DOUBLE)),
                new GenericColumnDescriptor("COUNT", DataTypeDescriptor.getBuiltInDataTypeDescriptor(Types.BIGINT)),
        };


        public static void getStatementStatistics(String statement, ResultSet[] resultSets) throws SQLException {
            try {
                // Run sql statement
                Connection con = DriverManager.getConnection("jdbc:default:connection");
                PreparedStatement ps = con.prepareStatement(statement);
                ResultSet rs = ps.executeQuery();

                // Convert result set to Java RDD
                JavaRDDLocatedRow> resultSetRDD = ResultSetToRDD(rs);

                // Collect column statistics
                int[] fieldsToConvert = getFieldsToConvert(ps);
                MultivariateStatisticalSummary summary = getColumnStatisticsSummary(resultSetRDD, fieldsToConvert);

                IteratorNoPutResultSet resultsToWrap = wrapResults((EmbedConnection) con, getColumnStatistics(ps, summary, fieldsToConvert));
                resultSets[0] = new EmbedResultSet40((EmbedConnection)con, resultsToWrap, false, null, true);
           } catch (StandardException e) {
                throw new SQLException(Throwables.getRootCause(e));
            }
        }

        private static MultivariateStatisticalSummary getColumnStatisticsSummary(JavaRDDLocatedRow> resultSetRDD,
                                                                         int[] fieldsToConvert) throws StandardException{
            JavaRDDVector> vectorJavaRDD = SparkMLibUtils.locatedRowRDDToVectorRDD(resultSetRDD, fieldsToConvert);
            MultivariateStatisticalSummary summary = Statistics.colStats(vectorJavaRDD.rdd());
            return summary;
        }


        /*
         * Convert a ResultSet to JavaRDD
         */
        private static JavaRDDLocatedRow> ResultSetToRDD (ResultSet resultSet) throws StandardException{
            EmbedResultSet40 ers = (EmbedResultSet40)resultSet;

            com.splicemachine.db.iapi.sql.ResultSet rs = ers.getUnderlyingResultSet();
            JavaRDDLocatedRow> resultSetRDD = SparkMLibUtils.resultSetToRDD(rs);

            return resultSetRDD;
        }


        private static int[] getFieldsToConvert(PreparedStatement ps) throws SQLException{
            ResultSetMetaData metaData = ps.getMetaData();
            int columnCount = metaData.getColumnCount();
            int[] fieldsToConvert = new int[columnCount];
            for (int i = 0; i  columnCount; ++i) {
                fieldsToConvert[i] = i+1;
            }
            return fieldsToConvert;
        }

        /*
         * Convert column statistics to an iterable row source
         */
        private static IterableExecRow> getColumnStatistics(PreparedStatement ps,
                                                             MultivariateStatisticalSummary summary,
                                                             int[] fieldsToConvert) throws StandardException {
            try {

                ListExecRow> rows = Lists.newArrayList();
                ResultSetMetaData metaData = ps.getMetaData();

                double[] min = summary.min().toArray();
                double[] max = summary.max().toArray();
                double[] mean = summary.mean().toArray();
                double[] nonZeros = summary.numNonzeros().toArray();
                double[] variance = summary.variance().toArray();
                double[] normL1 = summary.normL1().toArray();
                double[] normL2 = summary.normL2().toArray();
                long count = summary.count();

                for (int i= 0; i  fieldsToConvert.length; ++i) {
                    int columnPosition = fieldsToConvert[i];
                    String columnName = metaData.getColumnName(columnPosition);
                    ExecRow row = new ValueRow(9);
                    row.setColumn(1, new SQLVarchar(columnName));
                    row.setColumn(2, new SQLDouble(min[columnPosition-1]));
                    row.setColumn(3, new SQLDouble(max[columnPosition-1]));
                    row.setColumn(4, new SQLDouble(nonZeros[columnPosition-1]));
                    row.setColumn(5, new SQLDouble(variance[columnPosition-1]));
                    row.setColumn(6, new SQLDouble(mean[columnPosition-1]));
                    row.setColumn(7, new SQLDouble(normL1[columnPosition-1]));
                    row.setColumn(8, new SQLDouble(normL2[columnPosition-1]));
                    row.setColumn(9, new SQLLongint(count));
                    rows.add(row);
                }
                return rows;
            }
            catch (Exception e) {
                throw StandardException.newException(e.getLocalizedMessage());
            }
        }

        private static IteratorNoPutResultSet wrapResults(EmbedConnection conn, IterableExecRow> rows) throws
                StandardException {
            Activation lastActivation = conn.getLanguageConnection().getLastActivation();
            IteratorNoPutResultSet resultsToWrap = new IteratorNoPutResultSet(rows, STATEMENT_STATS_OUTPUT_COLUMNS,
                    lastActivation);
            resultsToWrap.openCore();
            return resultsToWrap;
        }
    }
{: .Example}

</div>
## See Also

* [Spark Overview](notes_sparkoverview.html)
* [Using the Splice Machine Database Console](tutorials_dbconsole_intro.html)
* You can find the Spark MLlib guide in the Programming Guides section
  of the Spark documentation site: [https://spark.apache.org/docs][1]{:
  target="_blank"}

</div>
</section>



[1]: https://spark.apache.org/docs
