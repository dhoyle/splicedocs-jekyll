---
title: SYSCHECKS system table
summary: System table that describes the check constraints within the current database.
keywords: constraint checks table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_syschecks.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCHECKS System Table

The `SYSCHECKS` table describes the check constraints within the current
database. It belongs to the `SYS` schema.

The following table shows the contents of the `SYS.SYSCHECKS` system table.

<table>
    <caption>SYSCHECKS system table</caption>
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
            <td><code>CONSTRAINTID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>Unique identifier for the constraint</td>
        </tr>
        <tr>
            <td><code>CHECKDEFINITION</code></td>
            <td><code>LONG VARCHAR</code></td>
            <td><code>32,700</code></td>
            <td><code>NO</code></td>
            <td>Text of check constraint definition</td>
        </tr>
        <tr>
            <td><code>REFERENCEDCOLUMNS</code></td>
            <td><em>com.splicemachine.
				db.catalog.
			ReferencedColumns</em>
                <p>This class
			is not part of the public API.</p>
            </td>
            <td><code>-1</code></td>
            <td><code>NO</code></td>
            <td>Description of the columns referenced by the check constraint</td>
        </tr>
    </tbody>
</table>

## Usage Example and Restrictions

Here's an example of using this table:

```
SELECT * FROM SYS.SYSCHECKS;
```
{: .Example}

{% include splice_snippets/systableaccessnote.md %}

## See Also

* [About System Tables](sqlref_systables_intro.html)

</div>
</section>
