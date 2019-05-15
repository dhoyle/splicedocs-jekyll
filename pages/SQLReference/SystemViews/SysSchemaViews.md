---
title: SYSSCHEMAVIEWS System View
summary: System view that shows all schemas within the database to which the current user has access.
keywords: system schema views
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysviews_sysschemaviews.html
folder: SQLReference/SystemViews
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSSCHEMAVIEWS System View

The `SYSSCHEMAVIEWS` view describes the schemas within the current database to which the current user has access. It belongs to the `SYSVW` schema.

The following table shows the contents of the `SYSVW.SYSSCHEMAVIEWS` system view.

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

## Usage Example

Here's an example of using this view:

```
SELECT * FROM SYSVW.SYSSCHEMAVIEWS;
```
{: .Example}


## See Also

* [About System Tables](sqlref_systables_intro.html)
* [`SYSTABLESTATISTICS`](sqlref_systables_systablestats.html)

</div>
</section>



[1]: https://datasketches.github.io/
