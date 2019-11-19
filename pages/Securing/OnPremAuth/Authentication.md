---
title: Configuring Splice Machine Authentication
summary: Describes how to configure and manage Splice Machine, which offers several different authentication mechanisms, including LDAP.
keywords: authenticate, credentials, configuring, native authentication, ldap
toc: false
compatible_version: 2.7
product: onprem
sidebar: home_sidebar
permalink: tutorials_security_authentication.html
folder: Securing/OnPremAuth
---

<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice Machine Authentication

This topic provides top-level information about the authentiation mechanisms you can use with Splice Machine and how to access the configuration files used for authentication, in these sections:

* [Supported Authentication Mechanisms](#mechanisms)
* [Configuring Authentication on Your Platform](#platforms)
* [Disabling Authentication](#disabling)

{% include splice_snippets/onpremonlytopic.md %}

## Supported Authentication Mechanisms   {#mechanisms}

You can use any of the following authentication mechanisms with Splice Machine; click the mechanism name link to navigate to a topic page that describes how to configure and use the mechanism.

<table summary="Descriptions of available authentication mechanisms.">
    <col />
    <col />
    <thead>
        <tr>
            <th>Authentication Mechanism</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>None</code></td>
            <td>Any user ID and password combination is allowed to connect to database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_security_usingnative.html">NATIVE</a></td>
            <td>
                <p>User IDs in a database table are validated against the corresponding, encrypted password.</p>
                <p>This is the default authentication setting for Splice Machine installations.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_security_usingkerberos.html">KERBEROS</a></td>
            <td>
                <p>User IDs are validated against a Kerberos server.</p>
{% include splice_snippets/enterpriseonly_note.md %}
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="tutorials_security_usingldap.html">LDAP</a></td>
            <td>
                <p>User IDs are validated against an existing LDAP service.</p>
{% include splice_snippets/enterpriseonly_note.md %}
            </td>
        </tr>
    </tbody>
</table>

## Configuring Authentication on Your Platform   {#platforms}
You can configure authentication for your Splice Machine database by adding or modifying properties in your HBase configuration file.
The location of the configuration file you need to modify depends on which platform you're using:

{% include splicevars.html %}
<table summary="Instructions for configuring Splice Machine authentication for your platform.">
    <col />
    <col />
    <thead>
        <tr>
            <th>Platform</th>
            <th>Configuration file to modify with your authentication properties</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>CDH</td>
            <td class="CodeFont">{{splvar_location_CDHAuthSettings}}</td>
        </tr>
        <tr>
            <td>HDP</td>
            <td>{{splvar_location_HDPAuthSettings}}</td>
        </tr>
        <tr>
            <td>MapR</td>
            <td class="CodeFont">{{splvar_location_MapRAuthSettings}}</td>
        </tr>
        <tr>
            <td>Standalone version</td>
            <td class="CodeFont">{{splvar_location_StandaloneAuthSettings}}</td>
        </tr>
    </tbody>
</table>

Specific property settings are listed on the topic page for each authentication mechanism, as listed in the previous section.

## Disabling Authentication   {#disabling}

To disable authentication for your Splice Machine database, set the `splice.authentication`
property in your configuration file to `NONE`:

<div class="preWrapperWide" markdown="1">
    <property>
       <name>splice.authentication</name>
       <value>NONE</value>
    </property>
{: .ExampleCell xml:space="preserve"}
</div>


Splice Machine **strongly encourages you to not use an open database**
for production databases!
{: .noteIcon}

</div>
</section>
