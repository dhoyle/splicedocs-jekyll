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

## DB Vendors Supported in This Release

The *Database Migration Tool* supports migration to Splice Machine from these databases:

* IBM DB2
* Oracle
* Postgres
* Splice Machine (earlier versions)
* SQL Server

Contact Splice Machine at support@splicemachine.com for more information to get started.

</div>
</section>
