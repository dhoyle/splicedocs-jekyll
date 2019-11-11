---
title: "About the Schema Restriction Feature"
summary: Overview of the schema restriction feature
keywords: schema, authorization
toc: false
compatible_version: 2.8
product: all
sidebar: home_sidebar
permalink: tutorials_security_schemarestrict.html
folder: Securing/Security
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# The Schema Restriction Feature

This topic provides an overview of the _schema restriction_ feature, which became available in Splice Machine version 2.8, in these sections:

* [What Is the Schema Restriction Feature?](#about)
* [Upgrading to Splice Machine with Schema Restriction](#upgrading)
* [Enabling and Disabling the Schema Restriction Feature](#enable)

## What Is the Schema Restriction Feature?  {#about}

Schema restriction is simply the ability to restrict access to objects belonging to a schema, so that other users cannot view or otherwise access those objects unless a Database Administrator explicitly grants access. A new privilege type, `ACCESS` is added for schemas. Starting with version 2.8 of Splice Machine, this feature is enabled by default.

With this feature enabled, access to the `SYS` schema is restricted, by default, to Database Administrators (_DBAs_) only. This means that the Splice Machine [system tables](sqlref_systables_intro.html) are only visible to DBAs or those to whom a DBA has granted access. However, Splice Machine has created [system views](sqlref_sysviews_intro.html) that can be viewed by all users; the information available in system views is automatically customized to show only objects for which the user has been granted permission. In summary:

* An administrative user or a user belonging to the admin group can see all schemas.
* A non-admin user can see:
  * schemas owned by the user
  * schemas owned by the public group
  * schemas owned by a group to which the user belongs
  * schemas to which the user has been granted `ACCESS` privilege
  * system views

    Although non-admin users can access the system views, only the rows associated with schemas for which the user has access are visible in these views. For example, in the [`SYSVW.SYSTABLESVIEW`](sqlref_sysviews_systablesview.html) view, each row represents a table; each user will only be able to see those rows belonging to schemas that are visible to him or her.
    {: .noteNote}

Please see the [tutorials_security_permissions.html](Summary of Permissions for Users and Roles) topic for an updated summary of which permissions are available to and can be granted or revoked by the `Splice` user, regular users, and roles, with and without schema restriction enabled.

### Determining If You Have Access

If you want to access the information in a table that is part of a restricted schema such as the `SYS` schema, you can instead use the corresponding system view. For example, instead of accessing the `SYS.SYSTABLES` system table, use the `SYSVW.SYSTABLESVIEW` system view.  Note that access to the view is slightly less performant than accessing the table, so if you have permission to access the system table, you might want to use it.

You can determine if you have access to this table by running the `DESCRIBE` command; for example:

```
splice> DESCRIBE SYS.SYSTABLES;
```
{: .Example}

If you see the table description, you have access. If you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you don't have access to the table; use the view instead.

If you believe that you need access to a table in a restricted schema, contact your Database Administrator.

## Upgrading to Splice Machine with Schema Restriction  {#upgrading}

If you've been using a version of Splice Machine earlier than release 2.8 and are upgrading, there are some very important things you need to know about schema restriction:

* Schema restriction is ON by default. The [next section](#enable) describes how to disable this feature if you don't want the security that it provides.
* For non-administrative users of your database to have any access to your schema(s), you must explicitly &nbsp;&nbsp[`GRANT ACCESS`](sqlref_statements_grant.html#SchemaSyntax) to those users on the schema(s).
* You can grant access to all users by granting access to the `PUBLIC` user.
*  

## Enabling and Disabling the Schema Restriction Feature  {#enable}

Applicability of the _schema restriction_ feature is controlled by the `splice.metadataRestrictionEnabled` configuration parameter, which has three possible values:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Setting</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">DISABLED</td>
            <td>Schema restriction is disabled. </td>
        </tr>
        <tr>
            <td class="CodeFont">NATIVE</td>
            <td><p>Schema restriction is enabled, and Splice Machine's <code>NATIVE</code> authorization is used.</p>
                <p>This is the default setting</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">RANGER</td>
            <td>Schema restriction is enabled, and <a href="tutorials_security_usingranger.html">Ranger</a> is used as the authorization mechanism.</td>
        </tr>
    </tbody>
</table>

### Modifying the Setting
To modify the setting, change the value of the `splice.metadataRestrictionEnabled` in the `hbase-site.xml` configuration file.

You must restart HBase after changing this setting!
{: .noteImportant}

If you are changing this setting with Cloudera Manager, you need to make the same change in <span class="important">both</span> of these configuration sections:

* `HBase Service Advanced Configuration Snippet (Safety Valve) for hbase-site.xml`
* `HBase Client Advanced Configuration Snippet (Safety Valve) for hbase-site.xml`



</div>
</section>
