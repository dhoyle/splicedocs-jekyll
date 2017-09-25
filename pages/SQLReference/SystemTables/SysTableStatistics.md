---
title: SYSTABLESTATISTICS system table
summary: System table that describes the statistics collected for a specific table
keywords: table statistics table
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_systables_systablestats.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSTABLESTATISTICS System Table

The `SYSTABLESTATISTICS` table view describes the statistics for tables
within the current database.

`SYS.SYSTABLESTATISTICS` is a system view.
{: .noteNote}

The following table shows the contents of the `SYSTABLESTATISTICS`
system table.

<table>
                <caption>SYSTABLESTATISTICS system table</caption>
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
                        <td>The name of the schema</td>
                    </tr>
                    <tr>
                        <td><code>TABLENAME</code></td>
                        <td><code>VARCHAR</code></td>
                        <td><code>32672</code></td>
                        <td><code>YES</code></td>
                        <td>The name of the table</td>
                    </tr>
                    <tr>
                        <td><code>CONGLOMERATENAME</code></td>
                        <td><code>VARCHAR</code></td>
                        <td><code>32672</code></td>
                        <td><code>YES</code></td>
                        <td>The name of the table</td>
                    </tr>
                    <tr>
                        <td><code>TOTAL_ROW_COUNT</code></td>
                        <td><code>BIGINT</code></td>
                        <td><code>19</code></td>
                        <td><code>YES</code></td>
                        <td>The total number of rows in the table</td>
                    </tr>
                    <tr>
                        <td><code>AVG_ROW_COUNT</code></td>
                        <td><code>BIGINT</code></td>
                        <td><code>19</code></td>
                        <td><code>YES</code></td>
                        <td>The average number of rows in the table</td>
                    </tr>
                    <tr>
                        <td><code>TOTAL_SIZE</code></td>
                        <td><code>BIGINT</code></td>
                        <td><code>19</code></td>
                        <td><code>YES</code></td>
                        <td>The total size of the table</td>
                    </tr>
                    <tr>
                        <td><code>NUM_PARTITIONS</code></td>
                        <td><code>BIGINT</code></td>
                        <td><code>19</code></td>
                        <td><code>YES</code></td>
                        <td>The number of partitions<span class="Footnote">1</span> for which statistics were collected.</td>
                    </tr>
                    <tr>
                        <td><code>AVG_PARTITION_SIZE</code></td>
                        <td><code>BIGINT</code></td>
                        <td><code>19</code></td>
                        <td><code>YES</code></td>
                        <td>The average size of a single partition<span class="Footnote">1</span>, in bytes.</td>
                    </tr>
                    <tr>
                        <td><code>ROW_WIDTH</code></td>
                        <td><code>BIGINT</code></td>
                        <td><code>19</code></td>
                        <td><code>YES</code></td>
                        <td>
                            <p class="noSpaceAbove">The <em>maximum average</em> of the widths of rows in the table, across all partitions, in bytes.</p>
                            <p>Each partition records the average width of a single row. This value is the maximum of those averages across all partitions.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><code>STATS_TYPE</code></td>
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
                        <td><code>SAMPLE_FRACTION</code></td>
                        <td><code>DOUBLE</code></td>
                        <td><code>52</code></td>
                        <td><code>YES</code></td>
                        <td>
                            <p>The sampling percentage, expressed as <code>0.0</code> to <code>1.0</code>, </p>
                        <ul>
                            <li>If <code>statsType=0</code> (full statistics), this value is not used, and is shown as <code>0</code>.</li>
                            <li>If <code>statsType=1</code>, this value is the percentage or rows to be sampled. A value of <code>0</code> means no rows, and a value of <code>1</code> means all rows (full statistics).</li>
                        </ul>

                        </td>
                    </tr>
                </tbody>
            </table>
> <span class="Footnote">1</span>Currently, a *partition* is equivalent
> to a region. In the future, we may use a more finely-grained
> definition for partition.

## See Also

* [About System Tables](sqlref_systables_intro.html)
* [`SYSCOLUMNSTATISTICS`](sqlref_systables_syscolumnstats.html) system
  table

</div>
</section>

