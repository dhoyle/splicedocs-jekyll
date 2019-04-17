---
summary: Information about how to access and modify Derby properties.
title: Derby Property Access
keywords: derby, property, properties
toc: false
product: onprem
sidebar:  getstarted_sidebar
permalink: onprem_admin_derbyprops.html
folder: OnPrem/Administrators
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Derby Property Access

This topic describes how to enable and disable Derby features by setting
Derby properties, which are divided into categories, as shown in the
following table.

{% include splice_snippets/onpremonlytopic.md %}

## About Property Categories

The following table summarizes the categories of Splice Machine properties.

<table summary="Table of Splice Machine property categories.">
    <col />
    <col />
    <thead>
        <tr>
            <th>Property Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><em>JVM (System) </em></td>
            <td>
                <p class="noSpaceAbove">These properties can be as command line arguments to JVM:</p>
                <ul>
                    <li>For Maven, include the command line arguments as an <code>&lt;argument&gt;</code> element in the <code>pom.xml</code> file. For example:</li>
                </ul>
                <div class="preWrapperWide"><pre class="AppCommand">&lt;argument&gt;-Dderby.language.logStatementText=true&lt;/argument&gt;</pre>
                </div>
                <ul>
                    <li>For shell scripts, you may need to manually add the argument to the java executable command line. For example:</li>
                </ul>
                <div class="preWrapperWide"><pre class="AppCommand">java -Dderby.language.logStatementText=true ... </pre>
                </div>
                <p>System properties can also be set manually using the <code>System.setProperty(key, value)</code> function.</p>
            </td>
        </tr>
        <tr>
            <td><em>Service</em></td>
            <td>
                <p class="noSpaceAbove">Service properties are a special type of database property that is required to boot the database; as such, these properties cannot be stored in the database. Instead, they are stored outside the database, as follows:</p>
                <ul>
                    <li>Derby stores service properties in the <code>service.properties file</code></li>
                    <li>Splice Machine stores service properties in a Zookeeper element.</li>
                </ul>
                <p>You can temporarily change service properties with the <a href="sqlref_sysprocs_setglobaldbprop.html"><code>SYSCS_UTIL.SYSCS_SET_GLOBAL_DATABASE_PROPERTY</code></a> built-in system procedure. These changes will be lost when the server is next restarted.</p>
                <p>To make a permanent change in a Derby service property, modify the value in the <code>service.properties</code> file and then restart the server to apply the changes.</p>
                <p>To make a permanent change in a Splice Machine service property, modify the value in ZooKeeper and then restart the server to apply the changes.</p>
            </td>
        </tr>
        <tr>
            <td><em>Database</em></td>
            <td>
                <p class="noSpaceAbove">Splice Machine database properties are saved in a hidden HBASE table with <code>CONGLOMERATEID=16</code>.</p>
            </td>
        </tr>
        <tr>
            <td><em>App (Derby/Splice)</em></td>
            <td>
                <p class="noSpaceAbove">App properties for both Derby and Splice Machine are saved to the <code>derby.properties</code> file in the Derby/Splice home directory. </p>
                <p>App properties can also be saved to these HBASE XML configuration files:</p>
                <ul>
                    <li><code>hbase-default.xml</code>
                    </li>
                    <li><code>hbase-site.xml</code>
                    </li>
                    <li><code>splice-site.xml</code>
                    </li>
                </ul>
                <p>Note that the XML files must reside in the <code>CLASSPATH</code>.</p>
            </td>
        </tr>
    </tbody>
</table>

When a property value is used, the property is searched for in the order
shown in the table: the property is first searched for in the
JVM properties; if not found there, it is searched for in the Service
properties, then in the Database properties, and finally in the App
properties.

## Site File Example

The following is an example of a `splice-site.xml` file:

<div class="preWrapperWide" markdown="1">
    <?xml version="1.0"?>
    <?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
       <configuration>
           <property>
               <name>splice.debug.logStatementContext</name>
               <value>true</value>
               <description>Property  to enable logging of all statements.</description>
               </property>
              <property>
              <name>splice.debug.david</name>
              <value>true</value>
              <description>Property  to test something.</description>
              </property>
       </configuration>
{: .Example xml:space="preserve"}

</div>
## Displaying Derby/Splice Properties

You can display the Derby/Splice properties with the
`SYSCS_UTIL.SYSCS_GET_ALL_PROPERTIES` system procedure, which displays
information like this:

<div class="preWrapperWide" markdown="1">
    splice> call SYSCS_UTIL.SYSCS_GET_ALL_PROPERTIES();

    KEY                                       |VALUE            |TYPE     
    ----------------------------------------------------------------------
    derby.authentication.builtin.algorithm    |SHA-256          |DATABASE 
    derby.user.BROWSE                         |Browse           |APP      
    derby.engineType                          |2                |SERVICE  
    derby.david.foo                           |WINTERS          |APP      
    derby.connection.requireAuthentication    |false            |JVM      
    derby.locks.escalationThreshold           |500              |SERVICE  
    derby.database.defaultConnectionMode      |fullAccess       |SERVICE  
    derby.database.propertiesOnly             |false            |SERVICE  
    derby.database.collation                  |UCS_BASIC        |DATABASE 
    derby.language.logStatementText           |false            |JVM      
    derby.storage.propertiesId                |16               |SERVICE  
    derby.language.logQueryPlan               |true             |JVM      
    splice.updateSystemProcs                  |false            |JVM      
    derby.storage.rowLocking                  |false            |SERVICE  
{: xml:space="preserve" .Example}

</div>
## See Also

* [`SYSCS_UTIL.SYSCS_SET_GLOBAL_DATABASE_PROPERTY`](sqlref_sysprocs_setglobaldbprop.html)
* The *Derby Properties Guide* on the [Apache Derby documentation
  site][1]{: target="_blank"}.

</div>
</section>



[1]: https://db.apache.org/derby/manuals/index.html
