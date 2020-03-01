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
            <th>Installer URL by Parcel Type</th>
            <th>Install Instructions URL</th>
        </tr>
    </thead>
    <tbody>
        <tr>
			<td>CDH 6.3.0</td>
			<td>
			    <p><a href="https://splice-releases.s3.amazonaws.com/3.0.0.1948/cluster/parcel/cdh6.3.0/SPLICEMACHINE-3.0.0.1948.cdh6.3.0.p0.109-el6.parcel">CDH 6.3.0 Installer - EL6</a></p>
			    <p><a href="https://splice-releases.s3.amazonaws.com/3.0.0.1948/cluster/parcel/cdh6.3.0/SPLICEMACHINE-3.0.0.1948.cdh6.3.0.p0.109-el7.parcel">CDH 6.3.0 Installer - EL7</a></p>
			    <p><a href="https://splice-releases.s3.amazonaws.com/3.0.0.1948/cluster/parcel/cdh6.3.0/SPLICEMACHINE-3.0.0.1948.cdh6.3.0.p0.109-precise.parcel">CDH 6.3.0 Installer - Precise</a></p>
			    <p><a href="https://splice-releases.s3.amazonaws.com/3.0.0.1948/cluster/parcel/cdh6.3.0/SPLICEMACHINE-3.0.0.1948.cdh6.3.0.p0.109-sles11.parcel">CDH 6.3.0 Installer - SLES11</a></p>
			    <p><a href="https://splice-releases.s3.amazonaws.com/3.0.0.1948/cluster/parcel/cdh6.3.0/SPLICEMACHINE-3.0.0.1948.cdh6.3.0.p0.109-trusty.parcel">CDH 6.3.0 Installer - Trusty</a></p>
			    <p><a href="https://splice-releases.s3.amazonaws.com/3.0.0.1948/cluster/parcel/cdh6.3.0/SPLICEMACHINE-3.0.0.1948.cdh6.3.0.p0.109-wheezy.parcel">CDH 6.3.0 Installer - Wheezy</a></p>
			    <p><a href="https://splice-releases.s3.amazonaws.com/3.0.0.1948/cluster/parcel/cdh6.3.0/SPLICEMACHINE-3.0.0.1948.cdh6.3.0.p0.109-xenial.parcel">CDH 6.3.0 Installer - Xenial</a></p>
			    <p><a href="https://splice-releases.s3.amazonaws.com/3.0.0.1948/cluster/parcel/cdh6.3.0/manifest.json">manifest.json</a></p>
            </td>
			<td><a href="https://github.com/splicemachine/spliceengine/blob/branch-3.0/platforms/cdh6.3.0/docs/CDH-installation.md">Install instructions for CDH 6.3.0</a>
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
            <td>HDP 3.1 (rpm)</td>
            <td>
                <p><a href="https://splice-releases.s3.amazonaws.com/3.0.0.1948/cluster/installer/hdp3.1.0/splicemachine-hdp3.1.0.3.0.0.1948.p0.109-1.noarch.rpm">HDP 3.1.0 Installer</a></p>
                <p><a href="https://splice-releases.s3.amazonaws.com/3.0.0.1948/cluster/installer/hdp3.1.0/splicemachine_ambari_service-hdp3.1.0.3.0.0.1948.p0.109-1.noarch.rpm">HDP 3.1.0 - Ambari Installer</a></p>
            </td>
            <td><a href="https://github.com/splicemachine/spliceengine/blob/branch-3.0/platforms/hdp3.1.0/docs/HDP-installation.md">Install instructions for HDP 3.1.0</a>
            </td>
        </tr>
    </tbody>
</table>

## Splice Machine Standalone (Version 2.7) Installation Links  {#standalone}

<table summary="Links for Installing the Standalone Version of Splice Machine">
    <col />
    <col />
    <thead>
        <tr>
            <th>Installer URL</th>
            <th>Install Instructions URL</th>
        </tr>
    </thead>
    <tbody>
        <tr>
			<td><a href="{{splvar_location_StandaloneLink}}">Standalone Version Installer</a>
            </td>
			<td><a href="https://github.com/splicemachine/spliceengine/blob/branch-2.7/platforms/std/docs/STD-installation.md">Install instructions for the Standalone Version</a>
            </td>
        </tr>
    </tbody>
</table>

{% include splice_snippets/githublink.html %}
</div>
</section>
