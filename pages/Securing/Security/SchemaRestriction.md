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
* [Enabling and Disabling the Schema Restriction Feature](#enable)

## What Is the Schema Restriction Feature?  {#about}

Schema restriction is simply the ability to restrict access to objects belonging to a schema, so that other users cannot view or otherwise access those objects unless a Database Administrator explicitly grants access.

Please see the [tutorials_security_permissions.html](Summary of Permissions for Users and Roles) topic for an updated summary of which permissions are available to and can be granted or revoked by the `Splice` user, regular users, and roles, with and without schema restriction enabled.

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

If you are changing this setting with Cloudera Manager, you need to make the same change in both of these configuration sections:

* `HBase Service Advanced Configuration Snippet (Safety Valve) for hbase-site.xml`
* `HBase Client Advanced Configuration Snippet (Safety Valve) for hbase-site.xml`



</div>
</section>
