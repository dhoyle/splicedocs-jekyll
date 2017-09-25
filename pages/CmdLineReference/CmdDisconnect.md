---
title: Disconnect command
summary: Disconnects from a database.
keywords: disconnecting
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_disconnect.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Disconnect Command

The <span class="AppCommand">disconnect</span> command disconnects from
a database. It issues a `java.sql.Connection.close` request for the
current connection, or for the connection(s) specified on the command
line.

Note that disconnecting from a database does not stop the command line
interface or shut down Splice Machine. You can use the
[exit](cmdlineref_exit.html) command to close out of the command line
interface.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    DISCONNECT [ALL | CURRENT | connectionIdentifier]
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
ALL
{: .paramName}

All known connections are closed; as a result, there will not be a
current connection.
{: .paramDefnFirst}

CURRENT
{: .paramName}

The current connection is closed. This is the default behavior.
{: .paramDefnFirst}

connectionIdentifier
{: .paramName}

The name of the connection to close; this must be same identifier
assigned when the connection was opened with a
[Connect](cmdlineref_connect.html) command.
{: .paramDefnFirst}

</div>
## Examples

<div class="preWrapper" markdown="1">
    splice> connect 'jdbc:splice://xyz:1527/splicedb';
    splice> -- we create a new table in splicedb:
    CREATE TABLE menu(course CHAR(10), ITEM char(20), PRICE integer);
    0 rows inserted/updated/deleted
    splice> disconnect;
    splice>
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>

