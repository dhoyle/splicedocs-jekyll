---
title: SYSCS_UTIL.SYSCS_GET_ALL_PROPERTIES built-in system procedure
summary: Built-in system procedure that displays the derby properties.
keywords: display derby properties, get_all_properties
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_getallprops.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_GET_ALL_PROPERTIES

The `SYSCS_UTIL.SYSCS_GET_ALL_PROPERTIES` system procedure displays all
of the Splice Machine Derby properties.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_GET_ALL_PROPERTIES()
{: .FcnSyntax xml:space="preserve"}

</div>
## Results

The displayed results of calling `SYSCS_UTIL.SYSCS_GET_ALL_PROPERTIES`
include these values:

<table summary=" summary=&quot;Columns in Get_All_Properties results display&quot;">
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
                        <td><code>KEY</code></td>
                        <td>The property name</td>
                    </tr>
                    <tr>
                        <td><code>VALUE</code></td>
                        <td>The property value</td>
                    </tr>
                    <tr>
                        <td><code>TYPE</code></td>
                        <td>The property type</td>
                    </tr>
                </tbody>
            </table>
## Example

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_GET_ALL_PROPERTIES();
    KEY                                               |VALUE                                   |TYPE
    ------------------------------------------------------------------------------------------------------
    derby.authentication.builtin.algorithm            |SHA-512                                 |JVM
    derby.authentication.native.create.credentials.da&|true                                    |JVM
    derby.authentication.provider                     |NATIVE:spliceDB:LOCAL                   |JVM
    derby.connection.requireAuthentication            |true                                    |JVM
    derby.database.collation                          |UCS_BASIC                               |DATABASE
    derby.database.defaultConnectionMode              |fullAccess                              |SERVICE
    derby.database.propertiesOnly                     |false                                   |SERVICE
    derby.database.sqlAuthorization                   |true                                    |JVM
    derby.engineType                                  |2                                       |SERVICE
    derby.language.logQueryPlan                       |false                                   |SERVICE
    derby.language.logStatementText                   |false                                   |SERVICE
    derby.language.updateSystemProcs                  |false                                   |JVM
    derby.locks.escalationThreshold                   |500                                     |SERVICE
    derby.storage.propertiesId                        |16                                      |SERVICE
    derby.storage.rowLocking                          |false                                   |SERVICE
    derby.stream.error.file                           |./splice-derby.log                      |JVM
    splice.authentication                             |NATIVE                                  |JVM
    splice.debug.logStatementContext                  |false                                   |JVM
    splice.software.buildtime                         |2015-10-21 13:18 -0500                  |JVM
    splice.software.release                           |1.5.1                                   |JVM
    splice.software.url                               |http://www.splicemachine.com            |JVM
    splice.software.versionhash                       |fe1b10bda0                              |JVM
    
    22 rows selected
{: xml:space="preserve" .Example}

</div>
</div>
</section>

