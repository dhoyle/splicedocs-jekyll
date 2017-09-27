---
title: Splice Machine MapReduce API
summary: The Splice Machine MapReduce API provides a simple programmatic interface for using MapReduce with HBase and taking advantage of the transactional capabilities that Splice Machine provides.
keywords: Map Reduce, MR, framework
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_fundamentals_mapreduce.html
folder: Developers
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice Machine Map Reduce API

{% include splice_snippets/onpremonlytopic.md %}
The Splice Machine MapReduce API provides a simple programming interface
to the Map Reduce Framework that is integrated into Splice Machine. You
can use MapReduce to import data, export data, or for purposes such as
implementing machine learning algorithms. One likely scenario for using
the Splice Machine MapReduce API is for customers who already have a
Hadoop cluster, want to use Splice Machine as their transactional
database, and need to continue using their batch MapReduce jobs.

This topic includes a summary of the Java classes included in the
API, and [presents an example](#Example) of using the MapReduce API.

## Splice Machine MapReduce API Classes

The Splice Machine MapReduce API includes the following key classes:

<table summary="Descriptions of the key classes in the Splie Machine MapReduce API.">
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
                        <td><code>SpliceJob</code></td>
                        <td>Creates a transaction for the MapReduce job.</td>
                    </tr>
                    <tr>
                        <td><code>SMInputFormat</code></td>
                        <td>
                            <p class="noSpaceAbove">Creates an object that:</p>
                            <ul>
                                <li> uses Splice Machine to scan the table and decode the data</li>
                                <li>returns an <code>ExecRow</code> (typed data) object</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td><code>SMOutputFormat</code></td>
                        <td>
                            <p class="noSpaceAbove">Creates an object that:</p>
                            <ul>
                                <li> writes to a buffered cache</li>
                                <li>dumps the cache into Splice Machine </li>
                                <li>returns an <code>ExecRow</code> (typed data) object.</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td><code>SpliceMapReduceUtil</code></td>
                        <td>A Helper class for writing MapReduce jobs in java; this class is used to initiate a mapper job or a reducer job, to set the number of reducers, and to add dependency jars.</td>
                    </tr>
                </tbody>
            </table>
Each transaction must manage its own commit and rollback operations.
{: .noteNote}

For information about and examples of using Splice Machine with
HCatalog, see the <a href="Using Splice Machine with HCatalog topic.

## Example of Using the Splice Machine MapReduce API   {#Example}

This topic describes using the Splice Machine MapReduce API,
`com.splicemachine.mrio.api`, a simple word count program that retrieves
data from an input table, summarizes the count of initial character of
each word, and writes the result to an output table.

<div class="opsStepsList" markdown="1">
1.  Define your input and output tables:
    {: .topLevel}

    First, assign the name of the Splice Machine database table from
    which you want to retrieve data to a variable, and then assign a
    name for your output table to another variable:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        String inputTableName  = "WIKIDATA";
        String outputTableName = "USERTEST";
    {: .Example xml:space="preserve"}

    </div>

    You can specify table names using the
    *&lt;schemaName&gt;.&lt;tableName&gt;* format; if you don't specify
    a schema name, the default schema is assumed.
    {: .indentLevel1}

2.  Create a new job instance:
    {: .topLevel}

    You need to create a new job instance and assign a name to it:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        Configuration config = HBaseConfiguration.create();
        Job job = new Job(config, "WordCount");
    {: .Example xml:space="preserve"}

    </div>

3.  Initialize your mapper job:
    {: .topLevel}

    We initialize our sample job using the `initTableMapperJob` utility
    method:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        TableMapReduceUtil.initTableMapperJob(
            tableName,			// input Splice Machine database table
            scan,			// a scan instance to control CF and attribute selection
            MyMapper.class,		// the mapper
            Text.class,			// the mapper output key
            InitWritable.class,		// the mapper output value
            job,
            true,
            SpliceInputFormat.class);
    {: .Example}

    </div>

4.  Retrieve values within your map function:
    {: .topLevel}

    Our sample `map` function retrieves and parses a single row with
    specified columns.
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        public void map(ImmutableBytesWritable row, ExecRow value, Context context)
                        throws InterruptedException, IOException {
            if(value != null) {
                try {
                    DataValueDescriptor dataValDesc[]  = value.getRowArray();
                    if(dataValDesc[0] != null) {}
                    word = dataValDesc[0].getString();
                    }
                catch (StandardException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
                if(word != null) {
                    Text key = new Text(word.charAt(0)+"");
                    IntWritable val = new IntWritable(1);
                    context.write(key, val);
                }
            }
        }
    {: .Example}

    </div>

5.  Manipulate and save the value with reduce function:
    {: .topLevel}

    Our sample `reduce` function manipulates and saves the value by
    creating an `ExecRow` and filling in the row with the
    `execRow.setRowArray` method.
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        public void reduce(Text key, IterableIntWritable> values, Context context)
                            throws IOException, InterruptedException {

            IteratorIntWritable> it=values.iterator();
            ExecRow execRow = new ValueRow(2);
            int sum = 0;
            String word = key.toString();
            while (it.hasNext()) {
                sum += it.next().get();
            }
            try{
                DataValueDescriptor []dataValDescs= {new SQLVarchar(word), new SQLInteger(sum)};
                execRow.setRowArray(dataValDescs);
                context.write(new ImmutableBytesWritable(Bytes.toBytes(word)), execRow);
            }
            catch(Exception E) {
                E.printStackTrace();
            }
        }
    {: .Example}

    </div>

6.  Commit or rollback the job:
    {: .topLevel}

    If the job is successful, commit the transaction.
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        job.commit();
    {: .Example xml:space="preserve"}

    </div>

    If the job fails, roll back the transaction.
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        job.rollback();
    {: .Example xml:space="preserve"}

    </div>
{: .boldFont}

</div>
</div>
</section>
