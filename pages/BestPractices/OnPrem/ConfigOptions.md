---
title: Splice Machine Installation Configuration Options
summary: Summary of configuration options used in Splice Machine installations
keywords: importing
toc: false
product: all
sidebar: home_sidebar
permalink: bestpractices_onprem_configoptions.html
folder: BestPractices
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Configuring Your Splice Machine Database Installation

The following table provides summary information about (some of) the configuration options used by Splice Machine.

{% include splice_snippets/onpremonlytopic.md %}

<table>
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Property</th>
            <th>Typical value</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">splice.authentication</td>
            <td class="CodeFont">NATIVE</td>
            <td>This is documented in our <a href="tutorials_security_authentication.html">Configuring Authentication</a> topic.</td>
        </tr>
        <tr>
            <td class="CodeFont">splice.authentication.native.algorithm</td>
            <td class="CodeFont">SHA-512</td>
            <td>This is documented in our <a href="tutorials_security_authentication.html">Configuring Authentication</a> topic.</td>
        </tr>
        <tr>
            <td class="CodeFont">splice.client.write.maxDependentWrites</td>
            <td class="CodeFont">60000</td>
            <td><p>A form of write throttling that controls the maximum number of concurrent dependent writes from a <em>single process</em>. Dependent writes are writes to a table with indexes and generate more independent writes (writes to the indexes themselves). They are segregated so we can guarantee progress by reserving some IPC threads for independent writes.</p>
                <p class="noteIcon">If your application is experiencing unexpected timeouts, see the <a href="#timeout"><em>Adjusting for Timeouts</em></a> section below.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">splice.client.write.maxIndependentWrites</td>
            <td class="CodeFont">60000</td>
            <td><p>A form of write throttling that controls the maximum number of concurrent independent writes from a <em>single process</em>.</p>
                <p class="noteIcon">If your application is experiencing unexpected timeouts, see the <a href="#timeout"><em>Adjusting for Timeouts</em></a> section below.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">splice.client.writer.maxThreads</td>
            <td class="CodeFont">200</td>
            <td><p>The total number of threads for the writer in the process, which determines the maximum number of concurrent writes from a process.</p>
                <p class="noteIcon">If your application is experiencing unexpected timeouts, see the <a href="#timeout"><em>Adjusting for Timeouts</em></a> section below.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">splice.compression</td>
            <td class="CodeFont">snappy</td>
            <td>The type of compression to use when compressing Splice Tables. This is set the same HBase sets table compression, and has the same codecs available to it (GZIP,Snappy, or LZO depending on what is installed).
            </td>
        </tr>
        <tr>
            <td class="CodeFont">splice.debug.logStatementContext</td>
            <td class="CodeFont">false</td>
            <td>Whether to log all statements. Note that this is costly in OLTP workloads.</td>
        </tr>
        <tr>
            <td class="CodeFont">splice.marshal.kryoPoolSize</td>
            <td class="CodeFont">1100</td>
            <td>The maximum number of Kryo objects to pool for reuse. This setting should only be adjusted if there are an extremely large number of operations allowed on the system.</td>
        </tr>
        <tr>
            <td class="CodeFont">splice.olap_server.clientWaitTime</td>
            <td class="CodeFont">900000</td>
            <td>The number of milliseconds the OLAP client should wait for a result.</td>
        </tr>
        <tr>
            <td class="CodeFont">splice.root.path</td>
            <td class="CodeFont">/splice</td>
            <td>Zookeper root node for Splice Machine. All Zookeeper nodes used by Splice Machine will hang from this root node.</td>
        </tr>
        <tr>
            <td class="CodeFont">splice.splitBlockSize</td>
            <td class="CodeFont">67108864</td>
            <td>Default size for Spark partitions when reading data from HBase. We sub-split each HBase region into several partitions targeting that size, but it rarely matches exactly. This is because it depend on a number of factors, including the number of storefiles in use by a given HBase region.</td>
        </tr>
        <tr>
            <td class="CodeFont">splice.timestamp_server.clientWaitTime</td>
            <td class="CodeFont">120000</td>
            <td>The number of milliseconds the timestamp client should wait for a result.</td>
        </tr>
        <tr>
            <td class="CodeFont">splice.txn.completedTxns.concurrency</td>
            <td class="CodeFont">128</td>
            <td>Concurrency level for the completed transactions cache. Specifies the estimated number of concurrently updating threads.</td>
        </tr>
        <tr>
            <td class="CodeFont">splice.txn.concurrencyLevel</td>
            <td class="CodeFont">4096</td>
            <td>Expected concurrent updates to a transaction region. Increasing it increases memory consumption, decreasing it decreases concurrency on transaction operations. A reasonable default is the number of ipc threads configured for this system.</td>
        </tr>
    </tbody>
</table>

## Adjusting for Application Timeouts  {#timeout}

If your application is experiencing unexpected timeouts, it may be due to the queue getting too large, which means that you need to reduce throughput by adjusting these property values:

* `splice.client.write.maxIndependentWrites`
* `splice.client.write.maxDependentWrites`
* `splice.client.writer.maxThreads` values

These values apply _per process_.

Here are some guidelines:

* The `splice.client.write.maxIndependentWrites` and `splice.client.write.maxDependentWrites` maximum concurrent write values must be within the capacity of the nodes in your cluster.
* You should set the value of the `splice.client.writer.maxThreads` property as follows:

  ```
  num-nodes * num-executors-per-node * (max-independent-write-threads + max-dependent-write-threads)
  ```
  {: .Plain}

Make sure that the values you select for these properties are commensurate with your read-side throughput.


</div>
</section>
