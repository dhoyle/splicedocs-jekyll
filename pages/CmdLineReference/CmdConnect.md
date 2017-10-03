---
title: Connect command
summary: Connect to a database via its URL.
keywords: connect, connecting, connectionUrlString
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_connect.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Connect Command

The <span class="AppCommand">connect</span> command connects to the
database specified by `ConnectionURLString`. It connects by issuing a
`getConnection` request with the specified URL, using
`java.sql.DriverManager `or `javax.sql.DataSource `to set the current
connection to that URL.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    CONNECT ConnectionURLString  [ AS Identifier ]
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
ConnectionURLString
{: .paramName}

The URL of the database. Note that this URL typically includes
connection parameters such as user name, password, or security options.
{: .paramDefnFirst}

Identifier
{: .paramName}

The optional name that you want to assign to the connection.
{: .paramDefnFirst}

</div>
If the connection succeeds, the connection becomes the current one and
all further commands are processed against the new, current connection.

## Example 1: Connecting on a Cluster

If you are running Splice Machine on a cluster, connect from a machine
that is NOT running an HBase RegionServer and specify the IP address of
a <span class="HighlightedCode">regionServer</span> node, e.g. <span
class="AppCommand">10.1.1.110</span>.

<div class="preWrapperWide" markdown="1">
    splice> connect 'jdbc:splice://regionServer:1527/splicedb';
{: .AppCommand xml:space="preserve"}

</div>
This example includes a user ID and password in the connection URL
string:

<div class="preWrapperWide" markdown="1">
    splice> connect 'jdbc:splice://1.2.3.456:1527/splicedb;user=splice;password=admin';
{: .AppCommand xml:space="preserve"}

</div>
And this example includes specifies that SSL peer authentication will be
enabled for the connection:

<div class="preWrapperWide" markdown="1">
    splice> connect 'jdbc:splice://1.2.3.456:1527/splicedb;user=splice;password=admin;ssl=peerAuthentication';
{: .AppCommand xml:space="preserve"}

</div>
You can only connect with SSL/TLS if your administrator has configured
this capability for you.
{: .noteNote}

## Example 2: Connecting to the Standalone Version

If you're using the standalone version of Splice Machine, specify <span
class="HighlightedCode">localhost</span> instead.

<div class="preWrapperWide" markdown="1">
    splice> connect 'jdbc:splice://localhost:1527/splicedb';
{: .AppCommand xml:space="preserve"}

</div>
Here is an example that includes a user ID and password in the connect
string:

<div class="preWrapperWide" markdown="1">
    splice> connect 'jdbc:splice://localhost:1527/splicedb;user=joey;password=bossman';
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>
