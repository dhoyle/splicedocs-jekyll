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
authentication uses the `sys.sysusers` table in the `splice` schema for
configuring user names and passwords.

{% include splice_snippets/tblaccess1.md %}

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
