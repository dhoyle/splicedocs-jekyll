---
summary: How to download, install, configure and verify your installation of Splice Machine on MapR.
title: Installing and Configuring Splice Machine for MapR
keywords: MapR, installation, warden, mapr warden, hadoop, hbase, hdfs sqlshell.sh, sqlshell, download splice
toc: false
product: onprem
sidebar:  onprem_sidebar
permalink: onprem_install_mapr.html
folder: OnPrem/InstallingSpliceMachine
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% include splicevars.html %} 
# Installing and Configuring Splice Machine for MapR

{% include splice_snippets/onpremonlytopic.html %}
<div markdown="1">
This topic describes installing and configuring Splice Machine on a
MapR-managed cluster. Follow these steps:

1.  [Verify Prerequisites](#Verify)
2.  [Download and Install Splice Machine](#Install)
3.  [Configure Cluster Services](#Configur)
4.  [Stop Cluster Services](#Stop)
5.  [Restart Cluster Services](#StartCluster)
6.  [Create the Splice Machine Event Log Directory](#CreateLogDir)
7.  Make any needed [Optional Configuration Modifications](#Optional)
8.  [Verify your Splice Machine Installation](#Run)

<div class="openSourceNote" markdown="1">
<span class="noteEnterpriseNote">MapR Secure Clusters Only Work with the
Enterprise Edition of Splice Machine</span>

MapR secure clusters do not support the Community Edition of Splice
Machine. You can check this by:

1.  Open the HBase Configuration page
2.  Search the XML for the `hbase.security.authentication` setting
3.  If the setting value is anything other than `simple`, you need the
    *Enterprise* edition of Splice Machine.

To read more about the additional features available in the Enterprise
Edition, see our [Splice Machine Editions](notes_editions.html) page. To
obtain a license for the Splice Machine *Enterprise Edition*, <span
class="noteEnterpriseNote">please [Contact Splice Machine Sales][1]{:
target="_blank"} today.</span>

</div>
## Verify Prerequisites   {#Verify}

Before starting your Splice Machine installation, please make sure that
your cluster contains the prerequisite software components:

* A cluster running MapR with MapR-FS
* HBase installed
* YARN installed
* ZooKeeper installed
* The latest `mapr-patch` should be installed to bring in all
  MapR-supplied platform patches, before proceeding with your Splice
  Machine installation.
* The MapR Ecosystem Package (MEP) should be installed on all cluster
  nodes, before proceeding with your Splice Machine installation.
* Ensure Spark services are **NOT** installed; Splice Machine cannot
  currently coexist with Spark 1.x on a cluster:
  * If `MEP version 1.x` is in use, you must remove the `Spark 1.x`
    packages from your cluster, as described below, in [Removing Spark
    Packages from Your Cluster.](#Removing)
  * MEP version 2.0 bundles Spark 2.0, and will not cause conflicts with
    Splice Machine.
  {: .bullet}

The specific versions of these components that you need depend on your
operating environment, and are called out in detail in the
[Requirements](onprem_info_requirements.html) topic of our *Getting
Started Guide*.
{: .noteNote}

### Removing Spark Packages from Your Cluster   {#Removing}

To remove Spark packages from your cluster and update your
configuration, follow these steps

<div class="opsStepsList" markdown="1">
1.  If you're running a Debian/Ubuntu-based Linux distribution:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        dpkg -l | awk '/ii.*mapr-spark/{print $2}' | xargs sudo apt-get purge
    {: .ShellCommand}

    </div>

    If you're running on a RHEL/CentOS-based Linux distribution:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        rpm -qa \*mapr-spark\* | xargs sudo yum -y erase
    {: .ShellCommand}

    </div>

2.  Reconfigure node services in your cluster:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        sudo /opt/mapr/server/configure.sh -R
    {: .ShellCommand}

    </div>
{: .boldFont}

</div>
## Download and Install Splice Machine   {#Install}

Perform the following steps <span class="important">on each node</span>
in your cluster:

<div class="opsStepsList" markdown="1">
1.  Download the installer for your version.
    Which Splice Machine installer (gzip) package you need depends upon
    which Splice Machine version you're installing and which version of
    MapR you are using. Here are the URLs for Splice Machine Release
    {{splvar_basic_SpliceReleaseVersion}} and
    {{splvar_basic_SplicePrevReleaseVersion}}:
    {: .indentLevel1}

    <table>
                                    <col />
                                    <col />
                                    <col />
                                    <thead>
                                        <tr>
                                            <th>Splice Machine Release</th>
                                            <th>MapR Version</th>
                                            <th>Installer Package Link</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                       <tr>
                                           <td class="SpliceRelease">2.6.1</td>
                                           <td class="SplicePlatform">{{splvar_install_MAPR520}}</td>
                                           <td><a href="{{splvar_install_v261_MAPR520}}">{{splvar_install_v261_MAPR520}}</a></td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" class="Separator"> </td>
                                        </tr>
                                       <tr>
                                           <td class="SpliceRelease">2.5.0</td>
                                           <td class="SplicePlatform">{{splvar_install_MAPR520}}</td>
                                           <td><a href="{{splvar_install_v250_MAPR520}}">{{splvar_install_v250_MAPR520}}</a></td>
                                        </tr>
                                    </tbody>
                                </table>

    To be sure that you have the latest URL, please check [the Splice
    Machine Community site][2]{: target="_blank"} or contact your Splice
    Machine representative.
    {: .noteIcon}

2.  Create the `splice` installation directory:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        mkdir -p /opt/splice
    {: .ShellCommand}

    </div>

3.  Download the Splice Machine package into the `splice` directory on
    the node. For example:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        cd /opt/splicecurl -O '{{splvar_install_AWSS3Bucket}}/{{splvar_install_CurrentRelease}}/{{splvar_install_AWSInstallerPart}}/{{splvar_install_MAPR-R2}}/SPLICEMACHINE-{{splvar_install_CurrentRelease}}.{{splvar_install_MAPR-R2}}.{{splvar_install_SpliceReleaseGZ}}'
    {: .ShellCommand}

    </div>

4.  Extract the Splice Machine package:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        tar -xf SPLICEMACHINE-{{splvar_install_CurrentRelease}}.{{splvar_install_MAPR-R2}}.{{splvar_install_SpliceReleaseGZ}}
    {: .ShellCommand}

    </div>

5.  Create a symbolic link. For example:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        ln -sf SPLICEMACHINE-{{splvar_install_CurrentRelease}}.{{splvar_install_MAPR-R2}}.{{splvar_install_SpliceReleasePart}} default
    {: .ShellCommand}

    </div>

6.  Run our script as *root* user <span class="important">on each
    node</span> in your cluster to add symbolic links to the set up the
    Splice Machine jar and to script symbolic links:
    {: .topLevel}

    Issue this command on each node in your cluster:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        sudo bash /opt/splice/default/scripts/install-splice-symlinks.sh
    {: .ShellCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>
## Configure Cluster Services   {#Configur}

The scripts used in this section all assume that password-less <span
class="ShellCommand">ssh </span>and password-less <span
class="ShellCommand">sudo </span>are enabled across all cluster nodes.
These scripts are designed to be run on the CLDB node in a cluster with
only one CLDB node. If your cluster has multiple CLDB nodes, do not run
these script; you need to change configuration settings manually <span
class="important">on each node</span> in the cluster. To do so, refer to
the `*.patch` files in the `/opt/splice/default/conf` directory.

If you're running on a cluster with a single CLDB node, follow these
steps:

<div class="opsStepsList" markdown="1">
1.  Tighten the ephemeral port range so HBase doesn't bump into it:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        cd /opt/splice/default/scripts
        ./install-sysctl-conf.sh
    {: .ShellCommand}

    </div>

2.  Update `hbase-site.xml`:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        cd /opt/splice/default/scripts
        ./install-hbase-site-xml.sh
    {: .ShellCommand}

    </div>

3.  Update `hbase-env.sh`:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        cd /opt/splice/default/scripts
        ./install-hbase-env-sh.sh
    {: .ShellCommand}

    </div>

4.  Update `yarn-site.xml`:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        cd /opt/splice/default/scripts
        ./install-yarn-site-xml.sh
    {: .ShellCommand}

    </div>

5.  Update `warden.conf`:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        cd /opt/splice/default/scripts
        ./install-warden-conf.sh
    {: .ShellCommand}

    </div>

6.  Update `zoo.cfg`:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        cd /opt/splice/default/scripts
        ./install-zookeeper-conf.sh
    {: .ShellCommand}

    </div>
{: .boldFont}

</div>
## Stop Cluster Services   {#Stop}

You need to stop all cluster services to continue with installing Splice
Machine. Run the following commands as `root` user <span
class="important">on each node</span> in your cluster

<div class="preWrapperWide" markdown="1">
    sudo service mapr-warden stopsudo service mapr-zookeeper stop
{: .ShellCommand}

</div>
## Restart Cluster Services   {#StartCluster}

Once you've completed the configuration steps described above, start
services on your cluster; run the following commands <span
class="important">on each node</span> in your cluster:

<div class="preWrapper" markdown="1">
    sudo service mapr-zookeeper startsudo service mapr-warden start
{: .ShellCommand}

</div>
## Create the Splice Machine Event Log Directory   {#CreateLogDir}

Create the Splice Machine event log directory by executing the following
commands on a single cluster node while MapR is up and running:

<div class="preWrapper" markdown="1">
    sudo -su mapr hadoop fs -mkdir -p /user/splice/historysudo -su mapr hadoop fs -chown -R mapr:mapr /user/splicesudo -su mapr hadoop fs -chmod 1777 /user/splice/history
{: .ShellCommand}

</div>
## Optional Configuration Modifications   {#Optional}

There are a few configuration modifications you might want to make:

* [Modify the Authentication Mechanism](#Modify) if you want to
  authenticate users with something other than the default *native
  authentication* mechanism.
* [Adjust the Replication Factor](#Adjust) if you have a small cluster
  and need to improve resource usage or performance.

### Modify the Authentication Mechanism   {#Modify}

Splice Machine installs with Native authentication configured; native
authentication uses the `sys.sysusers` table in the `splice` schema for
configuring user names and passwords.

You can disable authentication or change the authentication mechanism
that Splice Machine uses to LDAP by following the simple instructions in
[Command Line (splice&gt;) Reference](cmdlineref_intro.html){:
.WithinBook}

### Adjust the Replication Factor   {#Adjust}

The default namespace replication factor for Splice Machine is <span
class="PlatformVariablesMapRDefaultReplication">3</span>. If you're
running a small cluster you may want to adjust the replication down to
improve resource and performance drag. To do so in MapR, use the
following command:

    maprcli volume modify -nsreplication <value>
{: .ShellCommand}

For more information, see the MapR documentation site,
[doc.mapr.com][3]{: target="_blank"}.

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



[1]: http://www.splicemachine.com/company/contact-us/
[2]: https://community.splicemachine.com/
[3]: http://doc.mapr.com/ "MapR documentation site"
