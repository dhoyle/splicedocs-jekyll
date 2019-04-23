---
title: Set Connection command
summary: Allows you to specify which connection is the current connection
keywords: connections
toc: false
product: all
sidebar: home_sidebar
permalink: cmdlineref_setconnection.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Set Connection Command

The <span class="AppCommand">set connection</span> command allows you to
specify which connection is the current connection, when you have more
than one connection open.

If the specified connection does not exist, an error results, and the
current connection is unchanged.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SET CONNECTION Identifier
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
Identifier
{: .paramName}

The name of the connection that you want to be the current connection.
{: .paramDefnFirst}

</div>
## Examples

<div class="preWrapperWide" markdown="1">
    splice> connect 'jdbc:splice://abc:1527/splicedb;user=YourUserId;password=YourPassword' as sample1;
    splice> connect 'jdbc:splice://xyz:1527/splicedb' as sample2;
    splice (NEWDB)> show connections;
    SAMPLE1 -    jdbc:splice://abc:1527/splicedb
    SAMPLE2* -   jdbc:splice://xyz:1527/splicedb
    * = current connection
    splice(SAMPLE2)> set connection sample1;
    splice(SAMPLE1)> disconnect all;
    splice>
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>
