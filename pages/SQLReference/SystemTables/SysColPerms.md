---
title: SYSCOLPERMS system table
summary: System table that stores the column permissions that have been granted but not revoked.
keywords: column permissions table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_syscolperms.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCOLPERMS System Table

The `SYSCOLPERMS` table stores the column permissions that have been
granted but not revoked.

All of the permissions for one (`GRANTEE, TABLEID, TYPE, GRANTOR`)
combination are specified in a single row in the `SYSCOLPERMS` table.
The keys for the `SYSCOLPERMS` table are:

* Primary key (`GRANTEE, TABLEID, TYPE, GRANTOR`)
* Unique key (`COLPERMSID`)
* Foreign key (`TABLEID` references `SYS.SYSTABLES`)

The following table shows the contents of the `SYSCOLPERMS` system
table.

<table>
                <caption>SYSCOLPERMS system table</caption>
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
                        <td><code>COLPERMSID</code></td>
                        <td><code>CHAR</code></td>
                        <td><code>36</code></td>
                        <td><code>NO</code></td>
                        <td>Used by the dependency manager to track the dependency
of a view, trigger, or constraint on the column level permissions</td>
                    </tr>
                    <tr>
                        <td><code>GRANTEE</code></td>
                        <td><code>VARCHAR</code></td>
                        <td><code>128</code></td>
                        <td><code>NO</code></td>
                        <td>The authorization ID of the user or role to which the
privilege was granted</td>
                    </tr>
                    <tr>
                        <td><code>GRANTOR</code></td>
                        <td><code>VARCHAR</code></td>
                        <td><code>128</code></td>
                        <td><code>NO</code></td>
                        <td>The authorization ID of the user who granted the privilege.
Privileges can be granted only by the object owner</td>
                    </tr>
                    <tr>
                        <td><code>TABLEID</code></td>
                        <td><code>CHAR</code></td>
                        <td><code>36</code></td>
                        <td><code>NO</code></td>
                        <td>The unique identifier for the table on which the permissions
have been granted</td>
                    </tr>
                    <tr>
                        <td><code>TYPE</code></td>
                        <td><code>CHAR</code></td>
                        <td><code>1</code></td>
                        <td><code>NO</code></td>
                        <td>If the privilege is non-grantable, the valid values are:
<ul><li><code>'s'</code> for <code>SELECT</code></li><li><code>'u'</code> for <code>UPDATE</code></li><li><code>'r'</code> for <code>REFERENCES</code><br /></li></ul><p>
If the privilege is grantable, the valid values are:
</p><ul><li><code>'S'</code> for <code>SELECT</code></li><li><code>'U'</code> for <code>UPDATE</code></li><li><code>'R'</code> for <code>REFERENCES</code></li></ul></td>
                    </tr>
                    <tr>
                        <td><code>COLUMNS</code></td>
                        <td><em>org.apache.Splice Machine.
iapi.services.io.
FormatableBitSet</em>
                            <br />
                            <br />
                            <p>This class is not part of the public API.</p>
                        </td>
                        <td><code>-1</code></td>
                        <td><code>NO</code></td>
                        <td>A list of columns to which the privilege applies</td>
                    </tr>
                </tbody>
            </table>
## See Also

* [About System Tables](sqlref_systables_intro.html)

</div>
</section>

