---
title: Splice Machine Requirements
summary: Summary of requirements for installing and running Splice Machine on your cluster or computer.
keywords: on-premise requirements, requirements, cores, memory, disk space, hadoop ecosystem, cluster, linux, centos, rhel 6, hadoop, hbase, zookeeper, java jdk, openjdk, macos, macintosh, ubuntu
toc: false
product: all
sidebar: home_sidebar
permalink: onprem_info_requirements.html
folder: OnPrem/Info
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice Machine Requirements

This topic summarizes the hardware and software requirements for Splice
Machine running on a cluster or on a standalone computer, in these sections:

* [Cluster Node Requirements](#ClusterReq) summarizes requirements for running Splice Machine on a cluster, including these subsections:
  * [Amazon Web Services (AWS) Requirements](#AWSReq)
  * [Hadoop Ecosystem Requirements](#HadoopReq)
  * [Linux Configuration Requirements](#LinuxReq)
* [Standalone Version Prerequisites](#Standalo) summarizes requirements for running the standalone version of Splice Machine.
* [Java JDK Requirements](#JavaReq) summarizes which Java JDK requirements for running Splice Machine.

{% include splice_snippets/onpremonlytopic.md %}

{% include splicevars.html %}
<div markdown="1">
## Cluster Node Requirements {#ClusterReq}

The following table summarizes the minimum hardware requirements for the nodes in
your cluster for Splice Machine __Release {{site.version_display}}__:

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
            <td>The <span class="ItalicFont"><a href="#LinuxReq">Linux Configuration</a></span> section below summarizes the software tools and system settings required for your cluster machines.</td>
        </tr>
    </tbody>
</table>

### Amazon Web Services (AWS) Requirements {#AWSReq}

If you're running Splice Machine __Release {{site.version_display}}__ on AWS, your cluster must meet these minimum
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

### Hadoop Ecosystem Requirements {#HadoopReq}

The following table summarizes the required Hadoop ecosystem components
for Splice Machine __Release {{site.build_version}}__ on your platform:

<table summary="Splice Machine Hadoop ecosystem requirements">
    <col />
    <col width="135px" />
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Hadoop platform</th>
            <th>Linux</th>
            <th>Hadoop</th>
            <th>HBase</th>
            <th>ZooKeeper</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>{{splvar_requirements_CDH-Versions}}</td>
            <td>
                <p class="noSpaceAbove">{{splvar_requirements_CDH-OS}}
                </p>
            </td>
            <td>{{splvar_requirements_CDH-Hadoop}}</td>
            <td>{{splvar_requirements_CDH-HBase}}</td>
            <td>{{splvar_requirements_CDH-ZooKeeper}}</td>
        </tr>
        <tr>
            <td>{{splvar_requirements_HDP-Versions}}</td>
            <td>
                <p class="noSpaceAbove">{{splvar_requirements_HDP-OS}}
                </p>
            </td>
            <td>{{splvar_requirements_HDP-Hadoop}}</td>
            <td>{{splvar_requirements_HDP-HBase}}</td>
            <td>{{splvar_requirements_HDP-ZooKeeper}}</td>
        </tr>
        <tr>
            <td>{{splvar_requirements_MapR-Versions}}
            </td>
            <td>
                <p class="noSpaceAbove">{{splvar_requirements_MapR-OS}}
                </p>
            </td>
            <td>{{splvar_requirements_MapR-Hadoop}}</td>
            <td>{{splvar_requirements_MapR-HBase}}</td>
            <td>{{splvar_requirements_MapR-ZooKeeper}}</td>
        </tr>
    </tbody>
</table>

## Linux Configuration Requirements {#LinuxReq}
The following table summarizes Linux configuration requirements for
running Splice Machine __Release {{site.version_display}}__ on your cluster:

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
                </li>
                    <li class="CodeFont" value="3">nscd</li>
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
                <p class="noSpaceAbove">If you're running on CENTOS or RHEL, you also need to have this software available on each node:</p>
                <ul>
                    <li class="CodeFont" value="1">ftp</li>
                    <li class="CodeFont" value="2">EPEL <span class="bodyFont">repository</span></li>
                </ul>
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

## Standalone Version Prerequisites   {#Standalo}

You can use the standalone version of Splice Machine __Release {{site.version_display}}__ on MacOS and Linux
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

## Java JDK Requirements {#JavaReq}

Splice Machine for Splice Machine version __Release {{site.version_display}}__ supports the following versions of the Java JDK:

* Oracle JDK 1.8, update 60 or higher

  We recommend that you do not use JDK 1.8.0_40
  {: .noteNote}

Splice Machine does not test our releases with OpenJDK, so we recommend
against using it.

</div>
</section>
