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

## Usage Example

Here's an example of using this view:

```
SELECT * FROM SYSVW.SYSALLROLESVIEW;
```
{: .Example}

</div>
</section>
