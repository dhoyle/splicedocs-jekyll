---
summary: Introduction to the Splice Machine DBaaS User Interface
title: Introduction
keywords: dbaas, paas, cloud manager, ui, user interface
toc: false
product: all
sidebar: home_sidebar
permalink: dbaas_cm_intro.html
folder: DBaaS/CloudManager
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice Machine Cloud Manager

This guide helps you to get registered with and start using the Splice
Machine Cloud Manager. Here are the topics included in this guide:

<table>
    <col width="25%" />
    <col />
    <thead>
        <tr>
            <th>Topic</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><em><a href="dbaas_cm_dashboard.html">Navigating Your Dashboard</a></em></td>
            <td>Your <span class="ConsoleLink">Dashboard</span> is the entry point to the Splice Machine Cloud Manager. From here, you can create new clusters, access existing clusters, manage your account, review notifications, update your profile, and log out.</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="dbaas_cm_registration.html">Registering</a>
            </td>
            <td>Shows you how to complete the first step of using your database service: registering as a user of the Splice Machine Cloud Manager.</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="dbaas_cm_login.html">Logging In</a>
            </td>
            <td>Shows you how to log into the Splice Machine Cloud Manager once you've registered.</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="dbaas_cm_initialstartup.html">Creating a New Cluster</a>
            </td>
            <td>Follow this steps in this topic to quickly become productive with your clustered database. In only a few minutes, you'll have your cluster up and running, and will be able to load and work with your data.</td>
        </tr>
        <tr>
            <td><em><a href="bestpractices_ingest_overview.html">Best Practices: Ingesting Data</a></em></td>
            <td>
                <p>You can load your data into Splice Machine from Azure Storage or an AWS S3 bucket:</p>
                <ul>
                    <li>For information about uploading data to S3, please check our <a href="developers_cloudconnect_uploadtos3">Uploading Data to an S3 Bucket</a> tutorial. You may need to configure your Amazon IAM permissions to allow Splice Machine to access your bucket; see our <a href="developers_cloudconnect_configures3">Configuring an S3 Bucket for Splice Machine Access</a> tutorial.</li>
                    <li> To configure Azure Storage for use with Splice Machine, see our <a href="developers_cloudconnect_configureazure.html">Using Azure Storage</a> tutorial.</li>
                    <li>Once you've got your data uploaded, you can follow our <a href="bestpractices_ingest_overview.html">Best Practices: Ingesting Data</a> topic to load that data into Splice Machine.</li>
                </ul>
                <p>Also note that the directory you specify for the log of record import issues (the <em>bad record</em> directory), must be write-accessible using the same credentials that apply to the input directory.</p>
            </td>
        </tr>
        <tr>
            <td><em><a href="tutorials_dbconsole_intro.html">Using the DB Console</a></em></td>
            <td>
                <p>The <span class="ConsoleLink">Splice Machine Database Console</span> is a browser-based tool that you can use to monitor database queries on your cluster in real time. The Console UI allows you to see the Spark queries that are currently running in Splice Machine on your cluster, and to then drill down into each job to see the current progress of the queries, and to identify any potential bottlenecks. If you see something amiss, you can also terminate a query.</p>
				<p>The DB Console is available for all Splice Machine products; you access the Splice DB Console for the Database-as-Service product by clicking the <span class="ConsoleLink">DB Console</span> link in your Cluster Management dashboard, or by following the link sent to you by Splice Machine when your cluster was originally created.</p>
				<p class="noteIcon">The <span class="ConsoleLink">DB Console</span> link in your Cluster Management dashboard allows you to monitor Splice Machine jobs running on your cluster. If you are running non-Splice jobs, you'll need to use a different console to monitor them; you'll find a link to this <span class="ConsoleLink">External Spark Console</span> in the bottom left corner of your cluster dashboard.</p>
            </td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="dbaas_zep_intro.html">Using the Notebooks Manager</a>
            </td>
            <td>
                <p>One of the great features of our database service is the ease with which you can use Apache Zeppelin notebooks to interact with your database. Our <span class="ConsoleLink">Notebooks Manager</span> provides convenient access to your notebooks, and to information about using Zeppelin.</p>
                <p>This tutorial walks you through using a notebook created by Splice Machine that:</p>
                <ul>
                    <li>Creates a schema and the tables in your database to store the TPCH-1 benchmarks data.</li>
                    <li>Loads the data from an S3 bucket into your database.</li>
                    <li>Runs any or all of the TPCH-1 queries</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="dbaas_cm_acctmanage.html">Managing Your Account</a>
            </td>
            <td>Use our Account Manager to manage your company profile, billing, and users.</td>
        </tr>
        <tr>
            <td class="ItalicFont"><a href="dbaas_cm_eventsmgr.html">Reviewing Event Notifications</a>
            </td>
            <td>Use our Events Manager to review notification messages that have been sent to your account.</td>
        </tr>
    </tbody>
</table>
</div>
</section>
