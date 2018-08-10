---
title: Introduction to the Splice Machine Database Console
summary: Describes the Splice Machine Database Console, which allows you to monitor (and kill) queries on your cluster in real time.
keywords: console, guide, ui, dbaas, paas, db
toc: false
product: all
sidebar:  tutorials_sidebar
permalink: tutorials_dbconsole_intro.html
folder: DeveloperTutorials/DBConsole
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice Machine Database Console Guide

This topic introduces the *Splice Machine Database Console*, a
browser-based tool that you can use to monitor database queries on your
cluster in real time. The Console UI allows you to see the Spark queries
that are currently running in Splice Machine on your cluster, and to
then drill down into each job to see the current progress of the
queries, and to identify any potential bottlenecks. If you see something
amiss, you can also terminate a query.

The *Splice Machine Database Console* leverages the Spark cluster
manager *Web UI*, which is described
here: [http://spark.apache.org/docs/latest/monitoring.html][1]{:
target="_blank"}.
{: .noteIcon}

This section is organized into the following topics:

* The remainder of this topic, [About the Splice Machine Database Console](#About),
  tells you about the Database Console, including how to access it in
  your browser.
* The [Features of the Splice Machine Database
  Console](tutorials_dbconsole_features.html) topic describes how to use major
  features of the console interface.
* The [Managing Queries with the Console](tutorials_dbconsole_queries.html) topic
  shows you how to review and monitor the progress of your Spark jobs.

## About the Splice Machine Database Console   {#About}

The *Splice Machine Spark Database Console* is a browser-based tool that
you can use to watch your active Spark queries execute and to review the
execution of completed queries. You can use the console to:

* View any completed jobs
* Monitor active jobs as they execute
* View a timeline chart of the events in a job and its stages
* View a Directed Acyclic Graph (DAG) visualization of a job's stages
  and the tasks within each stage
* Monitor persisted and cached storage in realtime

How you access the Splice Machine Database Console depends on which
Splice Machine product you're using:

<table>
    <col />
    <col />
    <thead>
        <th>Product</th>
        <th>DB Console Access</th>
    </thead>
    <tbody>
        <tr>
            <td>Database-as-Service</td>
            <td>
                <ul>
                <li>To monitor the Splice Machine jobs running on your cluster, click the <span class="ConsoleLink">DB Console</span> button at the top right of your Management screen or click the DB Console link in the cluster created email that you received from Splice Machine.</li>
                <li>To monitor any non-Splice Machine Spark jobs that are running on your cluster, you need to use a different Spark console, which you can access by clicking the <span class="ConsoleLink">External Spark Console</span> link that is displayed in the bottom left corner of your cluster's dashboard page.</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>On-Premise Database</td>
{% include splicevars.html %}
            <td><div class="preWrapper"><pre class="AppCommand">{{splvar_location_SpliceMgmtConsoleUrl}}</pre></div></td>
        </tr>
    </tbody>
</table>
The Database Console URL will only be active after you've run at least
one query on our Spark engine; prior to using the Spark engine, your
browser will report an error such as *Connection Refused*.
{: .noteIcon}

Here are some of the terms you'll encounter while using the Database
Console:

<table summary="Spark Database Console terminology">
    <col />
    <col />
    <thead>
        <tr>
            <th>Term</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><em>Accumulators</em></td>
            <td>Accumulators are variables programmers can declare in Spark applications that can be efficiently supported in parallel operations, and are typically used to implement counters and sums. </td>
        </tr>
        <tr>
            <td><em>Additional Metrics</em></td>
            <td>You can indicate that you want to display additional metrics for a stage or job by clicking the <span class="AppCommand">Show Additional Metrics</span> arrow and then selecting which metrics you want shown.</td>
        </tr>
        <tr>
            <td><em>DAG Visualization</em></td>
            <td>A visual depiction of the execution Directed Acyclic Graph (DAG) for a job or job stage, which shows the details and flow of data. You can click the <span class="AppCommand">DAG Visualization</span> arrow to switch to this view.</td>
        </tr>
        <tr>
            <td><em>Enable Zooming</em></td>
            <td>For <em>event timeline</em> views, you can enable zooming to expand the view detail for a portion of the timeline. You can click the <span class="AppCommand">Event Timeline</span> arrow to switch to this view.</td>
        </tr>
        <tr>
            <td><em>Event Timeline</em></td>
            <td>A view that graphically displays the sequence of all <em>jobs</em>, a specific job, or a <em>stage</em> within a job. </td>
        </tr>
        <tr>
            <td><em>Executor</em></td>
            <td>A process that runs <em>tasks</em> on a cluster node.</td>
        </tr>
        <tr>
            <td><em>GC Time</em></td>
            <td>The amount of time spent performing garbage collection in a stage.</td>
        </tr>
        <tr>
            <td><em>Job</em></td>
            <td>
                <p class="noSpaceAbove">The basic unit of execution in the Spark engine, consisting of a set of stages. With some exceptions, each query submitted to the Spark engine is a single job.</p>
                <p>Each job is assigned a unique Job Id and is part of a unique Job Group.</p>
            </td>
        </tr>
        <tr>
            <td><em>Locality Level</em></td>
            <td>To minimize data transfers, Spark tries to execute as close to the data as possible. The <em>Locality Level</em> value indicates whether a task was able to run on the local node.</td>
        </tr>
        <tr>
            <td><em>Scheduling Mode</em></td>
            <td>
                <p class="noSpaceAbove">The scheduling mode used for a job.</p>
                <p>In FIFO scheduling, the first job gets priority on all available resources while its stages have tasks to launch. Then the second job gets priority, and so on.</p>
                <p>In FAIR scheduling, Spark assigns tasks between jobs in a round robin manner, meaning that all jobs get a roughly equal share of the available cluster resources. Which means that short jobs can gain fair access to resources immediately without having to wait for longer jobs to complete.</p>
            </td>
        </tr>
        <tr>
            <td><em>Scheduling Pool</em></td>
            <td>The FAIR schedule groups jobs into pools, each of which can have a different priority weighting value, which allows you to submit jobs with higher or lower priorities.</td>
        </tr>
        <tr>
            <td><em>ScrollInsensitive row</em></td>
            <td>A row in a result set that is scrollable, and is not sensitive to changes committed by other transactions or by other statements in the same transaction.</td>
        </tr>
        <tr>
            <td><em>Shuffling</em></td>
            <td>
                <p class="noSpaceAbove">Shuffling is the reallocation of data between multiple stages in a Spark job.</p>
                <p><em>Shuffle Write</em> is amount of data that is serialized and written at the end of a stage for transmission to the next stage. <em>Shuffle Read</em> is the amount of serialized data that is read at the beginning of a stage.</p>
            </td>
        </tr>
        <tr>
            <td><em>Stage</em></td>
            <td>
                <p class="noSpaceAbove">The Splice Machine Spark scheduler splits the execution of a <em>job</em> into stages, based on the RDD transformations required to complete the job.</p>
                <p>Each stage contains a group of tasks that perform a computation in parallel. </p>
            </td>
        </tr>
        <tr>
            <td><em>Task</em></td>
            <td>A computational command sent from the application driver to an <em>executor</em> as part of a <em>stage</em>.</td>
        </tr>
    </tbody>
</table>
## See Also

* [User Interface Features of the Splice Machine Database
  Console](tutorials_dbconsole_features.html)
* [Managing Queries with the Console](tutorials_dbconsole_queries.html)
* [Using Spark Libraries with Splice
  Machine](developers_spark_libs.html)

</div>
</section>



[1]: http://spark.apache.org/docs/latest/monitoring.html
