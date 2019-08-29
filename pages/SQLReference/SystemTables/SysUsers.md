---
title: SYSUSERS system table
summary: System table that stores user credentials when NATIVE authentication is enabled.
keywords: user credentials table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_sysusers.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSUSERS System Table

The `SYSUSERS` table stores user credentials when `NATIVE`
authentication is enabled. It belongs to the `SYS` schema.

When SQL authorization is enabled (as it is, for instance, when `NATIVE`
authentication is on) only the database owner can `SELECT` from this
table, and no one, not even the database owner, can `SELECT` the
`PASSWORD` column.

The following table shows the contents of the `SYS.SYSUSERS` system table.

<table>
    <caption>SYSUSERS system table</caption>
    <col />
    <col />
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Column Name</th>
            <th>Type</th>
            <th>Length</th>
            <th>Nullable</th>
            <th>Contents</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code> USERNAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The user's name, the value of the <code>user</code> attribute on a connection URL.</td>
        </tr>
        <tr>
            <td><code>HASHINGSCHEME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32672</code></td>
            <td><code>NO</code></td>
            <td>Describes how the password is hashed.</td>
        </tr>
        <tr>
            <td><code> PASSWORD</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32672</code></td>
            <td><code>NO</code></td>
            <td>The password after applying the <code>HASHINGSCHEME</code>.</td>
        </tr>
        <tr>
            <td><code> LASTMODIFIED</code></td>
            <td><code>TIMESTAMP</code></td>
            <td><code>29</code></td>
            <td><code>NO</code></td>
            <td>The time when the password was last updated.</td>
        </tr>
    </tbody>
</table>

## Usage Restrictions

Access to the `SYS` schema is restricted, for security purpose, to users for whom you Database Administrator has explicitly granted access.

{% include splice_snippets/systableaccessnote.md %}

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSUSERS;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you need your administrator to grant you access.

## Usage Example

Here's an example of using this table:

```
SELECT * FROM SYS.SYSUSERS;
```
{: .Example}

</div>
</section>
