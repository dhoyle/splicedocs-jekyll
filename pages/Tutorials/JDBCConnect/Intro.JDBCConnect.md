---
title: Connecting to Splice Machine with JDBC
summary: Examples of using JDBC to connect with Splice Machine from various programming languages.
keywords: JDBC
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_connectjdbc_intro.html
folder: Tutorials/JDBCConnect
---
{% include splicevars.html %}
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Connecting to Splice Machine with JDBC

This section introduces our JDBC driver and shows you how to connect to Splice Machine via JDBC with various programming languages, including:

* [About our JDBC Driver](#JDBCDriver)
* [Default Connection Parameters](#DefaultParams)
* [Connecting with Java and JDBC](tutorials_connect_java.html)
* [Connecting with JRuby and JDBC](tutorials_connect_jruby.html)
* [Connecting with Jython and JDBC](tutorials_connect_jython.html)
* [Connecting with Scala and JDBC](tutorials_connect_scala.html)
* [Connecting with AngularJS/NodeJS and JDBC](tutorials_connect_angular.html)

## The Splice Machine JDBC Driver   {#JDBCDriver}

Our JDBC driver is automatically installed on your computer(s) when you
install Splice Machine. You'll find it in the `jdbc-driver` folder under
the `splicemachine` directory. Typical locations are:

<table summary="Locations of the JDBC driver.">
    <col />
    <col />
    <thead>
        <tr>
            <th>OS</th>
            <th>Driver Location</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong>Linux / MacOS</strong></td>
            <td><code>/splicemachine/jdbc-driver/{{splvar_jdbc_jarloc}}</code></td>
        </tr>
        <tr>
            <td><strong>Windows</strong></td>
            <td><code>C:\splicemachine\jdbc-driver\{{splvar_jdbc_jarloc}}</code></td>
        </tr>
    </tbody>
</table>

You **must** use the *Splice Machine* JDBC driver to connect
with your Splice Machine database; other JDBC drivers will not work
correctly.
{: .noteImportant}

## Default Driver Connection Parameters   {#DefaultParams}

The following table shows the default connection values you use with
Splice Machine. These values are used in all of the Splice Machine
connection tutorials:

<table summary="Table of default Splice Machine connection parameters.">
    <col />
    <col />
    <thead>
        <tr>
            <th>Connection Parameter</th>
            <th>Default Value</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><em>port</em></td>
            <td><code>1527</code></td>
        </tr>
        <tr>
            <td><em>User name</em></td>
            <td><code>splice</code></td>
        </tr>
        <tr>
            <td><em>Password</em></td>
            <td><code>admin</code></td>
        </tr>
        <tr>
            <td><em>Database name</em></td>
            <td><code>splicedb</code></td>
        </tr>
    </tbody>
</table>

</div>
</section>
