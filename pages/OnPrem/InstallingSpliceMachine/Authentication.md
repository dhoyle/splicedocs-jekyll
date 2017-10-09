---
summary: Describes how to configure and manage Splice Machine, which offers several different authentication mechanisms, including LDAP.
title: Configuring Splice Machine Authentication
keywords: authenticate, credentials, configuring, native authentication, ldap
toc: false
product: onprem
sidebar:  onprem_sidebar
permalink: onprem_install_configureauth.html
folder: OnPrem/InstallingSpliceMachine
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Configuring Splice Machine Authentication

{% include splice_snippets/onpremonlytopic.md %}
This topic describes the mechanisms you can use in Splice Machine to
authenticate users and how to configure the mechanism you choose to use,
in these sections:

* [Supported Authentication Mechanisms](#Supporte)
* [Configuring Authentication](#Configur)

<div markdown="1">
## Supported Authentication Mechanisms   {#Supporte}

You can use one of the following authentication mechanisms, each of
which is described below the table:

<table summary="Descriptions of available authentication mechanisms.">
    <col style="width: 109px;" />
    <col style="width: 528px;" />
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
            <td><code>Native</code></td>
            <td>
                <p>User IDs in a database table are validated against the corresponding, encrypted password.</p>
                <p>This is the default authentication setting for Splice Machine installations.</p>
            </td>
        </tr>
        <tr>
            <td><code>LDAP</code></td>
            <td>
                <p>User IDs are validated against an existing LDAP service.</p>
{% include splice_snippets/enterpriseonly_note.md %}
            </td>
        </tr>
    </tbody>
</table>
## Configuring Authentication   {#Configur}

You configure Splice Machine authentication by adding or updating
properties in your HBase configuration file; this is typically done
during installation of Splice Machine, but you can modify your settings
whenever you want. This section contains the following subsections:

* [Locating Your Configuration File](#Locating)
* [Disabling Authentication](#Disablin)
* [Using Native Authentication](#Using)
* [Using LDAP Authentication](#Using2)

### Locating Your Configuration File   {#Locating}

{% include splicevars.html %}

The following table specifies the platform-specific location of the
configuration you need to update when changing your Splice Machine
authentication properties:

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
                <td>{{splvar_platform_v26_CDH5-AuthSettingsLoc}}
                </td>
            </tr>
            <tr>
                <td>HDP</td>
                <td><span class="splvar_platform_v26_HDP2-AuthSettingsLoc">Select the Custom HBase Configs option from the HBase configuration tab.</span>
                </td>
            </tr>
            <tr>
                <td>MapR</td>
                <td>
                    <p>{{splvar_platform_MapR-AuthSettingsLoc}}
                    </p>
                </td>
            </tr>
            <tr>
                <td>Standalone version</td>
                <td>{{splvar_platform_Standalone-AuthSettingsLoc}}
                </td>
            </tr>
        </tbody>
    </table>

Configure your authentication settings by adding or modifying properties
in the configuration file.

### Disabling Authentication   {#Disablin}

If you want to disable authentication for your Splice Machine database,
you can set the authentication property to `NONE`.

Splice Machine **strongly encourages you to not use** an open database
for production databases!
{: .noteNote}

You can configure an open database that allows any user to authenticate
against the database by setting your authentication properties as
follows:
{: .noSpaceAbove}

<div class="preWrapperWide" markdown="1">
    <property>
       <name>splice.authentication</name>
       <value>NONE</value>
    </property>
{: .ExampleCell xml:space="preserve"}

</div>
### Using Native Authentication   {#Using}

Native authentication is the default mechanism for Splice Machine; you
don't need to modify your configuration if you wish to use it. Native
authentication uses the `sys.sysusers` table in the `splice` schema for
configuring user names and passwords.

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

#### Switching to Native Authentication

If you are switching your authentication from to `Native` authentication
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
### Using LDAP Authentication   {#Using2}

LDAP authentication in Splice Machine uses an external LDAP server.

<div class="noteIcon" markdown="0">
<p>LDAP authentication is available only with a Splice Machine Enterprise license; you cannot use LDAP authentication with the Community version of Splice
Machine.</p>
<p>To obtain a license for the Splice Machine Enterprise Edition, <span
class="noteEnterpriseNote">please <a href="https://www.splicemachine.com/company/contact-us/" target="_blank">Contact Splice Machine Sales today.</a></span></p>
</div>

To use LDAP with Splice Machine, you must:

* <a href="https://www.splicemachine.com/company/contact-us/" target="_blank">Contact us</a> to obtain a license key from
  Splice Machine.

* Enable Enterprise features by adding your Splice Machine license key
  to your HBase configuration file as the value of the
  `splicemachine.enterprise.key` property, as shown below.

* Make sure that a user with name `splice` has been created in the LDAP
  server.

* Add the Splice Machine LDAP properties in your HBase configuration
  file, along with the license key property:

#### LDAP Property Settings

These are the property settings you need to configure:

<div class="preWrapperWide" markdown="1">
    <property>
       <name>splicemachine.enterprise.key</name>
       <value><your-Splice-Machine-license-key></value>
    </property>
    <property>
       <name>splice.authentication</name>
       <value>LDAP</value>
    </property>
    <property>
       <name>splice.authentication.ldap.server</name>
       <value><ldap://servername-ldap.yourcompany.com:389></value>
    </property>
    <property>
       <name>splice.authentication.ldap.searchAuthDN</name>
       <value><cn=commonName,ou=Users,dc=yourcompany,dc=com></value>
    </property>
    <property>
       <name>splice.authentication.ldap.searchAuthPW</name>
       <value><yourpassword</span></value>
    </property>
    <property>
       <name>splice.authentication.ldap.searchBase</name>
       <value>ou=Users,dc=yourcompany,dc=com</value>
    </property>
    <property>
       <name>splice.authentication.ldap.searchFilter</name>
       <value>&lt;(&amp;(objectClass=*)(uid=%USERNAME%))&gt;</value>
    </property>
{: .Example xml:space="preserve"}

</div>
Notes about the LDAP property values:

* Specify the location of your external LDAP server host in the <span
  class="Example">splice.authentication.ldap.server</span> property on
  port <span class="HighlightedCode">389</span>.
* The <span class="HighlightedCode">ldap.searchAuthDN</span> property is
  the security principal:

  * This is used to create the initial LDAP context (aka its connection
    to a specific DN).
  * It must have the authority to search the user space for user DNs.
  * The `cn=` is the *common name* of the security principal.
  {: .bullet}

* The <span class="HighlightedCode">ldap.searchAuthPW</span> property
  specifies password Splice Machine should use to perform the DN search.
* The <span class="HighlightedCode">ldap.searchBase</span> property
  specifies the root DN of the point in your hierarchy from which to
  begin a guest or anonymous search for the user's DN.
* The <span class="HighlightedCode">ldap.searchFilter</span> property
  specifies the search filter to use to determine what constitutes a
  user while searching for a user DN
{: .bullet}

#### Connecting with JDBC and LDAP

You can then use our JDBC driver to connect to your database with
LDAP authentication, using a connection string similar to this:

<div class="preWrapperWide" markdown="1">
    jdbc:splice://localhost:1527/splicedb;user=yourName;password=yourPswd
{: .Example}

</div>
</div>
</div>
</section>
