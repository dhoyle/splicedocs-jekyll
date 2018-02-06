---
summary: Walks you through installing Splice Machine on your cluster, or on computer if you're using the standalone version.
title: Splice Machine Installation Guide
keywords: installation, hadoop, hbase, hdfs
toc: false
product: onprem
sidebar:  onprem_sidebar
permalink: onprem_install_intro.html
folder: OnPrem/InstallingSpliceMachine
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice Machine Installation Guide

{% include splice_snippets/onpremonlytopic.md %}
This *Installation Guide* walks you through installing Splice Machine on
your cluster, or on computer if you're using the standalone version.

The fastest way to get started with Splice Machine is to set up our
sandbox on the Amazon Web Services (AWS) platform on EC2 instances using
`cloud.splicemachine.com`:

See the [Installing Splice Machine on Amazon Web
Services](onprem_install_awssandbox.html) topic for
step-by-step instructions for setting up the Splice Machine sandbox.
{: .noteIcon}

If you want to download and install Splice Machine on your cluster or
standalone computer, please read the remainder of this page, which
includes these sections:

* The Cluster Node Requirements section below details the hardware and
  ecosystem requirements for installing Splice Machine on a cluster or
  on a standalone computer.
* The [Configure Linux for Splice Machine](#Configur) section specifies
  the Linux software that Splice Machine requires.
* The [Install Splice Machine](#Install) links to the platform-specific
  installation and upgrade pages for each version of Splice Machine.

## Installing the Splice Machine Sandbox on AWS

The fastest way to get started with Splice Machine is to set up our
sandbox on the Amazon Web Services (AWS) platform on EC2 instances using
`cloud.splicemachine.com`.

See the [Installing Splice Machine on Amazon Web
Services](onprem_install_awssandbox.html) topic for
step-by-step instructions.
{: .noteIcon}

{% include splicevars.html %}
<div markdown="1">
## <a name="ClusterNodeRequirements" />Cluster Node Requirements

The following table summarizes the minimum requirements for the nodes in
your cluster:

<table summary="Splice Machine cluster node hardware requirements">
                    <col />
                    <col />
                    <thead>
                        <tr>
                            <th>Component</th>
                            <th>Requirements</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="BoldFont">Cores</td>
                            <td>Splice Machine recommends that each node in your cluster have 8-12 hyper-threaded cores (16-32 hyper-threads) for optimum throughput and concurrency.</td>
                        </tr>
                        <tr>
                            <td class="BoldFont">Memory</td>
                            <td>We recommend that each machine in your cluster have at least 64 GB of available memory.</td>
                        </tr>
                        <tr>
                            <td class="BoldFont">Disk Space</td>
                            <td>
                                <p class="noSpaceAbove">Your root drive needs to have at least 100 GB of free space. </p>
                                <p>Splice Machine recommends separate data drives on each cluster node to maintain a separation between the operating system and your database data. You need capacity for a minimum of three times the size of the data you intend to load; the typical recommended configuration is 2 TB or more of attached storage per node.</p>
                                <p><span class="BoldFont">Your data disks should be set up with a single partition and formatted with an <span class="CodeFont">ext4</span> file system.</span>
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td class="BoldFont">Hadoop Ecosystem</td>
                            <td>The table in the next section, Hadoop Ecosystem Requirements, summarizes the specific Hadoop component versions that we support in each of our product releases.</td>
                        </tr>
                        <tr>
                            <td class="BoldFont">Software Tools and System Settings</td>
                            <td>The <span class="ItalicFont">Linux Configuration</span> topic in each section of our <span class="ItalicFont">Installation Guide</span> that pertains to your installation summarizes the software tools and system settings required for your cluster machines.</td>
                        </tr>
                    </tbody>
                </table>
### Amazon Web Services (AWS) Requirements

If you're running on AWS, your cluster must meet these minimum
requirements:

<table summary="Splice Machine cluster node hardware requirements">
                    <col />
                    <col />
                    <thead>
                        <tr>
                            <th>Component</th>
                            <th>Requirements</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="BoldFont">Minimum Cluster Size</td>
                            <td>
                                <p>The minimum cluster size on AWS is <span class="ItalicFont">5 nodes</span>:</p>
                                <ul class="bullet">
                                    <li>1 master node</li>
                                    <li>4 worker nodes</li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td class="BoldFont">Minimum Node Size</td>
                            <td>Minimum recommended size of each node is <span class="ItalicFont">m4.4xlarge</span>.</td>
                        </tr>
                        <tr>
                            <td class="BoldFont">Disk Space</td>
                            <td>
                                <p class="noSpaceAbove">Minimum recommended storage space:</p>
                                <ul class="bullet">
                                    <li><span class="ItalicFont">100GB</span> EBS root drive</li>
                                    <li>4 EBS data drives per node</li>
                                </ul>
                                <p>Note that the required number of data drives per node depends on your use case.</p>
                            </td>
                        </tr>
                    </tbody>
                </table>
### Hadoop Ecosystem Requirements

The following table summarizes the required Hadoop ecosystem components
for your platform:

<table summary="Splice Machine Hadoop ecosystem requirements">
                    <col />
                    <col />
                    <col />
                    <col />
                    <col />
                    <col />
                    <thead>
                        <tr>
                            <th>Splice Machine </th>
                            <th>Hadoop platform</th>
                            <th>Linux</th>
                            <th>Hadoop</th>
                            <th>HBase</th>
                            <th>ZooKeeper</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td rowspan="3"><span class="BoldFont">Release 2.7.0</span>
                            </td>
                            <td>{{splvar_platform_v27_CDH5-Versions}}
                            </td>
                            <td>
                                <p class="noSpaceAbove">{{splvar_platform_v27_CDH5-OS}}
                                </p>
                            </td>
                            <td>{{splvar_platform_v27_CDH5-Hadoop}}
                            </td>
                            <td>{{splvar_platform_v27_CDH5-HBase}}
                            </td>
                            <td>{{splvar_platform_v27_CDH5-Zookeeper}}
                            </td>
                        </tr>
                        <tr>
                            <td>{{splvar_platform_v27_HDP2-Versions}}
                            </td>
                            <td>
                                <p class="noSpaceAbove">{{splvar_platform_v27_HDP2-OS}}
                                </p>
                            </td>
                            <td>{{splvar_platform_v27_HDP2-Hadoop}}
                            </td>
                            <td>{{splvar_platform_v27_HDP2-HBase}}
                            </td>
                            <td>{{splvar_platform_v27_HDP2-Zookeeper}}
                            </td>
                        </tr>
                        <tr>
                            <td>{{splvar_platform_v27_MapR5-Versions}}
                            </td>
                            <td>
                                <p class="noSpaceAbove">{{splvar_platform_v27_MapR5-OS}}
                                </p>
                            </td>
                            <td>{{splvar_platform_v27_MapR5-Hadoop}}
                            </td>
                            <td>{{splvar_platform_v27_MapR5-HBase}}
                            </td>
                            <td>{{splvar_platform_v27_MapR5-Zookeeper}}
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" class="Separator"> </td>
                        </tr>

                        <tr>
                            <td rowspan="3"><span class="BoldFont">Release 2.5</span>
                            </td>
                            <td>{{splvar_platform_v25_CDH5-Versions}}
                            </td>
                            <td>
                                <p class="noSpaceAbove">{{splvar_platform_v25_CDH5-OS}}
                                </p>
                            </td>
                            <td>{{splvar_platform_v25_CDH5-Hadoop}}
                            </td>
                            <td>{{splvar_platform_v25_CDH5-HBase}}
                            </td>
                            <td>{{splvar_platform_v25_CDH5-Zookeeper}}
                            </td>
                        </tr>
                        <tr>
                            <td>{{splvar_platform_v25_HDP2-Versions}}
                            </td>
                            <td>
                                <p class="noSpaceAbove">{{splvar_platform_v25_HDP2-OS}}
                                </p>
                            </td>
                            <td>{{splvar_platform_v25_HDP2-Hadoop}}
                            </td>
                            <td>{{splvar_platform_v25_HDP2-HBase}}
                            </td>
                            <td>{{splvar_platform_v25_HDP2-Zookeeper}}
                            </td>
                        </tr>
                        <tr>
                            <td>{{splvar_platform_v25_MapR5-Versions}}
                            </td>
                            <td>
                                <p class="noSpaceAbove">{{splvar_platform_v25_MapR5-OS}}
                                </p>
                            </td>
                            <td>{{splvar_platform_v25_MapR5-Hadoop}}
                            </td>
                            <td>{{splvar_platform_v25_MapR5-HBase}}
                            </td>
                            <td>{{splvar_platform_v25_MapR5-Zookeeper}}
                            </td>
                        </tr>
                    </tbody>
                </table>
### Java JDK Requirements

Splice Machine supports the following versions of the Java JDK:

* Oracle JDK 1.8, update 60 or higher

  We recommend that you do not use JDK 1.8.0_40
  {: .noteNote}

Splice Machine does not test our releases with OpenJDK, so we recommend
against using it.

## Standalone Version Prerequisites   {#Standalo}

You can use the standalone version of Splice Machine on MacOS and Linux
computers that meet these basic requirements:

<table summary="Standalone version requirements for running Splice Machine">
                    <col />
                    <col />
                    <thead>
                        <tr>
                            <th>Component</th>
                            <th>Requirements</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><span class="BoldFont">Operating System</span>
                            </td>
                            <td>
                                <p class="noSpaceAbove">Mac OS X, version 10.8 or later.</p>
                                <p>CentOS 6.4 or equivalent.</p>
                            </td>
                        </tr>
                        <tr>
                            <td><span class="BoldFont">CPU</span>
                            </td>
                            <td>Splice Machine recommends 2 or more multiple-core CPUs.</td>
                        </tr>
                        <tr>
                            <td><span class="BoldFont">Memory</span>
                            </td>
                            <td>At least 16 GB RAM, of which at least 10 GB is available.</td>
                        </tr>
                        <tr>
                            <td><span class="BoldFont">Disk Space</span>
                            </td>
                            <td>At least 100 GB of disk space available for Splice Machine software, plus as much space as will be required for your data; for example, if you have a 1 TB dataset, you need at least 1 TB of available data space.</td>
                        </tr>
                        <tr>
                            <td><span class="BoldFont">Software</span>
                            </td>
                            <td>
                                <p class="noSpaceAbove">You must have JDK installed on your computer.</p>
                            </td>
                        </tr>
                    </tbody>
                </table>
</div>

## Configure Linux for Splice Machine   {#Configur}

<div markdown="1">
The following table summarizes Linux configuration requirements for
running Splice Machine on your cluster:

<table summary="Summary of Linux configuration requirements">
                    <col />
                    <col />
                    <thead>
                        <tr>
                            <th>Configuration Step</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Configure SSH access:</td>
                            <td>Configure the user account that you're using for cluster administration for password-free access, to simplify installation.</td>
                        </tr>
                        <tr>
                            <td>Configure swappiness:</td>
                            <td>
                                <div class="preWrapperWide"><pre class="ShellCommandCell" xml:space="preserve">echo 'vm.swappiness = 0' &gt;&gt; /etc/sysctl.conf</pre>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>If you are using Ubuntu:</td>
                            <td>
                                <div class="preWrapperWide"><pre class="ShellCommandCell" xml:space="preserve">
rm /bin/sh ; ln -sf /bin/bash /bin/sh</pre>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>If your using CentOS or RHEL:</td>
                            <td>
                                <div class="preWrapperWide"><pre class="ShellCommandCell" xml:space="preserve">
sed -i '/requiretty/ s/^/#/' /etc/sudoers</pre>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Required software:</td>
                            <td>
                                <p class="noSpaceAbove">Verify that the following set of software (or packages) is available on each node in your cluster:</p>
                                <ul>
                                    <li class="CodeFont" value="1">curl</li>
									<li class="CodeFont">
                                    <p>Oracle JDK 1.8, update 60 or higher. We recommend against using JDK 1.8.0_40 or OpenJDK.</p>
                                    <p class="noteNote">Your platform management software may re-install JDK during its own installation process.</p>
                                </li>                                    <li class="CodeFont" value="3">nscd</li>
                                    <li class="CodeFont" value="4">ntp</li>
                                    <li class="CodeFont" value="5">openssh, openssh-clients<span class="bodyFont">, and</span> openssh-server</li>
                                    <li class="CodeFont" value="6">patch</li>
                                    <li class="CodeFont" value="7">rlwrap</li>
                                    <li class="CodeFont" value="8">wget</li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td>Additional required software on CentOS or RHEL</td>
                            <td>
                                <div class="preWrapperWide">
                                    <p class="noSpaceAbove">If you're running on CENTOS or RHEL, you also need to have this software available on each node:</p>
                                    <ul>
                                        <li class="CodeFont" value="1">ftp</li>
                                        <li class="CodeFont" value="2">EPEL <span class="bodyFont">repository</span></li>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Services that must be started</td>
                            <td>
                                <p class="noSpaceAbove">You need to make sure that the following services are enabled and started:</p>
                                <ul>
                                    <li><code>nscd</code>
                                    </li>
                                    <li><code>ntpd</code> (<code>ntp</code> package)</li>
                                    <li><code>sshd</code> (<code>openssh</code>-server package)</li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td>Time zone setting</td>
                            <td><span class="Highlighted">Make sure all nodes in your cluster are set to the same time zone.</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
</div>
## Install Splice Machine   {#Install}

If you've decided to try our sandbox, see the [Installing Splice Machine
on Amazon Web Services](onprem_install_awssandbox.html) topic for step-by-step instructions for setting up the Splice Machine
sandbox.     

To install Splice Machine on your cluster or standalone computer, click
the link below to see the instructions for your platform; each page
walks you through downloading and installing and configuring a specific
version of Splice Machine:

<table summary="Links to instructions for installing Splice Machine on each platform.">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Hadoop Platform</th>
                        <th>Installation Guide </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Cloudera-managed cluster</td>
                        <td><a href="onprem_install_cloudera.html">Installing and Configuring Splice Machine for Cloudera Manager</a>
                        </td>
                    </tr>
                    <tr>
                        <td>Hortonworks-managed cluster</td>
                        <td><a href="onprem_install_hortonworks.html">Installing and Configuring Splice Machine for Hortonworks HDP</a>
                        </td>
                    </tr>
                    <tr>
                        <td>MapR-managed cluster</td>
                        <td><a href="onprem_install_mapr.html">Installing and Configuring Splice Machine for MapR</a>
                        </td>
                    </tr>
                    <tr>
                        <td>Standalone version of Splice Machine</td>
                        <td><a href="onprem_install_standalone.html">Installing the Standalone Version of Splice Machine</a>
                        </td>
                    </tr>
                </tbody>
            </table>
{% include splice_snippets/githublink.html %}
</div>
</section>
