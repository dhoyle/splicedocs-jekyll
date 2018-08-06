---
summary: Describes how to configure and manage Splice Machine, which offers several different authentication mechanisms, including LDAP.
title: Configuring Splice Machine Authentication
keywords: authenticate, credentials, configuring, native authentication, ldap
toc: false
product: onprem
sidebar:  tutorials_sidebar
permalink: onprem_install_configureauth.html
folder: Tutorials/Security
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
* [Using Native Authentication](#Using)
* [Using KERBEROS Authentication](#UsingKerb)
* [Using LDAP Authentication](#Using2)

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
            <td><code>NATIVE</code></td>
            <td>
                <p>User IDs in a database table are validated against the corresponding, encrypted password.</p>
                <p>This is the default authentication setting for Splice Machine installations.</p>
            </td>
        </tr>
        <tr>
            <td><code>KERBEROS</code></td>
            <td>
                <p>User IDs are validated against kerberos server.</p>
{% include splice_snippets/enterpriseonly_note.md %}
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

## Using NATIVE Authentication   {#Using}

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

### Switching to Native Authentication

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

## Using KERBEROS Authentication   {#UsingKerb}

Kerberos authentication in Splice Machine uses an external KDC server. Follow these steps to enable Kerberos authentication:
{% include splice_snippets/kerberosconfig.md %}

You can then connect through JDBC with the `principal` and `keytab` values. For example:
   <div class="preWrapperWide" markdown="1">
       splice> CONNECT  'jdbc:splice://localhost:1527/splicedb;principal=jdoe@SPLICEMACHINE.COLO;keytab=/tmp/user1.keytab';
   {: .Example}
   </div>

For more information about using Kerberos with Splice Machine, see our [Using Kerberos](tutorials_security_usingkerberos.html) topic.

## Using LDAP Authentication   {#Using2}

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
  file, along with the license key property. Note that you may need to set `splice.authentication` properties in both service and client HBase configuration files:

### LDAP Property Settings

These are the property settings you need to configure:

<div class="preWrapperWide"><pre class="Example">
    &lt;property&gt;
       &lt;name&gt;splicemachine.enterprise.key&lt;/name&gt;
       &lt;value&gt;<span class="HighlightedCode">your-Splice-Machine-license-key</span>&lt;/value&gt;
    &lt;/property&gt;
    &lt;property&gt;
       &lt;name&gt;splice.authentication&lt;/name&gt;
       &lt;value&gt;LDAP&lt;/value&gt;
    &lt;/property&gt;
    &lt;property&gt;
       &lt;name&gt;splice.authentication.ldap.server&lt;/name&gt;
       &lt;value&gt;ldap://<span class="HighlightedCode">servername-ldap.yourcompany.com</span>:<span class="HighlightedCode">port-number</span>&lt;/value&gt;
    &lt;/property&gt;
    &lt;property&gt;
       &lt;name&gt;splice.authentication.ldap.searchAuthDN&lt;/name&gt;
       &lt;value&gt;cn=<span class="HighlightedCode">commonName</span>,ou=Users,dc=<span class="HighlightedCode">yourcompany</span>,dc=<span class="HighlightedCode">com</span>&lt;/value&gt;
    &lt;/property&gt;
    &lt;property&gt;
       &lt;name&gt;splice.authentication.ldap.searchAuth.password&lt;/name&gt;
       &lt;value&gt;<span class="HighlightedCode">yourpassword</span>&lt;/value&gt;
    &lt;/property&gt;
    &lt;property&gt;
       &lt;name&gt;splice.authentication.ldap.searchBase&lt;/name&gt;
       &lt;value&gt;ou=Users,dc=<span class="HighlightedCode">yourcompany</span>,dc=<span class="HighlightedCode">com</span>&lt;/value&gt;
    &lt;/property&gt;
    &lt;property&gt;
       &lt;name&gt;splice.authentication.ldap.searchFilter&lt;/name&gt;
       &lt;value&gt;<span class="HighlightedCode">search-filter-criteria</span>&lt;/value&gt;
    &lt;/property&gt;</pre>
</div>

Notes about the LDAP property values:

* Specify both the location of your external LDAP server host and the port number in the `splice.authentication.ldap.server property`. The default `openLDAP` port is `389`.
* The `ldap.searchAuthDN` property is
  the security principal:

  * This is used to create the initial LDAP context (aka its connection
    to a specific DN (*distinct name*)).
  * It must have the authority to search the user space for user DNs.
  * The `cn=` is the *common name* of the security principal.
  {: .bullet}

* The `ldap.searchAuth.password` property
  specifies password Splice Machine should use to perform the DN search; this is the password of the `DN` specified in ldap.searchAuthDN property.
* The `ldap.searchBase` property
  specifies the root DN of the point in your hierarchy from which to
  begin a guest or anonymous search for the user's DN.
* The `ldap.searchFilter` property specifies the search filter to use to determine what constitutes a user while searching for a user DN. An example is: <span class="Example">(&(objectClass=*)(uid=%USERNAME%))</span>
{: .bullet}

### Authenticating With an LDAP Group
To use a LDAP GROUP, you must create a Splice Machine database user for that group. You can then assign privileges to that user, and everyone belonging to the LDAP GROUP will gain those privileges.

For example, given an LDAP GROUP named `test_devel`:

<div class="preWrapperWide" markdown="1"><pre>
splice> call syscs_util.syscs_create_user('test_devel', 'test_devel');
Statement executed.
splice> create schema test_devel_schema;
0 rows inserted/updated/deleted
splice> create role test_devel_role;
0 rows inserted/updated/deleted
splice> grant all privileges on schema test_devel_schema to test_devel_role;
0 rows inserted/updated/deleted
splice> grant cdl_devl_role to test_devel;
0 rows inserted/updated/deleted</pre>
{: .Example}
</div>

Now we can connect as user `testuser`, who belongs to the `test_devel` LDAP Group:

<div class="preWrapperWide" markdown="1"><pre>
splice> connect 'jdbc:splice://localhost:1527/splicedb;user=testuser;password=testpswd';
splice> create table test_devel_schema.t1(a int);
0 rows inserted/updated/deleted
splice> insert into test_devel_schema.t1 values (10), (20), (30);
3 rows inserted/updated/deleted
splice> select * from test_devel_schema.t1;
A
-----------
10
20
30

3 rows selected</pre>
{: .Example}
</div>

### LDAP Groups and Splice Machine

Given an LDAP user and its `DN` (*Distinct Name*), Splice Machine honors the LDAP groups that user belongs to from two sources:

* the first `CN` (*Common Name*) in the `DN`, which may or may not be the same as the LDAP user name
* the user's `memberOf` property

Here's an example for an LDAP user with these `DN` and `memberOf` attributes:

<div class="preWrapperWide" markdown="1">
<pre># user3, Users, splicemachine.colo
dn: cn=user3,ou=Users,dc=splicemachine,dc=colo
memberOf: cn=foo,ou=groups,dc=splicemachine,dc=colo
memberOf: cn=mygroup,ou=groups,dc=splicemachine,dc=color</pre>
{: .Example}
</div>

Splice Machine treats <span class="Example">user3</span>, <span class="Example">`foo`</span>, and <span class="Example">`mygroup`</span> as the LDAP groups to which `user3` belongs. All privileges granted to those three groups are inherited by the LDAP user `user3`.

### Connecting with JDBC and LDAP

You can then use our JDBC driver to connect to your database with
LDAP authentication, using a connection string similar to this:

<div class="preWrapperWide" markdown="1">
    jdbc:splice://localhost:1527/splicedb;user=yourName;password=yourPswd
{: .Example}

</div>
</div>
</div>
</section>
