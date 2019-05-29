---
title: Migrating Your Database to Splice Machine
summary: Using the Splice Machine DB Migration Tool
keywords: migrating data
toc: false
product: all
sidebar: home_sidebar
permalink: splicetools_migratetool.html
folder: SpliceTools
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% include splicevars.html %}

# Migrating to Splice Machine
This topic describes how to migrate a database from another system to the latest version of Splice Machine software using the *Splice Machine Database Migration Tool*.

This tool uses a JDBC connection to directly connect to a third party database system. You can migrate the database to Splice Machine with a direct database connection, or you can use intermediate files. We recommend using scripts and intermediate files to allow for simple re-use.

You can complete the migration process in these simple steps:
* [XXX](#XXX)
* [XXX](#XXX)
* [XXX](#XXX)

XXX.


## DB Vendors Supported in This Release

As of Spring, 2019, the *Database Migration Tool* supports migration of databases from these systems:

* IBM DB2
* Oracle
* Postgres
* Splice Machine (earlier versions)
* SQL Server


## How the Migration Tool Works

The *Database Migration Tool* performs the following tasks. It:

*  Creates DDL scripts compatible with Splice Machine for schemas, tables, users, foreign keys, sequences, and indexes.
   The Migration Tool can:

   <ul class="bullet">
   <li>Export object from specific schemas or all schemas</li>
   <li>Include or exclude specific tables</li>
   <li>Export table column defaults</li>
   <li>Export users</li>
   <li>Export check constraints</li>
   <li>Map specific column data types</li>
{% comment %}
   <li>Map a source schema to a different target schema name.</li>``
{% endcomment %}

*  Creates reusable import scripts that work with Splice Machine's high-performance *Bulk HFile Ingestion* feature
*  Exports views, triggers, functions, stored procedures, and packages to files, which simplifies analysis
*  Creates reusable SQOOP scripts for exporting the data and importing it into Splice Machine
*  Generates a summary (from the log files) of the imports into Splice Machine
*  Generates a summary of SQOOP / Splice Machine activity from the log files


## Running the DB Migration Tool

1.  Make sure the JAR file is in place; this file will have a name like the following:
    <div class="PreWrapperWide"><pre class="ShellCommand">
    database-migration-<span class="HighlightedCode">0.0.1-SNAPSHOT</span>.jar</pre>
    </div>

2.  Use a command line similar to the following to run the code, replacing the highlighted values as described in the table below:
    <div class="PreWrapperWide"><pre class="ShellCommand">
    java -cp <span class="HighlightedCode">$DM_JAR</span>:<span class="HighlightedCode">$ORACLE_JDBC_JAR</span> com.splicemachine.cs.databasemigration.MigrateDatabase -configFile <span class="HighlightedCode">my-config.xml</span> -connectionId <span class="HighlightedCode">oracle</span> -configId <span class="HighlightedCode">default</span></pre>
    </div>

    To run the command in your environment, replace these highlighted values:
    <table>
        <col />
        <col />
        <thead>
            <tr>
                <th>Value Name</th>
                <th>Example Value</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Migration Tool Location</td>
                <td class="CodeFont">$DM_JAR</td>
                <td>Specify the location of the JAR file for the database migration tool (see Step 1).</td>
            </tr>
            <tr>
                <td>JDBC Connect Jar</td>
                <td class="CodeFont">$ORACLE_JDBC_JAR</td>
                <td>The JAR file for connecting to the vendor's database with JDBC.</td>
            </tr>
            <tr>
                <td class="CodeFont">-configFile</td>
                <td class="CodeFont">my-config.xml</td>
                <td>Your configuration settings, as described in <a href="#configsettings">Configuration Settings</a>, below.</td>
            </tr>
            <tr>
                <td class="CodeFont">-connectionId</td>
                <td class="CodeFont">oracle</td>
                <td>The ID of the <code>connection</code> element in your <code>configFile</code> to use. The connection specifies the target and source databases to which you're connecting. For more information, see <a href="#connections">Connections Section</a>, below.</td>
            </tr>
            <tr>
                <td class="CodeFont">-configId</td>
                <td class="CodeFont">default</td>
                <td>The ID of the <code>config</code> element in your <code>configFile</code> to use. The config specifies the options you want to use for this run of the migration tool. For more information, see <a href="#configIds">Configuration IDs</a>, below.</td>
            </tr>
        </tbody>
    </table>

### Sample Shell Scripts for Running the Tool


## Database Migration Tool Configuration

The XML configuration file that controls how your database migration operates is structured as follows:

```
<?xml version="1.0" encoding="UTF-8"?>
<migration>
   <connections>
      <connection id="oracle">
         <databaseVendorFile> ...  </databaseVendorFile>
         <sourceJdbcUrl>      ...  </sourceJdbcUrl>
         <sourceUser>         ...  </sourceUser>
         <sourcePassword>     ...  </sourcePassword>
         <targetJdbcUrl>      ...  </targetJdbcUrl>
         <targetUser>         ...  </targetUser>
         <targetPassword>     ...  </targetPassword>
      </connection>
      <connection id="splice">
         <databaseVendorFile> ...  </databaseVendorFile>
         <sourceJdbcUrl>      ...  </sourceJdbcUrl>
         <sourceUser>         ...  </sourceUser>
         <sourcePassword>     ...  </sourcePassword>
         <targetJdbcUrl>      ...  </targetJdbcUrl>
         <targetUser>         ...  </targetUser>
         <targetPassword>     ...  </targetPassword>
      </connection>
      ...
   </connections

   <configs>
      <config id="default">
         <scriptOutputPath>     ...  </scriptOutputPath>
         <debugOptions>         ...  </debugOptions>
         <schemas>              ...  </schemas>
         <createDDLOptions>     ...  </createDDLOptions>
         <exportDataOptions>    ...  </exportDataOptions>
            <exportObjectOptions>  ...  </exportObjectOptions>
         <spliceImport>         ...  </spliceImport>
         <sqoopOptions>         ...  </sqoopOptions>
         <dataTypeMapping>      ...  </dataTypeMapping>
      </config>
      <config id="myConfig">
         <scriptOutputPath>     ...  </scriptOutputPath>
         <debugOptions>         ...  </debugOptions>
         <schemas>              ...  </schemas>
         <createDDLOptions>     ...  </createDDLOptions>
         <exportDataOptions>    ...  </exportDataOptions>
            <exportObjectOptions>  ...  </exportObjectOptions>
         <spliceImport>         ...  </spliceImport>
         <sqoopOptions>         ...  </sqoopOptions>
         <dataTypeMapping>      ...  </dataTypeMapping>
      </config>
      ...
	</configs>
</migration>
```
{: .Example}
<br />

The remainder of this section contains subsections for each of the major elements, including an example, and a summary table:

* [Connections](#connections) section
* [Configs](#configs) section
* **********************FINISH THIS

### Connections Section  {#connections}

The `<connections>` section of the configuration file contains one or more `<connection id="ID">` entries, each of which has a unique ID; you specify one of these IDs on the command line to indicate which connection to use when running the Migration Tool.

Here's an example of a `connections` section:

```
<connections>
   <connection id="oracle">
       <databaseVendorFile>/Users/erindriggers/git/customer-solutions/database-migration/src/main/resources/databaseVendors.xml</databaseVendorFile>
       <sourceJdbcUrl>jdbc:oracle:thin:@stl-colo-srv38:1521:boso</sourceJdbcUrl>
       <sourceUser>ALLINKDBA</sourceUser>
       <sourcePassword>bigdata4u</sourcePassword>      <targetJdbcUrl>jdbc:splice://stl-colo-srv110:1527/splicedb</targetJdbcUrl>
      <targetUser>splice</targetUser>
      <targetPassword>admin</targetPassword>
   </connection>
   <connection id="sqlserver">
      <databaseVendorFile>/Users/erindriggers/git/customer-solutions/database-migration/src/main/resources/databaseVendors.xml</databaseVendorFile>
      <sourceJdbcUrl>jdbc:sqlserver://172.16.4.2:1433;databaseName=AdventureWorks2008R2</sourceJdbcUrl>
      <sourceUser>sa</sourceUser>
      <sourcePassword>bigdata4u</sourcePassword>
      <targetJdbcUrl>jdbc:splice://localhost:1527/splicedb</targetJdbcUrl>
      <targetUser>splice</targetUser>
      <targetPassword>admin</targetPassword>
   </connection>
   <connection id="splicemachine">
       <databaseVendorFile>/Users/erindriggers/git/customer-solutions/database-migration/src/main/resources/databaseVendors.xml</databaseVendorFile>
       <sourceJdbcUrl>jdbc:splice://localhost:1527/splicedb</sourceJdbcUrl>
       <sourceUser>splice</sourceUser>
       <sourcePassword>admin</sourcePassword>
       <targetJdbcUrl>jdbc:splice://localhost:1527/splicedb</targetJdbcUrl>
       <targetUser>splice</targetUser>
       <targetPassword>admin</targetPassword>
   </connection>
   <connection id="postgres">
      <databaseVendorFile>/Users/erindriggers/IdeaProjects/customer-solutions/database-migration/src/main/resources/databaseVendors.xml</databaseVendorFile>
      <sourceJdbcUrl>jdbc:postgresql://localhost:5432/splicemachine</sourceJdbcUrl>
      <sourceUser>dev</sourceUser>
      <sourcePassword>123456</sourcePassword>      <targetJdbcUrl>jdbc:splice://stl-colo-srv110:1527/splicedb</targetJdbcUrl>
      <targetUser>splice</targetUser>
      <targetPassword>admin</targetPassword>
   </connection>
</connections>
```
{: .Example}
<br />

Here's a summary of each element in the `connections` section:
<table>
    <col width="200px"/>
    <col />
    <col />
    <thead>
        <tr>
            <th>Section</th>
            <th>Value Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowSpan="8" class="CodeFont">&lt;connection=&quot;&lt;ID&gt;&quot;&gt;</td>
            <td class="CodeFont">id</td>
            <td>The <code>id</code> is your name for this connection, which is used on the command line when running the Migration Tool.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;databaseVendorFile&gt;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;sourceJdbcUrl&gt;</td>
            <td>The JDBC URL to use to access the source database.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;sourceUser&gt;</td>
            <td>Your user ID for accessing the source database.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;sourcePassword&gt;</td>
            <td>Your password for accessing the source database.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;targetJdbcUrl&gt;</td>
            <td>If you are using a direct connection (not writing to files), this is the JDBC URL to use to access the target database.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;targetUser&gt;</td>
            <td>If you are using a direct connection (not writing to files), this is your user ID for accessing the target database.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;targetPassword&gt;</td>
            <td>If you are using a direct connection (not writing to files), this is your password for accessing the target database.</td>
        </tr>
    </tbody>
</table>


### Configs Section  {#configsettings}

The `<configs>` section of the configuration file contains one or more `<config id="ID">`, each of which has a unique ID; you specify one of these IDs on the command to indicate which configuration to use when running the Migration Tool.

<table>
    <col width="200px" />
    <col />
    <col />
    <thead>
        <tr>
            <th>Section</th>
            <th>Value Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowSpan="10" class="CodeFont">&lt;config=&quot;&lt;ID&gt;&quot;&gt;</td>
            <td class="CodeFont">id</td>
            <td>The <code>id</code> is your name for this set of configuration settings, which is used on the command line when running the Migration Tool.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;scriptOutputPath&gt;</td>
            <td>The root directory in which the output files and scripts will be placed.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;debugOptions&gt;</td>
            <td>Debugging options, enumerated in the <a href="#debugOptions">Debug Options</a> section, below.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;schemas&gt;</td>
            <td>Schema options, enumerated in the <a href="#schemas">Schemas section</a>, below.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;createDDLOptions&gt;</td>
            <td>DDL options, enumerated in the <a href="#createddl">Create DDL section</a>, below.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;exportDataOptions&gt;</td>
            <td>Data Export options, enumerated in the <a href="#exportdata">Export Data Options</a> section, below.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;exportObjectOptions&gt;</td>
            <td>Options for exporting objects such as stored procedures, triggers, packages, and functions; these are enumerated in the <a href="#exportobjects">Export Object Options</a> section, below.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;spliceImport&gt;</td>
            <td>Used in combination with the `create table` script to specify options for importing into your Splice Machine database; these are enumerated in the <a href="#importOptions">Import Options</a> section, below.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;sqoopOptions&gt;</td>
            <td>Used to create the Sqoop scripts that are used to export the data from another database and import that data into your Splice Machine database. These options are enumerated in the <a href="#sqoopOptions">Sqoop Options</a> section, below.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;dataTypeMapping&gt;</td>
            <td>Used to manage problematic data type conversions: there are a few specific problems converting Oracle data types into Splice Machine data types. These options are enumerated in the <a href="#datatypemapping">Data Type Mapping Options</a> section, below.</td>
        </tr>
    </tbody>
</table>

#### Debug Options  {#debugOptions}

Here's an example of the `debugOptions` section:

```
<debugOptions>
   <log>WARN</log>
   <printDatabaseStats>false</printDatabaseStats>
   <printListOfTables>false</printListOfTables>
   <printListOfTablesRecordCount>false</printListOfTablesRecordCount>
</debugOptions>
```
{: .Example}
<br />

These are the options you can specify in the `<debugOptions>` subsection of the `<configs>` section:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Value Name</th>
            <th>Possible Values</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">&lt;log&gt;</td>
            <td class="CodeFont">ERROR, WARN, INFO, DEBUG, VERBOSE</td>
            <td>The logging level for printing output to the console.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;printDatabaseStats&gt;</td>
            <td class="CodeFont">true, false</td>
            <td>Prints a list of database statistics.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;printListOfTables&gt;</td>
            <td class="CodeFont">true, false</td>
            <td>Print a list of the tables in the database.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;printListOfTablesRecordCount&gt;</td>
            <td class="CodeFont">true, false</td>
            <td>Prints a list with the record count for each table in the database.</td>
        </tr>
    </tbody>
</table>

#### Schemas  {#schemas}

Here's an example of the `schemas` section of a configuration file:

```
<schemas>
   <processAllSchemas>false</processAllSchemas>
   <processSchemas>
      <includeSchemas>
         <schemaName>MDBCUSTOMER</schemaName>
      </includeSchemas>
      <excludeSchemas>
         <schemaName></schemaName>
      </excludeSchemas>
   </processSchemas>

   <schemaNameMapping>
      <schema source="public" target="publicmine" />
   </schemaNameMapping>

   <inclusionsExclusions>
      <schema name="public">
         <tablesToInclude>
            <table></table>
         </tablesToInclude>
         <tablesToExclude>
            <table></table>
         </tablesToExclude>
      </schema>
   </inclusionsExclusions>
</schemas>
```
{: .Example}
<br />

These are the options you can specify in the `<schemas>` subsection of the `<configs>` section:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Element Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
    		<td class="CodeFont">&lt;processAllSchemas&gt;</td>
    		<td><p>If this is <code>true</code>, all schemas are processed.</p>
    		 	<p>If this is <code>false</code>, only the schemas in the <code>processSchemas</code> are processed.</p>
    		</td>
        </tr>
        <tr>
    		<td class="CodeFont">&lt;processSchemas&gt;</td>
    		<td><p>This section is used to list the schemas that you want processed when <code>processAllSchemas=false</code>.</p>
    			<p>You also use this section when <code>processAllSchemas=true</code>, to specify which schemas you want excluded.</p>
    		</td>
        </tr>
        <tr>
    		<td class="CodeFont">&lt;includeSchemas&gt;</td>
    		<td>Includes a <code>schemaName</code> element for each schema you want processed when <code>processAllSchemas=false</code>.</td>
        </tr>
        <tr>
			<td class="CodeFont">&lt;excludeSchemas&gt;</td>
			<td>Includes a <code>schemaName</code> element for each schema you want excluded when <code>processAllSchemas=true</code>.</td>
        </tr>
        <tr>
			<td class="CodeFont">&lt;schemaName&gt;</td>
			<td>Names a schema that you want included or excluded.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;schemaNameMapping&gt;</td>
            <td><p>Allows you to map a source schema name to a target schema name, with a <code>&lt;schema&gt;</code>element.</p>
                <p>If no <code>&lt;schema&gt;</code>element is included, the target schema name is the same as the source schema name.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;schema source="name" target="name"&gt;</td>
            <td>Specifies the source and target names for a schema name mapping.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;inclusionsExclusions&gt;</td>
            <td><p>Use this section to specify special processing rules for the tables within a schema.</p>
                <p>Repeat this section for each schema that has such rules.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;schema name=&gt;</td>
            <td>The name of the scheme whose tables you want to include or exclude.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;tablesToInclude&gt;</td>
            <td>The names of tables in the schema to include. Any unnamed tables will be excluded.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;tablesToExclude&gt;</td>
            <td>The name of tables in the schema to exclude. Any unnamed tables will be included.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;table&gt;</td>
            <td>Names a table to include or exclude.</td>
        </tr>
    </tbody>
</table>
#### Create DDL Options  {#createddl}

Here's an example of the `createDDLOptions` section of a configuration file:

```
<createDDLOptions>
      <createTable>true</createTable>
      <createTableSubDirectory>/ddl/create/tables</createTableSubDirectory>
      <padVarcharColumns>false</padVarcharColumns>
      <padVarcharColumnValue>25</padVarcharColumnValue>
      <padCharColumns>false</padCharColumns>
      <padCharColumnValue>5</padCharColumnValue>
      <useUniqueIndexForMissingPrimary>true</useUniqueIndexForMissingPrimary>
      <primaryKeyUniqueIndexPrefix>^PK_</primaryKeyUniqueIndexPrefix>
      <createCheckConstraints>true</createCheckConstraints>
      <createConstraintSubDirectory>/ddl/create</createConstraintSubDirectory>
      <createForeignKeys>true</createForeignKeys>
      <createForeignKeysSubDirectory>/ddl/create/fkeys</createForeignKeysSubDirectory>
       <addColumnDefaults>true</addColumnDefaults>
      <createIndexes>false</createIndexes>
      <createIndexSubDirectory>/ddl/create/indexes</createIndexSubDirectory>
      <createUsers>true</createUsers>
      <createUserSubDirectory>/ddl/create</createUserSubDirectory>
      <skipUsers></skipUsers>
      <createSequence>true</createSequence>
      <createSequenceSubDirectory>/ddl/create/sequence</createSequenceSubDirectory>
      <createRoles>false</createRoles>
      <rolesToCreate>
          <role>{SCHEMA}_READ</role>
          <role>{SCHEMA}_WRITE</role>
          <role>{SCHEMA}_EXECUTE</role>
       </rolesToCreate>
      <createRoleSubDirectory>/ddl/create/roles</createRoleSubDirectory>
      <createGrantRead>false</createGrantRead>
      <rolesToGrantRead>{SCHEMA}_READ</rolesToGrantRead>
      <createGrantWrite>false</createGrantWrite>
      <rolesToGrantRead>{SCHEMA}_WRITE</rolesToGrantRead>
      <createGrantExecute>false</createGrantExecute>
      <rolesToGrantRead>{SCHEMA}_EXECUTE</rolesToGrantRead>
      <createGrantSubDirectory>/ddl/create/grants</createGrantSubDirectory>
      <dropTables>true</dropTables>
      <dropTableSubDirectory>/ddl/drop/tables</dropTableSubDirectory>
      <dropForeignKeys>true</dropForeignKeys>
      <dropForeignKeysSubDirectory>/ddl/drop/fkeys</dropForeignKeysSubDirectory>
      <dropIndexes>true</dropIndexes>
      <dropIndexSubDirectory>/ddl/drop/indexes</dropIndexSubDirectory>
      <dropTriggers>true</dropTriggers>
      <dropTriggerSubDirectory>/ddl/drop/triggers</dropTriggerSubDirectory>
      <dropSequence>true</dropSequence>
      <dropSequenceSubDirectory>/ddl/drop/sequence</dropSequenceSubDirectory>
      <createTableFileFormat>{SCHEMA}-create-tables.sql</createTableFileFormat>
      <dropTableFileFormat>{SCHEMA}-drop-tables.sql</dropTableFileFormat>
      <createSequenceFileFormat>{SCHEMA}-create-sequences.sql</createSequenceFileFormat>
      <dropSequenceFileFormat>{SCHEMA}-drop-sequences.sql</dropSequenceFileFormat>
      <createIndexFileFormat>{SCHEMA}-create-indexes.sql</createIndexFileFormat>
      <dropIndexFileFormat>{SCHEMA}-drop-indexes.sql</dropIndexFileFormat>
      <createUniqueIndexFileFormat>{SCHEMA}-create-unique-indexes.sql</createUniqueIndexFileFormat>
      <dropUniqueIndexFileFormat>{SCHEMA}-drop-unique-indexes.sql</dropUniqueIndexFileFormat>
      <createFKeyFileFormat>{SCHEMA}-create-fkeys.sql</createFKeyFileFormat>
      <dropFKeyFileFormat>{SCHEMA}-drop-fkeys.sql</dropFKeyFileFormat>
</createDDLOptions>
```
{: .Example}
<br />


These are the options you can specify in the `<createDDLOptions>` subsection of the `<configs>` section:


<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Value Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
        	<td class="CodeFont">&lt;createTable&gt;</td>
        	<td>Indicates if the create table scripts should be created</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createTableSubDirectory&gt;</td>
        	<td><p>The directory relative to the root directory into which the create table scripts are written.</p>
                <p>The root directory is specified by the <code>scriptOutputPath</code> element, at the top of the <code>config</code> element.</p>
            </td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;padVarcharColumns&gt;</td>
        	<td>If this value is <code>true</code>, the DDL will pad any varchar column by the value specified in <code>padVarcharColumnValue</code>.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;padVarcharColumnValue&gt;</td>
        	<td>The number of chars to pad varchar columns with when the <code>padVarcharColumns</code> option is <code>true</code>.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;padCharColumns&gt;</td>
        	<td>If this value is <code>true</code>, the DDL will pad any char column by the value specified in <code>padCharColumnValue</code>.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;padCharColumnValue&gt;</td>
        	<td>The number of chars to pad char columns with when the <code>padCharColumns</code> option is <code>true</code>.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;useUniqueIndexForMissingPrimary&gt;</td>
        	<td>If this is <code>true</code>, then the migration tool looks for a unique index on a table that has no primary key.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;primaryKeyUniqueIndexPrefix&gt;</td>
        	<td>Specifies a prefix to look for; when looking at unique indexes, only unique indexes that start with this prefix are considered.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createCheckConstraints&gt;</td>
        	<td>If this is <code>true</code>, check constraints are exported.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createConstraintSubDirectory&gt;</td>
        	<td><p>The directory relative to the root directory into which the create constraint scripts are written.</p>
                <p>The root directory is specified by the <code>scriptOutputPath</code> element, at the top of the <code>config</code> element.</p>
            </td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createForeignKeys&gt;</td>
        	<td>If this is <code>true</code>, foreign keys scripts are created.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createForeignKeysSubDirectory&gt;</td>
        	<td><p>The directory relative to the root directory into which the foreign key scripts are written.</p>
                <p>The root directory is specified by the <code>scriptOutputPath</code> element, at the top of the <code>config</code> element.</p>
            </td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;addColumnDefaults&gt;</td>
        	<td>If this is <code>true</code>, column defaults are extracted and added to the DDL.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createIndexes&gt;</td>
        	<td>If this is <code>true</code>, index script are created.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createIndexSubDirectory&gt;</td>
        	<td><p>The directory relative to the root directory into which the create index scripts are written.</p>
                <p>The root directory is specified by the <code>scriptOutputPath</code> element, at the top of the <code>config</code> element.</p>
            </td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createUsers&gt;</td>
        	<td>If this is <code>true</code>, users are exported.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createUserSubDirectory&gt;</td>
        	<td><p>The directory relative to the root directory into which the create user scripts are written.</p>
                <p>The root directory is specified by the <code>scriptOutputPath</code> element, at the top of the <code>config</code> element.</p>
            </td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;skipUsers&gt;</td>
        	<td>This is a list of users that should be skipped.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createSequence&gt;</td>
        	<td>If this is <code>true</code>, sequences are exported.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createSequenceSubDirectory&gt;</td>
        	<td><p>The directory relative to the root directory into which the create sequence scripts are written.</p>
                <p>The root directory is specified by the <code>scriptOutputPath</code> element, at the top of the <code>config</code> element.</p>
            </td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createRoles&gt;</td>
        	<td>If this is <code>true</code>, create roles scripts are created.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;rolesToCreate&gt;</td>
        	<td>A list of roles to create, per schema.</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;role&gt;</td>
            <td>A schema-specific role to create.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createRoleSubDirectory&gt;</td>
        	<td><p>The directory relative to the root directory into which the create roles scripts are written.</p>
                <p>The root directory is specified by the <code>scriptOutputPath</code> element, at the top of the <code>config</code> element.</p>
            </td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createGrantRead&gt;</td>
        	<td>If this is <code>true</code>, the grant read script is created.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;rolesToGrantRead&gt;</td>
        	<td>A comma-separated list of roles to which read access will be granted.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createGrantWrite&gt;</td>
        	<td>If this is <code>true</code>, the grant write script is created.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;rolesToGrantRead&gt;</td>
        	<td>A comma-separated list of roles to which write access will be granted.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createGrantExecute&gt;</td>
        	<td>If this is <code>true</code>, the grant execute script is created.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;rolesToGrantRead&gt;</td>
        	<td>A comma-separated list of roles to which execute access will be granted.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createGrantSubDirectory&gt;</td>
        	<td><p>The directory relative to the root directory into which the grant scripts are written.</p>
                <p>The root directory is specified by the <code>scriptOutputPath</code> element, at the top of the <code>config</code> element.</p>
            </td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;dropTables&gt;</td>
        	<td>If this is <code>true</code>, drop table scripts are created.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;dropTableSubDirectory&gt;</td>
        	<td><p>The directory relative to the root directory into which the drop table scripts are written.</p>
                <p>The root directory is specified by the <code>scriptOutputPath</code> element, at the top of the <code>config</code> element.</p>
            </td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;dropForeignKeys&gt;</td>
        	<td>If this is <code>true</code>, drop foreign keys scripts are created.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;dropForeignKeysSubDirectory&gt;</td>
        	<td><p>The directory relative to the root directory into which the drop foreign keys scripts are written.</p>
                <p>The root directory is specified by the <code>scriptOutputPath</code> element, at the top of the <code>config</code> element.</p>
            </td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;dropIndexes&gt;</td>
        	<td>If this is <code>true</code>, drop index scripts are created.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;dropIndexsSubDirectory&gt;</td>
        	<td><p>The directory relative to the root directory into which the drop indexes scripts are written.</p>
                <p>The root directory is specified by the <code>scriptOutputPath</code> element, at the top of the <code>config</code> element.</p>
            </td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;dropTriggers&gt;</td>
        	<td>If this is <code>true</code>, drop triggers scripts are created.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;dropTriggerSubDirectory&gt;</td>
        	<td><p>The directory relative to the root directory into which the drop triggers scripts are written.</p>
                <p>The root directory is specified by the <code>scriptOutputPath</code> element, at the top of the <code>config</code> element.</p>
            </td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;dropSequence&gt;</td>
        	<td>If this is <code>true</code>, drop foreign keys scripts are created.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;dropSequenceSubDirectory&gt;</td>
        	<td><p>The directory relative to the root directory into which the drop sequence scripts are written.</p>
                <p>The root directory is specified by the <code>scriptOutputPath</code> element, at the top of the <code>config</code> element.</p>
            </td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createTableFileFormat&gt;</td>
        	<td>The file format for the create tables file.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;dropTableFileFormat&gt;</td>
        	<td>The file format for the drop tables file.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createSequenceFileFormat&gt;</td>
        	<td>The file format for the create sequences file.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;dropSequenceFileFormat&gt;</td>
        	<td>The file format for the drop sequences file.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createIndexFileFormat&gt;</td>
        	<td>The file format for the create indexes file.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;dropIndexFileFormat&gt;</td>
        	<td>The file format for the drop indexes file.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createUniqueIndexFileFormat&gt;</td>
        	<td>The file format for the create unique indexes file.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;dropUniqueIndexFileFormat&gt;</td>
        	<td>The file format for the drop unique indexes file.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;createFKeyFileFormat&gt;</td>
        	<td>The file format for the create fkeys file.</td>
        </tr>
        <tr>
        	<td class="CodeFont">&lt;dropFKeyFileFormat&gt;</td>
        	<td>The file format for the drop fkeys file.</td>
        </tr>
    </tbody>
</table>

============================== START HERE =============================================
#### Export Data Options  {#exportdata}

Here's an example of an `exportDataOptions` section:

```
```
{: .Example}
<br />

These are the options you can specify in the `<exportDataOptions>` subsection of the `<configs>` section:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Value Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
    </tbody>
</table>

#### Export Object Options  {#exportobjects}

Here's an example of an `exportObjectOptions` section:

```
```
{: .Example}
<br />

These are the options you can specify in the `<exportObjectOptions>` subsection of the `<configs>` section:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Value Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
    </tbody>
</table>


#### Import Options  {#import}

Here's an example of an `spliceImport` section:

```
```
{: .Example}
<br />

These are the options you can specify in the `<spliceImport>` subsection of the `<configs>` section:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Value Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
    </tbody>
</table>

#### Sqoop Options  {#sqoop}

Here's an example of an `sqoopOptions` section:

```
```
{: .Example}
<br />


These are the options you can specify in the `<sqoopOptions>` subsection of the `<configs>` section:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Value Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
    </tbody>
</table>


#### Data Type Mapping Options  {#datatypemapping}

Here's an example of an `dataTypeMapping` section:

```
```
{: .Example}
<br />


These are the options you can specify in the `<dataTypeMapping>` subsection of the `<configs>` section:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Value Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
        <tr>
            <td class="CodeFont">&lt;XXX&gt;</td>
            <td>XXX</td>
        </tr>
    </tbody>
</table>


## Appendix: Sample Configuration File
The following is a listing of the `my-config.xml` configuration file that is installed with the *Database Migration Tool.* The extensive comments in this file describe the values that you can modify:

```
<?xml version="1.0" encoding="UTF-8"?>
<migration>
   <!-- This is the configuration file used in conjunction with the database-migration tool -->
   <!-- When you launch a data migration you need to specify the connection id and the config id -->
   <!-- The connections define the source and target (if any databases) and are typically reused acrossed configurations -->
   <!-- The configurations allow you to specify how the migration will occur: which object will be migrated, etc -->
   <connections>
      <connection id="oracle">
          <databaseVendorFile>/Users/erindriggers/git/customer-solutions/database-migration/src/main/resources/databaseVendors.xml</databaseVendorFile>
          <sourceJdbcUrl>jdbc:oracle:thin:@stl-colo-srv38:1521:boso</sourceJdbcUrl>
          <sourceUser>ALLINKDBA</sourceUser>
          <sourcePassword>bigdata4u</sourcePassword>
         <!-- This section is only used if you manually set directConnection in the code -->
         <!-- The target database.  This only needs to be specified if you are doing a directory connection -->
         <!-- Where you want the schema to be automatically added to the splice machine database.  -->
         <!-- We recommend that this is only done for testing as typically you want to have the scripts to run against  -->
         <!-- multiple environments -->
         <targetJdbcUrl>jdbc:splice://stl-colo-srv110:1527/splicedb</targetJdbcUrl>
         <targetUser>splice</targetUser>
         <targetPassword>admin</targetPassword>
      </connection>
      <connection id="sqlserver">
         <databaseVendorFile>/Users/erindriggers/git/customer-solutions/database-migration/src/main/resources/databaseVendors.xml</databaseVendorFile>
         <sourceJdbcUrl>jdbc:sqlserver://172.16.4.2:1433;databaseName=AdventureWorks2008R2</sourceJdbcUrl>
         <sourceUser>sa</sourceUser>
         <sourcePassword>bigdata4u</sourcePassword>
         <targetJdbcUrl>jdbc:splice://localhost:1527/splicedb</targetJdbcUrl>
         <targetUser>splice</targetUser>
         <targetPassword>admin</targetPassword>
      </connection>
      <connection id="splicemachine">
          <databaseVendorFile>/Users/erindriggers/git/customer-solutions/database-migration/src/main/resources/databaseVendors.xml</databaseVendorFile>
          <sourceJdbcUrl>jdbc:splice://localhost:1527/splicedb</sourceJdbcUrl>
          <sourceUser>splice</sourceUser>
          <sourcePassword>admin</sourcePassword>
          <targetJdbcUrl>jdbc:splice://localhost:1527/splicedb</targetJdbcUrl>
          <targetUser>splice</targetUser>
          <targetPassword>admin</targetPassword>
      </connection>
      <connection id="postgres">
         <databaseVendorFile>/Users/erindriggers/IdeaProjects/customer-solutions/database-migration/src/main/resources/databaseVendors.xml</databaseVendorFile>
         <sourceJdbcUrl>jdbc:postgresql://localhost:5432/splicemachine</sourceJdbcUrl>
         <sourceUser>dev</sourceUser>
         <sourcePassword>123456</sourcePassword>
         <!-- This section is only used if you manually set directConnection in the code -->
         <!-- The target database.  This only needs to be specified if you are doing a directory connection -->
         <!-- Where you want the schema to be automatically added to the splice machine database.  -->
         <!-- We recommend that this is only done for testing as typically you want to have the scripts to run against  -->
         <!-- multiple environments -->
         <targetJdbcUrl>jdbc:splice://stl-colo-srv110:1527/splicedb</targetJdbcUrl>
         <targetUser>splice</targetUser>
         <targetPassword>admin</targetPassword>
      </connection>
   </connections>
   <configs>
      <config id="default">
         <!-- Indicates where the root directory where the output files and scripts should be placed -->
         <scriptOutputPath>/tmp/database-migration/postgres</scriptOutputPath>

         <debugOptions>
            <!--Prints output to the console.  Valid values ERROR, WARN, INFO, DEBUG or VERBOSE  -->
            <log>WARN</log>
            <!-- Print a list of the database stats. -->
            <printDatabaseStats>false</printDatabaseStats>
            <!-- Print a list of the tables -->
            <printListOfTables>false</printListOfTables>
            <!-- Print a list of the tables with the record count. -->
            <printListOfTablesRecordCount>false</printListOfTablesRecordCount>
         </debugOptions>

         <schemas>
            <!-- Indicates if all the schemas should be processed.  If this is set to yes it will process all the schemas in the database -->
            <!-- If it is false, it will only process the schemas in the processSchemas section -->
            <!-- Regardless -->
            <processAllSchemas>false</processAllSchemas>
            <processSchemas>
               <!-- This will be used when you have processAllSchemas = false -->
               <!-- It should be the list of schemas that you want to process -->
               <includeSchemas>
                  <schemaName>MDBCUSTOMER</schemaName>
               </includeSchemas>
               <!-- There may be times when you want to use the processAllSchemas = true, but there are some schemas you do not want to process -->
               <excludeSchemas>
                  <schemaName></schemaName>
               </excludeSchemas>
            </processSchemas>
            <!-- Provide the ability to map a source schema name to a target schema name.  If no source schema -->
            <!-- is listed in this map, it will use the postgres schema-->
            <schemaNameMapping>
               <schema source="public" target="publicmine" />
            </schemaNameMapping>
            <!-- Regardless if you are processing all schemas or specific schemas, this section can contain a list of tables to specifically -->
            <!-- Include or exclude from processing -->
            <inclusionsExclusions>
               <!-- Repeat this section for each schema that may have special processing rules for the tables -->
               <schema name="public">
                  <tablesToInclude>
                     <!--
                     <table>testjsontable</table>
                     <table>testtexttable</table>
                     -->
                  </tablesToInclude>
                  <tablesToExclude>
                     <table></table>
                  </tablesToExclude>
               </schema>
            </inclusionsExclusions>
         </schemas>

         <createDDLOptions>
            <!-- Indicates if the table create script should be created -->
            <createTable>true</createTable>
            <!-- The directory relative to the root directory (scriptOutputPath above) where the create table scripts should be placed -->
            <createTableSubDirectory>/ddl/create/tables</createTableSubDirectory>
            <!-- Indicates if varchar columns should be padded. If true, the DDL will pad any varchar column by the value specified in padVarcharColumnValue -->
            <padVarcharColumns>false</padVarcharColumns>
            <!-- The number to pad varchar columns with - used only if padVarcharColumns = true -->
            <padVarcharColumnValue>25</padVarcharColumnValue>
            <!-- Indicates if char columns should be padded. If true, the DDL will pad any char column by the value specified in padCharColumnValue -->
            <padCharColumns>false</padCharColumns>
            <!-- The number to pad char columns with - used only if padCharColumns = true -->
            <padCharColumnValue>5</padCharColumnValue>
            <!-- Look for unique index on table if no primary key -->
            <useUniqueIndexForMissingPrimary>true</useUniqueIndexForMissingPrimary>
            <!-- When looking at the unique indexes, only consider unique indexes that have a prefix of the following -->
            <primaryKeyUniqueIndexPrefix>^PK_</primaryKeyUniqueIndexPrefix>
            <!-- Indicates if the check constraints should be exported -->
            <createCheckConstraints>true</createCheckConstraints>
            <!-- The directory relative to the root directory (scriptOutputPath above) where the create constraint scripts should be placed -->
            <createConstraintSubDirectory>/ddl/create</createConstraintSubDirectory>
            <!-- Indicates if the foreign keys script should be created -->
            <createForeignKeys>true</createForeignKeys>
            <!-- The directory relative to the root directory (scriptOutputPath above) where the create index scripts should be placed -->
            <createForeignKeysSubDirectory>/ddl/create/fkeys</createForeignKeysSubDirectory>
             <!-- Indicates if column defaults should be extracted and added to the DDL -->
            <addColumnDefaults>true</addColumnDefaults>
            <!-- Indicates if the index script should be created -->
            <createIndexes>false</createIndexes>
            <!-- The directory relative to the root directory (scriptOutputPath above) where the create index scripts should be placed -->
            <createIndexSubDirectory>/ddl/create/indexes</createIndexSubDirectory>
            <!-- Indicates if the users should be exported -->
            <createUsers>true</createUsers>
            <!-- The directory relative to the root directory (scriptOutputPath above) where the create user scripts should be placed -->
            <createUserSubDirectory>/ddl/create</createUserSubDirectory>
            <!-- List of users that should be skipped -->
            <skipUsers></skipUsers>
            <!-- Indicates if the sequences should be exported -->
            <createSequence>true</createSequence>
            <!-- The directory relative to the root directory (scriptOutputPath above) where the create sequence scripts should be placed -->
            <createSequenceSubDirectory>/ddl/create/sequence</createSequenceSubDirectory>
            <!-- Indicates if the create roles script should be created -->
            <createRoles>false</createRoles>
            <!-- List of roles to create per schema -->
            <rolesToCreate>
               <role>{SCHEMA}_READ</role>
               <role>{SCHEMA}_WRITE</role>
               <role>{SCHEMA}_EXECUTE</role>
            </rolesToCreate>
            <!-- The directory relative to the root directory (scriptOutputPath above) where the create role scripts should be placed -->
            <createRoleSubDirectory>/ddl/create/roles</createRoleSubDirectory>
            <!-- Indicates if the grant read script should be created -->
            <createGrantRead>false</createGrantRead>
            <!-- Comma separated list of roles to grant read access -->
            <rolesToGrantRead>{SCHEMA}_READ</rolesToGrantRead>
            <!-- Indicates if the grant write script should be created -->
            <createGrantWrite>false</createGrantWrite>
            <!-- Comma separated list of roles to grant write access -->
            <rolesToGrantRead>{SCHEMA}_WRITE</rolesToGrantRead>
            <!-- Indicates if the grant execute script should be created -->
            <createGrantExecute>false</createGrantExecute>
            <!-- Comma separated list of roles to grant execute access -->
            <rolesToGrantRead>{SCHEMA}_EXECUTE</rolesToGrantRead>
            <!-- The directory relative to the root directory (scriptOutputPath above) where the grant scripts should be placed -->
            <createGrantSubDirectory>/ddl/create/grants</createGrantSubDirectory>
            <!-- Indicates if the drop table script should be created -->
            <dropTables>true</dropTables>
            <!-- The directory relative to the root directory (scriptOutputPath above) where the drop table scripts should be placed -->
            <dropTableSubDirectory>/ddl/drop/tables</dropTableSubDirectory>
            <!-- Indicates if the foreign keys script should be created -->
            <dropForeignKeys>true</dropForeignKeys>
            <!-- The directory relative to the root directory (scriptOutputPath above) where the drop foreign keys scripts should be placed -->
            <dropForeignKeysSubDirectory>/ddl/drop/fkeys</dropForeignKeysSubDirectory>
            <!-- Indicates if the drop index script should be created -->
            <dropIndexes>true</dropIndexes>
            <!-- The directory relative to the root directory (scriptOutputPath above) where the drop index scripts should be placed -->
            <dropIndexSubDirectory>/ddl/drop/indexes</dropIndexSubDirectory>
            <!-- Indicates if the drop triggers script should be created -->
            <dropTriggers>true</dropTriggers>
            <!-- The directory relative to the root directory (scriptOutputPath above) where the drop trigger scripts should be placed -->
            <dropTriggerSubDirectory>/ddl/drop/triggers</dropTriggerSubDirectory>
            <!-- Indicates if the drop sequences script should be created -->
            <dropSequence>true</dropSequence>
            <!-- The directory relative to the root directory (scriptOutputPath above) where the drop sequence scripts should be placed -->
            <dropSequenceSubDirectory>/ddl/drop/sequence</dropSequenceSubDirectory>
            <!-- The file format for the create tables file-->
            <createTableFileFormat>{SCHEMA}-create-tables.sql</createTableFileFormat>
            <!-- The file format for the drop tables file-->
            <dropTableFileFormat>{SCHEMA}-drop-tables.sql</dropTableFileFormat>
            <!-- The file format for the create sequences file-->
            <createSequenceFileFormat>{SCHEMA}-create-sequences.sql</createSequenceFileFormat>
            <!-- The file format for the drop sequences file-->
            <dropSequenceFileFormat>{SCHEMA}-drop-sequences.sql</dropSequenceFileFormat>
            <!-- The file format for the create indexes file-->
            <createIndexFileFormat>{SCHEMA}-create-indexes.sql</createIndexFileFormat>
            <!-- The file format for the drop indexes file-->
            <dropIndexFileFormat>{SCHEMA}-drop-indexes.sql</dropIndexFileFormat>
            <!-- The file format for the create unique indexes file-->
            <createUniqueIndexFileFormat>{SCHEMA}-create-unique-indexes.sql</createUniqueIndexFileFormat>
            <!-- The file format for the drop unique indexes file-->
            <dropUniqueIndexFileFormat>{SCHEMA}-drop-unique-indexes.sql</dropUniqueIndexFileFormat>
            <!-- The file format for the create fkeys file-->
            <createFKeyFileFormat>{SCHEMA}-create-fkeys.sql</createFKeyFileFormat>
            <!-- The file format for the drop fkeys file-->
            <dropFKeyFileFormat>{SCHEMA}-drop-fkeys.sql</dropFKeyFileFormat>
         </createDDLOptions>

         <!-- Indicates if the data should be exported.  This should be used sparingly because it uses JDBC and does not perform well.-->
         <exportDataOptions>
            <exportData>false</exportData>
            <!-- These options in this section are only used if the exportData is set to true -->
              <!-- The cell delimiter for each non null field.  Default is none. -->
            <cellDelimiter></cellDelimiter>
              <!-- Indicates that the output should be compressed -->
            <compress>false</compress>
              <!-- Filesystem or HDFS.  Valid values are FS or HDFS.  Defaults to FS (filesystem) -->
            <dataOutputType>FS</dataOutputType>
              <!-- Path to put the data files. -->
            <dataOutputPath>/tmp/</dataOutputPath>
              <!-- The delimiter to use for the data files -->
            <delimiter>\t</delimiter>
              <!-- Exports column names to a file as the first row.  This is useful for debugging purposes -->
            <exportColumnNames>false</exportColumnNames>
              <!-- Indicates the maximum number of records per table that should be exported -->
              <!-- Using -1 indicates there is no limit -->
            <limitRecords>-1</limitRecords>
            <!-- If writing the output to a file, the maximum number of records to be written to each file. -->
            <maxRecordsPerFile>10000000</maxRecordsPerFile>
         </exportDataOptions>


         <!-- The existing objects are written to a file as is, these are not converted to Splice Machine syntax -->
         <exportObjectOptions>
            <!-- The directory relative to the root directory (scriptOutputPath above) where the functions should be exported to -->
            <exportFunctionDirectory>/export/functions</exportFunctionDirectory>
              <!-- Indicates if the functions should be exported -->
            <exportFunction>true</exportFunction>
            <!-- Indicates if all functions should be exported.  If you want to choose specific functions to export, specify them under functionList -->
            <exportAllFunctions>true</exportAllFunctions>
            <!-- Indicates the list of functions which should be exported -->
            <functionList></functionList>
            <!-- The directory relative to the root directory (scriptOutputPath above) where the packages should be exported to -->
            <exportPackageDirectory>/export/packages</exportPackageDirectory>
            <!-- Indicates if all packages should be exported.  If you want to choose specific packages to export, specify them under packageList -->
            <exportAllPackages>false</exportAllPackages>
              <!-- Indicates if the packages should be exported -->
            <exportPackage>false</exportPackage>
            <!-- List of packages that should be exported -->
            <packageList></packageList>
            <!-- The directory relative to the root directory (scriptOutputPath above) where the packages should be exported to -->
            <exportProcedureDirectory>/export/procedures</exportProcedureDirectory>
            <!-- Indicates if all procedures should be exported.  If you want to choose specific procedures to export, specify them under procedureList -->
            <exportAllProcedures>true</exportAllProcedures>
              <!-- Indicates if the procedures should be exported -->
            <exportProcedure>true</exportProcedure>
            <!-- Indicates the list of procedures that should be exported.  This is only used if the exportProcedure is true and exportAllProcedrres is false -->
            <procedureList></procedureList>
            <!-- The directory relative to the root directory (scriptOutputPath above) where the packages should be exported to -->
            <exportViewsDirectory>/export/views</exportViewsDirectory>
            <!-- Indicates if all views should be exported.  If you want to choose specific procedures to export, specify them under procedureList -->
            <exportAllViews>true</exportAllViews>
              <!-- Indicates if the views should be exported -->
            <exportViews>true</exportViews>
            <!-- Indicates the list of views that should be exported.  This is only used if the exportViews is true and exportAllViews is false -->
            <viewList></viewList>
            <!-- The directory relative to the root directory (scriptOutputPath above) where the triggers should be exported to -->
            <exportTriggersDirectory>/export/triggers</exportTriggersDirectory>
            <!-- Indicates if all views should be exported.  If you want to choose specific trigger to export, specify them under triggerList -->
            <exportAllTriggers>true</exportAllTriggers>
              <!-- Indicates if the procedures should be exported -->
            <exportTriggers>true</exportTriggers>
            <!-- Indicates the list of triggers that should be exported.  This is only used if the exportTriggers is true and exportAllTriggerss is false -->
            <triggerList></triggerList>
              <!-- Indicates if the roles should be exported -->
            <exportRoles>false</exportRoles>
         </exportObjectOptions>

         <!-- Indicates if import scripts should be created for each table -->
         <!-- This is used in combination with the create table script. -->
         <spliceImport>
            <!-- Create one import file for each schema -->
            <createForEachSchema>false</createForEachSchema>
            <!-- Create import file for each table, if createForEachSchema is true this is ignored -->
            <createForEachTable>true</createForEachTable>
            <!-- Indicates the sub directory where the import scripts should be created -->
            <importScriptSubDirectory>/import/</importScriptSubDirectory>
            <!-- Specifies which character is used to delimit strings in the imported data. You can specify the empty string to use the default string delimiter, which is the double-quote ("). -->
            <!-- If you want to use a control character specify the unicode control character ie u0001 for a control-a -->
            <characterDelimiter></characterDelimiter>
            <!-- The character used to separate columns, Specify empty if using the comma (,) character as your delimiter. -->
            <!-- If you want to use a control character specify the unicode control character ie u0001 for a control-a -->
            <columnDelimiter>u0001</columnDelimiter>
            <!-- Indicates the root directory where the data resides on HDFS -->
            <importPathOnHDFS>/data/sqoop</importPathOnHDFS>
            <!--  Indicates the bad record path on HDFS -->
            <badPathOnHDFS>/bad</badPathOnHDFS>
            <!-- Delimiter to use for the import files -->
            <importDelimiter>,</importDelimiter>
            <!-- The format of timestamps stored in the file. You can set this to empty if there are no timestamps in the file, or if the format of any timestamps in the file match the Java.sql.Timestamp default format, which is: "yyyy-MM-dd HH:mm:ss" -->
            <timestampFormat>yyyy-MM-dd HH:mm:ss</timestampFormat>
            <!-- The format of datestamps stored in the file. You can set this to null if there are no date columns in the file, or if the format of any dates in the file match pattern: "yyyy-mm-dd". -->
            <dateFormat>yyyy-MM-dd HH:mm:ss</dateFormat>
            <!-- The format of timeFormats stored in the file. You can set this to null if there are no time columns in the file, or if the format of any times in the file match pattern: "hh:mm:ss". -->
            <timeFormat>yyyy-MM-dd HH:mm:ss</timeFormat>
            <!-- failBadRecordCount -->
            <failBadRecordCount>1</failBadRecordCount>
            <!-- The file format for the create tables file-->
            <importForEachSchemaFileFormat>{SCHEMA}-import-tables.sql</importForEachSchemaFileFormat>
            <!-- The file format for the create tables file-->
            <importForEachTableFileFormat>import-{SCHEMA}-{TABLE}.sql</importForEachTableFileFormat>
            <!-- Set to true if you want to truncate table before import -->
            <addTruncate>false</addTruncate>
            <!-- Set to true if you want to call vacuum() before import -->
            <addVacuum>false</addVacuum>
            <!-- Set to true if you want to call major compaction on the table after import -->
            <addMajorCompact>false</addMajorCompact>
         </spliceImport>


         <!-- This section is for creating the sqoop scripts that will be used to export the data from the source database and import them into the splice database  -->
         <!-- This is the preferred way to take data from the source database, put it on hdfs and then use the splice import scripts to load it into splice machine -->
         <sqoopOptions>
            <!-- Indicates the directory that contains the run-sqoop-full.sh script-->
            <sqoopDirectory>/home/splice/sqoop</sqoopDirectory>
            <sqoopFilesSubDirectory>/sqoop</sqoopFilesSubDirectory>
            <!-- Indicates the sqoop extract / import scripts should be created -->
            <sqoopScripts>true</sqoopScripts>
            <!-- Indicates if query files (select statements) will be generated for each table -->
            <sqoopCreateQueryFiles>true</sqoopCreateQueryFiles>
            <!-- Indicates the sub directory where the query files should be created. This sub-directory will be under the directory specified in scriptOutputPath -->
            <sqoopQuerySubDirectory>/query/</sqooopQuerySubDirectory>
            <!-- Indicates the file format for the query file-->
            <sqoopQueryFileNameFormat>query-{SCHEMA}-{TABLE}.sql</sqoopQueryFileNameFormat>
            <!-- Indicates the location and file name of the sqoop config file -->
            <!-- The value of the CONFIG variable in the "/extract-" + currentSchema.toLowerCase() + "-full.sh" file -->
            <sqoopConfigFile>/tmp/database-migration/postgres/sqoop/postgres-config.txt</sqoopConfigFile>
            <!-- Indicates the location of the sqoop table list file -->
            <!-- The path of the TABLES variable in the "/extract-" + currentSchema.toLowerCase() + "-full.sh" file -->
            <sqoopTableListPath>/tmp/database-migration/postgres/sqoop/</sqoopTableListPath>
            <!-- Indicates the location of the sqoop import files -->
            <sqoopImportPath>/tmp/database-migration/postgres/import</sqoopImportPath>
            <!-- Indicates the location of the sqoop logs -->
            <!-- The path of the LOGFILE variable in the "/extract-" + currentSchema.toLowerCase() + "-full.sh" file -->
            <sqoopLogPath>/tmp/database-migration/postgres/logs</sqoopLogPath>
            <hadoopBin>/opt/cloudera/parcels/CDH/lib/hadoop/sbin</hadoopBin>
            <spliceBin>/opt/cloudera/parcels/SPLICEMACHINE/bin</spliceBin>
            <sqoopExportScript>
               <!-- This is not used and should be removed. -->
               <configFile>/tmp/sqoop/config.txt</configFile>
               <!-- This is not used and should be removed. -->
               <extractScriptFileNameFormat>extract-{SCHEMA}.txt</extractScriptFileNameFormat>
               <!-- This is not used and should be removed. -->
               <tableListFileNameFormat>tables-{SCHEMA}.txt</tableListFileNameFormat>
               <!-- The path to the directory containing the import sql statements.  Each table being imported must have an associated file in this directory named in the format import-<schema>-<table>.sql -->
               <importDir>/tmp/</importDir>
            </sqoopExportScript>
         </sqoopOptions>

         <!-- Data Type mapping -->
         <!-- There are some problems converting oracle DATE fields to Splice Machine syntax as  -->
         <!-- the dates could be a Splice DATE, TIMESTAMP, or TIME  -->
         <!-- Additionally, there is a situation where the NUMBER field in oracle may not have a negative -->
         <!-- precision / scale defined.  We need to map that correctly in Splice Machine -->
         <!-- For columns that are in a lot of tables, specify the schema and table as * -->
         <dataTypeMapping>
            <dataType name="DATE">
               <column schema="*" table="*" column="CREATE_DT" dataType="TIMESTAMP"/>
               <column schema="*" table="*" column="UPDATE_DT" dataType="TIMESTAMP"/>
            </dataType>
            <dataType name="DECIMAL">
            </dataType>
            <dataType name="NUMERIC">
            </dataType>
            <dataType name="TIMESTAMP">
               <column schema="*" table="*" column="CREATE_DT" dataType="TIMESTAMP"/>
               <column schema="*" table="*" column="UPDATE_DT" dataType="TIMESTAMP"/>
            </dataType>
            <dataType name="json">
               <column schema="*" table="*" column="*" dataType="CLOB"/>
            </dataType>
         </dataTypeMapping>
      </config>
   </configs>
</migration>
```
{: .Example}

</div>
</section>
