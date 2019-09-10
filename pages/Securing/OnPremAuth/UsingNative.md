---
title: Using Splice Machine Native Authentication
summary: Using Native Authentication
keywords: native
toc: false
product: all
sidebar: home_sidebar
permalink: tutorials_security_usingnative.html
folder: Securing/OnPremAuth
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Using NATIVE Authentication

Native authentication is the default mechanism for Splice Machine; you
don't need to modify your configuration if you wish to use it. Native
authentication uses the `SYS.SYSUSERS` table for configuring user names and passwords.

<div class="noteIcon" markdown="1">
Access to the system tables that store backup information (actually, to the entire `SYS` schema) is restricted, for security purposes, to users for whom your Database Administrator has explicitly granted access.

If you attempt to select information from a table such as `SYS.SYSBACKUP` and you don't have access, you'll see a message indicating that _"No schema exists with the name `SYS`."_&nbsp; If you believe you need access, please request
 `SELECT` privileges from your administrator.
</div>

The default native authentication property settings are:
{: .noSpaceAbove}

<div class="preWrapperWide" markdown="1">
    <property>
        <name>splice.authentication</name>
        <value>NATIVE</value>
    </property>
    <property>
        <name>splice.authentication.native.algorithm</name>
        <value>SHA-512</value>
    </property>
{: .ExampleCell xml:space="preserve"}

</div>
You can use `MD5`, `SHA-256`, or `SHA-512` for the value of the <span
class="HighlightedCode">native.algorithm</span> property; `SHA-512` is
the default value.

## Switching to Native Authentication

If you are switching your authentication from to `NATIVE` authentication
from another mechanism (including `NONE`), there's one additional step
you need to take: you must re-initialize the credentials database
(`SYSUSERS` table), by adding the following property setting to your
configuration file:

<div class="preWrapperWide" markdown="1">
    <property>
        <name>splice.authentication.native.create.credentials.database</name>
        <value>true</value>
    </property>
{: .Example}

</div>

</div>
</section>
