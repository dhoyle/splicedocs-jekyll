---
title: SYSUSERS system table
summary: System table that stores user credentials when NATIVE authentication is enabled.
keywords: user credentials table
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_systables_sysusers.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSUSERS System Table   {#SystemTables.SysUsers}

The `SYSUSERS` table stores user credentials when `NATIVE`
authentication is enabled.

When SQL authorization is enabled (as it is, for instance, when `NATIVE`
authentication is on) only the database owner can `SELECT` from this
table, and no one, not even the database owner, can `SELECT` the
`PASSWORD` column.

The following table shows the contents of the `SYSUSERS` system table.

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
## See Also

* [About System Tables](sqlref_systables_intro.html)

</div>
</section>

