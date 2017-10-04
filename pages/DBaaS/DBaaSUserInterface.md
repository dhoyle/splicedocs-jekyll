---
title: Splice Machine User Interface Overview
summary: An overview of the Splice Machine Cloud Managed Database Service.
keywords: dbaas, Service, user interface, cloud manager, account manager, events manager, ui for service
sidebar:  dbaas_sidebar
toc: false
product: all
permalink: dbaas_uioverview.html
folder: DBaaS
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Database Service User Interface

{% include splice_snippets/dbaasonlytopic.md %}
In addition to our our database, the Splice Machine Database Service
includes all of the tools you need to create your cluster, load data
into your database, query and manipulate your database, and create
visual representations of your query results, as described here:

<table>
                <col />
                <col />
                <thead>
                    <tr>
                        <th>UI Component</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Dashboard</td>
                        <td>The <a href="dbaas_cm_intro.html">Splice Machine Dashboard</a> or <span class="ConsoleLink">Cloud Manager</span> is your entry point to your Database Service. You can register and log into your account here, as well as accessing the other managers described in this table.</td>
                    </tr>
                    <tr>
                        <td>Cluster Manager</td>
                        <td>Use the <a href="dbaas_cm_initialstartup.html">Cluster Manager</a> to create new clusters and to monitor the health of your clusters.</td>
                    </tr>
                    <tr>
                        <td>Notebooks Manager</td>
                        <td><a href="dbaas_zep_intro.html">Apache Zeppelin notebooks</a> make it easy to query your database and apply various visualizations to the results of your queries. We've created several notebooks that will help you to quickly become productive and to see how easy it is to create your own notebooks.</td>
                    </tr>
                    <tr>
                        <td>Database Console</td>
                        <td>The <a href="dbconsole_intro.html">Database Console</a> is a browser-based tool that you can use to monitor database queries on your cluster in real time. The Console UI allows you to see the Spark queries that are currently running in Splice Machine on your cluster, and to then drill down into each job to see the current progress of the queries, and to identify any potential bottlenecks. If you see something amiss, you can also terminate a query.</td>
                    </tr>
                    <tr>
                        <td>Events Manager</td>
                        <td>Our <span class="ConsoleLink">Events Manager</span> allows you to examine events that have occurred on your cluster.</td>
                    </tr>
                    <tr>
                        <td>Account Manager</td>
                        <td>The <a href="dbaas_cm_acctmanage.html">Splice Machine Account Manager</a> is where you manage your users, your profile, and your billing information.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

