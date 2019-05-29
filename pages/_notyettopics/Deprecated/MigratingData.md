---
title: Migrating to Splice Machine
summary: Using the Splice Machine DB Migration Tools
keywords: migrating data
toc: false
product: all
sidebar: home_sidebar
permalink: splicetools_dbmigrate.html
folder: SpliceTools
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% include splicevars.html %}

# Migrating to Splice Machine
This topic describes how to migrate your Splice Machine database to the latest version of Splice Machine software using the *Splice Machine Migration Assistant*.

You can complete the migration process in these simple steps:
* [Download and Install the Migration Assistant](#Download)
* [Use the Migration Assistant to Export Your Database](#Use)
* [Update to the Latest Version of Splice Machine](#Update)
* [Use the Migration Assistant to Import Your Database](#Use2)

You use the same Migration Assistant tool to export your database before updating your Splice Machine installation, and to subsequently import your database after updating.

## Download and Install the Migration Assistant  {#Download}

To download and install the <em>Splice Machine Migration Assistant</em> tool, follow these steps:

1. Verify prerequisites:
   Make sure that you have version 1.8 (or later) of the JRE installed on the node. You can view the version of JRE installed on most computers by using the following command:

   ```
   java -XshowSettings:properties -version
   ```

2. Download the Migration Assistant:
   Download the tool in compressed archive format to the home directory of your standalone computer or to any node in your cluster. You'll find `gz` and `zip` versions of the the download package here: <a href="{{splvar_basic_MigrationToolUrl}}"

3. Unpackage the Tool:
   Unpackage the archive you downloaded on your node, which contains these files:

    <table>
        <col />
        <col />
        <thead>
            <tr>
                <th>File</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="CodeFont">Migration.sh</td>
                <td>The script you use to run the Migration Assistant once you have the configuration file set up.</td>
            </tr>
            <tr>
                <td class="CodeFont">ddlutils-&lt;version&gt;.jar</td>
                <td>The Migration Assistant code.</td>
            </tr>
            <tr>
                <td class="CodeFont">README.md</td>
                <td>The Read Me file for the Migration Assistant.</td>
            </tr>
            <tr>
                <td class="CodeFont">prop.cfg</td>
                <td>The configuration file used by the Migration Assistant. You need to modify this file before exporting or importing your database.</td>
            </tr>
        </tbody>
    </table>

## Use the Migration Assistant to Export Your Database  {#Use}

To export your database prior to upgrading your Splice Machine software, you need to:

1. Edit the `prop.cfg` file to configure your settings. See the [Migration Assistant Configuration Settings](#Migratio) section below for details.
   Make sure that you have the `operation` property set to `backup`.

2. Verify that permissions are set correctly for the directory you specify for bad record information is in HDFS (the value of the `hdfsBadDir` configuration setting); substitute that directory name for `&lt;hdfsBadDir&gt;` in the following command line:

   <div class="PreWrapper"><pre class="ShellCommand">chmod 777 <span class="Highlighted">hdfsBadDir</span></pre></div>

3. Verify that the directory you specify for the work file (the value of the `hdfsWorkDir` configuration property) is present on the computer you're using.

4. Run the `Migration.sh` script to export your database.

5. Examine the log file to verify that the export worked as you expect. See [The Export Log File](#The) section below for details on the generated log table.


## Update to the Latest Version of Splice Machine  {#Update}

Update your Splice Machine installation to the latest version. Our [installation page](#onprem_install_intro.html) has links to the instructions for your version.

## Use the Migration Assistant to Import Your Database  {#Use2}

After you've upgraded your database, you can use the Migration Assistant a second time to restore the database you previously exported. Follow these steps:

1. Verify that the Splice Machine region servers are running after the upgrade. You can easily verify this by issuing the following commands at the splice&gt; command prompt:

   <div class="PreWrapper"><pre class="Example">
   splice&gt; select * from SYS.SYSTABLES;
   splice&gt; select * from SYS.SYSTABLES --splice-properties useSpark=true;</pre>
   </div>

2. Edit the `prop.cfg` file with your desired configuration settings. Make sure that you change the the `operation` property set to `restore`.

3. Update any settings that start with import, as required. See the [Migration Assistant Configuration Settings](#Migratio)  section below for details.

4. Run the `Migration.sh` script to import your upgraded database.

5. Examine the log file to verify that the export worked as you expect. See [The Export Log File](#The) section below for details on the generated log table.

6. Verify that your database has been restored.

## Migration Assistant Configuration Settings  {#Migratio}

The following table describes the configuration properties you can specify in the Migration Assistant's `prop.cfg` file.

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Property Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">operation</td>
            <td>
The Migration Assistant offers two operation modes:

                <table>
                    <col />
                    <col />
                    <tbody>
                        <tr>
                            <td class="CodeFont">backup</td>
                            <td>Prepare your database for upgrade by exporting it.</td>
                        </tr>
                        <tr>
                            <td class="CodeFont">restore</td>
                            <td>Restore your database after upgrading by importing a previously exported database.</td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">fileWorkDir</td>
            <td>
The path of the directory in the local file system of the node on which you are running the Migration Assistant the local file system

            </td>
        </tr>
        <tr>
            <td class="CodeFont">hdfsDataDir</td>
            <td>
The path to the working directory in HDFS in which the exported/imported data files are stored. Each table's data is stored in a separate file that is named as (with bracketed values replaced by your actual directory, schema, and table names)d:

                <div class="preWrapper"><pre class="Plain">&lt;hdfsDataDir&gt;/&lt;schema-name&gt;/&lt;table-name&gt;/&lt;backedup data&gt;.csv</pre>
                </div>
Note that you can verify data that has been written with commands such as the following:

                <div class="preWrapper"><pre class="ShellCommand">sudo su &lt;userId&gt;<br />hadoop fs -ls /&lt;hdfsDataDir&gt;/&lt;schema-name&gt;/&lt;table-name&gt;/*</pre>
                </div>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">hdfsBadDir</td>
            <td>
The path to the directory in which you want all bad record information recorded.

If you do not specify a directory here, then all errors found in a specific table are stored in a subdirectory of the <span class="CodeFont">hdfsDataDir</span> directory:

                <div class="preWrapper"><pre class="Plain">&lt;hdfsDataDir&gt;/&lt;schema-name&gt;/&lt;table-name&gt;/</pre>
                </div>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">tables</td>
            <td>
Specifies which tables and schemas you want to upgrade (export and then import). Leave this blank if you want all schemas and tables in your data upgraded.

If you want to upgrade only a specific schema or set of schemas, use a list; for example:

                <div class="preWrapperWide"><pre class="Example">SPLICE.*,MYSCHEMA.*</pre>
                </div>
If you want to upgrade only a specific table or set of tables, use a list; for example:

                <div class="preWrapperWide"><pre class="Example">SPLICE.MyTable1,SPLICE.MyTable2</pre>
                </div>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">multilineImportTables</td>
            <td>
A Boolean value that specifies whether each line in the import file contains one complete record. Use one of the following values:

                <table>
                    <col />
                    <col />
                    <tbody>
                        <tr>
                            <td class="CodeFont">null</td>
                            <td>Each record is stored in one line in the file.</td>
                        </tr>
                        <tr>
                            <td class="CodeFont">true</td>
                            <td>Each record can span multiple lines in the file.</td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">exportObject</td>
            <td>
Which object types to export from your database; specify one of the following values:

                <table>
                    <col />
                    <col />
                    <tbody>
                        <tr>
                            <td class="CodeFont">ddl</td>
                            <td>Import only the data definitions, not the data.</td>
                        </tr>
                        <tr>
                            <td class="CodeFont">data</td>
                            <td>Import only the data, not the data definitions.</td>
                        </tr>
                        <tr>
                            <td class="CodeFont">all</td>
                            <td>Import all of the exported data definitions and data.</td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">exportServers</td>
            <td>
The name of the server(s) to use for exporting the data. You can use a comma-separated list to specify multiple servers; for example:

                <div class="preWrapper"><pre class="Example">server-011, server-02, server-03</pre>
                </div>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">exportDbUser</td>
            <td>
The user ID to use for the upgraded database when you export it.

The default user ID for Splice Machine databases is <span class="CodeFont">splice</span>.

            </td>
        </tr>
        <tr>
            <td class="CodeFont">exportDbPassword</td>
            <td>
The password to use for the upgraded database when you export it.

The default password for Splice Machine databases is <span class="CodeFont">admin</span>.

            </td>
        </tr>
        <tr>
            <td class="CodeFont">exportThreadCount</td>
            <td>
The number of export threads to use. You can increase the default value (1 thread) to improve performance.

            </td>
        </tr>
        <tr>
            <td class="CodeFont">importObject</td>
            <td>
Which object types to import from the previously exported file; specify one of the following values:

                <table>
                    <col />
                    <col />
                    <tbody>
                        <tr>
                            <td class="CodeFont">ddl</td>
                            <td>Import only the data definitions, not the data.</td>
                        </tr>
                        <tr>
                            <td class="CodeFont">data</td>
                            <td>Import only the data, not the data definitions.</td>
                        </tr>
                        <tr>
                            <td class="CodeFont">all</td>
                            <td>Import all of the exported data definitions and data.</td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">importServers</td>
            <td>
The name of the server(s) to use for importing the data. You can use a comma-separated list to specify multiple servers; for example:

                <div class="preWrapper"><pre class="Example">server-011, server-02, server-03</pre>
                </div>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">importDbUser</td>
            <td>
The user ID to use for the upgraded database when you import it.  This is typically the same user ID specified in the <span class="CodeFont">importDbPassword</span> property.

The default user ID for Splice Machine databases is <span class="CodeFont">splice</span>.

            </td>
        </tr>
        <tr>
            <td class="CodeFont">importDbPassword</td>
            <td>
The password to use for the upgraded database when you import it. This is typically the same password specified in the <span class="CodeFont">exportDbPassword</span> property.

The default password for Splice Machine databases is <span class="CodeFont">admin</span>.

            </td>
        </tr>
        <tr>
            <td class="CodeFont">importThreadCount</td>
            <td>
The number of import threads to use. You can increase the default value (1 thread) to improve performance.

            </td>
        </tr>
    </tbody>
</table>

## The Export Log File  {#The}

The following table shows the contents of the `EXPORT_IMPORT_LOG` file that the Migration Assistant generates.

<table>
    <caption>Database export logtable</caption>
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Column Name</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">S_NO</td>
            <td class="CodeFont">INTEGER</td>
            <td class="CodeFont">
GENERATED BY DEFAULT AS IDENTITY<br />(start with 0, increment by 1)

            </td>
        </tr>
        <tr>
            <td class="CodeFont">SCHEMA_NAME</td>
            <td class="CodeFont">VARCHAR(100)</td>
            <td>The name of the schema being processed.</td>
        </tr>
        <tr>
            <td class="CodeFont">TABLE_NAME</td>
            <td class="CodeFont">VARCHAR(100)</td>
            <td>The name of the table being processed.</td>
        </tr>
        <tr>
            <td class="CodeFont">DDL_EXPORT_FLAG</td>
            <td class="CodeFont">CHAR(1)</td>
            <td>
The status of the DDL export; this is one of the following values:

                <table>
                    <col />
                    <col />
                    <tbody>
                        <tr>
                            <td class="CodeFont">S</td>
                            <td>The operation was successful.</td>
                        </tr>
                        <tr>
                            <td class="CodeFont">F</td>
                            <td>The operation failed.</td>
                        </tr>
                        <tr>
                            <td class="CodeFont">null</td>
                            <td>The operation was not performed.</td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">DDL_EXPORT_TS</td>
            <td class="CodeFont">TIMESTAMP</td>
            <td>The time at which the DDL export was performed.</td>
        </tr>
        <tr>
            <td class="CodeFont">DATA_EXPORT_FLAG</td>
            <td class="CodeFont">CHAR(1)</td>
            <td>
The status of the data export; this is one of the following values:

                <table>
                    <col />
                    <col />
                    <tbody>
                        <tr>
                            <td class="CodeFont">S</td>
                            <td>The operation was successful.</td>
                        </tr>
                        <tr>
                            <td class="CodeFont">F</td>
                            <td>The operation failed.</td>
                        </tr>
                        <tr>
                            <td class="CodeFont">null</td>
                            <td>The operation was not performed.</td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">DATA_EXPORT_TS</td>
            <td class="CodeFont">TIMESTAMP</td>
            <td>The time at which the data export was performed.</td>
        </tr>
        <tr>
            <td class="CodeFont">DDL_IMPORT_FLAG</td>
            <td class="CodeFont">CHAR(1)</td>
            <td>
The status of the DDL import; this is one of the following values:

                <table>
                    <col />
                    <col />
                    <tbody>
                        <tr>
                            <td class="CodeFont">S</td>
                            <td>The operation was successful.</td>
                        </tr>
                        <tr>
                            <td class="CodeFont">F</td>
                            <td>The operation failed.</td>
                        </tr>
                        <tr>
                            <td class="CodeFont">null</td>
                            <td>The operation was not performed.</td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">DDL_IMPORT_TS</td>
            <td class="CodeFont">TIMESTAMP</td>
            <td>The time at which the DDL import was performed.</td>
        </tr>
        <tr>
            <td class="CodeFont">DATA_IMPORT_FLAG</td>
            <td class="CodeFont">CHAR(1)</td>
            <td>
The status of the data import; this is one of the following values:

                <table>
                    <col />
                    <col />
                    <tbody>
                        <tr>
                            <td class="CodeFont">S</td>
                            <td>The operation was successful.</td>
                        </tr>
                        <tr>
                            <td class="CodeFont">F</td>
                            <td>The operation failed.</td>
                        </tr>
                        <tr>
                            <td class="CodeFont">null</td>
                            <td>The operation was not performed.</td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">DATA_IMPORT_TS</td>
            <td class="CodeFont">TIMESTAMP</td>
            <td>The time at which the data import was performed.</td>
        </tr>
    </tbody>
</table>

</div>
</section>
