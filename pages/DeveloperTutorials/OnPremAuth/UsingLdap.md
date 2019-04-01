---
title: Using LDAP with Splice Machine
summary: Using LDAP Authentication
keywords: LDAP
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_security_usingldap.html
folder: DeveloperTutorials/OnPremAuth
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Using LDAP Authentication

This topic describes how to use LDAP authentication in Splice Machine, in these subsections:

* [About LDAP Authentication in Splice Machine](#about)
* [LDAP Property Settings](#props)
* [Authenticating With an LDAP Group](#groupauth)
* [Troubleshooting LDAP](#troubleshoot)


## About LDAP Authentication in Splice Machine  {#about}
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

## LDAP Property Settings  {#props}

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

### Notes about the LDAP property values:

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

## Authenticating With an LDAP Group  {#groupauth}
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

You can now connect as user `testuser`, who belongs to the `test_devel` LDAP Group:

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

### LDAP Group Names and Splice Machine {#ldapgroupnames}

When using an LDAP Group name in a `GRANT` or `REVOKE` statement: if the group name contains characters other than alphanumerics or the underscore character (<span class="HighlightedCode">A-Z, a-z, 0-9, _</span>), you must:

* Enclose the group name in double quotes
* Convert all alphabetic characters in the group name to uppercase.

For example, if you are granting rights to an LDAP Group with name <span class="Example">This-is-my-LDAP-Group</span>, you would use a statement like this:
   ```
   GRANT SELECT ON TABLE Salaries TO "THIS-IS-MY-LDAP-GROUP";
   ```
   {: .Example}

### Connecting with JDBC and LDAP

You can then use our JDBC driver to connect to your database with
LDAP authentication, using a connection string similar to this:

<div class="preWrapperWide" markdown="1">
    jdbc:splice://localhost:1527/splicedb;user=yourName;password=yourPswd
{: .Example}
</div>

## Troubleshooting LDAP  {#troubleshoot}

There is a known issue when authenticating with LDAP protocol to an Active Directory instance. If you see "*Unprocessed Continuation Reference*" error messages in the Splice Machine region server logs, this is typically caused by using a default Active Directory port (`369`/`636`). To fix:

* Change port `369` to port `3268` for LDAP
* Change port `636` to port `3269` for LDAPS.

Using the alternate port allows for a broader search and lets you follow references.

Secure ldap is always preferred since it is the only way to securely encrypt your users' passwords.
{: .notePlain}

</div>
</section>
