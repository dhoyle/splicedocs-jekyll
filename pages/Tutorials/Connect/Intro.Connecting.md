---
title: Connecting Your Splice Machine Database
summary: How to connect your Splice Machine database with third party database and business intelligence tools.
keywords: connect tutorial
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_connect_intro.html
folder: Tutorials/Connect
---
\{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Connecting Your Splice Machine Database

This topic introduces you to our JDBC and ODBC drivers, and then links
to mini-tutorials that walk you through using our drivers with various
programming and Business Intelligence tools, in the following sections:

* [The Splice Machine JDBC Driver](#The) introduces our JDBC driver.
* [The Splice Machine ODBC Driver](#The2) introduces our ODBC driver.
* [Default Driver Connection Parameters](#Default) shows the default
  connection parameters for our drivers.
* [Connecting with Programming Tools](#Connecti) links to mini-tutorials
  that show you how to connect to Splice Machine from various
  programming languages.
* [Connecting with Business Intelligence Tools](#Connecti2) links to
  mini-tutorials that show you how to connect your favorite Business
  Intelligence tools to Splice Machine.

## The Splice Machine JDBC Driver   {#The}

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
                        <td><code>/splicemachine/jdbc-driver/{{splvar_platform_JDBCDriverJar}}</code></td>
                    </tr>
                    <tr>
                        <td><strong>Windows</strong></td>
                        <td><code>C:\splicemachine\jdbc-driver\{{splvar_platform_JDBCDriverJar}}</code></td>
                    </tr>
                </tbody>
            </table>
## The Splice Machine ODBC Driver   {#The2}

You need to install the Splice Machine ODBC driver on the computer on
which want to use it; we provide detailed installation instructions for
both Unix and Windows computers in our Developer's Guide.

You **must** use the *Splice Machine* JDBC and ODBC drivers to connect
with your Splice Machine database; other drivers will not work
correctly.
{: .noteImportant}

## Default Driver Connection Parameters   {#Default}

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
## Connecting with Programming Tools   {#Connecti}

Here are links to tutorials to help you to use our drivers to connect to
Splice Machine using your favorite programming languages and tools:

<table>
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Splice Machine Driver</th>
                        <th>Tutorial Links</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>JDBC Driver</td>
                        <td>
                            <ul class="bulletCell">
                                <li><a href="tutorials_connect_java.html">Connecting With Java and JDBC</a>
                                </li>
                                <li><a href="tutorials_connect_jython.html">ConnectingWith Jython and JDBC</a>
                                </li>
                                <li><a href="tutorials_connect_jruby.html">Connecting With JRuby with JDBC</a>
                                </li>
                                <li><a href="tutorials_connect_scala.html">Connecting With Scala with JDBC</a>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td>ODBC Driver</td>
                        <td>
                            <ul class="bulletCell">
                                <li><a href="tutorials_connect_odbcc.html">Connecting With C and ODBC</a>
                                </li>
                                <li><a href="tutorials_connect_python.html">Connecting With Python and ODBC</a>
                                </li>
                            </ul>
                        </td>
                    </tr>
                </tbody>
            </table>
## Connecting with Business Intelligence Tools   {#Connecti2}

Here are links to tutorials to help you to use our drivers to connect
specific business intelligence tools to Splice Machine:

<table>
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Splice Machine Driver</th>
                        <th>Tutorial Links</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>JDBC Driver</td>
                        <td>
                            <ul class="bulletCell">
                                <li><a href="tutorials_connect_squirrel.html">Connecting Squirrel</a>
                                </li>
                                <li><a href="tutorials_connect_dbeaver.html">Connecting DBeaver</a>
                                </li>
                                <li><a href="tutorials_connect_dbvisualizer.html">Connecting DBVisualizer</a>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td>ODBC Driver</td>
                        <td>
                            <ul class="bulletCell">
                                <li><a href="tutorials_connect_tableau.html">Connecting Tableau</a>
                                </li>
                                <li><a href="tutorials_connect_cognos.html">Connecting Cognos</a>
                                </li>
                            </ul>
                        </td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

