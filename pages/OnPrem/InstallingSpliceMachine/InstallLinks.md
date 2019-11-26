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
# Splice Machine v2.8 Installer Links

The tables below link to both the downloadable installer and installation instructions for the each supported, platform-specific version of Splice Machine 2.8.

We recommend that you review the [installation requirements for Splice Machine](onprem_info_requirements.html) before proceeding.

{% include splice_snippets/onpremonlytopic.md %}

## Splice Machine Installation Links for Cloudera CDH

<table summary="Links for Installing on Cloudera">
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>CDH Version</th>
            <th>Installer URL</th>
            <th>Install Instructions URL</th>
        </tr>
    </thead>
    <tbody>
        <tr>
			<td>CDH 5.16.1</td>
			<td><a href="https://s3.amazonaws.com/splice-releases/2.8.0.1929/cluster/parcel/cdh5.16.1/">CDH 5.16.1 Installer</a>
            </td>
			<td><a href="https://github.com/splicemachine/spliceengine/blob/branch-2.8/platforms/cdh5.16.1/docs/CDH-installation.md">Install instructions for CDH 5.16.1</a>
            </td>
        </tr>
        <tr>
			<td>CDH 5.14.0</td>
			<td><a href="https://s3.amazonaws.com/splice-releases/2.8.0.1929/cluster/parcel/cdh5.14.0/">CDH 5.14.0 Installer</a>
            </td>
			<td><a href="https://github.com/splicemachine/spliceengine/blob/branch-2.8/platforms/cdh5.14.0/docs/CDH-installation.md">Install instructions for CDH 5.14.0</a>
            </td>
        </tr>
        <tr>
			<td>CDH 5.13.3</td>
			<td><a href="https://s3.amazonaws.com/splice-releases/2.8.0.1929/cluster/parcel/cdh5.13.3/">CDH 5.13.3 Installer</a>
            </td>
			<td><a href="https://github.com/splicemachine/spliceengine/blob/branch-2.8/platforms/cdh5.13.3/docs/CDH-installation.md">Install instructions for CDH 5.13.3</a>
            </td>
        </tr>
        <tr>
            <td>CDH 5.12.2 (Spark 2.3)</td>
			<td><a href="https://s3.amazonaws.com/splice-releases/2.8.0.1929/cluster/parcel/cdh5.12.2-2.3/">CDH 5.12.2 Installer</a>
            </td>
			<td><a href="https://github.com/splicemachine/spliceengine/blob/branch-2.8/platforms/cdh5.13.2/docs/CDH-installation.md">Install instructions for CDH 5.12.2</a>
            </td>
        </tr>
			<td>CDH 5.12.2 (Spark 2.2)</td>
			<td><a href="https://s3.amazonaws.com/splice-releases/2.8.0.1929/cluster/parcel/cdh5.12.2/">CDH 5.12.2 Installer</a>
            </td>
			<td><a href="https://github.com/splicemachine/spliceengine/blob/branch-2.8/platforms/cdh5.13.2/docs/CDH-installation.md">Install instructions for CDH 5.12.2</a>
            </td>
    </tbody>
</table>

## Splice Machine Installation Links for Hortonworks HDP

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
            <td>HDP 2.6.5 (rpm)</td>
            <td>
                <p><a href="https://splice-releases.s3.amazonaws.com/2.8.0.1929/cluster/installer/hdp2.6.5/splicemachine-hdp2.6.5.2.8.0.1929.p0.33-1.noarch.rpm">HDP 2.6.5 Installer</a></p>
                <p><a href="https://splice-releases.s3.amazonaws.com/2.8.0.1929/cluster/installer/hdp2.6.5/splicemachine_ambari_service-hdp2.6.5.2.8.0.1929.p0.33-1.noarch.rpm">HDP 2.6.5 - Ambari Installer</a></p>
            </td>
            <td><a href="https://github.com/splicemachine/spliceengine/blob/branch-2.8/platforms/hdp2.6.5/docs/HDP-installation.md">Install instructions for HDP 2.6.5</a>
            </td>
        </tr>
        <tr>
            <td>HDP 2.6.4 (rpm)</td>
            <td>
                <p><a href="https://splice-releases.s3.amazonaws.com/2.8.0.1929/cluster/installer/hdp2.6.4/splicemachine-hdp2.6.4.2.8.0.1929.p0.33-1.noarch.rpm">HDP 2.6.4 Installer</a></p>
                <p><a href="https://splice-releases.s3.amazonaws.com/2.8.0.1929/cluster/installer/hdp2.6.4/splicemachine_ambari_service-hdp2.6.4.2.8.0.1929.p0.33-1.noarch.rpm">HDP 2.6.4 - Ambari Installer</a></p>
            </td>
            <td><a href="https://github.com/splicemachine/spliceengine/blob/branch-2.8/platforms/hdp2.6.4/docs/HDP-installation.md">Install instructions for HDP 2.6.4</a>
            </td>
        </tr>
        <tr>
            <td>HDP 2.6.3 (rpm)</td>
            <td>
                <p><a href="https://splice-releases.s3.amazonaws.com/2.8.0.1929/cluster/installer/hdp2.6.3/splicemachine-hdp2.6.3.2.8.0.1929.p0.33-1.noarch.rpm">HDP 2.6.3 Installer</a></p>
                <p><a href="https://splice-releases.s3.amazonaws.com/2.8.0.1929/cluster/installer/hdp2.6.3/splicemachine_ambari_service-hdp2.6.3.2.8.0.1929.p0.33-1.noarch.rpm">HDP 2.6.3 - Ambari Installer</a></p>
            </td>
            <td><a href="https://github.com/splicemachine/spliceengine/blob/branch-2.8/platforms/hdp2.6.3/docs/HDP-installation.md">Install instructions for HDP 2.6.3</a>
            </td>
        </tr>
    </tbody>
</table>

{% include splice_snippets/githublink.html %}
</div>
</section>
