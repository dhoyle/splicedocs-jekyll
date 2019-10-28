---
title: SYSTABLESTATS System Table
summary: System table that describes the statistics collected for a specific table
keywords: table statistics
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_systablestats.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSTABLESTATS System Table

The `SYSTABLESTATS` system table describes the statistics for tables
within the current database. It belongs to the `SYS` schema.

The following table shows the contents of the `SYS.SYSTABLESTATS`
system table.

<table>
    <caption>SYSTABLESTATS system table</caption>
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
            <td><code>CONGLOMERATEID</code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td><code>NO</code></td>
            <td>Conglomerate ID for the table</td>
        </tr>
        <tr>
            <td><code>PARTITIONID</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>32672</code></td>
            <td><code>NO</code></td>
            <td>For non-merged statistics (<code>STATSTYPE=0 or 2</code>), this is the region ID represented by the current statistics row. For merged statistics (<code>STATSTYPE=1 or 3</code>), this is always a constant string.</td>
        </tr>
        <tr>
            <td><code>LAST_UPDATED</code></td>
            <td><code>TIMESTAMP</code></td>
            <td><code>29</code></td>
            <td><code>NO</code></td>
            <td>The timestamp for when the table was last updated.</td>
        </tr>
        <tr>
            <td><code>IS_STALE</code></td>
            <td><code>BOOLEAN</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>Whether or not the statistics for this table are stale.</td>
        </tr>
        <tr>
            <td><code>IN_PROGRESS</code></td>
            <td><code>BOOLEAN</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td>Whether or not the statistics are being collected for this table.</td>
        </tr>
        <tr>
            <td><code>ROWCOUNT</code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td><code>YES</code></td>
            <td>The number of rows in the table</td>
        </tr>
        <tr>
            <td><code>PARTITION_SIZE</code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td><code>YES</code></td>
            <td>The average size of a single partition, in bytes.</td>
        </tr>
        <tr>
            <td><code>MEANROWWIDTH</code></td>
            <td><code>BIGINT</code></td>
            <td><code>10</code></td>
            <td><code>YES</code></td>
            <td>The <em>maximum average</em> of the widths of rows in the table, across all partitions, in bytes.</p>
                <p>Each partition records the average width of a single row. This value is the maximum of those averages across all partitions.</p></td>
        </tr>
        <tr>
            <td><code>NUMPARTITIONS</code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td><code>YES</code></td>
            <td>The number of partitions<span class="Footnote">1</span> for which statistics were collected.</td>
        </tr>
        <tr>
            <td><code>STATSTYPE</code></td>
            <td><code>INTEGER</code></td>
            <td><code>10</code></td>
            <td><code>YES</code></td>
            <td>
                <p>The type of statistics, which is one of these values:</p>
                <table>
                    <col />
                    <col />
                    <tbody>
                        <tr>
                            <td>0</td>
                            <td>Full table (not sampled) statistics that reflect the unmerged partition values.</td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>Sampled statistics that reflect the unmerged partition values.</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>Full table (not sampled) statistics that reflect the table values after all partitions have been merged.</td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>Sampled statistics that reflect the table values after all partitions have been merged.</td>
                        </tr>
                    </tbody>
                </table>
                <p>If this value is <code>NULL</code>, <code>0</code> is used.</p>
            </td>
        </tr>
        <tr>
            <td><code>SAMPLEFRACTION</code></td>
            <td><code>DOUBLE</code></td>
            <td><code>52</code></td>
            <td><code>YES</code></td>
            <td>
                <p>The sampling percentage, expressed as <code>0.0</code> to <code>1.0</code>, </p>
            <ul>
                <li>If <code>statsType=0 or 2</code> (full statistics), this value is not used, and is shown as <code>0</code>.</li>
                <li>If <code>statsType=1 or 3</code>, this value is the percentage or rows to be sampled. A value of <code>0</code> means no rows, and a value of <code>1</code> means all rows (full statistics).</li>
            </ul>

            </td>
        </tr>
    </tbody>
</table>

## Usage Restrictions

Access to the `SYS` schema is restricted, for security purposes, to users for whom you Database Administrator has explicitly granted access. However, there is a corresponding&nbsp;&nbsp; [`SYSVW.SYSTABLESTATISTICS` system view](sqlref_sysviews_systablestats.html), that allows you to access those parts of the table to which you _have_ been granted access.

{% include splice_snippets/systableaccessnote.md %}

If you don't have access to this system table, you can use the view instead. Note that performance is better when using a table instead of its corresponding view. You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSCONGLOMERATES;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message stating that _"No schema exists with the name `SYS`,"_&nbsp; you don't have access to the table; use the [`SYSVW.SYSTABLESTATISTICS` system view](sqlref_sysviews_systablestats.html) instead.

## Usage Example

Here's an example of using this view:

```
SELECT * FROM SYS.SYSTABLESTATS;
```
{: .Example}


</div>
</section>
