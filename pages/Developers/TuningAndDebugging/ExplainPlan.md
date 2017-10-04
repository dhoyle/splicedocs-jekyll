---
title: Introduction to using Splice Machine's Explain Plan feature
summary: Use the Splice Machine explain plan feature to view the execution plan for a query without actually executing the query.
keywords: explain plan, statistics
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_tuning_explainplan.html
folder: Developers/TuningAndDebugging
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# About Explain Plan

You can use the `explain` command to display what the execution plan
will be for a statement without executing the statement. This topic
presents and describes several examples.

## Using Explain Plan to See the Execution Plan for a Statement

To display the execution plan for a statement without actually executing
the statement, use the <span class="AppCommand">explain</span> command
on the statement:

<div class="preWrapper" markdown="1">
    splice> explain Statement;
{: .AppCommand xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
Statement
{: .paramName}

An SQL statement.
{: .paramDefnFirst}

</div>
### Explain Plan and DDL Statements

SQL Data Definition Language (DDL) statements have no known cost, and
thus do not require optimization. Because of this, the `explain` command
does not work with DDL statements; attempting to `explain` a DDL
statement such as `CREATE TABLE` will generate a syntax error. You
**cannot** use `explain` with any of the following SQL statements:

* {: .CodeFont value="1"} ALTER
* {: .CodeFont value="2"} CREATE ... <span class="bodyFont">(any statement that starts with
  `CREATE`)</span>
* {: .CodeFont value="3"} DROP ... <span class="bodyFont">(any statement that starts with
  `DROP`)</span>
* {: .CodeFont value="4"} GRANT
* {: .CodeFont value="5"} RENAME ... <span class="bodyFont">(any statement that starts with
  `RENAME`)</span>
* {: .CodeFont value="6"} REVOKE
* {: .CodeFont value="7"} TRUNCATE TABLE

## Explain Plan Output

When you run the `explain` command, it displays output in a
tree-structured format:

* The first row in the output summarizes the plan
* Each row in the output represents a node in the tree.
* For join nodes, the right side of the join is displayed first,
  followed by the left side.
* Child node rows are indented and prefixed with '`->`'.

The first node in the plan output contains these fields:

<table summary="Description of the fields in the first node of the explain plan output.">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Field</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>n=<em>number</em></code></td>
                        <td>
                            <p class="noSpaceAbove">The number of nodes.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><code>rows=<em>number</em></code></td>
                        <td>
                            <p class="noSpaceAbove">The number of output rows.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><code>updateMode=[mode]</code></td>
                        <td>
                            <p class="noSpaceAbove">The update mode of the statement.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><code>engine=[engineType]</code></td>
                        <td>
                            <p>engineType=<code>Spark</code> means this query will be executed by our OLAP engine.</p>
                            <p>engineType=<code>control</code> means this query will be executed by our OLTP engine.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
Each node row in the output contains the following fields:

<table summary="Description of the fields in each node row in the explain plan output.">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Field</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>[<em>node label</em>]</code></td>
                        <td>The name of the node</td>
                    </tr>
                    <tr>
                        <td><code>n=<em>number</em></code></td>
                        <td>
                            <p class="noSpaceAbove">The result set number.</p>
                            <p>This is primarily used internally, and can also be used to determine the relative ordering of optimization.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><code>totalCost=<em>number</em></code></td>
                        <td>
                            <p class="noSpaceAbove">The total cost to perform this operation.</p>
                            <p>This is computed <em>as if the operation is at the top of the operation tree</em>.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><code>processingCost=<em>number</em></code></td>
                        <td>
                            <p class="noSpaceAbove">The cost to process all data in this node.</p>
                            <p>Processing includes everything except for reading the final results over the network.</p>
                        </td>
                    </tr>
                    <tr>
                        <td><code>transferCost=<em>number</em></code></td>
                        <td>The cost to send the final results over the network to the control node.</td>
                    </tr>
                    <tr>
                        <td><code>outputRows=<em>number</em></code></td>
                        <td>The total number of rows that are output.</td>
                    </tr>
                    <tr>
                        <td><code>outputHeapSize=<em>number unit</em></code></td>
                        <td>
                            <p class="noSpaceAbove">The total size of the output result set, and the unit in which that size is expressed, which is one of:</p>
                            <ul class="SecondLevel">
                                <li class="CodeFont" value="1">B</li>
                                <li class="CodeFont" value="2">KB</li>
                                <li class="CodeFont" value="3">MB</li>
                                <li class="CodeFont" value="4">GB</li>
                                <li class="CodeFont" value="5">TB</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td><code>partitions==<em>number</em></code></td>
                        <td>
                            <p class="noSpaceAbove">The number of partitions involved.</p>
                            <p><em>Partition</em> is currently equivalent to <em>Region</em>; however, this will not necessarily remain true in future releases.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
For example:

<div class="preWrapperWide" markdown="1">
    splice> explain select * from sys.systables t, sys.sysschemas s
            where t.schemaid =s.schemaid;
    
    Plan
    -------------------------------------------------------------------------------------------------Cursor(n=5,rows=20,updateMode=READ_ONLY (1),engine=control)
      ->  ScrollInsensitive(n=4,totalCost=21.728,outputRows=20,outputHeapSize=6.641 KB,partitions=1)
        ->  BroadcastJoin(n=3,totalCost=12.648,outputRows=20,outputHeapSize=6.641 KB,partitions=1,preds=[(T.SCHEMAID[4:4] = S.SCHEMAID[4:8])])
          ->  TableScan[SYSSCHEMAS(32)](n=2,totalCost=4.054,outputRows=20,outputHeapSize=6.641 KB,partitions=1)
          ->  TableScan[SYSTABLES(48)](n=1,totalCost=4.054,outputRows=20,outputHeapSize=3.32 KB,partitions=1)
    
    5 rows selected
{: .AppCommand xml:space="preserve"}

</div>
The next topic, [Explain Plan
Examples](developers_tuning_explainplan_examples.html), contains a
number of examples, annotated with notes to help you understand the
output of each.

## See Also

* [Explain Plan Examples](developers_tuning_explainplan_examples.html)

</div>
</section>

