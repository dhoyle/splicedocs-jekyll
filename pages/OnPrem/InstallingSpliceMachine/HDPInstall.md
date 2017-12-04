---
summary: How to download, install, configure and verify your installation of Splice Machine on Hortonworks HDP.
title: Installing and Configuring Splice Machine for Hortonworks HDP
keywords: Hortonworks, HDP, installation, hadoop, hbase, hdfs sqlshell.sh, sqlshell, download splice
toc: false
product: onprem
sidebar:  onprem_sidebar
permalink: onprem_install_hortonworks.html
folder: OnPrem/InstallingSpliceMachine
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% include splicevars.html %}
# Installing and Configuring Splice Machine for Hortonworks HDP

{% include splice_snippets/onpremonlytopic.md %}
This topic describes installing and configuring Splice Machine on a
Hortonworks Ambari-managed cluster. Follow these steps:

1.  [Verify Prerequisites](#Verify)
2.  [Download and Install Splice Machine](#Install)
3.  [Stop Hadoop Services](#Stop)
4.  [Configure Hadoop Services](#Configur8)
5.  [Start Any Additional Services](#Start)
6.  Make any needed [Optional Configuration Modifications](#Optional)
7.  [Verify your Splice Machine Installation](#Run)

## Verify Prerequisites   {#Verify}

Before starting your Splice Machine installation, please make sure that
your cluster contains the prerequisite software components:

* A cluster running HDP
* Ambari installed and configured for HDP
* HBase installed
* HDFS installed
* YARN installed
* ZooKeeper installed
* Ensure that Phoenix services are **NOT** installed on your cluster, as
  they interfere with Splice Machine HBase settings.

The specific versions of these components that you need depend on your
operating environment, and are called out in detail in the
[Requirements](onprem_info_requirements.html) topic of our *Getting
Started Guide*.
{: .noteNote}

## Download and Install Splice Machine   {#Install}

Perform the following steps <span class="important">on each node</span>
in your cluster:

<div class="opsStepsList" markdown="1">
1.  Download the installer for your version.
    {: .topLevel}

    Which Splice Machine installer (gzip) package you need depends upon which Splice Machine version you're installing and which version of HDP you are using. Here are the URLs for Splice Machine Release {{splvar_basic_SpliceReleaseVersion}} and {{splvar_basic_SplicePrevReleaseVersion}}:
    {: .indentLevel1}

    <table>
        <col />
        <col />
        <col />
        <thead>
            <tr>
                <th>Splice Machine Release</th>
                <th>HDP Version</th>
                <th>Installer Package Link</th>
            </tr>
        </thead>
        <tbody>
               <tr>
                   <td class="SpliceRelease">2.6.1</td>
                   <td class="SplicePlatform">{{splvar_install_HDP255}}</td>
                   <td><a href="{{splvar_install_v261_HDP255}}">{{splvar_install_v261_HDP255}}</a></td>
                </tr>
                <tr>
                    <td colspan="3" class="Separator"> </td>
                </tr>
               <tr>
                   <td class="SpliceRelease">2.5.0</td>
                   <td class="SplicePlatform">{{splvar_install_HDP255}}</td>
                   <td><a href="{{splvar_install_v250_HDP255}}">{{splvar_install_v250_HDP255}}</a></td>
                </tr>
        </tbody>
    </table>

    To be sure that you have the latest URL, please check [the Splice
    Machine Community site][1]{: target="_blank"} or contact your Splice
    Machine representative.
    {: .noteIcon}

2.  Create the `splice` installation directory:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        sudo mkdir -p /opt/splice
    {: .ShellCommandCell}

    </div>

3.  Download the Splice Machine package into the `splice` directory on
    the node. For example:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        sudo curl '{{splvar_install_AWSS3Bucket}}/{{splvar_install_CurrentRelease}}/{{splvar_install_AWSInstallerPart}}/{{splvar_install_HDP-R2}}/SPLICEMACHINE-{{splvar_install_CurrentRelease}}.{{splvar_install_HDP-R2}}.{{splvar_install_SpliceReleaseGZ}}' -o /opt/splice/SPLICEMACHINE-{{splvar_install_CurrentRelease}}.{{splvar_install_HDP-R2}}.{{splvar_install_SpliceReleaseGZ}}
    {: .ShellCommandCell}

    </div>

4.  Extract the Splice Machine package:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        sudo tar -xf SPLICEMACHINE-{{splvar_install_CurrentRelease}}.{{splvar_install_HDP-R2}}.{{splvar_install_SpliceReleaseGZ}} --directory /opt/splice
    {: .ShellCommandCell}

    </div>

5.  Run our script as *root* user <span class="important">on each
    node</span> in your cluster to add symbolic links to set up Splice
    Machine jar script symbolic links
    {: .topLevel}

    Issue this command <span class="important">on each node</span> in
    your cluster:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        sudo /opt/splice/default/scripts/install-splice-symlinks.sh
    {: .AppCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>
## Stop Hadoop Services   {#Stop}

As a first step, we stop cluster services to allow our installer to make
changes that require the cluster to be temporarily inactive.

<div class="opsStepsList" markdown="1">
1.  Access the Ambari Home Screen
    {: .topLevel}

2.  Click the <span class="AppCommand">Actions</span> drop-down, and
    then click the <span class="AppCommand">Stop All</span> button.
    {: .topLevel}
{: .boldFont}

</div>
## Configure Hadoop Services   {#Configur8}

Now it's time to make a few modifications in the Hadoop services
configurations:

* [Configure and Restart ZooKeeper](#Configur4)
* [Configure and Restart HDFS](#Configur5)
* [Configure and Restart YARN](#Configur2)
* [Configure MapReduce2](#Configur)
* [Configure and Restart HBASE](#Configur3)

### Configure and Restart ZooKeeper   {#Configur4}

To edit the ZooKeeper configuration, select the <span
class="AppCommand">Services</span> tab at the top of the Ambari
dashboard screen, then click <span class="AppCommand">ZooKeeper</span>
in the Ambari in the left pane of the screen.

<div class="opsStepsList" markdown="1">
1.  Select the <span class="AppCommand">Configs</span> tab to configure
    ZooKeeper
    {: .topLevel}

2.  Make configuration changes:
    {: .topLevel}

    Scroll down to where you see *Custom zoo.cfg* and click <span
    class="AppCommand">Add Property</span> to add the `maxClientCnxns`
    property and then again to add the `maxSessionTimeout` property,
    with these values:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        maxClientCnxns=0
        maxSessionTimeout=120000
    {: .AppCommand xml:space="preserve"}

    </div>

3.  Save Changes
    {: .topLevel}

    Click the <span class="AppCommand">Save</span> button to save your
    changes. You'll be prompted to optionally add a note such as
    `Updated ZooKeeper configuration for Splice Machine`. Click <span
    class="AppCommand">Save</span> again.
    {: .indentLevel1}

4.  Start ZooKeeper
    {: .topLevel}

    After you save your changes, you'll land back on the ZooKeeper
    Service <span class="AppCommand">Configs</span> tab in Ambari.
    {: .indentLevel1}

    Open the <span class="AppCommand">Service Actions</span> drop-down
    in the upper-right corner and select the <span
    class="AppCommand">Start</span> action to start ZooKeeper. Wait for
    the restart to complete.
    {: .indentLevel1}
{: .boldFont}

</div>
### Configure and Restart HDFS   {#Configur5}

To edit the HDFS configuration, select the <span
class="AppCommand">Services</span> tab at the top of the Ambari
dashboard screen, then click <span class="AppCommand">HDFS</span> in the
Ambari in the left pane of the screen. Finally, click the <span
class="AppCommand">Configs</span> tab.

<div class="opsStepsList" markdown="1">
1.  Edit the HDFS configuration as follows:
    {: .topLevel}

    <table>
            <col />
            <col />
            <tbody>
                <tr>
                    <td class="AppFont">NameNode Java heap size</td>
                    <td class="AppFontCust">4 GB</td>
                </tr>
                <tr>
                    <td class="AppFont">DataNode maximum Java heap size</td>
                    <td class="AppFontCust">2 GB</td>
                </tr>
                <tr>
                    <td class="AppFont">Block replication</td>
                    <td class="AppFontCust">2 <span class="bodyFont">(for clusters with less than 8 nodes)</span><br />3 <span class="bodyFont">(for clusters with 8 or more nodes)</span></td>
                </tr>
            </tbody>
        </table>

2.  Add a new property:
    {: .topLevel}

    Click <span class="AppCommand">Add Property</span>... under <span
    class="AppCommand">Custom hdfs-site</span>, and add the following
    property:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        dfs.datanode.handler.count=20
    {: .AppCommand xml:space="preserve"}

    </div>

3.  Save Changes
    {: .topLevel}

    Click the <span class="AppCommand">Save</span> button to save your
    changes. You'll be prompted to optionally add a note such as
    `Updated HDFS configuration for Splice Machine`. Click <span
    class="AppCommand">Save</span> again.
    {: .indentLevel1}

4.  Start HDFS
    {: .topLevel}

    After you save your changes, you'll land back on the <span
    class="AppCommand">HDFS Service Configs</span> tab in Ambari.
    {: .indentLevel1}

    Open the <span class="AppCommand">Service Actions</span> drop-down
    in the upper-right corner and select the <span
    class="AppCommand">Start</span> action to start HDFS. Wait for the
    restart to complete.
    {: .indentLevel1}

5.  Create directories for hbase user and the Splice Machine YARN
    application:
    {: .topLevel}

    Use your terminal window to create these directories:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        sudo -iu hdfs hadoop fs -mkdir -p hdfs:///user/hbase hdfs:///user/splice/history
        sudo -iu hdfs hadoop fs -chown -R hbase:hbase hdfs:///user/hbase hdfs:///user/splice
        sudo -iu hdfs hadoop fs -chmod 1777 hdfs:///user/splice hdfs:///user/splice/history
    {: .ShellCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>
### Configure and Restart YARN   {#Configur2}

To edit the YARN configuration, select the <span
class="AppCommand">Services</span> tab at the top of the Ambari
dashboard screen, then click <span class="AppCommand">YARN</span> in the
Ambari in the left pane of the screen. Finally, click the <span
class="AppCommand">Configs</span> tab.

<div class="opsStepsList" markdown="1">
1.  Update these other configuration values:
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
                <td class="AppFont">yarn.application.classpath </td>
                <td class="AppFontCust">
                    <div class="preWrapperWide"><pre class="Example">$HADOOP_CONF_DIR,/usr/hdp/current/hadoop-client/*,/usr/hdp/current/hadoop-client/lib/*,/usr/hdp/current/hadoop-hdfs-client/*,/usr/hdp/current/hadoop-hdfs-client/lib/*,/usr/hdp/current/hadoop-yarn-client/*,/usr/hdp/current/hadoop-yarn-client/lib/*,/usr/hdp/current/hadoop-mapreduce-client/*,/usr/hdp/current/hadoop-mapreduce-client/lib/*,/usr/hdp/current/hbase-regionserver/*,/usr/hdp/current/hbase-regionserver/lib/*,/opt/splice/default/lib/*</pre>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="AppFont">yarn.nodemanager.aux-services.spark2_shuffle.classpath</td>
                <td class="AppFontCust">/opt/splice/default/lib/*</td>
            </tr>
            <tr>
                <td class="AppFont">yarn.nodemanager.aux-services.spark_shuffle.classpath</td>
                <td class="AppFontCust">/opt/splice/default/lib/*</td>
            </tr>
            <tr>
                <td class="AppFont">yarn.nodemanager.aux-services.spark2_shuffle.class</td>
                <td class="AppFontCust">org.apache.spark.network.yarn.YarnShuffleService</td>
            </tr>
            <tr>
                <td class="AppFont">yarn.nodemanager.delete.debug-delay-sec</td>
                <td class="AppFontCust">86400</td>
            </tr>
            <tr>
                <td class="AppFont">Memory allocated for all YARN containers on a node </td>
                <td class="AppFontCust">30 GB (based on node specs)</td>
            </tr>
            <tr>
                <td class="AppFont">Minimum Container Size (Memory)</td>
                <td class="AppFontCust">1 GB (based on node specs)</td>
            </tr>
            <tr>
                <td class="AppFont">Minimum Container Size (Memory)</td>
                <td class="AppFontCust">30 GB (based on node specs)</td>
            </tr>
        </tbody>
    </table>

2.  Save Changes
    {: .topLevel}

    Click the <span class="AppCommand">Save</span> button to save your
    changes. You'll be prompted to optionally add a note such as
    `Updated YARN configuration for Splice Machine`. Click <span
    class="AppCommand">Save</span> again.
    {: .indentLevel1}

3.  Start YARN
    {: .topLevel}

    After you save your changes, you'll land back on the <span
    class="AppCommand">YARN Service Configs</span> tab in Ambari.
    {: .indentLevel1}

    Open the <span class="AppCommand">Service Actions</span> drop-down
    in the upper-right corner and select the <span
    class="AppCommand">Start</span> action to start YARN. Wait for the
    restart to complete.
    {: .indentLevel1}
{: .boldFont}

</div>
### Configure MapReduce2   {#Configur}

Ambari automatically sets these values for you:

* Map Memory

* Reduce Memory

* Sort Allocation Memory

* AppMaster Memory

* MR Map Java Heap Size

* MR Reduce Java Heap Size
{: .codeList}

You do, however, need to make a few property changes for this service.

To edit the MapReduce2 configuration, select the <span
class="AppCommand">Services</span> tab at the top of the Ambari
dashboard screen, then click <span class="AppCommand">MapReduce2</span>
in the Ambari in the left pane of the screen. Finally, click the <span
class="AppCommand">Configs</span> tab and follow these steps:

<div class="opsStepsList" markdown="1">
1.  Select the <span class="AppCommand">Configs</span> tab to configure MapReduce2.
    {: .topLevel}

2.  Update property values
    {: .topLevel}

    You need to replace <span
    class="AppFontCustCode">${hdp.version}</span> with the actual HDP
    version number you are using in these property values:
    {: .indentLevel1}

    * mapreduce.admin.map.child.java.opts

    * mapreduce.admin.reduce.child.java.opts

    * mapreduce.admin.user.env

    * mapreduce.application.classpath

    * mapreduce.application.framework.path

    * yarn.app.mapreduce.am.admin-command-opts

    * MR AppMaster Java Heap Size  <br /><br />

    An example of an HDP version number that you would substitute for
    <span class="AppFontCustCode">${hdp.version}</span> is
    `2.5.0.0-1245`.
    {: .noteNote}

3.  Save Changes
    {: .topLevel}

    Click the <span class="AppCommand">Save</span> button to save your
    changes. You'll be prompted to optionally add a note such as
    `Updated MapReduce2 configuration for Splice Machine`. Click <span
    class="AppCommand">Save</span> again.
    {: .indentLevel1}

4.  Start MapReduce2
    {: .topLevel}

    After you save your changes, you'll land back on the MapReduce2
    Service <span class="AppCommand">Configs</span> tab in Ambari.
    {: .indentLevel1}

    Open the <span class="AppCommand">Service Actions</span> drop-down
    in the upper-right corner and select the <span
    class="AppCommand">Start</span> action to start MapReduce2. Wait for
    the restart to complete.
    {: .indentLevel1}
{: .boldFont}

</div>
### Configure and Restart HBASE   {#Configur3}

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
                    <td class="AppFont">% of RegionServer Allocated to Write Buffer<br />(hbase.regionserver.global.memstore.size)</td>
                    <td class="AppFontCust">0.25</td>
                </tr>
                <tr>
                    <td class="AppFont">HBase RegionServer Maximum Memory<br /> (hbase_regionserver_heapsize)</td>
                    <td class="AppFontCust">24 GB</td>
                </tr>
                <tr>
                    <td class="AppFont">% of RegionServer Allocated to Read Buffers<br /> (hfile.block.cache.size)</td>
                    <td class="AppFontCust">0.25</td>
                </tr>
                <tr>
                    <td class="AppFont">HBase Master Maximum Memory<br /> (hbase_master_heapsize)</td>
                    <td class="AppFontCust">5 GB</td>
                </tr>
                <tr>
                    <td class="AppFont">Number of Handlers per RegionServer<br /> (hbase.regionserver.handler.count)</td>
                    <td class="AppFontCust">200</td>
                </tr>
                <tr>
                    <td class="AppFont">HBase RegionServer Meta-Handler Count</td>
                    <td class="AppFontCust">200</td>
                </tr>
                <tr>
                    <td class="AppFont">HBase RPC Timeout</td>
                    <td class="AppFontCust">1200000 (20 minutes)</td>
                </tr>
                <tr>
                    <td class="AppFont">Zookeeper Session Timeout</td>
                    <td class="AppFontCust">120000 (2 minutes)</td>
                </tr>
                <tr>
                    <td class="AppFont">hbase.coprocessor.master.classes</td>
                    <td class="AppFontCust">com.splicemachine.hbase.SpliceMasterObserver</td>
                </tr>
                <tr>
                    <td class="AppFont">hbase.coprocessor.region.classes</td>
                    <td class="AppFontCust">
                        <p><span class="bodyFont">The value of this property is shown below, in Step 2</span>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td class="AppFont">Maximum Store Files before Minor Compaction<br /> (hbase.hstore.compactionThreshold)<br /></td>
                    <td class="AppFontCust">5</td>
                </tr>
                <tr>
                    <td class="AppFont">Number of Fetched Rows when Scanning from Disk<br /> (hbase.client.scanner.caching)<br /></td>
                    <td class="AppFontCust">1000</td>
                </tr>
                <tr>
                    <td class="AppFont">hstore blocking storefiles<br /> (hbase.hstore.blockingStoreFiles)</td>
                    <td class="AppFontCust">20</td>
                </tr>
                <tr>
                    <td class="AppFont">Advanced hbase-env</td>
                    <td class="AppFontCust"><span class="bodyFont">The value of this property is shown below, in Step 3</span>
                    </td>
                </tr>
                <tr>
                    <td class="AppFont">Custom hbase-site</td>
                    <td class="AppFontCust"><span class="bodyFont">The value of this is shown below, in Step 4</span>
                    </td>
                </tr>
            </tbody>
        </table>

2.  Set the value of the `hbase.coprocessor.region.classes` property to the following:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        com.splicemachine.hbase.MemstoreAwareObserver,com.splicemachine.derby.hbase.SpliceIndexObserver,com.splicemachine.derby.hbase.SpliceIndexEndpoint,com.splicemachine.hbase.RegionSizeEndpoint,com.splicemachine.si.data.hbase.coprocessor.TxnLifecycleEndpoint,com.splicemachine.si.data.hbase.coprocessor.SIObserver,com.splicemachine.hbase.BackupEndpointObserver
    {: .Example}

    </div>

3.  Under `Advanced hbase-env`, set the value of `hbase-env template` to the following:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        # Set environment variables here.

        # The java implementation to use. Java 1.6 required.
        export JAVA_HOME={{java64_home}}

        # HBase Configuration directory
        export HBASE_CONF_DIR=${HBASE_CONF_DIR:-{{hbase_conf_dir}}}

        # Extra Java CLASSPATH elements. Optional.
        export HBASE_CLASSPATH=${HBASE_CLASSPATH}
        # add Splice Machine to the HBase classpath
        SPLICELIBDIR="/opt/splice/default/lib"
        APPENDSTRING=$(echo $(find ${SPLICELIBDIR} -maxdepth 1 -name \*.jar | sort) | sed 's/ /:/g')
        export HBASE_CLASSPATH="${HBASE_CLASSPATH}:${APPENDSTRING}"

        # The maximum amount of heap to use, in MB. Default is 1000.
        # export HBASE_HEAPSIZE=1000

        # Extra Java runtime options.
        # Below are what we set by default. May only work with SUN JVM.
        # For more on why as well as other possible settings,
        # see http://wiki.apache.org/hadoop/PerformanceTuning
        export SERVER_GC_OPTS="-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:{{log_dir}}/gc.log-`date +'%Y%m%d%H%M'`"
        # Uncomment below to enable java garbage collection logging.
        # export HBASE_OPTS="$HBASE_OPTS -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:$HBASE_HOME/logs/gc-hbase.log"

        # Uncomment and adjust to enable JMX exporting
        # See jmxremote.password and jmxremote.access in $JRE_HOME/lib/management to configure remote password access.
        # More details at: http://java.sun.com/javase/6/docs/technotes/guides/management/agent.html
        #
        # export HBASE_JMX_BASE="-Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
        # If you want to configure BucketCache, specify '-XX: MaxDirectMemorySize=' with proper direct memory size
        # export HBASE_THRIFT_OPTS="$HBASE_JMX_BASE -Dcom.sun.management.jmxremote.port=10103"
        # export HBASE_ZOOKEEPER_OPTS="$HBASE_JMX_BASE -Dcom.sun.management.jmxremote.port=10104"

        # File naming hosts on which HRegionServers will run. $HBASE_HOME/conf/regionservers by default.
        export HBASE_REGIONSERVERS=${HBASE_CONF_DIR}/regionservers

        # Extra ssh options. Empty by default.
        # export HBASE_SSH_OPTS="-o ConnectTimeout=1 -o SendEnv=HBASE_CONF_DIR"

        # Where log files are stored. $HBASE_HOME/logs by default.
        export HBASE_LOG_DIR={{log_dir}}

        # A string representing this instance of hbase. $USER by default.
        # export HBASE_IDENT_STRING=$USER

        # The scheduling priority for daemon processes. See 'man nice'.
        # export HBASE_NICENESS=10

        # The directory where pid files are stored. /tmp by default.
        export HBASE_PID_DIR={{pid_dir}}

        # Seconds to sleep between slave commands. Unset by default. This
        # can be useful in large clusters, where, e.g., slave rsyncs can
        # otherwise arrive faster than the master can service them.
        # export HBASE_SLAVE_SLEEP=0.1

        # Tell HBase whether it should manage it's own instance of Zookeeper or not.
        export HBASE_MANAGES_ZK=false

        export HBASE_OPTS="${HBASE_OPTS} -XX:ErrorFile={{log_dir}}/hs_err_pid%p.log -Djava.io.tmpdir={{java_io_tmpdir}}"
    {: .Example}

    </div>

    * If you're using version 2.2 or later of the Spark Shuffle service, set these HBase Master option values:

        <div class="preWrapperWide" markdown="1">
        export HBASE_MASTER_OPTS="${HBASE_MASTER_OPTS} -Xms{{master_heapsize}} -Xmx{{master_heapsize}} ${JDK_DEPENDED_OPTS} -XX:+HeapDumpOnOutOfMemoryError -XX:MaxDirectMemorySize=2g -XX:+AlwaysPreTouch -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=70 -XX:+CMSParallelRemarkEnabled -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=10101 -Dsplice.spark.enabled=true -Dsplice.spark.app.name=SpliceMachine -Dsplice.spark.master=yarn-client -Dsplice.spark.logConf=true -Dsplice.spark.yarn.maxAppAttempts=1 -Dsplice.spark.driver.maxResultSize=1g -Dsplice.spark.driver.cores=2 -Dsplice.spark.yarn.am.memory=1g -Dsplice.spark.dynamicAllocation.enabled=true -Dsplice.spark.dynamicAllocation.executorIdleTimeout=120 -Dsplice.spark.dynamicAllocation.cachedExecutorIdleTimeout=120 -Dsplice.spark.dynamicAllocation.minExecutors=0 -Dsplice.spark.dynamicAllocation.maxExecutors=12 -Dsplice.spark.io.compression.lz4.blockSize=32k -Dsplice.spark.kryo.referenceTracking=false -Dsplice.spark.kryo.registrator=com.splicemachine.derby.impl.SpliceSparkKryoRegistrator -Dsplice.spark.kryoserializer.buffer.max=512m -Dsplice.spark.kryoserializer.buffer=4m -Dsplice.spark.locality.wait=100 -Dsplice.spark.memory.fraction=0.5 -Dsplice.spark.scheduler.mode=FAIR -Dsplice.spark.serializer=org.apache.spark.serializer.KryoSerializer -Dsplice.spark.shuffle.compress=false -Dsplice.spark.shuffle.file.buffer=128k -Dsplice.spark.shuffle.service.enabled=true -Dsplice.spark.reducer.maxReqSizeShuffleToMem=134217728 -Dsplice.spark.yarn.am.extraLibraryPath=/usr/hdp/current/hadoop-client/lib/native -Dsplice.spark.yarn.am.waitTime=10s -Dsplice.spark.yarn.executor.memoryOverhead=2048 -Dsplice.spark.driver.extraJavaOptions=-Dlog4j.configuration=file:/etc/spark/conf/log4j.properties -Dsplice.spark.driver.extraLibraryPath=/usr/hdp/current/hadoop-client/lib/native -Dsplice.spark.driver.extraClassPath=/usr/hdp/current/hbase-regionserver/conf:/usr/hdp/current/hbase-regionserver/lib/htrace-core-3.1.0-incubating.jar -Dsplice.spark.executor.extraLibraryPath=/usr/hdp/current/hadoop-client/lib/native -Dsplice.spark.executor.extraClassPath=/usr/hdp/current/hbase-regionserver/conf:/usr/hdp/current/hbase-regionserver/lib/htrace-core-3.1.0-incubating.jar -Dsplice.spark.ui.retainedJobs=100 -Dsplice.spark.ui.retainedStages=100 -Dsplice.spark.worker.ui.retainedExecutors=100 -Dsplice.spark.worker.ui.retainedDrivers=100 -Dsplice.spark.streaming.ui.retainedBatches=100 -Dsplice.spark.executor.cores=4 -Dsplice.spark.executor.memory=8g -Dspark.compaction.reserved.slots=4 -Dsplice.spark.eventLog.enabled=true -Dsplice.spark.eventLog.dir=hdfs:///user/splice/history -Dsplice.spark.local.dir=/tmp -Dsplice.spark.yarn.jars=/opt/splice/default/lib/*"
        {: .Example}

        </div>

    * If you're using a version of the Spark Shuffle service earlier than 2.2, set these HBase Master option values instead:

        <div class="preWrapperWide" markdown="1">
        export HBASE_MASTER_OPTS="${HBASE_MASTER_OPTS} -Xms{{master_heapsize}} -Xmx{{master_heapsize}} ${JDK_DEPENDED_OPTS} -XX:+HeapDumpOnOutOfMemoryError -XX:MaxDirectMemorySize=2g -XX:+AlwaysPreTouch -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=70 -XX:+CMSParallelRemarkEnabled -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=10101 -Dsplice.spark.enabled=true -Dsplice.spark.app.name=SpliceMachine -Dsplice.spark.master=yarn-client -Dsplice.spark.logConf=true -Dsplice.spark.yarn.maxAppAttempts=1 -Dsplice.spark.driver.maxResultSize=1g -Dsplice.spark.driver.cores=2 -Dsplice.spark.yarn.am.memory=1g -Dsplice.spark.dynamicAllocation.enabled=true -Dsplice.spark.dynamicAllocation.executorIdleTimeout=120 -Dsplice.spark.dynamicAllocation.cachedExecutorIdleTimeout=120 -Dsplice.spark.dynamicAllocation.minExecutors=0 -Dsplice.spark.dynamicAllocation.maxExecutors=12 -Dsplice.spark.io.compression.lz4.blockSize=32k -Dsplice.spark.kryo.referenceTracking=false -Dsplice.spark.kryo.registrator=com.splicemachine.derby.impl.SpliceSparkKryoRegistrator -Dsplice.spark.kryoserializer.buffer.max=512m -Dsplice.spark.kryoserializer.buffer=4m -Dsplice.spark.locality.wait=100 -Dsplice.spark.memory.fraction=0.5 -Dsplice.spark.scheduler.mode=FAIR -Dsplice.spark.serializer=org.apache.spark.serializer.KryoSerializer -Dsplice.spark.shuffle.compress=false -Dsplice.spark.shuffle.file.buffer=128k -Dsplice.spark.shuffle.service.enabled=true -Dsplice.spark.yarn.am.extraLibraryPath=/usr/hdp/current/hadoop-client/lib/native -Dsplice.spark.yarn.am.waitTime=10s -Dsplice.spark.yarn.executor.memoryOverhead=2048 -Dsplice.spark.driver.extraJavaOptions=-Dlog4j.configuration=file:/etc/spark/conf/log4j.properties -Dsplice.spark.driver.extraLibraryPath=/usr/hdp/current/hadoop-client/lib/native -Dsplice.spark.driver.extraClassPath=/usr/hdp/current/hbase-regionserver/conf:/usr/hdp/current/hbase-regionserver/lib/htrace-core-3.1.0-incubating.jar -Dsplice.spark.executor.extraLibraryPath=/usr/hdp/current/hadoop-client/lib/native -Dsplice.spark.executor.extraClassPath=/usr/hdp/current/hbase-regionserver/conf:/usr/hdp/current/hbase-regionserver/lib/htrace-core-3.1.0-incubating.jar -Dsplice.spark.ui.retainedJobs=100 -Dsplice.spark.ui.retainedStages=100 -Dsplice.spark.worker.ui.retainedExecutors=100 -Dsplice.spark.worker.ui.retainedDrivers=100 -Dsplice.spark.streaming.ui.retainedBatches=100 -Dsplice.spark.executor.cores=4 -Dsplice.spark.executor.memory=8g -Dspark.compaction.reserved.slots=4 -Dsplice.spark.eventLog.enabled=true -Dsplice.spark.eventLog.dir=hdfs:///user/splice/history -Dsplice.spark.local.dir=/tmp -Dsplice.spark.yarn.jars=/opt/splice/default/lib/*"
        {: .Example}

        </div>

4.  Finish updating of `hbase-env template` with the following:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        export HBASE_REGIONSERVER_OPTS="${HBASE_REGIONSERVER_OPTS} -Xmn{{regionserver_xmn_size}} -Xms{{regionserver_heapsize}} -Xmx{{regionserver_heapsize}} ${JDK_DEPENDED_OPTS} -XX:+HeapDumpOnOutOfMemoryError -XX:MaxDirectMemorySize=2g -XX:+AlwaysPreTouch -XX:+UseG1GC -XX:MaxNewSize=4g -XX:InitiatingHeapOccupancyPercent=60 -XX:ParallelGCThreads=24 -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=5000 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=10102"
        # HBase off-heap MaxDirectMemorySize
        export HBASE_REGIONSERVER_OPTS="$HBASE_REGIONSERVER_OPTS {% if hbase_max_direct_memory_size %} -XX:MaxDirectMemorySize={{hbase_max_direct_memory_size}}m {% endif %}"
    {: .Example}

    </div>

5.  In `Custom hbase-site` property, add the following properties:
    {: .topLevel}
    
    <div class="preWrapperWide" markdown="1">
        dfs.client.read.shortcircuit.buffer.size=131072
        hbase.balancer.period=60000
        hbase.client.ipc.pool.size=10
        hbase.client.max.perregion.tasks=100
        hbase.coprocessor.regionserver.classes=com.splicemachine.hbase.RegionServerLifecycleObserver
        hbase.hstore.compaction.max.size=260046848
        hbase.hstore.compaction.min.size=16777216
        hbase.hstore.compaction.min=5
        hbase.hstore.defaultengine.compactionpolicy.class=com.splicemachine.compactions.SpliceDefaultCompactionPolicy
        hbase.hstore.defaultengine.compactor.class=com.splicemachine.compactions.SpliceDefaultCompactor
        hbase.htable.threads.max=96
        hbase.ipc.warn.response.size=-1
        hbase.ipc.warn.response.time=-1
        hbase.master.loadbalance.bytable=TRUE
        hbase.mvcc.impl=org.apache.hadoop.hbase.regionserver.SIMultiVersionConsistencyControl
        hbase.regions.slop=0.01
        hbase.regionserver.global.memstore.size.lower.limit=0.9
        hbase.regionserver.lease.period=1200000
        hbase.regionserver.maxlogs=48
        hbase.regionserver.thread.compaction.large=1
        hbase.regionserver.thread.compaction.small=4
        hbase.regionserver.wal.enablecompression=TRUE
        hbase.rowlock.wait.duration=0
        hbase.splitlog.manager.timeout=3000
        hbase.status.multicast.port=16100
        hbase.wal.disruptor.batch=TRUE
        hbase.wal.provider=multiwal
        hbase.wal.regiongrouping.numgroups=16
        hbase.zookeeper.property.tickTime=6000
        hfile.block.bloom.cacheonwrite=TRUE
        io.storefile.bloom.error.rate=0.005
        splice.authentication.native.algorithm=SHA-512
        splice.authentication=NATIVE
        splice.client.numConnections=1
        splice.client.write.maxDependentWrites=60000
        splice.client.write.maxIndependentWrites=60000
        splice.compression=snappy
        splice.marshal.kryoPoolSize=1100
        splice.olap_server.clientWaitTime=900000
        splice.ring.bufferSize=131072
        splice.splitBlockSize=67108864
        splice.timestamp_server.clientWaitTime=120000
        splice.txn.activeTxns.cacheSize=10240
        splice.txn.completedTxns.concurrency=128
        splice.txn.concurrencyLevel=4096
    {: .Example}

    </div>

6.  Save Changes
    {: .topLevel}

    Click the <span class="AppCommand">Save</span> button to save your
    changes. You'll be prompted to optionally add a note such as
    `Updated HDFS configuration for Splice Machine`. Click <span
    class="AppCommand">Save</span> again.
    {: .indentLevel1}

7.  Start HBase
    {: .topLevel}

    After you save your changes, you'll land back on the HBase Service
    <span class="AppCommand">Configs</span> tab in Ambari.
    {: .indentLevel1}

    Open the <span class="AppCommand">Service Actions</span> drop-down
    in the upper-right corner and select the <span
    class="AppCommand">Start</span> action to start HBase. Wait for the
    restart to complete.
    {: .indentLevel1}
{: .boldFont}

</div>
## Start any Additional Services   {#Start}

We started this installation by shutting down your cluster services, and
then configured and restarted each individual service used by Splice
Machine.

If you had any additional services running, such as Ambari Metrics, you
need to restart each of those services.

## Optional Configuration Modifications   {#Optional}

There are a few configuration modifications you might want to make:

* [Modify the Authentication Mechanism](#Modify) if you want to
  authenticate users with something other than the default *native
  authentication* mechanism.
* [Modify the Log Location](#Logging) if you want your Splice Machine
  log entries stored somewhere other than in the logs for your region
  servers.
* Adjust the replication factor if you have a small cluster and need to
  improve resource usage or performance.

### Modify the Authentication Mechanism   {#Modify}

Splice Machine installs with Native authentication configured; native
authentication uses the `sys.sysusers` table in the `splice` schema for
configuring user names and passwords.

You can disable authentication or change the authentication mechanism
that Splice Machine uses to LDAP by following the simple instructions in
[Configuring Splice Machine
Authentication](onprem_install_configureauth.html){: .WithinBook}

If you're using Kerberos, you need to add this option to your HBase Master Java Configuration Options:

<div class="preWrapper" markdown="1">
    -Dsplice.spark.hadoop.fs.hdfs.impl.disable.cache=true
{:.Example}

</div>

### Modify the Log Location   {#Logging}

Splice Machine logs all SQL statements by default, storing the log
entries in your region server's logs, as described in our [Using
Logging](developers_tuning_logging) topic. You can modify where Splice
Machine stores logs by adding the following snippet to your *RegionServer Logging
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
## Verify your Splice Machine Installation   {#Run}

Now start using the Splice Machine command line interpreter, which is
referred to as <span class="AppCommand">the splice prompt</span> or
simply <span class="AppCommand">splice&gt;</span> by launching the
`sqlshell.sh` script on any node in your cluster that is running an
HBase region server.

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
</section>



[1]: https://community.splicemachine.com/
