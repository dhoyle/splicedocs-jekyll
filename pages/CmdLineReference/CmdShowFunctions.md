---
title: Show Functions command
summary: Displays information about functions defined in the database or in a schema.
keywords: function, show commands
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_showfunctions.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Show Functions

The <span class="AppCommand">show functions</span> command displays all
of the functions in the database, or the names of the functions in the
specified schema.

### Syntax

<div class="fcnWrapperWide" markdown="1">
    SHOW FUNCTIONS [ IN schemaName ]
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
schemaName
{: .paramName}

If you supply a schema name, only the functions in that schema are
displayed; otherwise, all functions in the database are displayed.
{: .paramDefnFirst}

</div>
### Results

The <span class="AppCommand">show functions</span> command results
contains the following columns:

<table summary="List of columns in the output of the show functions command.">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Column Name</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>FUNCTION_SCHEMA</code></td>
                        <td>The name of the function's schema</td>
                    </tr>
                    <tr>
                        <td><code>FUNCTION_NAME</code></td>
                        <td>The name of the function</td>
                    </tr>
                    <tr>
                        <td><code>REMARKS</code></td>
                        <td>Any remarks that have been stored for the function</td>
                    </tr>
                </tbody>
            </table>
### Examples

<div class="preWrapperWide" markdown="1">
    splice> CREATE FUNCTION TO_DEGREES ( RADIANS DOUBLE )
    > RETURNS DOUBLE
    > PARAMETER STYLE JAVA
    > NO SQL
    > LANGUAGE JAVA
    > EXTERNAL NAME 'java.lang.Math.toDegrees';
    0 rows inserted/updated/deleted
    splice> show functions in splice;
    FUNCTION_SCHEM|FUNCTION_NAME               |REMARKS
    -------------------------------------------------------------------------
    SPLICE        |TO_DEGREES                  |java.lang.Math.toDegrees

    1 row selected
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>
