---
title: SYSCONGLOMERATEINSCHEMAS System View
summary: System view that displays all of the roles granted to the current user.
keywords: system roles view
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysviews_sysconglomerateinschemas.html
folder: SQLReference/SystemViews
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCONGLOMERATEINSCHEMAS System View

The `SYSCONGLOMERATEINSCHEMAS` view displays all of the conglomerates within the current database. It belongs to the `SYSVW` schema.

A conglomerate is a unit of storage and is either a
table or an index.

The following table shows the contents of the `SYSVW.SYSCONGLOMERATEINSCHEMAS` system view.

<table>
    <caption>SYSCONGLOMERATEINSCHEMAS system view</caption>
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
            <td><code>CONGLOMERATENUMBER</code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td><code>NO</code></td>
            <td>Conglomerate ID for the conglomerate (heap or index)</td>
        </tr>
        <tr>
            <td><code>SCHEMANAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>Schema name</td>
        </tr>
        <tr>
            <td><code>TABLENAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>Table name</td>
        </tr>
        <tr>
            <td><code>ISINDEX</code></td>
            <td><code>BOOLEAN</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>Whether or not conglomerate is an index</td>
        </tr>
        <tr>
            <td><code>ISCONSTRAINT</code></td>
            <td><code>BOOLEAN</code></td>
            <td><code>1</code></td>
            <td><code>YES</code></td>
            <td>Whether or not the conglomerate is a system-generated index
		enforcing a constraint</td>
        </tr>
    </tbody>
</table>
## Usage Note

This is a view on the system table, [`SYS.SYSCONGLOMERATES`](sqlref_systables_sysconglomerates.html); Access to that table is restricted, for security purposes, to users for whom your Database Administrator has explicitly granted access. This view allows you to access those parts of the table to which you have been granted access. Note that performance is better when using a table instead of its corresponding view.

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSCONGLOMERATES;
```
{: .Example}

If you see the table description, you have access. If you see a message that the table doesn't exist, you don't have access to the table; use the view instead.

## Usage Example

Here's an example of using this view:

```
select * from sysvw.sysconglomerateinschemas;
```
{: .Example}

</div>
</section>
