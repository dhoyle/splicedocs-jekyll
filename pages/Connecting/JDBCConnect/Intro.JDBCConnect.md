---
title: Connecting to Splice Machine with JDBC
summary: Examples of using JDBC to connect with Splice Machine from various programming languages.
keywords: JDBC
toc: false
product: all
sidebar: home_sidebar
permalink: tutorials_connectjdbc_intro.html
folder: Connecting/JDBCConnect
---
{% include splicevars.html %}
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Connecting to Splice Machine with JDBC

This section introduces our JDBC driver and shows you how to connect to Splice Machine via JDBC with various programming languages, including:

* [About our JDBC Driver](#JDBCDriver)
* [Default Connection Parameters](#DefaultParams)
* [Connecting with Java via JDBC](tutorials_connect_java.html)
* [Connecting with JRuby via JDBC](tutorials_connect_jruby.html)
* [Connecting with Jython via JDBC](tutorials_connect_jython.html)
* [Connecting with Python via JDBC](tutorials_connect_python.html)
* [Connecting with R via JDBC](tutorials_connectjdbc_r.html)
* [Connecting with Scala via JDBC](tutorials_connect_scala.html)
* [Connecting with AngularJS/NodeJS via JDBC](tutorials_connect_angular.html)

## The Splice Machine JDBC Driver   {#JDBCDriver}

Our JDBC driver is automatically installed on your computer(s) when
you install Splice Machine. You'll find it in the <span
class="CodeFont">jdbc-driver</span> folder under the `splicemachine`
directory; typically:

<div class="PreWrapperWide" markdown="1">
    /splicemachine/jdbc-driver/{{splvar_jdbc_jarloc}}
{: .Example}
</div>
You can also download the driver from our JDBC Download site:
<div class="indented">
    <a href="{{splvar_jdbc_dllink}}" target="_blank">{{splvar_jdbc_dllink}}.</a>
</div>

You **must** use the *Splice Machine* JDBC driver to connect
with your Splice Machine database; other JDBC drivers will not work
correctly.
{: .noteIcon}

## Default Driver Connection Parameters   {#DefaultParams}

The following table shows the default connection values you use with
Splice Machine.

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
            <td>Substitute your own user ID</td>
        </tr>
        <tr>
            <td><em>Password</em></td>
            <td>Substitute your own password</td>
        </tr>
        <tr>
            <td><em>Database name</em></td>
            <td><code>splicedb</code></td>
        </tr>
    </tbody>
</table>

</div>
</section>
