---
title: Using HAProxy on a Kerberos-Enabled Cluster
summary: How to use HAProxy with Splice Machine and Kerberos
keywords: haproxy, load balancing, high availability, TCP requests, http requests, client requests, kerberos
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_security_haproxykerberos.html
folder: Tutorials/Security
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Using HAProxy with Splice Machine on a Kerberos-Enabled Cluster   {#Using}

This topic shows you how JDBC and ODBC applications can authenticate to the backend region server
through HAProxy on a Splice Machine cluster that has Kerberos enabled.

Our Developer's Guide includes the [Connecting to Splice Machine Through HAProxy](tutorials_connect_haproxy.html) topic, which shows you how to configure HAProxy for use with Splice Machine.
{: .noteIcon}

## Configuring Kerberos on CDH

You can enable Kerberos mode on a CDH5.8.x or later cluster using the
configuration wizard described here:

<a href="https://www.cloudera.com/documentation/enterprise/5-8-x/topics/cm_sg_intro_kerb.html" target="_blank">https://www.cloudera.com/documentation/enterprise/5-8-x/topics/cm_sg_intro_kerb.html</a>
{: .indentLevel1}


## Kerberos and Application Access
As a Kerberos pre-requisite for Splice Machine JDBC and ODBC access:

* Database users must be added in the Kerberos realm as principals
* Keytab entries must be generated and deployed to the remote clients on
  which the applications are going to connect.

HAProxy will then transparently forward the connections to the back-end
cluster in Kerberos setup.

### Kerberos and ODBC Access
To connect to a Kerberos-enabled cluster with ODBC, please review the information in our [Configuring Kerberos for ODBC Windows](tutorials_connect_odbcwin.html) topic.

In summary, follow these steps:

1. [Follow our instructions for installing and configuring our ODBC driver](tutorials_connect_odbcinstall.html). Verify that the odbc.ini configuration file for the DSN you're connecting to includes this setting:

    <div class="preWrapperWide" markdown="0"><pre class="Example">
    USE_KERBEROS=1</pre>
    </div>

2. A default security principal user must be established with a TGT in the ticket
  cache prior to invoking the driver. You can use the following command to establish
  the principal user:

    <div class="preWrapperWide" markdown="0"><pre class="ShellCommand">
    kinit <em>principal</em></pre>
    </div>
    Where *principal* is the name of the user who will be accessing Splice Machine.
    Enter the password for this user when prompted.

3. Launch the application that will connect using ODBC. The ODBC driver will use
  that default Kerberos *principal* when authenticating with Splice Machine.

## JDBC Example

This example assumes that you are using the default user name `splice`.
Follow these steps to connect with through HAProxy:

<div class="opsStepsList" markdown="1">
1.  Create the principal in Kerberos Key Distribution Center
    {: .topLevel}

    Create the principal splice@kerberos_realm_name in Kerberos Key
    Distribution Center (KDC). This generates a keytab file named
    `splice.keytab`.
    {: .indentLevel1}

2.  Copy the generated keytab file
    {: .topLevel}

    Copy the `splice.keytab` file that to all client systems.
    {: .indentLevel1}

3.  Connect:
    {: .topLevel}

    You can now connect to the Kerberos-enabled Splice Machine cluster with JDBC
    through HAProxy, using the following URL:

    <div class="preWrapperWide" markdown="1">
        jdbc:splice://<haproxy_host>:1527/splicedb;principal=splice@<realm_name>;keytab=/<path>/splice.keytab
    {: .Plain}
    </div>

    If your keytab file is stored on HDFS, you can specify the connection like this instead:
    {: .topLevel}
    <div class="preWrapperWide" markdown="1">
        jdbc:splice://localhost:1527/splicedb;principal=jdoe@SPLICEMACHINE.COLO;keytab=hdfs:///tmp/splice.keytab
    {: .Plain}
    </div>

    When connecting third-party software via JDBC using a keytab file stored on HDFS, you must make sure that the Splice Machine libraries are in your classpath:
    <div class="preWrapperWide" markdown="1">
        export HADOOP_CLASSPATH=/opt/cloudera/parcels/SPLICEMACHINE/lib/*
    {: .ShellCommand}
    </div>
{: .boldFont}

</div>
Use the same steps to allow other Splice Machine users to connect by
adding them to the Kerberos realm and copying the keytab files to their
client systems. This example sets up access for a new user name `jdoe`.

<div class="opsStepsList" markdown="1">
1.  Create the user in your Splice Machine database:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        call syscs_util.syscs_create_user( 'jdoe', 'jdoe' );
    {: .Example}

    </div>

2.  Grant privileges to the user
    {: .topLevel}

    For this example, we are granting all privileges on a table named
    `myTable` to the new user:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        grant all privileges on splice.myTable to jdoe;
    {: .Example}

    </div>

3.  Use KDC to create a new principal and generate a keytab file. For
    example:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        # kadmin.local addprinc -randkey jdoe@SPLICEMACHINE.COLO
    {: .Example}

    </div>

4.  Set the password for the new principal:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        # kadmin.local cpw jdoeEnter password for principal "jdoe@SPLICEMACHINE.COLO":
    {: .ShellCommand}

    </div>

5.  Create keytab file jdoe.keytab
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        # kadmin: xst -k jdoe.keytab jdoe@SPLICEMACHINE.COLO
    {: .ShellCommand}

    </div>

6.  Copy the generated keytab file to the client system
    {: .topLevel}

7.  Connect through HAProxy with the following URL:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        jdbc:splice://ha-proxy-host:1527/splicedb;principal=jdoe@SPLICEMACHINE.COLO;keytab=/home/splice/user1.keytab
    {: .Plain}

    </div>
{: .boldFont}

</div>
</div>
</section>
