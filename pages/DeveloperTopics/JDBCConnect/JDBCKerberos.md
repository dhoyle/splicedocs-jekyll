---
title: JDBC Access to Splice Machine with Kerberos
summary: JDBC Access to Splice Machine with Kerberos
keywords: kerberos
toc: false
product: all
sidebar: home_sidebar
permalink: developers_connectjdbc_kerberos.html
folder: DeveloperTopics/JDBCConnect
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# JDBC Access to Splice Machine with Kerberos

This section shows you how to connect your applications to Splice Machine on a Kerberized cluster, using our JDBC driver. As a prerequisite to connecting, you must ensure that:

* Database users are added in the Kerberos realm as principals.
* Keytab entries have been generated and deployed to the remote clients on
  which the applications are going to connect.

See [Enabling Kerberos Authentication](tutorials_security_usingkerberos.html) for information about using Splice Machine on a Kerberized cluster.

{% include splicevars.html %}

You can read more about [our JDBC Driver here](tutorials_connectjdbc_intro.html). And you can download the driver from here: <a href="{{splvar_jdbc_dllink}}" target="_blank">{{splvar_jdbc_dllink}}.</a>

## Connecting Splice Machine with Kerberos and JDBC {#JDBCAccess}

Once you've configured Kerberos, you can connect with JDBC by specifying the principal and keytab values in your connection string; for example:

   <div class="PreWrapper" markdown="1">
    splice> CONNECT 'jdbc:splice://localhost:1527/splicedb;principal=jdoe@SPLICEMACHINE.COLO;keytab=/tmp/user1.keytab';
   {: .AppCommand}
   </div>

If you're using HAProxy, simply specify your proxy host as the server in the connect string:
{: .spaceAbove}
   <div class="PreWrapper" markdown="1">
    splice> CONNECT 'jdbc:splice://<haproxy-host>:1527/splicedb;principal=jdoe@SPLICEMACHINE.COLO;keytab=/tmp/user1.keytab';
   {: .AppCommand}
   </div>

If your keytab file is stored on HDFS, you can specify the connection like this instead:
{: .spaceAbove}
   <div class="PreWrapper" markdown="1">
    splice> CONNECT 'jdbc:splice://localhost:1527/splicedb;principal=jdoe@SPLICEMACHINE.COLO;keytab=hdfs:///tmp/splice.keytab';
   {: .AppCommand}
   </div>

When connecting third-party software via JDBC using a keytab file stored on HDFS, you must make sure that the Splice Machine libraries are in your classpath:
{: .spaceAbove}
   <div class="PreWrapper" markdown="1">
    export HADOOP_CLASSPATH=/opt/cloudera/parcels/SPLICEMACHINE/lib/*
   {: .ShellCommand}
   </div>


</div>
</section>
