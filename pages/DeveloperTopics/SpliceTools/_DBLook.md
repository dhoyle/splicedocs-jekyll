---
title: The DBLook Tool
summary:
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: developers_splicetools_dblook.html
folder: DeveloperTopics/SpliceTools
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# DBLook

The Splice Machine *DBLook* tool allows you to
Download the file, extract it to a directory and then navigate to the directory where the script get-ddl.sh is. This is only tested this on a mac and linux. It doesn't work on Windows. It assumes that the java command is known.

You may use test.sql to create a test schema and a couple of tables to test.

You may also need to modify get-ddl.sh. For example, the following variables should be changed to match your environment:
HOST=
PORT=
USER=
PASS=


USAGE FROM GIT
DBLOOK_Usage=

java.com.splicemachine.db.tools.dblook -d <sourceDBUrl> [OPTIONS]

[OPTIONS]:
<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Option</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">-d <span="Highlighted">sourceDBUrl</span></td>
            <td><p>The full URL, including the connection protocol and any connection attributes that might apply. For example:</p>
                <div class="Example"><pre>'jdbc:splice://localhost:1527/myDB;user=usr</pre></div>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">-z <span="Highlighted">schemaName</span></td>
            <td><p>If you specify a schema name, only objects belonging to the specified schema will have DDL generated for them.</p>
                <p>If you do not include this option, *DBLook* generates DDL for all objects in all schemas in the database.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">-t <span="Highlighted">table1 table2 ... tablen</span></td>
            <td><p>Specifies the tables for which you want DDL generated; tables not in this list are ignored.</p>
                <p>If you do not include this option, DDL is generated only for the tables in the list.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><span="Highlighted">value</span></td>
            <td><p>This `value` is appended to the end of each DDL statement.</p>
                <p>If unspecified, the default value `;` is appended to each DDL statement.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">-noview</td>
            <td><p>Indicates that you *do not* want DDL generated for views.</p>
                <p>If you do not include this option, DDL is generated for views.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">-append</td>
            <td><p>Specifies that you do not want the generated DDL to overwrite the output files.</p>
                <p>If you do not include this option, ???????????????.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">-verbose</td>
            <td><p>Specifies that you want error messages printed to the console, in addition to writing them to the log file.</p>
                <p>If you do not include this option, error messages are only written to the log file.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">-o <span="Highlighted">filename</span></td>
            <td><p>Specifies the name of the file to which the generated DDL is written.</p>
                <p>If you do not include this option, the DDL is written to the console.</p>
            </td>
        </tr>
    </tbody>
</table>



Here are some examples of how to use the tool.

Writing the DDL to a file
./get-ddl.sh -o ddl.sql

Writing the DDL to a file connecting to a database on server MYSERVER, with user SOMEUSER and password MYPASSWORD
/get-ddl.sh -o ddl.sql -h MYSERVER -u SOMEUSER -s MYPASSWORD

Write ddl to a file and only extract the SPLICE schema
./get-ddl.sh -o ddl.sql -z SPLICE

Write ddl to a file and only extract the table TABLE1 in schema SPLICE
./get-ddl.sh -o ddl.sql -z SPLICE -t "TABLE1"

Write ddl to a file and only extract the table TABLE1 and TABLE2 in schema SPLICE
./get-ddl.sh -o ddl.sql -z SPLICE -t "TABLE1 TABLE2"

Write ddl to a file and only extract the SPLICE schema with verbose output
./get-ddl.sh -o ddl.sql -z SPLICE -v

Add the ddl to the existing to output file
./get-ddl.sh -o ddl.sql -z SPLICE -a
</div>
</section>
