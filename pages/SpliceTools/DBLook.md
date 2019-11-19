---
title: The DBLook Tool
summary:
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: splicetools_dblook.html
folder: SpliceTools
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DBLook

You can use the Splice Machine *DBLook* tool on MacOS or Linux to export the DDL (data definition language). The *DBLook* tool does not work on Windows.

To use this tool, you need to:

1. Download and install it into the directory in which you want to use it.
2. Modify variables in the script file (`get-ddl.sh`) as required to match your environment.
3. Run the script with your desired options.

<!--
## Download and Install
To install the *DBLook* tool, follow these steps:
1. Download the XXXXXXX file from XXXXXXX.
2. Unpack the file to the directory in which you want to run *DBLook*, using the following command:
   ```
   xxx
   ```
   {: .ShellCommand}
-->

## Modify the Script Variables
You may need to modify some variables in the `get-ddl.sh` script file, including these:

* `HOST`
* `PORT`
* `USER`
* `PASS`

## Run the Script

Here are the command line options for the *DBLook* tool:
<table>
    <col width="25%" />
    <col width="45%" />
    <col width="30%" />
    <thead>
        <tr>
            <th>Option</th>
            <th>Description</th>
            <th>Example</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">name</td>
            <td>description</td>
            <td class="CodeFont">example</td>
        </tr>
        <tr>
            <td class="CodeFont">name</td>
            <td>description</td>
            <td class="CodeFont">example</td>
        </tr>
        <tr>
            <td class="CodeFont">name</td>
            <td>description</td>
            <td class="CodeFont">example</td>
        </tr>
        <tr>
            <td class="CodeFont">name</td>
            <td>description</td>
            <td class="CodeFont">example</td>
        </tr>
    </tbody>
</table>

## Examples

The following table shows you various examples of using the *DBLook* tool:

<table>
    <col width="50%" />
    <col width="50%" />
    <thead>
        <tr>
            <th>Description</th>
            <th>Command Line Example</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Write the DDL to a file</td>
            <td class="CodeFont">./get-ddl.sh -o ddl.sql</td>
        </tr>
        <tr>
            <td>Write the DDL to a file connecting to a database on server <code>MYSERVER</code>, with user <code>SOMEUSER</code> and password <code>MYPASSWORD</code></td>
            <td class="CodeFont">/get-ddl.sh -o ddl.sql -h MYSERVER -u SOMEUSER -s MYPASSWORD</td>
        </tr>
        <tr>
            <td>Write the DDL to a file, extracting only the <code>SPLICE</code> schema.</td>
            <td class="CodeFont">./get-ddl.sh -o ddl.sql -z SPLICE</td>
        </tr>
        <tr>
            <td>Write the DDL to a file, extracting only the <code>TABLE1</code> table that is in schema <code>SPLICE</code>.</td>
            <td class="CodeFont">./get-ddl.sh -o ddl.sql -z SPLICE -t "TABLE1"</td>
        </tr>
        <tr>
            <td>Write the DDL to a file, extracting only the <code>TABLE1</code> and <code>TABLE2</code> tables that are in schema <code>SPLICE</code>.</td>
            <td class="CodeFont">./get-ddl.sh -o ddl.sql -z SPLICE -t "TABLE1 TABLE2"</td>
        </tr>
        <tr>
            <td>Write the DDL to a file, extracting only the <code>SPLICE</code> schema, with verbose output.</td>
            <td class="CodeFont">./get-ddl.sh -o ddl.sql -z SPLICE -v</td>
        </tr>
        <tr>
            <td>Add the DDL to an existing file</td>
            <td class="CodeFont">./get-ddl.sh -o ddl.sql -z <code>SPLICE</code> -a</td>
        </tr>
    </tbody>
</table>

You can use the included `test.sql` file to experiment with this tool.
{: .noteNote}

</div>
</section>
