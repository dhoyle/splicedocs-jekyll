---
title: "Summary of Permissions for Users and Roles"
summary: Summary of privileges to Grant or Revoke access to various system objects
keywords: privileges, user, super-user
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_security_userprivs.html
folder: Tutorials/Security
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Permissions for Users and Roles

This topic summarizes which permissions are available to and can be granted or revoked by the `Splice` user, regular users, and roles, in these sections:

* [Permissions in System Schemas](#systables)
* [Permissions in the *SPLICE* Schema](#spliceschema)
* [Permissions in Regular Schemas](#regularschemas)
* [System Procedures and Routines Permissions](#sysprocs)

## Summary of Permissions in System Schemas {#systables}

The following table summarizes which permissions apply to and can be granted or revoked by the `Splice` user, regular users, and roles for tables in the system schemas:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th rowspan="2">Operation</th>
            <th colspan="2"><span class="CodeFont">Splice</span> User</th>
            <th colspan="2">Regular User</th>
            <th colspan="2">Role</th>
        </tr>
        <tr>
            <th>Has Permission?</th>
            <th>Can Grant or Revoke?</th>
            <th>Has Permission?</th>
            <th>Can Grant or Revoke?</th>
            <th>Has Permission?</th>
            <th>Can Grant or Revoke?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">Update/Delete/Insert</td>
            <td>No</td>
            <td>No</td>
            <td>No</td>
            <td>No</td>
            <td colspan="2">Same as Regular User</td>
        </tr>
        <tr>
            <td class="CodeFont">Select</td>
            <td>Yes</td>
            <td>No</td>
            <td>Yes, except for <code>sys.sysusers</code></td>
            <td>No</td>
            <td colspan="2">Same as Regular User</td>
        </tr>
        <tr>
            <td class="CodeFont">Create/Drop/Alter table ...</td>
            <td>No</td>
            <td>No</td>
            <td>No</td>
            <td>No</td>
            <td colspan="2">Same as Regular User</td>
        </tr>
        <tr>
            <td class="CodeFont">Create/Drop schema</td>
            <td>No</td>
            <td>No</td>
            <td>No</td>
            <td>No</td>
            <td colspan="2">Same as Regular User</td>
        </tr>
    </tbody>
</table>

<div class="indented" markdown="1">
These are the system schemas to which the above privileges apply:
* `sys`
* `sysibm`
* `syscs_util`
* `syscs_diag`
* `syscat`
* `sysfun`
* `sysproc`
* `sysstat`
* `nullid`
* `sqlj`
</div>

## Permissions in the *SPLICE* Schema {#spliceschema}
The following table summarizes which permissions apply to and can be granted or revoked by the `Splice` user, regular users, and roles for tables in the `SPLICE` schema:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th rowspan="2">Operation</th>
            <th colspan="2"><span class="CodeFont">Splice</span> User</th>
            <th colspan="2">Regular User</th>
            <th colspan="2">Role</th>
        </tr>
        <tr>
            <th>Has Permission?</th>
            <th>Can Grant or Revoke?</th>
            <th>Has Permission?</th>
            <th>Can Grant or Revoke?</th>
            <th>Has Permission?</th>
            <th>Can Grant or Revoke?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">Update/Delete/Insert</td>
            <td>Yes</td>
            <td>No</td>
            <td colspan="2">Yes, if granted the corresponding privilege.</td>
            <td colspan="2">Same as regular user</td>
        </tr>
        <tr>
            <td class="CodeFont">Select</td>
            <td>Yes</td>
            <td>No</td>
            <td colspan="2">Yes, if granted the corresponding privilege.</td>
            <td colspan="2">Same as regular user</td>
        </tr>
        <tr>
            <td class="CodeFont">Create/Drop/Alter table ...</td>
            <td>Yes</td>
            <td>No</td>
            <td colspan="2">Yes, if granted the corresponding privilege.</td>
            <td colspan="2">Same as regular user</td>
        </tr>
        <tr>
            <td class="CodeFont">Create/Drop schema</td>
            <td>Yes</td>
            <td>No</td>
            <td>Yes for <code>DROP SCHEMA</code>, if the user becomes the owner of the <code>SPLICE</code> schema.</td>
            <td>No</td>
            <td colspan="2">No</td>
        </tr>
    </tbody>
</table>

## Permissions in Regular Schemas {#regularschemas}
The following table summarizes which permissions apply to and can be granted or revoked by the `Splice` user, regular users, and roles for tables in regular schemas:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th rowspan="2">Operation</th>
            <th colspan="2"><span class="CodeFont">Splice</span> User</th>
            <th colspan="2">Regular User</th>
            <th colspan="2">Role</th>
        </tr>
        <tr>
            <th>Has Permission?</th>
            <th>Can Grant or Revoke?</th>
            <th>Has Permission?</th>
            <th>Can Grant or Revoke?</th>
            <th>Has Permission?</th>
            <th>Can Grant or Revoke?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">Update/Delete/Insert</td>
            <td>Yes</td>
            <td>No</td>
            <td colspan="2">Yes, if schema owner, or if granted the corresponding privilege.</td>
            <td colspan="2">Yes, if granted the corresponding privilege</td>
        </tr>
        <tr>
            <td class="CodeFont">Select</td>
            <td>Yes</td>
            <td>No</td>
            <td colspan="2">Yes, if schema owner, or if granted the corresponding privilege.</td>
            <td colspan="2">Yes, if granted the corresponding privilege</td>
        </tr>
        <tr>
            <td class="CodeFont">Create/Drop/Alter table ...</td>
            <td>Yes</td>
            <td>No</td>
            <td colspan="2">Yes, if schema owner, or if granted the corresponding privilege.</td>
            <td colspan="2">Yes, if granted the corresponding privilege</td>
        </tr>
        <tr>
            <td class="CodeFont">Create/Drop schema</td>
            <td>Yes</td>
            <td>No</td>
            <td><p>Yes for <code>CREATE SCHEMA</code>, if the schema name is the same as the user and does not yet exist.</p>
                <p>Yes  for <code>DROP SCHEMA</code>, if user is the schema owner.</p></td>
            <td>No</td>
            <td colspan="2">No</td>
        </tr>
    </tbody>
</table>

## Permissions for System Procedures and Routines {#sysprocs}
The following table summarizes which permissions apply to and can be granted or revoked by the `Splice` user, regular users, and roles for system procedures and routines:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th rowspan="2">Object</th>
            <th colspan="2"><span class="CodeFont">Splice</span> User</th>
            <th colspan="2">Regular User</th>
            <th colspan="2">Role</th>
        </tr>
        <tr>
            <th>Has Permission?</th>
            <th>Can Grant or Revoke?</th>
            <th>Has Permission?</th>
            <th>Can Grant or Revoke?</th>
            <th>Has Permission?</th>
            <th>Can Grant or Revoke?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>System Procedures/Routines</td>
            <td>Yes</td>
            <td>No</td>
            <td>Yes for system schemas other than <code>SYSCS_UTIL</code> and <code>SQLJ</code>, which require that execution privilege be explicitly granted.</td>
            <td>Yes for the <code>SYSCS_UTIL</code> and <code>SQLJ</code> schemas; No for other system schemas.</td>
            <td colspan="2">Same as regular user</td>
        </tr>
    </tbody>
</table>

</div>
</section>
