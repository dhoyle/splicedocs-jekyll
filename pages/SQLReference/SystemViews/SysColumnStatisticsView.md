---
title: SYSCOLUMNSTATISTICS System View
summary: System view that describes the statistics collected for a specific table column
keywords: column statistics table view
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysviews_syscolumnstats.html
folder: SQLReference/SystemViews
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCOLUMNSTATISTICS System View

The `SYSCOLUMNSTATISTICS` table view describes the statistics for a
specific table column within the current database. It belongs to the `SYSVW` schema.

The following table shows the contents of the `SYSVW.SYSCOLUMNSTATISTICS`
system view.

<table>
    <caption>SYSCOLUMNSTATISTICS system view</caption>
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
            <td><code>SCHEMANAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32672</code></td>
            <td><code>YES</code></td>
            <td>The name of the schema.</td>
        </tr>
        <tr>
            <td><code>TABLENAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32672</code></td>
            <td><code>YES</code></td>
            <td>The name of the table.</td>
        </tr>
        <tr>
            <td><code>COLUMNNAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32672</code></td>
            <td><code>YES</code></td>
            <td>The name of the column.</td>
        </tr>
        <tr>
            <td><code>CARDINALITY</code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td><code>YES</code></td>
            <td>The estimated number of distinct values for the column.</td>
        </tr>
        <tr>
            <td><code>NULL_COUNT</code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td><code>YES</code></td>
            <td>The number of rows in the table that have NULL for the column.</td>
        </tr>
        <tr>
            <td><code>NULL_FRACTION</code></td>
            <td><code>REAL</code></td>
            <td><code>23</code></td>
            <td><code>YES</code></td>
            <td>
                <p class="noSpaceAbove">The ratio of <code>NULL</code> records to all records:</p><pre class="PlainCell">NULL_COUNT / TOTAL_ROW_COUNT</pre>
            </td>
        </tr>
        <tr>
            <td><code>MIN_VALUE</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32672</code></td>
            <td><code>YES</code></td>
            <td>The minimum value for the column.</td>
        </tr>
        <tr>
            <td><code>MAX_VALUE</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32672</code></td>
            <td><code>YES</code></td>
            <td>The maximum value for the column.</td>
        </tr>
        <tr>
            <td><code>QUANTILES</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32672</code></td>
            <td><code>YES</code></td>
            <td>
                <p>The quantiles statistics sketch for the column.</p>
            </td>
        </tr>
        <tr>
            <td><code>FREQUENCIES</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32672</code></td>
            <td><code>YES</code></td>
            <td>The frequencies statistics sketch for the column.</td>
        </tr>
        <tr>
            <td><code>THETA</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32672</code></td>
            <td><code>YES</code></td>
            <td>The theta statistics sketch for the column.</td>
        </tr>
    </tbody>
</table>
The `QUANTILES`, `FREQUENCIES`, and `THETA` values are all sketches
computed using the Yahoo Data Sketches library, which you can read about
here: [https://datasketches.github.io/][1]{: target="_blank"}
{: .notePlain}

## Usage Example

Here's an example of using this view:

```
SELECT * FROM SYSVW.SYSCOLUMNSTATISTICS;
```
{: .Example}

</div>
</section>



[1]: https://datasketches.github.io/
