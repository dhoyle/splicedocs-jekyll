---
title: SYSCS_UTIL.SYSCS_GET_SCHEMA_INFO built-in system procedure
summary: Built-in system procedure that displays table information for all user schemas, including the HBase regions occupied and their store file size.
keywords: get schema info, get_schema_info
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_getschemainfo.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_GET_SCHEMA_INFO

The `SYSCS_UTIL.SYSCS_GET_SCHEMA_INFO` system procedure displays table
information,including the HBase regions occupied and their store file
size, for all user schemas.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_GET_SCHEMA_INFO()
{: .FcnSyntax xml:space="preserve"}

</div>
## Results

The displayed results of calling `SYSCS_UTIL.SYSCS_GET_SCHEMA_INFO`
include these values:

<table summary=" summary=&quot;Columns in Get_Schema_Info results display&quot;">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Value</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="CodeFont">SCHEMANAME
					</td>
                        <td>The schema to which the table belongs.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont">TABLENAME
					</td>
                        <td>The name of the table. Note that may be more than one row containing a table name; for example, this happens if the table has an index.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont">ISINDEX
					</td>
                        <td>A Boolean value that specifies whether the HBase table is an index table.</td>
                    </tr>
                    <tr>
                        <td class="CodeFont">HBASEREGIONS
					</td>
                        <td>
                            <p class="noSpaceAbove">The HBase regions on which the table resides. There can be multiple regions.</p>
                            <p>Each region display shows (tableName, regionId.storeFileSize, memStoreSize, and storeIndexSize MB).</p>
                        </td>
                    </tr>
                </tbody>
            </table>
## Example

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_GET_SCHEMA_INFO();
    SCHEMANAME |TABLENAME  |REGIONNAME                                             |IS_I&|HBASEREGIONS_STORES&|MEMSTORESIZE |STOREINDEXSIZE
    ---------------------------------------------------------------------------------------------------------------------------------------
    SPLICE     |PLAYERS    |2176,,1446847689610.7211e284f7f767d7b142dbd639b4d9bf.  |false|0                   |0            |0
    SPLICE     |PITCHING   |1968,,1446260714743.01963d7260fc9d4dc01507eccdf67e40.  |false|0                   |0            |0
    SPLICE     |BATTING    |1984,,1446260731076.ca29785eb5b16a8752d9c4ceeaad2ce4.  |false|0                   |0            |0
    SPLICE     |FIELDING   |2192,,1447092732332.b4aae99023002bbac1a08432e6ffc2df.  |false|0                   |0            |0
    SPLICE     |SALARIES   |2256,,1447803176538.11ce38c9e470b4d209de4d32c96cb815.  |false|0                   |0            |0
    
    5 rows selected
{: .Example xml:space="preserve"}

</div>
</div>
</section>

