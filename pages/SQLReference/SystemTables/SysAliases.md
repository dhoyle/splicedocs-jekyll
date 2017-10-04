---
title: SYSALIASES system table
summary: System table that describes the procedures, functions, and user-defined types in the database.
keywords: aliases table
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_systables_sysaliases.html
folder: SQLReference/SystemTables
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSALIASES System Table

The `SYSALIASES` table describes the procedures, functions, and
user-defined types in the database.

The following table shows the contents of the `SYSALIASES` system table.

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
                        <td>Alias (in the case of a user-defined type, the name of the
						user-defined type)</td>
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
                        <td><em>org.apache.Splice Machine.
							catalog.AliasInfo</em>
                            <br />
                            <br />
                            <p>This class is not part of the public API.</p>
                        </td>
                        <td><code>-1</code></td>
                        <td><code>YES</code></td>
                        <td>A Java interface that encapsulates the additional information
						that is specific to an alias</td>
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
## See Also

* [About System Tables](sqlref_systables_intro.html)

</div>
</section>

