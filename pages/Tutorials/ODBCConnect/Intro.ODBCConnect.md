---
title: Connecting to Splice Machine with ODBC
summary: How to install and use ODBC to connect with Splice Machine from various programming languages.
keywords: JDBC
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_connectodbc_intro.html
folder: Tutorials/ODBCConnect
---
{% include splicevars.html %}
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Connecting to Splice Machine with ODBC

This section introduces our ODBC Driver and shows you how to connect to Splice Machine via ODBC with various programming languages, including:

* [About our ODBC Driver](#ODBCDriver)
* [Default Connection Parameters](#DefaultParams)
* [Installing the Splice Machine ODBC Driver](tutorials_connect_odbcinstall.html)
* [Connecting With C via ODBC](tutorials_connect_odbcc.html)
* [Connecting With Python via ODBC](tutorials_connect_python.html)

## The Splice Machine ODBC Driver   {#ODBCDriver}

You need to install the Splice Machine ODBC driver on the computer on
which want to use it; we provide [detailed installation instructions](tutorials_connect_odbcinstall.html) for
Unix, MacOS, and Windows computers in our Developer's Guide.

You **must** use the *Splice Machine* ODBC driver to connect
with your Splice Machine database; other ODBC drivers will not work
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
            <td><p><span class="HighlightedCode">splice</span></p>
                <p>Substitute your own user ID.</p></td>
        </tr>
        <tr>
            <td><em>Password</em></td>
            <td><p><span class="HighlightedCode">admin</span></p>
                <p>Substitute your own password.</p></td>
</td>
        </tr>
        <tr>
            <td><em>Database name</em></td>
            <td><code>splicedb</code></td>
        </tr>
    </tbody>
</table>

</div>
</section>
