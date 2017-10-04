---
title: Show Connections command
summary: Displays information about active connections and database objects.
keywords: connections, show commands
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_showconnections.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Show Connections

The <span class="AppCommand">show connections</span> command displays a
list of connection names and the URLs used to connect to them. The name
of the current connection is marked with a trailing asterisk (`*`).

### Syntax

<div class="fcnWrapperWide" markdown="1">
    SHOW CONNECTIONS
{: .FcnSyntax xml:space="preserve"}

</div>
### Examples

<div class="preWrapperWide" markdown="1">
    splice> connect 'jdbc:splice://abc:1527/splicedb' as sample1;
    splice> connect 'jdbc:splice://xyz:1527/splicedb' as sample2;
    splice (NEWDB)> show connections;
    SAMPLE1 -    jdbc:splice://abc:1527/splicedb
    SAMPLE2* -   jdbc:splice://xyz:1527/splicedb
    * = current connection
    splice(NEWDB)>
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>

