---
summary: How to download, install, configure and verify your installation of Splice Machine on CDH.
title: Installing and Configuring Splice Machine for Cloudera Manager
keywords: Cloudera, CDH, installation, hadoop, hbase, hdfs, sqlshell.sh, sqlshell, parcel url
toc: false
product: onprem
sidebar:  onprem_sidebar
permalink: onprem_install_cloudera.html
folder: OnPrem/InstallingSpliceMachine
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% include splicevars.html %}
# Installing and Configuring Splice Machine for Cloudera Manager

{% include splice_snippets/onpremonlytopic.md %}

This topic describes installing and configuring Splice Machine on a
Cloudera-managed cluster. Follow these steps:

1.  [Verify Prerequisites](#Verify)
2.  [Install the Splice Machine Parcel](#Install)
3.  [Stop Hadoop Services](#Stop){: .WithinBook}
4.  [Make Cluster Modifications for Splice Machine](#ClusterMod)
5.  [Configure Hadoop Services](#Configur8)
6.  Make any needed [Optional Configuration Modifications](#Optional)
7.  [Deploy the Client Configuration](#Deploy)
8.  [Restart the Cluster](#Restart)
9.  [Verify your Splice Machine Installation](#Run)

## Verify Prerequisites   {#Verify}

Before starting your Splice Machine installation, please make sure that
your cluster contains the prerequisite software components:

* A cluster running Cloudera Data Hub (CDH) with Cloudera Manager (CM)
* HBase installed
* HDFS installed
* YARN installed
* ZooKeeper installed

The specific versions of these components that you need depend on your
operating environment, and are called out in detail in the
[Requirements](onprem_info_requirements.html) topic of our *Getting
Started Guide*.
{: .noteNote}

## Install the Splice Machine Parcel   {#Install}

Follow these steps to install CDH, Hadoop, Hadoop services, and Splice
Machine on your cluster:

<div class="opsStepsList" markdown="1">
1.  Copy your parcel URL to the clipboard for use in the next step.
    {: .topLevel}

    Which Splice Machine parcel URL you need depends upon which Splice
    Machine version you're installing and which version of CDH you are
    using. Here are the URLs for Splice Machine Release {{splvar_basic_SpliceReleaseVersion}} and
    {{splvar_basic_SplicePrevReleaseVersion}}:
    {: .indentLevel1}

    <table>
        <col />
        <col />
        <col />
        <col />
        <thead>
            <tr>
                <th>Splice Machine Release</th>
                <th>CDH Version</th>
                <th>Parcel Type</th>
                <th>Installer Package Link(s)</th>
            </tr>
        </thead>
        <tbody>
           <tr>
               <td rowspan="12" class="SpliceRelease">2.6.1</td>
               <td rowspan="6" class="SplicePlatform">{{splvar_install_CDH5120}}</td>
               <td>EL6</td>
               <td><a href="{{splvar_install_v261_CDH5120-EL6}}">{{splvar_install_v261_CDH5120-EL6}}</a></td>
           </tr>
           <tr>
               <td>EL7</td>
               <td><a href="{{splvar_install_v261_CDH5120-EL7}}">{{splvar_install_v261_CDH5120-EL7}}</a></td>
           </tr>
           <tr>
               <td>Precise</td>
               <td><a href="{{splvar_install_v261_CDH5120-PRECISE}}">{{splvar_install_v261_CDH5120-PRECISE}}</a></td>
           </tr>
           <tr>
               <td>SLES11</td>
               <td><a href="{{splvar_install_v261_CDH5120-SLES11}}">{{splvar_install_v261_CDH5120-SLES11}}</a></td>
           </tr>
           <tr>
               <td>Trusty</td>
               <td><a href="{{splvar_install_v261_CDH5120-TRUSTY}}">{{splvar_install_v261_CDH5120-TRUSTY}}</a></td>
           </tr>
           <tr>
               <td>Wheezy</td>
               <td><a href="{{splvar_install_v261_CDH5120-WHEEZY}}">{{splvar_install_v261_CDH5120-WHEEZY}}</a></td>
            </tr>
           <tr>
               <td rowspan="6" class="SplicePlatform">{{splvar_install_CDH583}}</td>
               <td>EL6</td>
               <td><a href="{{splvar_install_v261_CDH583-EL6}}">{{splvar_install_v261_CDH583-EL6}}</a></td>
           </tr>
           <tr>
               <td>EL7</td>
               <td><a href="{{splvar_install_v261_CDH583-EL7}}">{{splvar_install_v261_CDH583-EL7}}</a></td>
           </tr>
           <tr>
               <td>PRECISE</td>
               <td><a href="{{splvar_install_v261_CDH583-PRECISE}}">{{splvar_install_v261_CDH583-PRECISE}}</a></td>
           </tr>
           <tr>
               <td>SLES11</td>
               <td><a href="{{splvar_install_v261_CDH583-SLES11}}">{{splvar_install_v261_CDH583-SLES11}}</a></td>
           </tr>
           <tr>
               <td>Trusty</td>
               <td><a href="{{splvar_install_v261_CDH583-TRUSTY}}">{{splvar_install_v261_CDH583-TRUSTY}}</a></td>
           </tr>
           <tr>
               <td>Wheezy</td>
               <td><a href="{{splvar_install_v261_CDH583-WHEEZY}}">{{splvar_install_v261_CDH583-WHEEZY}}</a></td>
            </tr>
            <tr>
                <td colspan="4" class="Separator"> </td>
            </tr>
           <tr>
               <td rowspan="12" class="SpliceRelease">2.5.0</td>
               <td rowspan="6" class="SplicePlatform">{{splvar_install_CDH583}}</td>
               <td>EL6</td>
               <td><a href="{{splvar_install_v250_CDH583-EL6}}">{{splvar_install_v250_CDH583-EL6}}</a></td>
           </tr>
           <tr>
               <td>EL7</td>
               <td><a href="{{splvar_install_v250_CDH583-EL7}}">{{splvar_install_v250_CDH583-EL7}}</a></td>
           </tr>
           <tr>
               <td>Precise</td>
               <td><a href="{{splvar_install_v250_CDH583-PRECISE}}">{{splvar_install_v250_CDH583-PRECISE}}</a></td>
           </tr>
           <tr>
               <td>SLES11</td>
               <td><a href="{{splvar_install_v250_CDH583-SLES11}}">{{splvar_install_v250_CDH583-SLES11}}</a></td>
           </tr>
           <tr>
               <td>Trusty</td>
               <td><a href="{{splvar_install_v250_CDH583-TRUSTY}}">{{splvar_install_v250_CDH583-TRUSTY}}</a></td>
           </tr>
           <tr>
               <td>Wheezy</td>
               <td><a href="{{splvar_install_v250_CDH583-WHEEZY}}">{{splvar_install_v250_CDH583-WHEEZY}}</a></td>
            </tr>
           <tr>
               <td rowspan="6" class="SplicePlatform">{{splvar_install_CDH580}}</td>
               <td>EL6</td>
               <td><a href="{{splvar_install_v250_CDH580-EL6}}">{{splvar_install_v250_CDH580-EL6}}</a></td>
           </tr>
           <tr>
               <td>EL7</td>
               <td><a href="{{splvar_install_v250_CDH580-EL7}}">{{splvar_install_v250_CDH580-EL7}}</a></td>
           </tr>
           <tr>
               <td>Precise</td>
               <td><a href="{{splvar_install_v250_CDH580-PRECISE}}">{{splvar_install_v250_CDH580-PRECISE}}</a></td>
           </tr>
           <tr>
               <td>SLES11</td>
               <td><a href="{{splvar_install_v250_CDH580-SLES11}}">{{splvar_install_v250_CDH580-SLES11}}</a></td>
           </tr>
           <tr>
               <td>Trusty</td>
               <td><a href="{{splvar_install_v250_CDH580-TRUSTY}}">{{splvar_install_v250_CDH580-TRUSTY}}</a></td>
           </tr>
           <tr>
               <td>Wheezy</td>
               <td><a href="{{splvar_install_v250_CDH580-WHEEZY}}">{{splvar_install_v250_CDH580-WHEEZY}}</a></td>
            </tr>
        </tbody>
    </table>

    To be sure that you have the latest URL, please check [the Splice
    Machine Community site][1]{: target="_blank"} or contact your Splice
    Machine representative.
    {: .noteIcon}

2.  Add the parcel repository
    {: .topLevel}

    1. Make sure the <span class="AppCommand">Use Parcels
    (Recommended)</span> option and the <span
    class="AppCommand">Matched release</span> option are both
    selected.

    2. Click the <span class="AppCommand">Continue</span> button to
    land on the *More Options* screen.

    3. Cick the <span class="AppCommand">+</span> button for the <span
    class="AppCommand">Remote Parcel Repository URLs</span> field.
    Paste your Splice Machine repository URL into this field.
    {: .LowerAlphaPlainFont}

3.  Use Cloudera Manager to install the parcel.
    {: .topLevel}

4.  Verify that the parcel has been distributed and activated.
    {: .topLevel}

    The Splice Machine parcel is identified as `SPLICEMACHINE` in the
    Cloudera Manager user interface. Make sure that this parcel has been
    downloaded, distributed, and activated on your cluster.
    {: .indentLevel1}

5.  Restart and redeploy any client changes when Cloudera Manager
prompts you.
    {: .topLevel}

    </div>
{: .boldFont}

</div>
## Stop Hadoop Services   {#Stop}

As a first step, we stop cluster services to allow our installer to make
changes that require the cluster to be temporarily inactive.

From the Cloudera Manager home screen, click the drop-down arrow next to
the cluster on

<div class="opsStepsList" markdown="1">
1.  Select your cluster in Cloudera Manager
    {: .topLevel}

    Click the drop-down arrow next to the name of the cluster on which
    you are installing Splice Machine.
    {: .indentLevel1}

2.  Stop the cluster
    {: .topLevel}

    Click the <span class="AppCommand">Stop</span> button.
    {: .indentLevel1}
{: .boldFont}

</div>
## Make Cluster Modifications for Splice Machine   {#ClusterMod}

Splice Machine requires a few modifications at the file system level to
work properly on a CDH cluster:

<div class="opsStepsList" markdown="1">
1.  Install updated Java Servlet library:
    {: .topLevel}

    You need to install an updated <span
    class="AppFontCustCode">javax.servlet-api</span> library so that
    Splice Machine can use Spark 2.0.x functionality in YARN.
    {: .indentLevel1}

2.  Remove Spark 1.6.x libraries
    {: .topLevel}

    By default, Splice Machine version uses Spark 2.0. To avoid Spark version mismatches, we strongly recommend that you remove Spark 1.6x libraries from /opt/cloudera/parcels/CDH/jars/; however, if you need to retain Spark 1.6 for other applications, please contact our install team to help with your configuration.
    {: .indentLevel1}

3.  Run our script as *root* user <span class="important">on each
    node</span> in your cluster to add symbolic links to the Splice
    Machine uber jar and YARN proxy jar into the YARN directories
    {: .topLevel}

    Issue this command <span class="important">on each node</span> in
    your cluster::
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

    sudo /opt/cloudera/parcels/SPLICEMACHINE/scripts/install-splice-symlinks.sh
    {: .AppCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>
## Configure Hadoop Services   {#Configur8}

Now it's time to make a few modifications in the Hadoop services
configurations:

* [Configure and Restart the Management Service](#Configur)
* [Configure ZooKeeper](#Configur4)
* [Configure HDFS](#Configur5)
* [Configure YARN](#Configur2)
* [Configure HBASE](#Configur3)

### Configure and Restart the Management Service   {#Configur}

<div class="opsStepsList" markdown="1">
1.  Select the <span class="AppCommand">Configuration</span> tab in CM:

    ![Configuring the Cloudera Manager
    ports](images/CM.AlertListenPort.png){: .nestedTightSpacing}

2.  Change the value of the Alerts: Listen Port to <span
class="AppFontCustCode">10110</span>.

3.  Save changes and restart the Management Service.
{: .boldFont}

</div>
### Configure ZooKeeper   {#Configur4}

To edit the ZooKeeper configuration, click <span
class="AppCommand">ZooKeeper</span> in the Cloudera Manager (CM) home
screen, then click the <span class="AppCommand">Configuration</span> tab
and follow these steps:

<div class="opsStepsList" markdown="1">
1.  Select the <span class="AppCommand">Service-Wide</span> category.
    {: .topLevel}

    Make the following changes:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
    Maximum Client Connections = 0
    Maximum Session Timeout    = 120000
    {: .AppCommand xml:space="preserve"}

    </div>

    Click the <span class="AppCommand">Save Changes</span> button.
    {: .indentLevel1}
{: .boldFont}

</div>
### Configure HDFS   {#Configur5}

To edit the HDFS configuration, click <span
class="AppCommand">HDFS</span> in the Cloudera Manager home screen, then
click the <span class="AppCommand">Configuration</span> tab and make
these changes:

<div class="opsStepsList" markdown="1">
1.  Verify that the HDFS data directories for your cluster are set up to
use your data disks.
    {: .topLevel}

2.  Change the values of these settings
    {: .topLevel}

    <table>
        <col />
        <col />
        <thead>
            <tr>
                <th>Setting</th>
                <th>New Value</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="AppFont">Handler Count</td>
                <td class="AppFontCust">20</td>
            </tr>
            <tr>
                <td class="AppFont">Maximum Number of Transfer Threads</td>
                <td class="AppFontCust">8192</td>
            </tr>
            <tr>
                <td class="AppFont">NameNodeHandler Count</td>
                <td class="AppFontCust">64</td>
            </tr>
            <tr>
                <td class="AppFont">NameNode Service Handler Count</td>
                <td class="AppFontCust">60</td>
            </tr>
            <tr>
                <td class="AppFont">Replication Factor</td>
                <td class="AppFontCust">2 or 3 *</td>
            </tr>
            <tr>
                <td class="AppFont">Java Heap Size of DataNode in Bytes</td>
                <td class="AppFontCust">2 GB</td>
            </tr>
        </tbody>
    </table>

3.  Click the <span class="AppCommand">Save Changes</span> button.
{: .boldFont}

</div>
### Configure YARN   {#Configur2}

To edit the YARN configuration, click <span
class="AppCommand">YARN</span> in the Cloudera Manager home screen, then
click the <span class="AppCommand">Configuration</span> tab and make
these changes:

<div class="opsStepsList" markdown="1">
1.  Verify that the following directories are set up to use your data disks.
    {: .topLevel}

    <table>
        <col />
        <tbody>
            <tr>
                <td class="AppFont">NodeManager Local Directories<br />NameNode Data Directories<br />HDFS Checkpoint Directories<br /></td>
            </tr>
        </tbody>
    </table>

2.  Change the values of these settings
    {: .topLevel}

    <table>
        <col />
        <col />
        <thead>
            <tr>
                <th>Setting</th>
                <th>New Value</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="AppFont">Heartbeat Interval</td>
                <td class="AppFontCust">100 ms</td>
            </tr>
            <tr>
                <td class="AppFont">MR Application Classpath</td>
                <td class="AppFontCust">
                    <div class="preWrapperWide"><pre class="Example">$HADOOP_MAPRED_HOME/*
$HADOOP_MAPRED_HOME/lib/*
$MR2_CLASSPATH/opt/cloudera/parcels/SPLICEMACHINE/lib/*</pre>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="AppFont">YARN Application Classpath</td>
                <td class="AppFontCust">
                    <div class="preWrapperWide"><pre class="Example">$HADOOP_CLIENT_CONF_DIR
$HADOOP_CONF_DIR
$HADOOP_COMMON_HOME/*
$HADOOP_COMMON_HOME/lib/*
$HADOOP_HDFS_HOME/*
$HADOOP_HDFS_HOME/lib/*
$HADOOP_YARN_HOME/*
$HADOOP_YARN_HOME/lib/*
$HADOOP_MAPRED_HOME/*
$HADOOP_MAPRED_HOME/lib/*
$MR2_CLASSPATH
/opt/cloudera/parcels/CDH/lib/hbase/*
/opt/cloudera/parcels/CDH/lib/hbase/lib/*
/opt/cloudera/parcels/SPLICEMACHINE/lib/*</pre>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="AppFont">Localized Dir Deletion Delay</td>
                <td class="AppFontCust">86400</td>
            </tr>
            <tr>
                <td class="AppFont">JobHistory Server Max Log Size</td>
                <td class="AppFontCust">1 GB</td>
            </tr>
            <tr>
                <td class="AppFont">NodeManager Max Log Size</td>
                <td class="AppFontCust">1 GB</td>
            </tr>
            <tr>
                <td class="AppFont">ResourceManager Max Log Size</td>
                <td class="AppFontCust">1 GB</td>
            </tr>
            <tr>
                <td class="AppFont">Container Memory</td>
                <td class="AppFontCust">30 GB (based on node specs)</td>
            </tr>
            <tr>
                <td class="AppFont">Container Memory Maximum</td>
                <td class="AppFontCust">30 GB (based on node specs)</td>
            </tr>
            <tr>
                <td class="AppFont">Container Virtual CPU Cores</td>
                <td class="AppFontCust">19 (based on node specs)</td>
            </tr>
            <tr>
                <td class="AppFont">Container Virtual CPU Cores Maximum</td>
                <td class="AppFontCust">19 (Based on node specs)</td>
            </tr>
        </tbody>
    </table>

3.  Add property values
    {: .topLevel}

    You need to add the same two property values to each of four YARN
    advanced configuration settings.
    {: .indentLevel1}

    Add these properties:
    {: .indentLevel1}

    <table>
        <col />
        <col />
        <thead>
            <tr>
                <th>XML Property Name</th>
                <th>XML Property Value</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="AppFont">yarn.nodemanager.aux-services.spark_shuffle.class</td>
                <td class="AppFontCust">org.apache.spark.network.yarn.YarnShuffleService</td>
            </tr>
            <tr>
                <td class="AppFont">yarn.nodemanager.aux-services</td>
                <td class="AppFontCust">mapreduce_shuffle,spark_shuffle</td>
            </tr>
        </tbody>
    </table>

    To each of these YARN settings:
    {: .indentLevel1}

    * Yarn Service Advanced Configuration Snippet (Safety Valve) for yarn-site.xml

    * Yarn Client Advanced Configuration Snippet (Safety Valve) for yarn-site.xml

    * NodeManager Advanced Configuration Snippet (Safety Valve) for yarn-site.xml

    * ResourceManager Advanced Configuration Snippet (Safety Valve) for yarn-site.xml
    {: .plainFont}

4.  Click the <span class="AppCommand">Save Changes</span> button.
{: .boldFont}

</div>
### Configure HBASE   {#Configur3}

To edit the HBASE configuration, click <span
class="AppCommand">HBASE</span> in the Cloudera Manager home screen,
then click the <span class="AppCommand">Configuration</span> tab and
make these changes:

<div class="opsStepsList" markdown="1">
1.  Change the values of these settings
    {: .topLevel}

    <table>
        <col />
        <col />
        <thead>
            <tr>
                <th>Setting</th>
                <th>New Value</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="AppFont">HBase Client Scanner Caching</td>
                <td class="AppFontCust">100 ms</td>
            </tr>
            <tr>
                <td class="AppFont">Graceful Shutdown Timeout</td>
                <td class="AppFontCust">30 seconds</td>
            </tr>
            <tr>
                <td class="AppFont">HBase Service Advanced Configuration Snippet (Safety Valve) for hbase-site.xml</td>
                <td class="AppFontCust"><span class="bodyFont">The property list for the Safety Valve snippet is shown below, in Step 2</span>
                </td>
            </tr>
            <tr>
                <td class="AppFont">SplitLog Manager Timeout</td>
                <td class="AppFontCust">5 minutes</td>
            </tr>
            <tr>
                <td class="AppFont">Maximum HBase Client Retries</td>
                <td class="AppFontCust">40</td>
            </tr>
            <tr>
                <td class="AppFont">RPC Timeout</td>
                <td class="AppFontCust">20 minutes (or 1200000 milliseconds)</td>
            </tr>
            <tr>
                <td class="AppFont">HBase Client Pause</td>
                <td class="AppFontCust">90</td>
            </tr>
            <tr>
                <td class="AppFont">ZooKeeper Session Timeout</td>
                <td class="AppFontCust">120000</td>
            </tr>
            <tr>
                <td class="AppFont">HBase Master Web UI Port</td>
                <td class="AppFontCust">16010</td>
            </tr>
            <tr>
                <td class="AppFont">HBase Master Port</td>
                <td class="AppFontCust">16000</td>
            </tr>
            <tr>
                <td class="AppFont">Java Configuration Options for HBase Master</td>
                <td class="AppFontCust"><span class="bodyFont">The  HBase Master Java configuration options list is shown below, in Step 3</span>
                </td>
            </tr>
            <tr>
                <td class="AppFont">HBase Coprocessor Master Classes</td>
                <td class="AppFontCust">
                    <p>com.splicemachine.hbase.SpliceMasterObserver</p>
                </td>
            </tr>
            <tr>
                <td class="AppFont">Java Heap Size of HBase Master in Bytes</td>
                <td class="AppFontCust">5 GB</td>
            </tr>
            <tr>
                <td class="AppFont">HStore Compaction Threshold</td>
                <td class="AppFontCust">5</td>
            </tr>
            <tr>
                <td class="AppFont">HBase RegionServer Web UI port</td>
                <td class="AppFontCust">16030</td>
            </tr>
            <tr>
                <td class="AppFont">HStore Blocking Store Files</td>
                <td class="AppFontCust">20</td>
            </tr>
            <tr>
                <td class="AppFont">Java Configuration Options for HBase RegionServer</td>
                <td class="AppFontCust"><span class="bodyFont">The HBase RegionServerJava configuration options list is shown below, in Step 4</span>
                </td>
            </tr>
            <tr>
                <td class="AppFont">HBase Memstore Block Multiplier</td>
                <td class="AppFontCust">4</td>
            </tr>
            <tr>
                <td class="AppFont">Maximum Number of HStoreFiles Compaction</td>
                <td class="AppFontCust">7</td>
            </tr>
            <tr>
                <td class="AppFont">HBase RegionServer Lease Period</td>
                <td class="AppFontCust">20 minutes (or 1200000 milliseconds)</td>
            </tr>
            <tr>
                <td class="AppFont">HFile Block Cache Size</td>
                <td class="AppFontCust">0.25</td>
            </tr>
            <tr>
                <td class="AppFont">Java Heap Size of HBase RegionServer in Bytes</td>
                <td class="AppFontCust">24 GB</td>
            </tr>
            <tr>
                <td class="AppFont">HBase RegionServer Handler Count</td>
                <td class="AppFontCust">200</td>
            </tr>
            <tr>
                <td class="AppFont">HBase RegionServer Meta-Handler Count</td>
                <td class="AppFontCust">200</td>
            </tr>
            <tr>
                <td class="AppFont">HBase Coprocessor Region Classes</td>
                <td class="AppFontCust">com.splicemachine.hbase.MemstoreAwareObserver<br />com.splicemachine.derby.hbase.SpliceIndexObserver<br />com.splicemachine.derby.hbase.SpliceIndexEndpoint<br />com.splicemachine.hbase.RegionSizeEndpoint<br />com.splicemachine.si.data.hbase.coprocessor.TxnLifecycleEndpoint<br />com.splicemachine.si.data.hbase.coprocessor.SIObserver<br />com.splicemachine.hbase.BackupEndpointObserver</td>
            </tr>
            <tr>
                <td class="AppFont">Maximum number of Write-Ahead Log (WAL) files</td>
                <td class="AppFontCust">48</td>
            </tr>
            <tr>
                <td class="AppFont">RegionServer Small Compactions Thread Count</td>
                <td class="AppFontCust">4</td>
            </tr>
            <tr>
                <td class="AppFont">HBase RegionServer Port</td>
                <td class="AppFontCust">16020</td>
            </tr>
            <tr>
                <td class="AppFont">Per-RegionServer Number of WAL Pipelines</td>
                <td class="AppFontCust">16</td>
            </tr>
        </tbody>
    </table>

2.  Set the value of `HBase Service Advanced Configuration Snippet
    (Safety Valve)` for `hbase-site.xml`:
    {: #HBaseAdvConfigStep}

    <div class="preWrapperWide" markdown="1">
        <property><name>dfs.client.read.shortcircuit.buffer.size</name><value>131072</value></property>
        <property><name>hbase.balancer.period</name><value>60000</value></property>
        <property><name>hbase.client.ipc.pool.size</name><value>10</value></property>
        <property><name>hbase.client.max.perregion.tasks</name><value>100</value></property>
        <property><name>hbase.coprocessor.regionserver.classes</name><value>com.splicemachine.hbase.RegionServerLifecycleObserver</value></property><property><name>hbase.hstore.defaultengine.compactionpolicy.class</name><value>com.splicemachine.compactions.SpliceDefaultCompactionPolicy</value></property>
        <property><name>hbase.hstore.defaultengine.compactor.class</name><value>com.splicemachine.compactions.SpliceDefaultCompactor</value></property>
        <property><name>hbase.htable.threads.max</name><value>96</value></property>
        <property><name>hbase.ipc.warn.response.size</name><value>-1</value></property>
        <property><name>hbase.ipc.warn.response.time</name><value>-1</value></property>
        <property><name>hbase.master.loadbalance.bytable</name><value>true</value></property>
        <property><name>hbase.mvcc.impl</name><value>org.apache.hadoop.hbase.regionserver.SIMultiVersionConsistencyControl</value></property>
        <property><name>hbase.regions.slop</name><value>0.01</value></property>
        <property><name>hbase.regionserver.global.memstore.size.lower.limit</name><value>0.9</value></property>
        <property><name>hbase.regionserver.global.memstore.size</name><value>0.25</value></property>
        <property><name>hbase.regionserver.maxlogs</name><value>48</value></property>
        <property><name>hbase.regionserver.wal.enablecompression</name><value>true</value></property>
        <property><name>hbase.rowlock.wait.duration</name><value>0</value></property>
        <property><name>hbase.status.multicast.port</name><value>16100</value></property>
        <property><name>hbase.wal.disruptor.batch</name><value>true</value></property>
        <property><name>hbase.wal.provider</name><value>multiwal</value></property>
        <property><name>hbase.wal.regiongrouping.numgroups</name><value>16</value></property>
        <property><name>hbase.zookeeper.property.tickTime</name><value>6000</value></property>
        <property><name>hfile.block.bloom.cacheonwrite</name><value>true</value></property>
        <property><name>io.storefile.bloom.error.rate</name><value>0.005</value></property>
        <property><name>splice.client.numConnections</name><value>1</value></property>
        <property><name>splice.client.write.maxDependentWrites</name><value>60000</value></property>
        <property><name>splice.client.write.maxIndependentWrites</name><value>60000</value></property>
        <property><name>splice.compression</name><value>snappy</value></property>
        <property><name>splice.marshal.kryoPoolSize</name><value>1100</value></property>
        <property><name>splice.olap_server.clientWaitTime</name><value>900000</value></property>
        <property><name>splice.ring.bufferSize</name><value>131072</value></property>
        <property><name>splice.splitBlockSize</name><value>67108864</value></property>
        <property><name>splice.timestamp_server.clientWaitTime</name><value>120000</value></property>
        <property><name>splice.txn.activeTxns.cacheSize</name><value>10240</value></property>
        <property><name>splice.txn.completedTxns.concurrency</name><value>128</value></property>
        <property><name>splice.txn.concurrencyLevel</name><value>4096</value></property>
        <property><name>hbase.hstore.compaction.max.size</name><value>260046848</value></property>
        <property><name>hbase.hstore.compaction.min.size</name><value>16777216</value></property>
        <property><name>hbase.hstore.compaction.min</name><value>5</value></property>
        <property><name>hbase.regionserver.thread.compaction.large</name><value>1</value></property>
        <property><name>splice.authentication.native.algorithm</name><value>SHA-512</value></property>
        <property><name>splice.authentication</name><value>NATIVE</value></property>
    {: .Example}

    </div>

3.  Set the value of Java Configuration Options for HBase Master:

    <div class="preWrapperWide" markdown="1">
        -XX:MaxPermSize=512M -XX:+HeapDumpOnOutOfMemoryError -XX:MaxDirectMemorySize=2g
        -XX:+AlwaysPreTouch -XX:+UseParNewGC -XX:+UseConcMarkSweepGC
        -XX:CMSInitiatingOccupancyFraction=70 -XX:+CMSParallelRemarkEnabled
        -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false
        -Dcom.sun.management.jmxremote.port=10101 -Dsplice.spark.enabled=true
        -Dsplice.spark.app.name=SpliceMachine -Dsplice.spark.master=yarn-client
        -Dsplice.spark.logConf=true -Dsplice.spark.yarn.maxAppAttempts=1
        -Dsplice.spark.driver.maxResultSize=1g -Dsplice.spark.driver.cores=2
        -Dsplice.spark.yarn.am.memory=1g -Dsplice.spark.dynamicAllocation.enabled=true
        -Dsplice.spark.dynamicAllocation.executorIdleTimeout=120
        -Dsplice.spark.dynamicAllocation.cachedExecutorIdleTimeout=120
        -Dsplice.spark.dynamicAllocation.minExecutors=0
        -Dsplice.spark.dynamicAllocation.maxExecutors=12 -Dsplice.spark.io.compression.lz4.blockSize=32k
        -Dsplice.spark.kryo.referenceTracking=false
        -Dsplice.spark.kryo.registrator=com.splicemachine.derby.impl.SpliceSparkKryoRegistrator
        -Dsplice.spark.kryoserializer.buffer.max=512m -Dsplice.spark.kryoserializer.buffer=4m
        -Dsplice.spark.locality.wait=100 -Dsplice.spark.memory.fraction=0.5
        -Dsplice.spark.scheduler.mode=FAIR
        -Dsplice.spark.serializer=org.apache.spark.serializer.KryoSerializer
        -Dsplice.spark.shuffle.compress=false -Dsplice.spark.shuffle.file.buffer=128k
        -Dsplice.spark.shuffle.service.enabled=true
        -Dsplice.spark.yarn.am.extraLibraryPath=/opt/cloudera/parcels/CDH/lib/hadoop/lib/native
        -Dsplice.spark.yarn.am.waitTime=10s -Dsplice.spark.yarn.executor.memoryOverhead=2048
        -Dsplice.spark.driver.extraJavaOptions=-Dlog4j.configuration=file:/etc/spark/conf/log4j.properties
        -Dsplice.spark.driver.extraLibraryPath=/opt/cloudera/parcels/CDH/lib/hadoop/lib/native
        -Dsplice.spark.driver.extraClassPath=/opt/cloudera/parcels/CDH/lib/hbase/conf:/opt/cloudera/parcels/CDH/jars/htrace-core-3.1.0-incubating.jar
        -Dsplice.spark.executor.extraLibraryPath=/opt/cloudera/parcels/CDH/lib/hadoop/lib/native
        -Dsplice.spark.executor.extraClassPath=/opt/cloudera/parcels/CDH/lib/hbase/conf:/opt/cloudera/parcels/CDH/jars/htrace-core-3.1.0-incubating.jar
        -Dsplice.spark.ui.retainedJobs=100 -Dsplice.spark.ui.retainedStages=100 -Dsplice.spark.worker.ui.retainedExecutors=100
        -Dsplice.spark.worker.ui.retainedDrivers=100 -Dsplice.spark.streaming.ui.retainedBatches=100 -Dsplice.spark.executor.cores=4
        -Dsplice.spark.executor.memory=8g -Dspark.compaction.reserved.slots=4 -Dsplice.spark.eventLog.enabled=true
        -Dsplice.spark.eventLog.dir=hdfs:///user/splice/history -Dsplice.spark.local.dir=/tmp
        -Dsplice.spark.yarn.jars=/opt/cloudera/parcels/SPLICEMACHINE/lib/*
    {: .Example}

    </div>

4.  Set the value of Java Configuration Options for Region Servers:

    <div class="preWrapperWide" markdown="1">
        -XX:+HeapDumpOnOutOfMemoryError -XX:MaxDirectMemorySize=2g -XX:MaxPermSize=512M -XX:+AlwaysPreTouch -XX:+UseG1GC -XX:MaxNewSize=4g -XX:InitiatingHeapOccupancyPercent=60 -XX:ParallelGCThreads=24 -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=5000 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=10102
    {: .Example}

    </div>

5.  Click the <span class="AppCommand">Save Changes</span> button.
{: .boldFont}

</div>
## Optional Configuration Modifications   {#Optional}

There are a few configuration modifications you might want to make:

* [Modify the Authentication Mechanism](#Modify) if you want to
  authenticate users with something other than the default *native
  authentication* mechanism.
* [Modify the Log Location](#Logging) if you want your Splice Machine
  log entries stored somewhere other than in the logs for your region
  servers.

### Modify the Authentication Mechanism   {#Modify}

Splice Machine installs with Native authentication configured; native
authentication uses the `sys.sysusers` table in the `splice` schema for
configuring user names and passwords.

You can disable authentication or change the authentication mechanism
that Splice Machine uses to LDAP by following the simple instructions in
[Configuring Splice Machine
Authentication](onprem_install_configureauth.html)

You can use <a href="https://www.cloudera.com/documentation/enterprise/5-8-x/topics/cm_sg_intro_kerb.html" target="_blank">Cloudera's Kerberos Wizard</a> to enable Kerberos mode on a CDH5.8.x cluster.

### Modify the Log Location   {#Logging}

Splice Machine logs all SQL statements by default, storing the log
entries in your region server's logs, as described in our [Using
Logging](developers_tuning_logging) topic. You can modify where Splice
Machine by adding the following snippet to your *RegionServer Logging
Advanced Configuration Snippet (Safety Valve)* section of your HBase
Configuration:

<div class="preWrapper" markdown="1">
    log4j.appender.spliceDerby=org.apache.log4j.FileAppender
    log4j.appender.spliceDerby.File=${hbase.log.dir}/splice-derby.log
    log4j.appender.spliceDerby.layout=org.apache.log4j.EnhancedPatternLayout
    log4j.appender.spliceDerby.layout.ConversionPattern=%d{EEE MMM d HH:mm:ss,SSS} Thread[%t] %m%n

    log4j.appender.spliceStatement=org.apache.log4j.FileAppender
    log4j.appender.spliceStatement.File=${hbase.log.dir}/splice-statement.log
    log4j.appender.spliceStatement.layout=org.apache.log4j.EnhancedPatternLayout
    log4j.appender.spliceStatement.layout.ConversionPattern=%d{EEE MMM d HH:mm:ss,SSS} Thread[%t] %m%n

    log4j.logger.splice-derby=INFO, spliceDerby
    log4j.additivity.splice-derby=false

    # Uncomment to log statements to a different file:
    #log4j.logger.splice-derby.statement=INFO, spliceStatement
    # Uncomment to not replicate statements to the spliceDerby file:
    #log4j.additivity.splice-derby.statement=false
{: .Plain}

</div>
## Deploy the Client Configuration   {#Deploy}

Now that you've updated your configuration information, you need to
deploy it throughout your cluster. You should see a small notification
in the upper right corner of your screen that looks like this:

![Clicking the button to tell Cloudera to redeploy the client
configuration](images/CDH.StaleConfig.png){: .nestedTightSpacing}

To deploy your configuration:

<div class="opsStepsList" markdown="1">
1.  Click the notification.
2.  Click the <span class="AppCommand">Deploy Client
    Configuration</span> button.
3.  When the deployment completes, click the <span
    class="AppCommand">Finish</span> button.
{: .boldFont}

</div>
## Restart the Cluster   {#Restart}

As a first step, we stop the services that we're about to configure from
the Cloudera Manager home screen:

<div class="opsStepsList" markdown="1">
1.  Restart ZooKeeper
    {: .topLevel}

    Select <span class="AppCommand">Start</span> from the <span
    class="AppCommand">Actions</span> menu in the upper right corner of
    the ZooKeeper <span class="AppCommand">Configuration</span> tab to
    restart ZooKeeper.
    {: .indentLevel1}

2.  Restart HDFS
    {: .topLevel}

    Click the <span class="AppCommand">HDFS Actions</span> drop-down
    arrow associated with (to the right of) HDFS in the cluster summary
    section of the Cloudera Manager home screen, and then click <span
    class="AppCommand">Start</span> to restart HDFS.
    {: .indentLevel1}

    Use your terminal window to create these directories (if they are
    not already available in HDFS):
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        sudo -iu hdfs hadoop fs -mkdir -p hdfs:///user/hbase hdfs:///user/splice/history
        sudo -iu hdfs hadoop fs -chown -R hbase:hbase hdfs:///user/hbase hdfs:///user/splice
        sudo -iu hdfs hadoop fs -chmod 1777 hdfs:///user/splice hdfs:///user/splice/history
    {: .ShellCommand xml:space="preserve"}

    </div>

3.  Restart YARN
    {: .topLevel}

    Click the <span class="AppCommand">YARN Actions</span> drop-down
    arrow associated with (to the right of) YARN in the cluster summary
    section of the Cloudera Manager home screen, and then click <span
    class="AppCommand">Start</span> to restart YARN.
    {: .indentLevel1}

4.  Restart HBase
    {: .topLevel}

    Click the <span class="AppCommand">HBASE Actions</span> drop-down
    arrow associated with (to the right of) HBASE in the cluster summary
    section of the Cloudera Manager home screen, and then click <span
    class="AppCommand">Start</span> to restart HBase.
    {: .indentLevel1}
{: .boldFont}

</div>
## Verify your Splice Machine Installation   {#Run}

Now start using the Splice Machine command line interpreter, which is
referred to as *the splice prompt* or simply <span
class="AppCommand">splice&gt;</span> by launching the `sqlshell.sh`
script on any node in your cluster that is running an HBase region
server.

The command line interpreter defaults to connecting on port `1527` on
`localhost`, with username `splice`, and password `admin`. You can
override these defaults when starting the interpreter, as described in
the [Command Line (splice&gt;) Reference](cmdlineref_intro.html) topic
in our *Developer's Guide*.
{: .noteNote}

Now try entering a few sample commands you can run to verify that
everything is working with your Splice Machine installation.

<table summary="Sample commands to verify your installation">
                    <col />
                    <col />
                    <thead>
                        <tr>
                            <th>Operation</th>
                            <th>Command to perform operation</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Display tables</td>
                            <td>
                                <div class="preWrapperWide"><pre class="AppCommandCell" xml:space="preserve">splice&gt; show tables;</pre>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Create a table</td>
                            <td>
                                <div class="preWrapperWide"><pre class="AppCommandCell">splice&gt; create table test (i int);</pre>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Add data to the table</td>
                            <td>
                                <div class="preWrapperWide"><pre class="AppCommandCell">splice&gt; insert into test values 1,2,3,4,5;</pre>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Query data in the table</td>
                            <td>
                                <div class="preWrapperWide"><pre class="AppCommandCell">splice&gt; select * from test;</pre>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Drop the table</td>
                            <td>
                                <div class="preWrapperWide"><pre class="AppCommandCell">splice&gt; drop table test;</pre>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>List available commands</td>
                            <td>
                                <div class="preWrapperWide"><pre class="AppCommandCell">splice&gt; help;</pre>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Exit the command line interpreter</td>
                            <td>
                                <div class="preWrapperWide"><pre class="AppCommandCell">splice&gt; exit;</pre>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"><strong>Make sure you end each command with a semicolon</strong> (<code>;</code>), followed by the <em>Enter</em> key or <em>Return</em> key </td>
                        </tr>
                    </tbody>
                </table>
See the [Command Line (splice&gt;) Reference](cmdlineref_intro.html)
section of our *Developer's Guide* for information about our commands
and command syntax.

</div>
</div>
</section>



[1]: https://community.splicemachine.com/
