---
summary: How to shut down your database.
title: Shutting Down Your Database
keywords: shutting down
toc: false
product: onprem
sidebar: home_sidebar
permalink: onprem_admin_shuttingdowndb.html
folder: OnPrem/Administrators
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Shutting Down Your Database

This topic describes how to shut down your Splice Machine database. You
need to follow different steps, depending on which version of Splice
Machine you are using:

* [Shutting Down Your Splice Machine Database on a Cloudera-Managed
  Cluster](#ShutdownDBCloudera)
* [Shutting Down Your Splice Machine Database on a Hortonworks
  HDP-Managed Cluster](#ShutdownDBHDP)
* [Shutting Down Your Splice Machine Database on a MapR-Managed
  Cluster](#ShutdownDBMapR)
* [Shutting Down Your Splice Machine Database on a Standalone
  installation](#ShutdownDbStandalone)

{% include splice_snippets/onpremonlytopic.md %}

## Shutting Down Your Splice Machine Database on a Cloudera-Managed Cluster   {#ShutdownDBCloudera}

Use the Cloudera Manager to either shut down HBase or to shut down the
entire cluster, whichever is appropriate for your situation.

<div class="opsStepsList" markdown="1">
1.  Navigate to the *Services-&gt;All Services* screen in *Cloudera
    Manager*, and select this action to stop *HBase*:
    {: .topLevel}

    <div class="preWrapper" markdown="1">
        hbase -> Actions -> Stop
    {: .AppCommand xml:space="preserve"}

    </div>

2.  If you also want to shut down the entire cluster, select this action
    in the same screen to stop*HDFS*:
    {: .topLevel}

    <div class="preWrapper" markdown="1">
        hdfs1 -> Actions -> Stop
    {: .AppCommand}

    </div>
{: .boldFont}

</div>
## Shutting Down Your Splice Machine Database on a Hortonworks HDP-Managed Cluster   {#ShutdownDBHDP}

Use the Ambari dashboard to shut down Splice Machine:

<div class="opsStepsList" markdown="1">
1.  Log in to the Ambari Dashboard by pointing your browser to the
    publicly visible <span
    class="HighlightedCode">&lt;hostName&gt;</span> for your master node
    that is hosting Ambari Server:
    {: .topLevel}

    <div class="preWrapper" markdown="1">
        http://<hostName>:8080/
    {: .ShellCommand xml:space="preserve"}

    </div>

2.  Shut down cluster services by selecting:
    {: .topLevel}

    <div class="preWrapper" markdown="1">
        Action -> Stop All
    {: .AppCommand}

    </div>
{: .boldFont}

</div>
## Shutting Down Your Splice Machine Database on a MapR-Managed Cluster   {#ShutdownDBMapR}

To shut down Splice Machine, use the MapR Command System (MCS) to stop
HBase.

<div class="opsStepsList" markdown="1">
1.  Navigate to the node that is running the `mapr-webserver` service.
2.  Log into `https://<hostIPAddr>:8443`, substituting the correct <span
    class="HighlightedCode">&lt;hostIPAddr&gt;</span> value.
3.  Stop hbase.
{: .boldFont}

</div>
## Shutting Down Your Database in the Standalone Version   {#ShutdownDbStandalone}

Follow these steps to shut down your database if you're using the
Standalone version of Splice Machine:

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

        $ ./bin/stop-splice.sh
    {: .ShellCommand xml:space="preserve"}

    </div>
{: .boldFont}

This stops the Splice Machine database and the Splice Machine
Administrative Console.
{: .indentLevel1}

</div>
</div>
</section>
