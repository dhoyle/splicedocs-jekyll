---
summary: Installing Splice Machine
title: Splice Machine Installation Guide
keywords: installation, hadoop, hbase, hdfs
toc: false
product: onprem
sidebar: home_sidebar
permalink: onprem_install_links.html
folder: OnPrem/InstallingSpliceMachine
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice Machine v3.0 Installer Links

The tables below link to both the downloadable installer and installation instructions for the each supported, platform-specific version of Splice Machine 3.0:

* [Splice Machine Installation Links for Cloudera CDH](#CDH)
* [Splice Machine Installation Links for Hortonworks HDP](#HDP)
* [Splice Machine Standalone Version Installation Links](#standalone)

We recommend that you review the [installation requirements for Splice Machine](onprem_info_requirements.html) before proceeding.

{% include splice_snippets/onpremonlytopic.md %}

## Splice Machine Installation Links for Cloudera CDH {#CDH}

<table summary="Links for Installing on Cloudera">
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>CDH Version</th>
            <th>Copy this URL (New Remote Parcel Repository - see Install Instructions)</th>
            <th>Install Instructions URL</th>
        </tr>
    </thead>
    <tbody>
        <tr>
			<td>CDH 6.3.0</td>
			<td>
			    https://splice-releases.s3.amazonaws.com/3.1.0.2002/cluster/parcel/cdh6.3.0/
            </td>
			<td><a href="https://github.com/splicemachine/spliceengine/blob/branch-3.1/platforms/cdh6.3.0/docs/CDH-installation.md">Installation instructions for CDH 6.3.0</a>
            </td>
        </tr>
    </tbody>
</table>

## Splice Machine Installation Links for Hortonworks HDP  {#HDP}

<table summary="Links for Installing on Hortonworks HDP">
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>HDP Version</th>
            <th>Installer URL</th>
            <th>Install Instructions URL</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>HDP 3.1.5 (rpm)</td>
            <td>
                <p><a href="https://splice-releases.s3.amazonaws.com/3.1.0.2002/cluster/installer/hdp3.1.5/splicemachine-hdp3.1.5.3.1.0.2002.p0.52-1.noarch.rpm">HDP 3.1.5 Installer</a></p>
                <p><a href="https://splice-releases.s3.amazonaws.com/3.1.0.2002/cluster/installer/hdp3.1.5/splicemachine_ambari_service-hdp3.1.5.3.1.0.2002.p0.52-1.noarch.rpm">HDP 3.1.5 - Ambari Installer</a></p>
            </td>
            <td><a href="https://github.com/splicemachine/spliceengine/blob/branch-3.1/platforms/hdp3.1.0/docs/HDP-installation.md">Installation instructions for HDP</a>
            </td>
        </tr>
    </tbody>
</table>

<!--
## Splice Machine Standalone Installation Links  {#standalone}

<table summary="Links for Installing the Standalone Version of Splice Machine">
    <col />
    <col />
    <thead>
        <tr>
            <th>Splice Machine Version</th>
            <th>Installer Download URL</th>
            <th>Install Instructions Link</th>
        </tr>
    </thead>
    <tbody>
        <tr>
			<td>Version 3.0</td>
			<td><a href="https://splice-releases.s3.amazonaws.com/standalone/SPLICEMACHINE-3.0.0.1958.standalone.tar.gz">Standalone Version 3.0</a>
            </td>
			<td><a href="https://github.com/splicemachine/spliceengine/blob/branch-3.0/platforms/std/docs/STD-installation.md">Installation instructions for the Standalone Version 3.0</a>
            </td>
        </tr>
     </tbody>
</table>
-->

{% include splice_snippets/githublink.html %}
</div>
</section>
