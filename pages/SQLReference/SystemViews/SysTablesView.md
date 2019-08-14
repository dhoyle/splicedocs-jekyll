---
title: SYSTABLESVIEW System View
summary: System table that describes the tables and views within the current database.
keywords: tables, permissions
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysviews_systablesview.html
folder: SQLReference/SystemViews
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSTABLESVIEW System View

The `SYSTABLESVIEW` table view describes the tables and views within the current
database. It belongs to the `SYSVW` schema.

The following table shows the contents of the `SYSVW.SYSTABLESVIEW`
system view.

<table>
    <caption>SYSTABLESVIEW system view</caption>
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
            <td><code>TABLEID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td>NO</td>
            <td>Unique identifier for table or view</td>
        </tr>
        <tr>
            <td><code>TABLENAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td>NO</td>
            <td>Table or view name</td>
        </tr>
        <tr>
            <td><code>TABLETYPE</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td>NO</td>
            <td>
                <p class="noSpaceAbove">Possible values are:</p>
                <ul>
                    <li><code>'S'</code> (system table)</li>
                    <li><code>'T'</code> (user table)</li>
                    <li><code>'A'</code> (synonym)</li>
                    <li><code>'V'</code> (view)</li>
                    <li><code>'E'</code> (external table)</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><code>SCHEMAID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td>NO</td>
            <td>Schema ID for the table or view</td>
        </tr>
        <tr>
            <td><code>LOCKGRANULARITY</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td>NO</td>
            <td>
                <p class="noSpaceAbove">Lock granularity for the table:</p>
                <ul>
                    <li> <code>'T'</code> (table level
		locking)</li>
                    <li><code>'R'</code> (row level locking, the default)</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td><code>VERSION</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td>YES</td>
            <td>Version ID.</td>
        </tr>
        <tr>
            <td><code>COLSEQUENCE</code></td>
            <td><code>INTEGER</code></td>
            <td><code>10</code></td>
            <td>NO</td>
            <td>TBD</td>
        </tr>
        <tr>
            <td><code>DELIMITED</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32672</code></td>
            <td>NO</td>
            <td>TBD</td>
        </tr>
        <tr>
            <td><code>ESCAPED</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32672</code></td>
            <td>NO</td>
            <td>TBD</td>
        </tr>
        <tr>
            <td><code>LINES</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32672</code></td>
            <td>YES</td>
            <td>TBD</td>
        </tr>
        <tr>
            <td><code>STORED</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32672</code></td>
            <td>YES</td>
            <td>TBD</td>
        </tr>
        <tr>
            <td><code>LOCATION</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32672</code></td>
            <td>YES</td>
            <td>TBD</td>
        </tr>
        <tr>
            <td><code>COMPRESSION</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32672</code></td>
            <td>YES</td>
            <td>TBD</td>
        </tr>
        <tr>
            <td><code>IS_PINNED</code></td>
            <td><code>BOOLEAN</code></td>
            <td><code>1</code></td>
            <td>NO</td>
            <td>Whether or not the table is pinned.</td>
        </tr>
        <tr>
            <td><code>PURGE_DELETED_ROWS</code></td>
            <td><code>BOOLEAN</code></td>
            <td><code>1</code></td>
            <td>NO</td>
            <td>TBD.</td>
        </tr>
        <tr>
            <td><code>SCHEMANAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td>NO</td>
            <td>Schema Name.</td>
        </tr>
    </tbody>
</table>

## Usage Example

Here's an example of using this view:

```
SELECT * FROM SYSVW.SYSTABLESVIEW;
```
{: .Example}

</div>
</section>
