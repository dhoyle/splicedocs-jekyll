---
title: Show Schemas command
summary: Displays information about the schemas in the current connection.
keywords: schema, show commands
toc: false
product: all
sidebar: home_sidebar
permalink: cmdlineref_showschemas.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Show Schemas

The <span class="AppCommand">show schemas</span> command displays all of
the schemas for which the current user has `ACCESS` privileges.

### Syntax

<div class="fcnWrapperWide" markdown="1">
    SHOW SCHEMAS
{: .FcnSyntax xml:space="preserve"}

</div>
### Examples

<div class="preWrapperWide" markdown="1">
    splice> show schemas;
    TABLE_SCHEM
    ------------------------------
    NULLID
    SPLICE
    SQLJ
    SYS
    SYSCAT
    SYSCS_DIAG
    SYSCS_UTIL
    SYSFUN
    SYSIBM
    SYSPROC
    SYSSTAT
    11 rows selected
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>
