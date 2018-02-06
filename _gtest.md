---
title: Gary Test Page
summary: Blah
keywords: blah
toc: false
product: all
sidebar: home_sidebar
permalink: gtest.html
folder: /
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% include splicevars.html %}
<div class="TopicContent" style="text-align: left;">
<h1>Installing and Configuring Splice Machine for Cloudera Manager</h1>
<p style="text-align: left;">This topic describes installing and configuring Splice Machine on a Cloudera-managed cluster. Follow these steps:</p>
<ol>
<li><a style="text-decoration: underline;" href="onprem_install_cloudera.html#Verify">Verify Prerequisites</a></li>
<li><a style="text-decoration: underline;" href="onprem_install_cloudera.html#Install">Install the Splice Machine Parcel</a></li>
<li><a class="WithinBook" style="text-decoration: underline;" href="onprem_install_cloudera.html#Stop">Stop Hadoop Services</a></li>
<li><a style="text-decoration: underline;" href="onprem_install_cloudera.html#ClusterMod">Make Cluster Modifications for Splice Machine</a></li>
<li><a style="text-decoration: underline;" href="onprem_install_cloudera.html#Configur8">Configure Hadoop Services</a></li>
<li>Make any needed<span>&nbsp;</span><a style="text-decoration: underline;" href="onprem_install_cloudera.html#Optional">Optional Configuration Modifications</a></li>
<li><a style="text-decoration: underline;" href="onprem_install_cloudera.html#Deploy">Deploy the Client Configuration</a></li>
<li><a style="text-decoration: underline;" href="onprem_install_cloudera.html#Restart">Restart the Cluster</a></li>
<li><a style="text-decoration: underline;" href="onprem_install_cloudera.html#Run">Verify your Splice Machine Installation</a></li></ol>
<h2>Verify Prerequisites</h2>
<p style="text-align: left;">Before starting your Splice Machine installation, please make sure that your cluster contains the prerequisite software components:</p>
<ul>
<li>A cluster running Cloudera Data Hub (CDH) with Cloudera Manager (CM)</li>
<li>HBase installed</li>
<li>HDFS installed</li>
<li>YARN installed</li>
<li>ZooKeeper installed</li></ul>
<p class="noteNote" style="text-align: left;">The specific versions of these components that you need depend on your operating environment, and are called out in detail in the<span>&nbsp;</span><a style="text-decoration: underline;" href="onprem_info_requirements.html">Requirements</a><span>&nbsp;</span>topic of our<span>&nbsp;</span><em>Getting Started Guide</em>.</p>
<h2>Install the Splice Machine Parcel</h2>
<p style="text-align: left;">Follow these steps to install CDH, Hadoop, Hadoop services, and Splice Machine on your cluster:</p>
<div class="opsStepsList" style="text-align: left;">
<ol class="boldFont">
<li>
<p class="topLevel" style="text-align: left;">Copy your parcel URL to the clipboard for use in the next step.</p>
<p class="indentLevel1" style="text-align: left;">Which Splice Machine parcel URL you need depends upon which Splice Machine version you&rsquo;re installing and which version of CDH you are using. Here are the URLs for Splice Machine Release 2.7.0 and 2.5.0:</p>
<table class="wrapped"><colgroup><col /><col /><col /><col /></colgroup>
<thead>
<tr>
<th style="text-align: left;">Splice Machine Release</th>
<th style="text-align: left;">CDH Version</th>
<th style="text-align: left;">Parcel Type</th>
<th style="text-align: left;">Installer Package Link(s)</th></tr></thead>
<tbody>
<tr>
<td class="SpliceRelease" style="text-align: left;" rowspan="12">2.7.0</td>
<td class="SplicePlatform" style="text-align: left;" rowspan="6">5.12.0</td>
<td style="text-align: left;">EL6</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.6.1.1745.cdh5.12.0.p0.121-el6.parcel">https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.6.1.1745.cdh5.12.0.p0.121-el6.parcel</a></td></tr>
<tr>
<td style="text-align: left;">EL7</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.6.1.1745.cdh5.12.0.p0.121-el7.parcel">https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.6.1.1745.cdh5.12.0.p0.121-el7.parcel</a></td></tr>
<tr>
<td style="text-align: left;">Precise</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.6.1.1745.cdh5.12.0.p0.121-precise.parcel">https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.6.1.1745.cdh5.12.0.p0.121-precise.parcel</a></td></tr>
<tr>
<td style="text-align: left;">SLES11</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.6.1.1745.cdh5.12.0.p0.121-sles11.parcel">https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.6.1.1745.cdh5.12.0.p0.121-sles11.parcel</a></td></tr>
<tr>
<td style="text-align: left;">Trusty</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.6.1.1745.cdh5.12.0.p0.121-trusty.parcel">https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.6.1.1745.cdh5.12.0.p0.121-trusty.parcel</a></td></tr>
<tr>
<td style="text-align: left;">Wheezy</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.6.1.1745.cdh5.12.0.p0.121-wheezy.parcel">https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.6.1.1745.cdh5.12.0.p0.121-wheezy.parcel</a></td></tr>
<tr>
<td class="SplicePlatform" style="text-align: left;" rowspan="6">5.8.3</td>
<td style="text-align: left;">EL6</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.6.1.1745.cdh5.8.3.p0.121-el6.parcel">https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.6.1.1745.cdh5.8.3.p0.121-el6.parcel</a></td></tr>
<tr>
<td style="text-align: left;">EL7</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.6.1.1745.cdh5.8.3.p0.121-el7.parcel">https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.6.1.1745.cdh5.8.3.p0.121-el7.parcel</a></td></tr>
<tr>
<td style="text-align: left;">PRECISE</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.6.1.1745.cdh5.8.3.p0.121-precise.parcel">https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.6.1.1745.cdh5.8.3.p0.121-precise.parcel</a></td></tr>
<tr>
<td style="text-align: left;">SLES11</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.6.1.1745.cdh5.8.3.p0.121-sles11.parcel">https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.6.1.1745.cdh5.8.3.p0.121-sles11.parcel</a></td></tr>
<tr>
<td style="text-align: left;">Trusty</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.6.1.1745.cdh5.8.3.p0.121-trusty.parcel">https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.6.1.1745.cdh5.8.3.p0.121-trusty.parcel</a></td></tr>
<tr>
<td style="text-align: left;">Wheezy</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.6.1.1745.cdh5.8.3.p0.121-wheezy.parcel">https://s3.amazonaws.com/splice-releases/2.6.1.1745/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.6.1.1745.cdh5.8.3.p0.121-wheezy.parcel</a></td></tr>
<tr>
<td class="Separator" style="text-align: left;" colspan="4"><br /></td></tr>
<tr>
<td class="SpliceRelease" style="text-align: left;" rowspan="12">2.5.0</td>
<td class="SplicePlatform" style="text-align: left;" rowspan="6">5.12.0</td>
<td style="text-align: left;">EL6</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.5.0.1802.cdh5.12.0.p0.540-el6.parcel">https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.5.0.1802.cdh5.12.0.p0.540-el6.parcel</a></td></tr>
<tr>
<td style="text-align: left;">EL7</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.5.0.1802.cdh5.12.0.p0.540-el7.parcel">https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.5.0.1802.cdh5.12.0.p0.540-el7.parcel</a></td></tr>
<tr>
<td style="text-align: left;">Precise</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.5.0.1802.cdh5.12.0.p0.540-precise.parcel">https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.5.0.1802.cdh5.12.0.p0.540-precise.parcel</a></td></tr>
<tr>
<td style="text-align: left;">SLES11</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.5.0.1802.cdh5.12.0.p0.540-sles11.parcel">https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.5.0.1802.cdh5.12.0.p0.540-sles11.parcel</a></td></tr>
<tr>
<td style="text-align: left;">Trusty</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.5.0.1802.cdh5.12.0.p0.540-trusty.parcel">https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.5.0.1802.cdh5.12.0.p0.540-trusty.parcel</a></td></tr>
<tr>
<td style="text-align: left;">Wheezy</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.5.0.1802.cdh5.12.0.p0.540-wheezy.parcel">https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.12.0/SPLICEMACHINE-2.5.0.1802.cdh5.12.0.p0.540-wheezy.parcel</a></td></tr>
<tr>
<td class="SplicePlatform" style="text-align: left;" rowspan="6">5.8.3</td>
<td style="text-align: left;">EL6</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.5.0.1802.cdh5.8.3.p0.540-el6.parcel">https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.5.0.1802.cdh5.8.3.p0.540-el6.parcel</a></td></tr>
<tr>
<td style="text-align: left;">EL7</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.5.0.1802.cdh5.8.3.p0.540-el7.parcel">https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.5.0.1802.cdh5.8.3.p0.540-el7.parcel</a></td></tr>
<tr>
<td style="text-align: left;">Precise</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.5.0.1802.cdh5.8.3.p0.540-precise.parcel">https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.5.0.1802.cdh5.8.3.p0.540-precise.parcel</a></td></tr>
<tr>
<td style="text-align: left;">SLES11</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.5.0.1802.cdh5.8.3.p0.540-sles11.parcel">https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.5.0.1802.cdh5.8.3.p0.540-sles11.parcel</a></td></tr>
<tr>
<td style="text-align: left;">Trusty</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.5.0.1802.cdh5.8.3.p0.540-trusty.parcel">https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.5.0.1802.cdh5.8.3.p0.540-trusty.parcel</a></td></tr>
<tr>
<td style="text-align: left;">Wheezy</td>
<td style="text-align: left;"><a style="text-decoration: underline;" href="https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.5.0.1802.cdh5.8.3.p0.540-wheezy.parcel">https://s3.amazonaws.com/splice-releases/2.5.0.1802/cluster/parcel/cdh5.8.3/SPLICEMACHINE-2.5.0.1802.cdh5.8.3.p0.540-wheezy.parcel</a></td></tr></tbody></table>
<p class="noteIcon" style="text-align: left;">To be sure that you have the latest URL, please check<span>&nbsp;</span><a style="text-decoration: underline;" href="https://community.splicemachine.com/">the Splice Machine Community site</a><span>&nbsp;</span>or contact your Splice Machine representative.</p></li>
<li>
<p class="topLevel" style="text-align: left;">Add the parcel repository</p>
<ol class="LowerAlphaPlainFont">
<li style="list-style-type: lower-alpha;">
<p style="text-align: left;">Make sure the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Use Parcels (Recommended)</span><span>&nbsp;</span>option and the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Matched release</span><span>&nbsp;</span>option are both selected.</p></li>
<li style="list-style-type: lower-alpha;">
<p style="text-align: left;">Click the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Continue</span><span>&nbsp;</span>button to land on the<span>&nbsp;</span><em>More Options</em><span>&nbsp;</span>screen.</p></li>
<li style="list-style-type: lower-alpha;">
<p style="text-align: left;">Cick the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">+</span><span>&nbsp;</span>button for the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Remote Parcel Repository URLs</span><span>&nbsp;</span>field. Paste your Splice Machine repository URL into this field.</p></li></ol></li>
<li>
<p class="topLevel" style="text-align: left;">Use Cloudera Manager to install the parcel.</p></li>
<li>
<p class="topLevel" style="text-align: left;">Verify that the parcel has been distributed and activated.</p>
<p class="indentLevel1" style="text-align: left;">The Splice Machine parcel is identified as<span>&nbsp;</span><code>SPLICEMACHINE</code><span>&nbsp;</span>in the Cloudera Manager user interface. Make sure that this parcel has been downloaded, distributed, and activated on your cluster.</p></li>
<li>
<p class="topLevel" style="text-align: left;">Restart and redeploy any client changes when Cloudera Manager prompts you.</p>
<p style="text-align: left;">&lt;/div&gt;</p></li></ol></div>
<h2>Stop Hadoop Services</h2>
<p style="text-align: left;">As a first step, we stop cluster services to allow our installer to make changes that require the cluster to be temporarily inactive.</p>
<p style="text-align: left;">From the Cloudera Manager home screen, click the drop-down arrow next to the cluster on</p>
<div class="opsStepsList" style="text-align: left;">
<ol class="boldFont">
<li>
<p class="topLevel" style="text-align: left;">Select your cluster in Cloudera Manager</p>
<p class="indentLevel1" style="text-align: left;">Click the drop-down arrow next to the name of the cluster on which you are installing Splice Machine.</p></li>
<li>
<p class="topLevel" style="text-align: left;">Stop the cluster</p>
<p class="indentLevel1" style="text-align: left;">Click the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Stop</span><span>&nbsp;</span>button.</p></li></ol></div>
<h2>Make Cluster Modifications for Splice Machine</h2>
<p style="text-align: left;">Splice Machine requires a few modifications at the file system level to work properly on a CDH cluster:</p>
<div class="opsStepsList" style="text-align: left;">
<ol class="boldFont">
<li>
<p class="topLevel" style="text-align: left;">Install updated Java Servlet library:</p>
<p class="indentLevel1" style="text-align: left;">You need to install an updated<span>&nbsp;</span><span class="AppFontCustCode" style="color: inherit;">javax.servlet-api</span><span>&nbsp;</span>library so that Splice Machine can use Spark 2.0.x functionality in YARN.</p></li>
<li>
<p class="topLevel" style="text-align: left;">Remove Spark 1.6.x libraries</p>
<p class="indentLevel1" style="text-align: left;">By default, Splice Machine version uses Spark 2.0. To avoid Spark version mismatches, we strongly recommend that you remove Spark 1.6x libraries from /opt/cloudera/parcels/CDH/jars/; however, if you need to retain Spark 1.6 for other applications, please contact our install team to help with your configuration.</p></li>
<li>
<p class="topLevel" style="text-align: left;">Run our script as<span>&nbsp;</span><em>root</em><span>&nbsp;</span>user<span>&nbsp;</span><span class="important" style="color: rgb(255,0,0);">on each node</span><span>&nbsp;</span>in your cluster to add symbolic links to the Splice Machine uber jar and YARN proxy jar into the YARN directories</p>
<p class="indentLevel1" style="text-align: left;">Issue this command<span>&nbsp;</span><span class="important" style="color: rgb(255,0,0);">on each node</span><span>&nbsp;</span>in your cluster::</p>
<div class="preWrapperWide">
<p class="AppCommand" style="text-align: left;">sudo /opt/cloudera/parcels/SPLICEMACHINE/scripts/install-splice-symlinks.sh</p></div></li></ol></div>
<h2>Configure Hadoop Services</h2>
<p style="text-align: left;">Now it&rsquo;s time to make a few modifications in the Hadoop services configurations:</p>
<ul>
<li><a style="text-decoration: underline;" href="onprem_install_cloudera.html#Configur">Configure and Restart the Management Service</a></li>
<li><a style="text-decoration: underline;" href="onprem_install_cloudera.html#Configur4">Configure ZooKeeper</a></li>
<li><a style="text-decoration: underline;" href="onprem_install_cloudera.html#Configur5">Configure HDFS</a></li>
<li><a style="text-decoration: underline;" href="onprem_install_cloudera.html#Configur2">Configure YARN</a></li>
<li><a style="text-decoration: underline;" href="onprem_install_cloudera.html#Configur3">Configure HBASE</a></li></ul>
<h3>Configure and Restart the Management Service</h3>
<div class="opsStepsList" style="text-align: left;">
<ol class="boldFont">
<li>
<p style="text-align: left;">Select the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Configuration</span><span>&nbsp;</span>tab in CM:</p>
<p style="text-align: left;"><ac:image ac:class="nestedTightSpacing" ac:alt="Configuring the Cloudera Manager
ports"><ri:url ri:value="images/CM.AlertListenPort.png" /></ac:image></p></li>
<li>
<p style="text-align: left;">Change the value of the Alerts: Listen Port to<span>&nbsp;</span><span class="AppFontCustCode" style="color: inherit;">10110</span>.</p></li>
<li>
<p style="text-align: left;">Save changes and restart the Management Service.</p></li></ol></div>
<h3>Configure ZooKeeper</h3>
<p style="text-align: left;">To edit the ZooKeeper configuration, click<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">ZooKeeper</span><span>&nbsp;</span>in the Cloudera Manager (CM) home screen, then click the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Configuration</span><span>&nbsp;</span>tab and follow these steps:</p>
<div class="opsStepsList" style="text-align: left;">
<ol class="boldFont">
<li>
<p class="topLevel" style="text-align: left;">Select the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Service-Wide</span><span>&nbsp;</span>category.</p>
<p class="indentLevel1" style="text-align: left;">Make the following changes:</p>
<div class="preWrapperWide">
<p class="AppCommand" style="text-align: left;">Maximum Client Connections = 0 Maximum Session Timeout = 120000</p></div>
<p class="indentLevel1" style="text-align: left;">Click the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Save Changes</span><span>&nbsp;</span>button.</p></li></ol></div>
<h3>Configure HDFS</h3>
<p style="text-align: left;">To edit the HDFS configuration, click<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">HDFS</span><span>&nbsp;</span>in the Cloudera Manager home screen, then click the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Configuration</span><span>&nbsp;</span>tab and make these changes:</p>
<div class="opsStepsList" style="text-align: left;">
<ol class="boldFont">
<li>
<p class="topLevel" style="text-align: left;">Verify that the HDFS data directories for your cluster are set up to use your data disks.</p></li>
<li>
<p class="topLevel" style="text-align: left;">Change the values of these settings</p>
<table class="wrapped"><colgroup><col /><col /></colgroup>
<thead>
<tr>
<th style="text-align: left;">Setting</th>
<th style="text-align: left;">New Value</th></tr></thead>
<tbody>
<tr>
<td class="AppFont" style="text-align: left;">Handler Count</td>
<td class="AppFontCust" style="text-align: left;">20</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">Maximum Number of Transfer Threads</td>
<td class="AppFontCust" style="text-align: left;">8192</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">NameNodeHandler Count</td>
<td class="AppFontCust" style="text-align: left;">64</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">NameNode Service Handler Count</td>
<td class="AppFontCust" style="text-align: left;">60</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">Replication Factor</td>
<td class="AppFontCust" style="text-align: left;">2 or 3 *</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">Java Heap Size of DataNode in Bytes</td>
<td class="AppFontCust" style="text-align: left;">2 GB</td></tr></tbody></table>
<p class="auto-cursor-target"><br /></p></li>
<li>
<p style="text-align: left;">Click the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Save Changes</span><span>&nbsp;</span>button.</p></li></ol></div>
<h3>Configure YARN</h3>
<p style="text-align: left;">To edit the YARN configuration, click<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">YARN</span><span>&nbsp;</span>in the Cloudera Manager home screen, then click the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Configuration</span><span>&nbsp;</span>tab and make these changes:</p>
<div class="opsStepsList" style="text-align: left;">
<ol class="boldFont">
<li>
<p class="topLevel" style="text-align: left;">Verify that the following directories are set up to use your data disks.</p>
<table class="wrapped"><colgroup><col /></colgroup>
<tbody>
<tr>
<td class="AppFont" style="text-align: left;">NodeManager Local Directories<br />NameNode Data Directories<br />HDFS Checkpoint Directories</td></tr></tbody></table>
<p class="auto-cursor-target"><br /></p></li>
<li>
<p class="topLevel" style="text-align: left;">Change the values of these settings</p>
<table class="wrapped"><colgroup><col /><col /></colgroup>
<thead>
<tr>
<th style="text-align: left;">Setting</th>
<th style="text-align: left;">New Value</th></tr></thead>
<tbody>
<tr>
<td class="AppFont" style="text-align: left;">Heartbeat Interval</td>
<td class="AppFontCust" style="text-align: left;">100 ms</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">MR Application Classpath</td>
<td class="AppFontCust" style="text-align: left;">
<div class="preWrapperWide">
<pre class="Example">$HADOOP_MAPRED_HOME/*
$HADOOP_MAPRED_HOME/lib/*
$MR2_CLASSPATH/opt/cloudera/parcels/SPLICEMACHINE/lib/*</pre></div></td></tr>
<tr>
<td class="AppFont" style="text-align: left;">YARN Application Classpath</td>
<td class="AppFontCust" style="text-align: left;">
<div class="preWrapperWide">
<pre class="Example">$HADOOP_CLIENT_CONF_DIR
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
/opt/cloudera/parcels/SPLICEMACHINE/lib/*</pre></div></td></tr>
<tr>
<td class="AppFont" style="text-align: left;">Localized Dir Deletion Delay</td>
<td class="AppFontCust" style="text-align: left;">86400</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">JobHistory Server Max Log Size</td>
<td class="AppFontCust" style="text-align: left;">1 GB</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">NodeManager Max Log Size</td>
<td class="AppFontCust" style="text-align: left;">1 GB</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">ResourceManager Max Log Size</td>
<td class="AppFontCust" style="text-align: left;">1 GB</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">Container Memory</td>
<td class="AppFontCust" style="text-align: left;">30 GB (based on node specs)</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">Container Memory Maximum</td>
<td class="AppFontCust" style="text-align: left;">30 GB (based on node specs)</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">Container Virtual CPU Cores</td>
<td class="AppFontCust" style="text-align: left;">19 (based on node specs)</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">Container Virtual CPU Cores Maximum</td>
<td class="AppFontCust" style="text-align: left;">19 (Based on node specs)</td></tr></tbody></table>
<p class="auto-cursor-target"><br /></p></li>
<li>
<p class="topLevel" style="text-align: left;">Add property values</p>
<p class="indentLevel1" style="text-align: left;">You need to add the same two property values to each of four YARN advanced configuration settings.</p>
<p class="indentLevel1" style="text-align: left;">Add these properties:</p>
<table class="wrapped"><colgroup><col /><col /></colgroup>
<thead>
<tr>
<th style="text-align: left;">XML Property Name</th>
<th style="text-align: left;">XML Property Value</th></tr></thead>
<tbody>
<tr>
<td class="AppFont" style="text-align: left;">yarn.nodemanager.aux-services.spark_shuffle.class</td>
<td class="AppFontCust" style="text-align: left;">org.apache.spark.network.yarn.YarnShuffleService</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">yarn.nodemanager.aux-services</td>
<td class="AppFontCust" style="text-align: left;">mapreduce_shuffle,spark_shuffle</td></tr></tbody></table>
<p class="indentLevel1" style="text-align: left;">To each of these YARN settings:</p>
<ul class="plainFont">
<li style="list-style-type: disc;">
<p style="text-align: left;">Yarn Service Advanced Configuration Snippet (Safety Valve) for yarn-site.xml</p></li>
<li style="list-style-type: disc;">
<p style="text-align: left;">Yarn Client Advanced Configuration Snippet (Safety Valve) for yarn-site.xml</p></li>
<li style="list-style-type: disc;">
<p style="text-align: left;">NodeManager Advanced Configuration Snippet (Safety Valve) for yarn-site.xml</p></li>
<li style="list-style-type: disc;">
<p style="text-align: left;">ResourceManager Advanced Configuration Snippet (Safety Valve) for yarn-site.xml</p></li></ul></li>
<li>
<p style="text-align: left;">Click the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Save Changes</span><span>&nbsp;</span>button.</p></li></ol></div>
<h3>Configure HBASE</h3>
<p style="text-align: left;">To edit the HBASE configuration, click<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">HBASE</span><span>&nbsp;</span>in the Cloudera Manager home screen, then click the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Configuration</span><span>&nbsp;</span>tab and make these changes:</p>
<div class="opsStepsList" style="text-align: left;">
<ol class="boldFont">
<li>
<p class="topLevel" style="text-align: left;">Change the values of these settings</p>
<table class="wrapped"><colgroup><col /><col /></colgroup>
<thead>
<tr>
<th style="text-align: left;">Setting</th>
<th style="text-align: left;">New Value</th></tr></thead>
<tbody>
<tr>
<td class="AppFont" style="text-align: left;">HBase Client Scanner Caching</td>
<td class="AppFontCust" style="text-align: left;">100 ms</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">Graceful Shutdown Timeout</td>
<td class="AppFontCust" style="text-align: left;">30 seconds</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">HBase Service Advanced Configuration Snippet (Safety Valve) for hbase-site.xml</td>
<td class="AppFontCust" style="text-align: left;"><span class="bodyFont" style="color: inherit;">The property list for the Safety Valve snippet is shown below, in Step 2</span></td></tr>
<tr>
<td class="AppFont" style="text-align: left;">SplitLog Manager Timeout</td>
<td class="AppFontCust" style="text-align: left;">5 minutes</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">Maximum HBase Client Retries</td>
<td class="AppFontCust" style="text-align: left;">40</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">RPC Timeout</td>
<td class="AppFontCust" style="text-align: left;">20 minutes (or 1200000 milliseconds)</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">HBase Client Pause</td>
<td class="AppFontCust" style="text-align: left;">90</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">ZooKeeper Session Timeout</td>
<td class="AppFontCust" style="text-align: left;">120000</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">HBase Master Web UI Port</td>
<td class="AppFontCust" style="text-align: left;">16010</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">HBase Master Port</td>
<td class="AppFontCust" style="text-align: left;">16000</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">Java Configuration Options for HBase Master</td>
<td class="AppFontCust" style="text-align: left;"><span class="bodyFont" style="color: inherit;">The HBase Master Java configuration options list is shown below, in Step 3</span></td></tr>
<tr>
<td class="AppFont" style="text-align: left;">HBase Coprocessor Master Classes</td>
<td class="AppFontCust" style="text-align: left;">
<p style="text-align: left;">com.splicemachine.hbase.SpliceMasterObserver</p></td></tr>
<tr>
<td class="AppFont" style="text-align: left;">Java Heap Size of HBase Master in Bytes</td>
<td class="AppFontCust" style="text-align: left;">5 GB</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">HStore Compaction Threshold</td>
<td class="AppFontCust" style="text-align: left;">5</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">HBase RegionServer Web UI port</td>
<td class="AppFontCust" style="text-align: left;">16030</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">HStore Blocking Store Files</td>
<td class="AppFontCust" style="text-align: left;">20</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">Java Configuration Options for HBase RegionServer</td>
<td class="AppFontCust" style="text-align: left;"><span class="bodyFont" style="color: inherit;">The HBase RegionServerJava configuration options list is shown below, in Step 4</span></td></tr>
<tr>
<td class="AppFont" style="text-align: left;">HBase Memstore Block Multiplier</td>
<td class="AppFontCust" style="text-align: left;">4</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">Maximum Number of HStoreFiles Compaction</td>
<td class="AppFontCust" style="text-align: left;">7</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">HBase RegionServer Lease Period</td>
<td class="AppFontCust" style="text-align: left;">20 minutes (or 1200000 milliseconds)</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">HFile Block Cache Size</td>
<td class="AppFontCust" style="text-align: left;">0.25</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">Java Heap Size of HBase RegionServer in Bytes</td>
<td class="AppFontCust" style="text-align: left;">24 GB</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">HBase RegionServer Handler Count</td>
<td class="AppFontCust" style="text-align: left;">200</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">HBase RegionServer Meta-Handler Count</td>
<td class="AppFontCust" style="text-align: left;">200</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">HBase Coprocessor Region Classes</td>
<td class="AppFontCust" style="text-align: left;">com.splicemachine.hbase.MemstoreAwareObserver<br />com.splicemachine.derby.hbase.SpliceIndexObserver<br />com.splicemachine.derby.hbase.SpliceIndexEndpoint<br />com.splicemachine.hbase.RegionSizeEndpoint<br /><a href="http://com.splicemachine.si">com.splicemachine.si</a>.data.hbase.coprocessor.TxnLifecycleEndpoint<br /><a href="http://com.splicemachine.si">com.splicemachine.si</a>.data.hbase.coprocessor.SIObserver<br />com.splicemachine.hbase.BackupEndpointObserver</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">Maximum number of Write-Ahead Log (WAL) files</td>
<td class="AppFontCust" style="text-align: left;">48</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">RegionServer Small Compactions Thread Count</td>
<td class="AppFontCust" style="text-align: left;">4</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">HBase RegionServer Port</td>
<td class="AppFontCust" style="text-align: left;">16020</td></tr>
<tr>
<td class="AppFont" style="text-align: left;">Per-RegionServer Number of WAL Pipelines</td>
<td class="AppFontCust" style="text-align: left;">16</td></tr></tbody></table>
<p class="auto-cursor-target"><br /></p></li>
<li>
<p style="text-align: left;">Set the value of<span>&nbsp;</span><code>HBase Service Advanced Configuration Snippet (Safety Valve)</code><span>&nbsp;</span>for<span>&nbsp;</span><code>hbase-site.xml</code>:</p>
<div class="preWrapperWide">
<pre class="Example"><code>&lt;property&gt;&lt;name&gt;dfs.client.read.shortcircuit.buffer.size&lt;/name&gt;&lt;value&gt;131072&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.balancer.period&lt;/name&gt;&lt;value&gt;60000&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.client.ipc.pool.size&lt;/name&gt;&lt;value&gt;10&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.client.max.perregion.tasks&lt;/name&gt;&lt;value&gt;100&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.coprocessor.regionserver.classes&lt;/name&gt;&lt;value&gt;com.splicemachine.hbase.RegionServerLifecycleObserver&lt;/value&gt;&lt;/property&gt;&lt;property&gt;&lt;name&gt;hbase.hstore.defaultengine.compactionpolicy.class&lt;/name&gt;&lt;value&gt;com.splicemachine.compactions.SpliceDefaultCompactionPolicy&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.hstore.defaultengine.compactor.class&lt;/name&gt;&lt;value&gt;com.splicemachine.compactions.SpliceDefaultCompactor&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.htable.threads.max&lt;/name&gt;&lt;value&gt;96&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.ipc.warn.response.size&lt;/name&gt;&lt;value&gt;-1&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.ipc.warn.response.time&lt;/name&gt;&lt;value&gt;-1&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.master.loadbalance.bytable&lt;/name&gt;&lt;value&gt;true&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.mvcc.impl&lt;/name&gt;&lt;value&gt;org.apache.hadoop.hbase.regionserver.SIMultiVersionConsistencyControl&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.regions.slop&lt;/name&gt;&lt;value&gt;0.01&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.regionserver.global.memstore.size.lower.limit&lt;/name&gt;&lt;value&gt;0.9&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.regionserver.global.memstore.size&lt;/name&gt;&lt;value&gt;0.25&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.regionserver.maxlogs&lt;/name&gt;&lt;value&gt;48&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.regionserver.wal.enablecompression&lt;/name&gt;&lt;value&gt;true&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.rowlock.wait.duration&lt;/name&gt;&lt;value&gt;0&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.status.multicast.port&lt;/name&gt;&lt;value&gt;16100&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.wal.disruptor.batch&lt;/name&gt;&lt;value&gt;true&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.wal.provider&lt;/name&gt;&lt;value&gt;multiwal&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.wal.regiongrouping.numgroups&lt;/name&gt;&lt;value&gt;16&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.zookeeper.property.tickTime&lt;/name&gt;&lt;value&gt;6000&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hfile.block.bloom.cacheonwrite&lt;/name&gt;&lt;value&gt;true&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;io.storefile.bloom.error.rate&lt;/name&gt;&lt;value&gt;0.005&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;splice.client.numConnections&lt;/name&gt;&lt;value&gt;1&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;splice.client.write.maxDependentWrites&lt;/name&gt;&lt;value&gt;60000&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;splice.client.write.maxIndependentWrites&lt;/name&gt;&lt;value&gt;60000&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;splice.compression&lt;/name&gt;&lt;value&gt;snappy&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;splice.marshal.kryoPoolSize&lt;/name&gt;&lt;value&gt;1100&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;splice.olap_server.clientWaitTime&lt;/name&gt;&lt;value&gt;900000&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;splice.ring.bufferSize&lt;/name&gt;&lt;value&gt;131072&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;splice.splitBlockSize&lt;/name&gt;&lt;value&gt;67108864&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;splice.timestamp_server.clientWaitTime&lt;/name&gt;&lt;value&gt;120000&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;splice.txn.activeTxns.cacheSize&lt;/name&gt;&lt;value&gt;10240&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;splice.txn.completedTxns.concurrency&lt;/name&gt;&lt;value&gt;128&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;splice.txn.concurrencyLevel&lt;/name&gt;&lt;value&gt;4096&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.hstore.compaction.max.size&lt;/name&gt;&lt;value&gt;260046848&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.hstore.compaction.min.size&lt;/name&gt;&lt;value&gt;16777216&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.hstore.compaction.min&lt;/name&gt;&lt;value&gt;5&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;hbase.regionserver.thread.compaction.large&lt;/name&gt;&lt;value&gt;1&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;splice.authentication.native.algorithm&lt;/name&gt;&lt;value&gt;SHA-512&lt;/value&gt;&lt;/property&gt;
&lt;property&gt;&lt;name&gt;splice.authentication&lt;/name&gt;&lt;value&gt;NATIVE&lt;/value&gt;&lt;/property&gt;
</code></pre></div></li>
<li>
<p class="topLevel" style="text-align: left;">Set the value of Java Configuration Options for HBase Master</p>
<p class="indentLevel1" style="text-align: left;">If you&rsquo;re using version 2.2 or later of the Spark Shuffle service, set the Java Configuration Options for HBase Master to:</p>
<div class="preWrapperWide">
<pre class="Example"><code>-XX:MaxPermSize=512M -XX:+HeapDumpOnOutOfMemoryError -XX:MaxDirectMemorySize=2g -XX:+AlwaysPreTouch -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=70 -XX:+CMSParallelRemarkEnabled -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=10101 -Dsplice.spark.enabled=true -Dsplice.spark.app.name=SpliceMachine -Dsplice.spark.master=yarn-client -Dsplice.spark.logConf=true -Dsplice.spark.yarn.maxAppAttempts=1 -Dsplice.spark.driver.maxResultSize=1g -Dsplice.spark.driver.cores=2 -Dsplice.spark.yarn.am.memory=1g -Dsplice.spark.dynamicAllocation.enabled=true -Dsplice.spark.dynamicAllocation.executorIdleTimeout=120 -Dsplice.spark.dynamicAllocation.cachedExecutorIdleTimeout=120 -Dsplice.spark.dynamicAllocation.minExecutors=0 -Dsplice.spark.dynamicAllocation.maxExecutors=12 -Dsplice.spark.io.compression.lz4.blockSize=32k -Dsplice.spark.kryo.referenceTracking=false -Dsplice.spark.kryo.registrator=com.splicemachine.derby.impl.SpliceSparkKryoRegistrator -Dsplice.spark.kryoserializer.buffer.max=512m -Dsplice.spark.kryoserializer.buffer=4m -Dsplice.spark.locality.wait=100 -Dsplice.spark.memory.fraction=0.5 -Dsplice.spark.scheduler.mode=FAIR -Dsplice.spark.serializer=org.apache.spark.serializer.KryoSerializer -Dsplice.spark.shuffle.compress=false -Dsplice.spark.shuffle.file.buffer=128k -Dsplice.spark.shuffle.service.enabled=true -Dsplice.spark.reducer.maxReqSizeShuffleToMem=134217728 -Dsplice.spark.yarn.am.extraLibraryPath=/opt/cloudera/parcels/CDH/lib/hadoop/lib/native -Dsplice.spark.yarn.am.waitTime=10s -Dsplice.spark.yarn.executor.memoryOverhead=2048 -Dsplice.spark.driver.extraJavaOptions=-Dlog4j.configuration=file:/etc/spark/conf/log4j.properties -Dsplice.spark.driver.extraLibraryPath=/opt/cloudera/parcels/CDH/lib/hadoop/lib/native -Dsplice.spark.driver.extraClassPath=/opt/cloudera/parcels/CDH/lib/hbase/conf:/opt/cloudera/parcels/CDH/jars/htrace-core-3.1.0-incubating.jar -Dsplice.spark.executor.extraLibraryPath=/opt/cloudera/parcels/CDH/lib/hadoop/lib/native -Dsplice.spark.executor.extraClassPath=/opt/cloudera/parcels/CDH/lib/hbase/conf:/opt/cloudera/parcels/CDH/jars/htrace-core-3.1.0-incubating.jar -Dsplice.spark.ui.retainedJobs=100 -Dsplice.spark.ui.retainedStages=100 -Dsplice.spark.worker.ui.retainedExecutors=100 -Dsplice.spark.worker.ui.retainedDrivers=100 -Dsplice.spark.streaming.ui.retainedBatches=100 -Dsplice.spark.executor.cores=4 -Dsplice.spark.executor.memory=8g -Dspark.compaction.reserved.slots=4 -Dsplice.spark.eventLog.enabled=true -Dsplice.spark.eventLog.dir=hdfs:///user/splice/history -Dsplice.spark.local.dir=/tmp -Dsplice.spark.yarn.jars=/opt/cloudera/parcels/SPLICEMACHINE/lib/*
</code></pre></div>
<p class="indentLevel1" style="text-align: left;">If you&rsquo;re using a version of the Spark Shuffle service earlier than 2.2, set the Java Configuration Options for HBase Master to this instead:</p>
<div class="preWrapperWide">
<pre class="Example"><code>-XX:MaxPermSize=512M -XX:+HeapDumpOnOutOfMemoryError -XX:MaxDirectMemorySize=2g -XX:+AlwaysPreTouch -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=70 -XX:+CMSParallelRemarkEnabled -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=10101 -Dsplice.spark.enabled=true -Dsplice.spark.app.name=SpliceMachine -Dsplice.spark.master=yarn-client -Dsplice.spark.logConf=true -Dsplice.spark.yarn.maxAppAttempts=1 -Dsplice.spark.driver.maxResultSize=1g -Dsplice.spark.driver.cores=2 -Dsplice.spark.yarn.am.memory=1g -Dsplice.spark.dynamicAllocation.enabled=true -Dsplice.spark.dynamicAllocation.executorIdleTimeout=120 -Dsplice.spark.dynamicAllocation.cachedExecutorIdleTimeout=120 -Dsplice.spark.dynamicAllocation.minExecutors=0 -Dsplice.spark.dynamicAllocation.maxExecutors=12 -Dsplice.spark.io.compression.lz4.blockSize=32k -Dsplice.spark.kryo.referenceTracking=false -Dsplice.spark.kryo.registrator=com.splicemachine.derby.impl.SpliceSparkKryoRegistrator -Dsplice.spark.kryoserializer.buffer.max=512m -Dsplice.spark.kryoserializer.buffer=4m -Dsplice.spark.locality.wait=100 -Dsplice.spark.memory.fraction=0.5 -Dsplice.spark.scheduler.mode=FAIR -Dsplice.spark.serializer=org.apache.spark.serializer.KryoSerializer -Dsplice.spark.shuffle.compress=false -Dsplice.spark.shuffle.file.buffer=128k -Dsplice.spark.shuffle.service.enabled=true  -Dsplice.spark.yarn.am.extraLibraryPath=/opt/cloudera/parcels/CDH/lib/hadoop/lib/native -Dsplice.spark.yarn.am.waitTime=10s -Dsplice.spark.yarn.executor.memoryOverhead=2048 -Dsplice.spark.driver.extraJavaOptions=-Dlog4j.configuration=file:/etc/spark/conf/log4j.properties -Dsplice.spark.driver.extraLibraryPath=/opt/cloudera/parcels/CDH/lib/hadoop/lib/native -Dsplice.spark.driver.extraClassPath=/opt/cloudera/parcels/CDH/lib/hbase/conf:/opt/cloudera/parcels/CDH/jars/htrace-core-3.1.0-incubating.jar -Dsplice.spark.executor.extraLibraryPath=/opt/cloudera/parcels/CDH/lib/hadoop/lib/native -Dsplice.spark.executor.extraClassPath=/opt/cloudera/parcels/CDH/lib/hbase/conf:/opt/cloudera/parcels/CDH/jars/htrace-core-3.1.0-incubating.jar -Dsplice.spark.ui.retainedJobs=100 -Dsplice.spark.ui.retainedStages=100 -Dsplice.spark.worker.ui.retainedExecutors=100 -Dsplice.spark.worker.ui.retainedDrivers=100 -Dsplice.spark.streaming.ui.retainedBatches=100 -Dsplice.spark.executor.cores=4 -Dsplice.spark.executor.memory=8g -Dspark.compaction.reserved.slots=4 -Dsplice.spark.eventLog.enabled=true -Dsplice.spark.eventLog.dir=hdfs:///user/splice/history -Dsplice.spark.local.dir=/tmp -Dsplice.spark.yarn.jars=/opt/cloudera/parcels/SPLICEMACHINE/lib/*
</code></pre></div></li>
<li>
<p style="text-align: left;">Set the value of Java Configuration Options for Region Servers:</p>
<div class="preWrapperWide">
<pre class="Example"><code>-XX:+HeapDumpOnOutOfMemoryError -XX:MaxDirectMemorySize=2g -XX:MaxPermSize=512M -XX:+AlwaysPreTouch -XX:+UseG1GC -XX:MaxNewSize=4g -XX:InitiatingHeapOccupancyPercent=60 -XX:ParallelGCThreads=24 -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=5000 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=10102
</code></pre></div></li>
<li>
<p style="text-align: left;">Click the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Save Changes</span><span>&nbsp;</span>button.</p></li></ol></div>
<h2>Optional Configuration Modifications</h2>
<p style="text-align: left;">There are a few configuration modifications you might want to make:</p>
<ul>
<li><a style="text-decoration: underline;" href="onprem_install_cloudera.html#Modify">Modify the Authentication Mechanism</a><span>&nbsp;</span>if you want to authenticate users with something other than the default<span>&nbsp;</span><em>native authentication</em>mechanism.</li>
<li><a style="text-decoration: underline;" href="onprem_install_cloudera.html#Logging">Modify the Log Location</a><span>&nbsp;</span>if you want your Splice Machine log entries stored somewhere other than in the logs for your region servers.</li></ul>
<h3>Modify the Authentication Mechanism</h3>
<p style="text-align: left;">Splice Machine installs with Native authentication configured; native authentication uses the<span>&nbsp;</span><code>sys.sysusers</code><span>&nbsp;</span>table in the<span>&nbsp;</span><code>splice</code><span>&nbsp;</span>schema for configuring user names and passwords.</p>
<p style="text-align: left;">You can disable authentication or change the authentication mechanism that Splice Machine uses to LDAP by following the simple instructions in<span>&nbsp;</span><a style="text-decoration: underline;" href="onprem_install_configureauth.html">Configuring Splice Machine Authentication</a></p>
<p style="text-align: left;">You can use<span>&nbsp;</span><a style="text-decoration: underline;" href="https://www.cloudera.com/documentation/enterprise/5-8-x/topics/cm_sg_intro_kerb.html">Cloudera&rsquo;s Kerberos Wizard</a><span>&nbsp;</span>to enable Kerberos mode on a CDH5.8.x cluster. If you&rsquo;re enabling Kerberos, you need to add this option to your HBase Master Java Configuration Options:</p>
<div class="preWrapper">
<pre class="Example"><code>-Dsplice.spark.hadoop.fs.hdfs.impl.disable.cache=true
</code></pre></div>
<h3>Modify the Log Location</h3>
<p style="text-align: left;">Splice Machine logs all SQL statements by default, storing the log entries in your region server&rsquo;s logs, as described in our<span>&nbsp;</span><a style="text-decoration: underline;" href="developers_tuning_logging">Using Logging</a><span>&nbsp;</span>topic. You can modify where Splice Machine stroes logs by adding the following snippet to your<span>&nbsp;</span><em>RegionServer Logging Advanced Configuration Snippet (Safety Valve)</em><span>&nbsp;</span>section of your HBase Configuration:</p>
<div class="preWrapper">
<pre class="Plain"><code>log4j.appender.spliceDerby=org.apache.log4j.FileAppender
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
</code></pre></div>
<h2>Deploy the Client Configuration</h2>
<p style="text-align: left;">Now that you&rsquo;ve updated your configuration information, you need to deploy it throughout your cluster. You should see a small notification in the upper right corner of your screen that looks like this:</p>
<p style="text-align: left;"><ac:image ac:class="nestedTightSpacing" ac:alt="Clicking the button to tell Cloudera to redeploy the client
configuration"><ri:url ri:value="images/CDH.StaleConfig.png" /></ac:image></p>
<p style="text-align: left;">To deploy your configuration:</p>
<div class="opsStepsList" style="text-align: left;">
<ol class="boldFont">
<li>Click the notification.</li>
<li>Click the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Deploy Client Configuration</span><span>&nbsp;</span>button.</li>
<li>When the deployment completes, click the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Finish</span><span>&nbsp;</span>button.</li></ol></div>
<h2>Restart the Cluster</h2>
<p style="text-align: left;">As a first step, we stop the services that we&rsquo;re about to configure from the Cloudera Manager home screen:</p>
<div class="opsStepsList" style="text-align: left;">
<ol class="boldFont">
<li>
<p class="topLevel" style="text-align: left;">Restart ZooKeeper</p>
<p class="indentLevel1" style="text-align: left;">Select<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Start</span><span>&nbsp;</span>from the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Actions</span><span>&nbsp;</span>menu in the upper right corner of the ZooKeeper<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Configuration</span><span>&nbsp;</span>tab to restart ZooKeeper.</p></li>
<li>
<p class="topLevel" style="text-align: left;">Restart HDFS</p>
<p class="indentLevel1" style="text-align: left;">Click the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">HDFS Actions</span><span>&nbsp;</span>drop-down arrow associated with (to the right of) HDFS in the cluster summary section of the Cloudera Manager home screen, and then click<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Start</span><span>&nbsp;</span>to restart HDFS.</p>
<p class="indentLevel1" style="text-align: left;">Use your terminal window to create these directories (if they are not already available in HDFS):</p>
<div class="preWrapperWide">
<pre class="ShellCommand"><code>sudo -iu hdfs hadoop fs -mkdir -p hdfs:///user/hbase hdfs:///user/splice/history
sudo -iu hdfs hadoop fs -chown -R hbase:hbase hdfs:///user/hbase hdfs:///user/splice
sudo -iu hdfs hadoop fs -chmod 1777 hdfs:///user/splice hdfs:///user/splice/history
</code></pre></div></li>
<li>
<p class="topLevel" style="text-align: left;">Restart YARN</p>
<p class="indentLevel1" style="text-align: left;">Click the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">YARN Actions</span><span>&nbsp;</span>drop-down arrow associated with (to the right of) YARN in the cluster summary section of the Cloudera Manager home screen, and then click<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Start</span><span>&nbsp;</span>to restart YARN.</p></li>
<li>
<p class="topLevel" style="text-align: left;">Restart HBase</p>
<p class="indentLevel1" style="text-align: left;">Click the<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">HBASE Actions</span><span>&nbsp;</span>drop-down arrow associated with (to the right of) HBASE in the cluster summary section of the Cloudera Manager home screen, and then click<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">Start</span><span>&nbsp;</span>to restart HBase.</p></li></ol></div>
<h2>Verify your Splice Machine Installation</h2>
<p style="text-align: left;">Now start using the Splice Machine command line interpreter, which is referred to as<span>&nbsp;</span><em>the splice prompt</em><span>&nbsp;</span>or simply<span>&nbsp;</span><span class="AppCommand" style="color: inherit;">splice&gt;</span><span>&nbsp;</span>by launching the<span>&nbsp;</span><code>sqlshell.sh</code><span>&nbsp;</span>script on any node in your cluster that is running an HBase region server.</p>
<p class="noteNote" style="text-align: left;">The command line interpreter defaults to connecting on port<span>&nbsp;</span><code>1527</code><span>&nbsp;</span>on<span>&nbsp;</span><code>localhost</code>, with username<span>&nbsp;</span><code>splice</code>, and password<span>&nbsp;</span><code>admin</code>. You can override these defaults when starting the interpreter, as described in the<span>&nbsp;</span><a style="text-decoration: underline;" href="cmdlineref_intro.html">Command Line (splice&gt;) Reference</a><span>&nbsp;</span>topic in our<span>&nbsp;</span><em>Developer&rsquo;s Guide</em>.</p>
<p style="text-align: left;">Now try entering a few sample commands you can run to verify that everything is working with your Splice Machine installation.</p>
<table class="wrapped"><colgroup><col /><col /></colgroup>
<thead>
<tr>
<th style="text-align: left;">Operation</th>
<th style="text-align: left;">Command to perform operation</th></tr></thead>
<tbody>
<tr>
<td style="text-align: left;">Display tables</td>
<td style="text-align: left;">
<div class="preWrapperWide">
<pre class="AppCommandCell">splice&gt; show tables;</pre></div></td></tr>
<tr>
<td style="text-align: left;">Create a table</td>
<td style="text-align: left;">
<div class="preWrapperWide">
<pre class="AppCommandCell">splice&gt; create table test (i int);</pre></div></td></tr>
<tr>
<td style="text-align: left;">Add data to the table</td>
<td style="text-align: left;">
<div class="preWrapperWide">
<pre class="AppCommandCell">splice&gt; insert into test values 1,2,3,4,5;</pre></div></td></tr>
<tr>
<td style="text-align: left;">Query data in the table</td>
<td style="text-align: left;">
<div class="preWrapperWide">
<pre class="AppCommandCell">splice&gt; select * from test;</pre></div></td></tr>
<tr>
<td style="text-align: left;">Drop the table</td>
<td style="text-align: left;">
<div class="preWrapperWide">
<pre class="AppCommandCell">splice&gt; drop table test;</pre></div></td></tr>
<tr>
<td style="text-align: left;">List available commands</td>
<td style="text-align: left;">
<div class="preWrapperWide">
<pre class="AppCommandCell">splice&gt; help;</pre></div></td></tr>
<tr>
<td style="text-align: left;">Exit the command line interpreter</td>
<td style="text-align: left;">
<div class="preWrapperWide">
<pre class="AppCommandCell">splice&gt; exit;</pre></div></td></tr>
<tr>
<td style="text-align: left;" colspan="2"><strong>Make sure you end each command with a semicolon</strong><span>&nbsp;</span>(<code>;</code>), followed by the<span>&nbsp;</span><em>Enter</em><span>&nbsp;</span>key or<span>&nbsp;</span><em>Return</em><span>&nbsp;</span>key</td></tr></tbody></table>
<p style="text-align: left;">See the<span>&nbsp;</span><a style="text-decoration: underline;" href="http://docstest.splicemachine.com/cmdlineref_intro.html">Command Line (splice&gt;) Reference</a><span>&nbsp;</span>section of our<span>&nbsp;</span><em>Developer&rsquo;s Guide</em><span>&nbsp;</span>for information about our commands and command syntax.</p></div>
</div>
</section>
