---
title: Splice Machine Requirements
summary: Summary of requirements for installing and running Splice Machine on your cluster or computer.
keywords: on-premise requirements, requirements, cores, memory, disk space, hadoop ecosystem, cluster, linux, centos, rhel 6, hadoop, hbase, zookeeper, java jdk, openjdk, macos, macintosh, ubuntu
toc: false
product: all
sidebar:  onprem_sidebar
permalink: onprem_info_requirements.html
folder: OnPrem/Info
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice Machine Requirements

{% include splice_snippets/onpremonlytopic.md %}
This topic summarizes the hardware and software requirements for Splice
Machine running on a cluster or on a standalone computer.

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
            <th>Hadoop platform</th>
            <th>Linux</th>
            <th>Hadoop</th>
            <th>HBase</th>
            <th>ZooKeeper</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>{{splvar_requirements_CDH-Versions}}
            </td>
            <td>
                <p class="noSpaceAbove">{{splvar_requirements_CDH-OS}}
                </p>
            </td>
            <td>{{splvar_requirements_CDH-Hadoop}}
            </td>
            <td>{{splvar_requirements_CDH-HBase}}
            </td>
            <td>{{splvar_requirements_CDH-ZooKeeper}}
            </td>
        </tr>
        <tr>
            <td>{{splvar_requirements_HDP-Versions}}
            </td>
            <td>
                <p class="noSpaceAbove">{{splvar_requirements_HDP-OS}}
                </p>
            </td>
            <td>{{splvar_requirements_HDP-Hadoop}}
            </td>
            <td>{{splvar_requirements_HDP-HBase}}
            </td>
            <td>{{splvar_requirements_HDP-ZooKeeper}}
            </td>
        </tr>
        <tr>
            <td>{{splvar_requirements_MapR-Versions}}
            </td>
            <td>
                <p class="noSpaceAbove">{{splvar_requirements_MapR-OS}}
                </p>
            </td>
            <td>{{splvar_requirements_MapR-Hadoop}}
            </td>
            <td>{{splvar_requirements_MapR-HBase}}
            </td>
            <td>{{splvar_requirements_MapR-ZooKeeper}}
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

You can also run our standalone version on a virtual machine, using Virtual Box. See our [Standalone Installation](onprem_install_standalone.html) page for details.

</div>
</section>
