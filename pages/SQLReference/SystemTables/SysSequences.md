---
title: SYSSEQUENCES system table
summary: System table that describes the sequence generators in the database.
keywords: sequences table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_syssequences.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSSEQUENCES System Table

The `SYSSEQUENCES` table describes the sequence generators in the
database. It belongs to the `SYS` schema.

Users should not directly query the `SYSSEQUENCES` table, because that
will slow down the performance of sequence generators. Instead, users
should call the &nbsp;[`SYSCS_UTIL.SYSCS_PEEK_AT_SEQUENCE` system
function](sqlref_sysprocs_peekatseq.html)
{: .noteNote}

The following table shows the contents of the `SYS.SYSSEQUENCES` system
table.

<table>
    <caption>SYSSEQUENCES system table</caption>
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
            <td><code>SEQUENCEID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>The ID of the sequence generator. This is the primary key.</td>
        </tr>
        <tr>
            <td><code>SEQUENCENAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>The name of the sequence generator. There is a unique index on (<code>SCHEMAID, SEQUENCENAME</code>).</td>
        </tr>
        <tr>
            <td><code>SCHEMAID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>The ID of the schema that holds the sequence generator. There is a foreign key linking this column to <code>SYSSCHEMAS.SCHEMAID</code>.</td>
        </tr>
        <tr>
            <td><code>SEQUENCEDATATYPE</code></td>
            <td class="CodeFont"><em>com.splicemachine.db.catalog.TypeDescriptor</em>
            </td>
            <td><code>-1</code></td>
            <td><code>NO</code></td>
            <td>System type that describes the precision, length, scale, nullability, type name, and storage type of the data</td>
        </tr>
        <tr>
            <td><code>CURRENTVALUE</code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td><code>YES</code></td>
            <td>
                <p class="noSpaceAbove">The current value of the sequence generator. This is not the actual next value for the sequence generator. That value can be obtained by calling the system function <code>SYSCS_UTIL.SYSCS_PEEK_AT_SEQUENCE</code>.</p>
                <p><code>SYSSEQUENCES.CURRENTVALUE</code> holds the end of the range of values that have been preallocated in order to boost concurrency. The initial value of this column is <code>STARTVALUE</code>. </p>
                <p>This column is <code>NULL</code> only if the sequence generator is exhausted and cannot issue any more numbers.</p>
            </td>
        </tr>
        <tr>
            <td><code>STARTVALUE</code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td>NO</td>
            <td>The initial value of the sequence generator</td>
        </tr>
        <tr>
            <td><code>MINIMUMVALUE</code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td>NO</td>
            <td>The minimum value of the sequence generator</td>
        </tr>
        <tr>
            <td><code>MAXIMUMVALUE</code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td>NO</td>
            <td>The maximum value of the sequence generator</td>
        </tr>
        <tr>
            <td><code>INCREMENT</code></td>
            <td><code>BIGINT</code></td>
            <td><code>19</code></td>
            <td>NO</td>
            <td>The step size of the sequence generator</td>
        </tr>
        <tr>
            <td><code>CYCLEOPTION</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td>NO</td>
            <td>
                <p class="noSpaceAbove">If the sequence generator cycles, this value is <code>'Y'</code>.</p>
                <p>If the sequence generator does not cycle, this value is <code>'N'</code>.</p>
            </td>
        </tr>
    </tbody>
</table>

## Usage Example and Restrictions

Here's an example of using this table:

```
SELECT * FROM SYS.SYSSEQUENCES;
```
{: .Example}

{% include splice_snippets/systableaccessnote.md %}

## See Also

* [About System Tables](sqlref_systables_intro.html)

</div>
</section>
