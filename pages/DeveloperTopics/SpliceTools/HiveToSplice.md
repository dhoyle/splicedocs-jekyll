---
title: The Hive-to-Splice Tool
summary:
keywords:
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_splicetools_hivetosplice.html
folder: DeveloperTopics/SpliceTools
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# The Splice Machine Hive-to-Splice Tool

You can use the *Hive-to-Splice* tool to import tables from Hive into your Splice Machine Database. To use this tool, you must:

1. [Modify the configuration file.](#setproperties)
2. [Run the *HiveToSpliceDDLTool* to generate the Splice Machine DDL for the tables you are importing.](#generateddl)
3. [Use Maven to build the runnable jar.](#buildjar)


### Data Types Limitation
The *Hive-to-Splice* tool does not handle the following data types that may be found in your Hive tables:

* Array
* Maps
* Struct
* Uniontype

## Modify the Properties File {#setproperties}
We have provided a default configuration file named `hiveToSplice.properties`, which you can modify with settings that work for your cluster.

You must keep all three of these files in the same directory:
* `HiveToSpliceLoader-1.0.jar`
* `hiveToSplice.properties`
* `log4j.properties`

The following table summarizes the property values:

<table>
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Property Name</th>
            <th>Example Value</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">HIVEJDBC</td>
            <td class="CodeFont">jdbc:hive2://hostname:10000</td>
            <td>Your Hive JDBC connection string</td>
        </tr>
        <tr>
            <td class="CodeFont">HIVEUSER</td>
            <td class="CodeFont">hive</td>
            <td>Your Hive user name</td>
        </tr>
        <tr>
            <td class="CodeFont">HIVEPASSWORD</td>
            <td class="CodeFont">hive</td>
            <td>Your Hive password</td>
        </tr>
        <tr>
            <td class="CodeFont">HIVESCHEMA</td>
            <td class="CodeFont">test</td>
            <td>The source schema in Hive for exporting data</td>
        </tr>
        <tr>
            <td class="CodeFont">HIVETABLES</td>
            <td class="CodeFont">*</td>
            <td><p>Which tables in the source schema you want to export/import.</p>
                <p>You can export multiple tables by specifying their names in a comma-separated list; for example: <code>t1, t2, t3</code>. You can specify <code>*</code> to indicate that you want to export all tables in the schema.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">SPLICEJDBC</td>
            <td class="CodeFont">jdbc:splice://hostname:1527/splicedb</td>
            <td>Your Splice Machine JDBC connection string</td>
        </tr>
        <tr>
            <td class="CodeFont">SPLICEUSER</td>
            <td class="CodeFont">splice</td>
            <td>Your Splice Machine user name</td>
        </tr>
        <tr>
            <td class="CodeFont">SPLICEPASSWORD</td>
            <td class="CodeFont">XXXXXX</td>
            <td>Your Splice Machine password</td>
        </tr>
        <tr>
            <td class="CodeFont">SPLICETARGETEXTERNALSCHEMA</td>
            <td class="CodeFont">hivetmp</td>
            <td>The target schema in Splice Machine for loading data as external tables.</td>
        </tr>
        <tr>
            <td class="CodeFont">SPLICETARGETINTERNALSCHEMA</td>
            <td class="CodeFont">hive</td>
            <td>The target schema in Splice Machine for loading data as internal tables.</td>
        </tr>
        <tr>
            <td class="CodeFont">MAXSTRINGLENGTH</td>
            <td class="CodeFont">512</td>
            <td>The maximum string length; note that <code>STRING</code> type values in Hive will convert to <code>VARCHAR(MAXSTRINGLENGTH)</code> in Splice Machine.</td>
        </tr>
        <tr>
            <td class="CodeFont">DDLOUTPUTFILEPREFIX</td>
            <td class="CodeFont">splice</td>
            <td>The prefix to use for the generated DDL files.</td>
        </tr>
        <tr>
            <td class="CodeFont">ONLYGENERATEDDL</td>
            <td class="CodeFont">false</td>
            <td>Setting of whether execute DDLs on Splice Machine. "true" means only generate Splice Machine's DDL without executing them.</td>
        </tr>
        <tr>
            <td class="CodeFont">IMPORTTOINTERNAL</td>
            <td class="CodeFont">false</td>
            <td>A Boolean value (<code>true</code> or <code>false</code>) that specifies whether to import the tables into Splice as external tables (<code>false</code>) or internal tables (<code>true</code>).</td>
        </tr>
    </tbody>
</table>

## Run the *HiveToSpliceDDLTool* {#generateddl}
Use one of the following command to run the tool that generates the `.sql` files that you'll import into yoru Splice Machine database:

If you're using the default configuration file name (`hiveToSplice.properties`):
````
   java -jar HiveToSpliceDDLTool-1.0.jar
````
{: .ShellCommand}

Or to specify a different configuration file name:
{: .spaceAbove}

````
    java -jar HiveToSpliceDDLTool-1.0.jar myHiveToSplice.properties
````
{: .ShellCommand}

This will generate a set of `.sql` files; the default set is:
{: .spaceAbove}

* `splice-createExternal.sql`
* `splice-createTarget.sql`
* `splice-dropTarget.sql`
* `splice-dropExternal.sql`


## Build the Jar File {#buildjar}

Once you've generated the DDL files, use the following *maven` command, which generates the `HiveToSpliceDDLTool-1.0.jar` in the `./target` subdirectory of your current directory.

````
    mvn clean package
````
{: .ShellCommand}

</div>
</section>
