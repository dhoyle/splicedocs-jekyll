---
summary: How to clean (flatten) your database.
title: Cleaning Your Database
keywords: cleaning database, flatten
toc: false
product: onprem
sidebar:  onprem_sidebar
permalink: onprem_admin_cleaningdb.html
folder: OnPrem/Administrators
---
\{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Cleaning Your Database

{% include splice_snippets/onpremonlytopic.html %}
Cleaning your database essentially wipes out any user-defined tables,
indexes, and related items. You need to follow different steps,
depending on which version of Splice Machine you are using:

* [Cleaning Your Splice Machine Database on a Cloudera-Managed
  Cluster](#CleaningDBCloudera)
* [Cleaning Your Splice Machine Database on a Hortonworks HDP-Managed
  Cluster](#CleaningDBHDP)
* [Cleaning Your Splice Machine Database on a MapR-Managed
  Cluster](#CleaningDBMapR)
* [Cleaning Your Splice Machine Database on a Standalone
  installation](#CleaningDbStandalone)

## Cleaning Your Splice Machine Database on a Cloudera-Managed Cluster   {#CleaningDBCloudera}

Follow these steps to clean your database if you're using the
Cloudera-managed cluster version of Splice Machine:

<div class="opsStepsList" markdown="1">
1.  Shut down HBase and HDFS
    {: .topLevel}
    
    Navigate to the <span class="AppCommand">Services-&gt;All
    Services</span> screen in <span>Cloudera Manager</span>, and select
    these actions to stop *HBase* and *HDFS*:
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        hbase -> Actions -> Stop
        hdfs1 -> Actions -> Stop
        zookeeper1 -> Actions -> Stop
    {: .AppCommand xml:space="preserve"}
    
    </div>

2.  Use the Zookeeper client to clean things:
    {: .topLevel}
    
    Restart ZooKeeper in the <span
    class="AppCommand">Services-&gt;All Services</span> screen:
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        zookeeper1 -> Actions -> Start
    {: .AppCommand xml:space="preserve"}
    
    </div>
    
    Log in to the machine running Zookeeper on your cluster and start up
    a command-line (terminal) window.
    {: .indentLevel1}
    
    Run the <span class="ShellCommand">zookeeper-client</span> command.
    At the prompt, run the following commands:
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        rmr /startupPath
        rmr /spliceJobs
        rmr /derbyPropertyPath
        rmr /spliceTasks
        rmr /hbase
        rmr /conglomerates
        rmr /transactions
        rmr /ddl
    {: .AppCommand xml:space="preserve"}
    
    </div>

3.  Start HDFS
    {: .topLevel}
    
    Navigate to the <span class="AppCommand">Services-&gt;All
    Services</span> screen in <span>Cloudera Manager</span>, and restart
    *HDFS*:
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        hdfs1 -> Actions -> Start
    {: .AppCommand xml:space="preserve"}
    
    </div>

4.  Clean up HBase
    {: .topLevel}
    
    Use the following shell command to delete the existing `/hbase`
    directory. You can run this command on any Data Node:
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        sudo -su hdfs hadoop fs -rm -r /hbase
    {: .ShellCommand xml:space="preserve"}
    
    </div>
    
    If you are logged in as root, use this command instead:
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        sudo -u hdfs hadoop fs -rm -r /hbase
    {: .ShellCommand xml:space="preserve"}
    
    </div>
    
    If the machine running Cloudera Manager is not part of the cluster,
    **do not** run the command on that machine
    {: .noteNote}

5.  Create a new HBase directory:
    {: .topLevel}
    
    Navigate to the <span class="AppCommand">HBase</span> screen in
    <span>Cloudera Manager</span>, and create a new `/hbase` directory
    by selecting:
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        Actions -> Create Root Directory
    {: .AppCommand xml:space="preserve"}
    
    </div>

6.  Restart HBase
    {: .topLevel}
    
    Now restart HBase from the same <span
    class="AppCommand">Home-&gt;Services-&gt;hbase1</span> screen in
    Cloudera Manager, using this action:
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        Actions -> Start
    {: .AppCommand xml:space="preserve"}
    
    </div>
{: .boldFont}

</div>
## Cleaning Your Splice Machine Database on a Hortonworks HDP-Managed Cluster   {#CleaningDBHDP}

Follow these steps to clean (or *flatten*) your database if you're using
Splice Machine on an Ambari-managed Hortonworks Cluster:

<div class="opsStepsList" markdown="1">
1.  Shut down HBase and HDFS
    {: .topLevel}
    
    Log in to the Ambari Dashboard by pointing your browser to the
    publicly visible <span
    class="HighlightedCode">&lt;hostName&gt;</span> for your master node
    that is hosting Ambari Server:
    {: .indentLevel1}
    
    <div class="preWrapperWide" markdown="1">
        http://<hostName>:8080/
    {: .ShellCommand xml:space="preserve"}
    
    </div>
    
    > <div class="preWrapperWide" markdown="1">
    >     http://<hostName>:8080/
    > {: .ShellCommand xml:space="preserve"}
    > 
    > </div>
    
    Select these actions to stop HBase and HDFS: :
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        Services->HBase->Service Actions->Stop
        Services->HDFS->Service Actions->Stop
    {: .AppCommand xml:space="preserve"}
    
    </div>

2.  Use the Zookeeper client to clean things
    {: .topLevel}
    
    Log in to the node running Zookeeper on your cluster and start up a
    command-line (terminal) window.
    {: .indentLevel1}
    
    Run the <span class="ShellCommand">zookeeper-client</span> command.
    At the prompt, run the following commands:
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        rmr /startupPath
        rmr /spliceJobs
        rmr /derbyPropertyPath
        rmr /spliceTasks
        rmr /hbase-unsecure
        rmr /conglomerates
        rmr /transactions
        rmr /ddl
    {: .AppCommand xml:space="preserve"}
    
    </div>

3.  Restart HDFS
    {: .topLevel}
    
    Use the Ambari Dashboard to restart HDFS:
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        Services->HDFS->Service Actions->Start
    {: .AppCommand xml:space="preserve"}
    
    </div>

4.  Re-create the required directory structure
    {: .topLevel}
    
    You need to SSH into a node that is running the HDFS Client and
    re-create the directory structure that Splice Machine expects by
    issuing these commands:
    {: .indentLevel1}
    
    Run the <span class="ShellCommand">zookeeper-client</span> command.
    At the prompt, run the following commands:
    {: .indentLevel1}
    
    <div class="preWrapperWide" markdown="1">
        
        sudo -su hdfs hadoop fs -rm -r /apps/hbase
        sudo -su hdfs hadoop fs -mkdir /apps/hbase
        sudo -su hdfs hadoop fs -mkdir /apps/hbase/data
        sudo -su hdfs hadoop fs -chown hbase:hdfs /apps/hbase
        sudo -su hdfs hadoop fs -chown hbase:hdfs /apps/hbase/data
    {: .ShellCommand xml:space="preserve"}
    
    </div>

5.  Restart HBase
    {: .topLevel}
    
    Use the Ambari Dashboard to restart HBase:
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        Services->HBase->Service Actions->Start
    {: .AppCommand xml:space="preserve"}
    
    </div>
{: .boldFont}

</div>
## Cleaning Your Splice Machine Database on a MapR-Managed Cluster   {#CleaningDBMapR}

Follow the steps below to clean (flatten) your database on your MapR
cluster. You must be logged in as the cluster administrator (typically
`clusteradmin` or `ec2-user`) to run each step. Unless otherwise
specified, run each of these steps **on your cluster control node**;
some steps, as indicated, must be run on each node in your cluster.

<div class="opsStepsList" markdown="1">
1.  Stop the HBase RegionServers and Master:
    {: .topLevel}
    
    Use the following command **on your control node** to stop HBase on
    your cluster:
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        ~/splice-installer-mapr4.0/stop-hbase.sh
    {: .AppCommand xml:space="preserve"}
    
    </div>

2.  Remove old data from HDFS:
    {: .topLevel}
    
    Ignore any error messages you may see when you run this command:
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        sudo -iu mapr hadoop fs -rm -r -f 'maprfs:///hbase/*'
    {: .AppCommand xml:space="preserve"}
    
    </div>

3.  Stop MapR warden services:
    {: .topLevel}
    
    Run the following command **on each node** in your cluster:
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        sudo service mapr-warden stop
    {: .AppCommand xml:space="preserve"}
    
    </div>

4.  Launch the ZooKeeper command line shell:
    {: .topLevel}
    
    Note that the exact path may vary with different MapR versions
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        /opt/mapr/zookeeper/zookeeper-3.4.5/bin/zkCli.sh
    {: .AppCommand xml:space="preserve"}
    
    </div>

5.  Connect to the local ZooKeeper instance:
    {: .topLevel}
    
    When the ZooKeeper command shell prompts you, enter the <span
    class="HighlightedCode">connect</span> command shown here:
    {: .indentLevel1}
    
    <div class="preWrapperWide" markdown="1">
        Connecting to localhost:2181
        Welcome to ZooKeeper!
        JLine support is enabled
        [zk: localhost:2181(CONNECTING) 0] connect localhost:5181
    {: .AppCommand xml:space="preserve"}
    
    </div>

6.  Complete the connection:
    {: .topLevel}
    
    Press `Enter` again to display the connected prompt
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        [zk: localhost:5181(CONNECTED) 1]
    {: .AppCommand xml:space="preserve"}
    
    </div>

7.  Clear old ZooKeeper data:
    {: .topLevel}
    
    Enter the following commands to clear ZooKeeper data and then exit
    the command shell:
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        rmr /startupPath
        rmr /spliceJobs
        rmr /derbyPropertyPath
        rmr /spliceTasks
        rmr /hbase
        rmr /conglomerates
        rmr /transactions
        rmr /ddl
        quit
    {: .AppCommand xml:space="preserve"}
    
    </div>

8.  Restart MapR warden services on all nodes:
    {: .topLevel}
    
    Run the following command **on each node** in your cluster:
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        sudo service mapr-warden start
    {: .AppCommand xml:space="preserve"}
    
    </div>
    
    Once you do so, your cluster will re-create the Splice Machine
    schema, and the command line interface will once again be available
    after a minute or so.
    {: .indentLevel1}

9.  Restart HBase
    {: .topLevel}
    
    Run this command to restart hbase:
    {: .indentLevel1}
    
    <div class="preWrapper" markdown="1">
        ~/splice-installer-mapr4.0/start-hbase.sh
    {: .AppCommand xml:space="preserve"}
    
    </div>
{: .boldFont}

</div>
## Cleaning Your Database in the Standalone Version   {#CleaningDbStandalone}

Follow these steps to clean your database if you're using the Standalone
version of Splice Machine:

<div class="opsStepsList" markdown="1">
1.  Make sure that you have quit the <span
    class="AppCommand">splice&gt;</span> command line interpreter:
    {: .topLevel}
    
    <div class="preWrapper" markdown="1">
        splice> quit;
    {: .AppCommand}
    
    </div>

2.  Change directory to your install directory:
    {: .topLevel}
    
    <div class="preWrapper" markdown="1">
        cd splicemachine
    {: .ShellCommand}
    
    </div>

3.  Run the following scripts:
    {: .topLevel}
    
    <div class="preWrapper" markdown="1">
        
        $ {{splvar_location_StandaloneStopScript}}
        $ {{splvar_location_StandaloneCleanScript}}
        $ {{splvar_location_StandaloneStartScript}}
    {: .ShellCommand xml:space="preserve"}
    
    </div>
{: .boldFont}

</div>
</div>
</section>

