---
title: SYSSCHEMAPERMSVIEW System View
summary: System view that describes schema permissions.
keywords: schema, permissions
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysviews_sysschemapermsview.html
folder: SQLReference/SystemViews
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSSCHEMAPERMSVIEW System View

The `SYSSCHEMAPERMSVIEW` table view describes the schema permissions that have been granted but not revoked within the current database. It belongs to the `SYSVW` schema.

The following table shows the contents of the `SYSVW.SYSSCHEMAPERMSVIEW`
system view.

<table>
    <caption>SYSSCHEMAPERMSVIEW system view</caption>
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
            <td><code></code></td>
            <td><code></code></td>
            <td><code></code></td>
            <td><code></code></td>
            <td>.</td>
        </tr>
    </tbody>
</table>

## Usage Example

Here's an example of using this view:

```
SELECT * FROM SYSVW.SYSSCHEMAPERMSVIEW;
```
{: .Example}

</div>
</section>
