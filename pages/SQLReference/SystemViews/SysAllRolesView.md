---
title: SYSALLROLES System View
summary: System view that displays all of the roles granted to the current user.
keywords: system roles view
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysviews_sysallroles.html
folder: SQLReference/SystemViews
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSALLROLES System View

The `SYSALLROLES` view displays all of the roles granted to the current user. It belongs to the `SYSVW` schema.

The following table shows the contents of the `SYSVW.SYSALLROLES` system view.

<table>
    <caption>SYSALLROLES system view</caption>
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
            <td><code>NAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>YES</code></td>
            <td>The name of a role that's been granted to the user.</td>
        </tr>
    </tbody>
</table>

## Usage Note

This is a view on the system table, [`SYS.SYSROLES`](sqlref_systables_sysroles.html); Access to that table is restricted, for security purposes, to users for whom your Database Administrator has explicitly granted access. This view allows you to access those parts of the table to which you have been granted access. Note that performance is better when using a table instead of its corresponding view.

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSROLES;
```
{: .Example}

If you see the table description, you have access. If you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you don't have access to the table; use the view instead.


## Usage Example

Here's an example of using this view:

```
SELECT * FROM SYSVW.SYSALLROLESVIEW;
```
{: .Example}

</div>
</section>
