---
title: SYSALIASES system table
summary: System table that describes the procedures, functions, and user-defined types in the database.
keywords: aliases table
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_systables_sysaliases.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSALIASES System Table

The `SYSALIASES` table describes the procedures, functions, and
user-defined types in the database. It belongs to the `SYS` schema.

The following table shows the contents of the `SYS.SYSALIASES` system table.

<table>
    <caption>SYSALIASES system table</caption>
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
            <td><code>ALIASID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>NO</code></td>
            <td>Unique identifier for the alias</td>
        </tr>
        <tr>
            <td><code>ALIAS</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>Alias (in the case of a user-defined type, the name of the user-defined type)</td>
        </tr>
        <tr>
            <td><code>SCHEMAID</code></td>
            <td><code>CHAR</code></td>
            <td><code>36</code></td>
            <td><code>YES</code></td>
            <td>Reserved for future use</td>
        </tr>
        <tr>
            <td><code>JAVACLASSNAME</code></td>
            <td><code>LONG VARCHAR</code></td>
            <td><code>2,147,483,647</code></td>
            <td><code>NO</code></td>
            <td>The Java class name</td>
        </tr>
        <tr>
            <td><code>ALIASTYPE</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td><em>'F'</em> (function), <em>'P'</em> (procedure),
			<em>'A'</em> (user-defined type)</td>
        </tr>
        <tr>
            <td><code>NAMESPACE</code></td>
            <td><code>CHAR</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td><em>'F'</em> (function), <em>'P'</em> (procedure),
			<em>'A'</em> (user-defined type)</td>
        </tr>
        <tr>
            <td><code>SYSTEMALIAS</code></td>
            <td><code>BOOLEAN</code></td>
            <td><code>1</code></td>
            <td><code>NO</code></td>
            <td><em>YES</em> (system supplied or built-in alias)
			<p><em>NO</em> (alias created by a user)</p></td>
        </tr>
        <tr>
            <td><code>ALIASINFO</code></td>
            <td><code>org.apache.Splice Machine.<br />catalog.AliasInfo</code></td>
            <td><code>-1</code></td>
            <td><code>YES</code></td>
            <td><p>A Java interface that encapsulates the additional information that is specific to an alias.</p>
                <p>This class is not part of the public API.</p>
            </td>
        </tr>
        <tr>
            <td><code>SPECIFICNAME</code></td>
            <td><code>VARCHAR</code></td>
            <td><code>128</code></td>
            <td><code>NO</code></td>
            <td>System-generated identifier</td>
        </tr>
    </tbody>
</table>

## Usage Restrictions

Access to system tables is restricted, for security purpose, to users for whom you Database Administrator has explicitly granted access.

{% include splice_snippets/systableaccessnote.md %}

You can determine if you have access to this table by running the following command:

```
splice> DESCRIBE SYS.SYSALIASES;
```
{: .Example}

If you see the table description, you have access; if, instead, you see a message that the table doesn't exist, you need your administrator to grant you access.


## Usage Example

Here's an example of using this table:

```
SELECT * FROM SYS.SYSALIASES;
```
{: .Example}

</div>
</section>
