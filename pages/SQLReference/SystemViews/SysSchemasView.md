---
title: SYSSCHEMASVIEW System View
summary: System view that shows all schemas within the database to which the current user has access.
keywords: system schema views
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysviews_sysschemasview.html
folder: SQLReference/SystemViews
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSSCHEMASVIEW System View

The `SYSSCHEMASVIEW` view describes the schemas within the current database to which the current user has access. It belongs to the `SYSVW` schema.

The following table shows the contents of the `SYSVW.SYSSCHEMASVIEW` system view.

<table>
    <caption>SYSSCHEMAVIEWS system view</caption>
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
            <td><code>SCHEMAID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>Unique identifier for the schema</td>
        </tr>
        <tr>
            <td><code>SCHEMANAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>Schema name</td>
        </tr>
        <tr>
            <td><code> AUTHORIZATIONID</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The authorization identifier of the owner of the schema</td>
        </tr>
    </tbody>
</table>
## Usage Note

This is a view on the system table, [`SYS.SYSSCHEMAS`](sqlref_systables_sysschemas.html); Access to that table is restricted, for security purposes, to users for whom your Database Administrator has explicitly granted access. This view allows you to access those parts of the table to which you have been granted access. Note that performance is better when using a table instead of its corresponding view.

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSSCHEMAS;
```
{: .Example}

If you see the table description, you have access. If you see a message that the table doesn't exist, you don't have access to the table; use the view instead.

## Usage Example

Here's an example of using this view:

```
SELECT * FROM SYSVW.SYSSCHEMASVIEW;
```
{: .Example}


</div>
</section>



[1]: https://datasketches.github.io/
